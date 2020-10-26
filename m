Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B2AC55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:01:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DE6E20706
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 16:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VulL4z0h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DE6E20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX4wV-0001ul-5X
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 12:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4pP-0002ko-Nv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:54:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kX4pO-0004U9-5n
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 11:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603727672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hF5PTBLVjy2CuSHHEyxICX0prM5nf+mUDdhBFkn2ZIA=;
 b=VulL4z0hU8gytIudAcEQ+WqKAbKKHIW54UuAC2trs/6K+aQl5z00LOpQIxwDEdjwzT/hX1
 4OltTUFhjkM1XdthP2C8N7CMXZVLcFCiYpIKYfsRVUxvmL5MIThcB2S5dGikDt8hQZVQbu
 uDWvbDMmArw114gx+nesKIyWAmaNhvQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-dZwwczYUN96L_ELKK5SAig-1; Mon, 26 Oct 2020 11:54:29 -0400
X-MC-Unique: dZwwczYUN96L_ELKK5SAig-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5DF6809DC9
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 15:54:28 +0000 (UTC)
Received: from localhost (ovpn-114-214.ams2.redhat.com [10.36.114.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76A3319D6C;
 Mon, 26 Oct 2020 15:54:28 +0000 (UTC)
Date: Mon, 26 Oct 2020 15:54:27 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH v4 4/5] tools/virtiofsd: xattr name mapping examples
Message-ID: <20201026155427.GF52035@stefanha-x1.localdomain>
References: <20201023165812.36028-1-dgilbert@redhat.com>
 <20201023165812.36028-5-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023165812.36028-5-dgilbert@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
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
Cc: dinechin@redhat.com, virtio-fs@redhat.com, qemu-devel@nongnu.org,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 23, 2020 at 05:58:11PM +0100, Dr. David Alan Gilbert (git) wrote:
> +The third rule stops a guest from explicitly setting
> +the 'user.viritofs.' path directly.

s/virito/virtio/

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+W8TMACgkQnKSrs4Gr
c8h1eQf+MPFHU/Gm6bGNu/Zh4G5Kz6VB0R1y+4LIx/MR2FIx2MviyLJYCsB/jaFE
OfoFofaKp0sqkDs+Oc5i7zTAAq6//oFp8mthREL+JgGcb/mCHcC6nyfun5+p3DWc
KOqwcDikQgBwm1342R0YhdJHSY90reyD/0WsPoqJ6ezLDAnqdoyxHyqWPxLYy/+c
Z1DFaDUmsfVTrLw0H6KIjIQgEyS1++MINjpaJDVZP5Z4zE5w4AsHnJJNE6oDV+1W
Sr8/l+G47vKhSqVGVTdh+QyxeknyyOVJbDcNrRepvjSq0DMGHnrEx23gXfm6DyyM
mtRrh1rRmxriEOnv1n6CSLGs9h222Q==
=wL1+
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--


