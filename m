Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEDEC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:56:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 201472220B
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 07:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UNxq1p5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 201472220B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXgKI-0001Qf-3G
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 03:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60106)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXgIt-0000wq-98
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 03:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59516)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kXgIr-0001pP-2h
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 03:55:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603871727;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NE0v1t/DLeS/MpZl3Cu4Vwl3EbG/iOnTNhULuUH9l90=;
 b=UNxq1p5LQ5TJ96hIYv3ug33JnnX6FlvzeA04KJG0uPtVchNV68Q13XtvMw7ms2QOxN36fY
 Rd1Lz/dqrZft+sDJkxnlpum8epL1zY6eXeCUSFTTEZoJel2K0lZ+Vf8L5JigHBlTsxcDPZ
 PDNEt6qbi+N/Frv7g+jq/d8sD7NXHuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-U5OQviKUO1WzEOBRnxdpxg-1; Wed, 28 Oct 2020 03:55:25 -0400
X-MC-Unique: U5OQviKUO1WzEOBRnxdpxg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F33AD1800D42;
 Wed, 28 Oct 2020 07:55:23 +0000 (UTC)
Received: from localhost (ovpn-113-87.ams2.redhat.com [10.36.113.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8E63E196FD;
 Wed, 28 Oct 2020 07:55:20 +0000 (UTC)
Date: Wed, 28 Oct 2020 07:55:19 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] Revert series: virtiofsd: Announce submounts to the guest
Message-ID: <20201028075519.GB221115@stefanha-x1.localdomain>
References: <160385090886.20017.13382256442750027666.stgit@gimli.home>
MIME-Version: 1.0
In-Reply-To: <160385090886.20017.13382256442750027666.stgit@gimli.home>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tsOsTdHNUZQcU9Ye"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, cjia@nvidia.com, mjrosato@linux.ibm.com,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 kwankhede@nvidia.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--tsOsTdHNUZQcU9Ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 27, 2020 at 08:13:28PM -0600, Alex Williamson wrote:
> This reverts the following commits due to their basis on a bogus
> linux kernel header update:

What was the issue? Did the sub-mounts series include kernel header
changes that haven't landed in Linux yet?

--tsOsTdHNUZQcU9Ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+ZI+cACgkQnKSrs4Gr
c8i+vgf/djr38UNrMC+ZZhvJFeyXL7cL2oKvwECYBWE0mFWCQSuS/4/SKHeY4dk/
XmsmXSTBTM/CXksNO9P1NCyAJzeXAC72Ou1jJ4SsigCQC83nBAHUuDw4+Qp0HpNw
0fa2dr32U7t8J3Z4COkbscnJcadYLy2q2upvL1o53EdDveWhTqjkNli/QCgDuduc
VY7N3edIlAHIVgqDlYoVt6c2eRs8CdqaEcWeRfzfvwnLspEQscnAa5XlPtej1SvR
LQlAUMwl20DHjP2u0Ps/UeOzHSmsZObw7X0kbv6Yn2DKyaO974eJp087ImuxHWGG
kObXJd08QjfN4G/Jlfww+gt+3EKxlA==
=jaJw
-----END PGP SIGNATURE-----

--tsOsTdHNUZQcU9Ye--


