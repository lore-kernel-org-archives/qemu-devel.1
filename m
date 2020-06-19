Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BABC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:11:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A82206F1
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 12:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGmFSrEN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A82206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmFrr-00033g-2a
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 08:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFod-00077F-O0
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:08:15 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54959
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jmFoF-0007c7-WD
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 08:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592568471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IREyClAeHR/y1Lqgg4psa9bjYEzXFibpvPc44BgBAcU=;
 b=AGmFSrENYlhoFErrV8k+QzlUsrg8VXc3QB/+hXb4/pElDhtn0eI0+o31UCL/apXko5o7nf
 KB1GttMDaej2MWltFYjrZ+Gj7RjviluvzbSFB5y7/L+b8wiAyhszbIUPvcbtlgi3Zp2JZo
 IVljBGAxRjjub8hSXvJP3aYgBzyXcOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-SpdnShS2OeejZ-iKDxazcg-1; Fri, 19 Jun 2020 08:07:48 -0400
X-MC-Unique: SpdnShS2OeejZ-iKDxazcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0C72A0BD7;
 Fri, 19 Jun 2020 12:07:47 +0000 (UTC)
Received: from localhost (ovpn-113-212.ams2.redhat.com [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 808CB5D9CA;
 Fri, 19 Jun 2020 12:07:47 +0000 (UTC)
Date: Fri, 19 Jun 2020 13:07:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v9 0/5] vhost-user block device backend implementation
Message-ID: <20200619120746.GA2422025@stefanha-x1.localdomain>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200614183907.514282-1-coiby.xu@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 15, 2020 at 02:39:02AM +0800, Coiby Xu wrote:
> v9
>  - move logical block size check function to a utility function
>  - fix issues regarding license, coding style, memory deallocation, etc.

I have replied with patches that you can consider squashing into your
series. I was testing this patch series and decided it was easier to
send code than to go back and write review comments since I was already
on a git branch.

My patches can be combined into your original patches using "git rebase
-i" and the "fixup" or "squash" directive.

Please add my Signed-off-by: line to affected patches when squashing
patches so that the git log records that I have confirmed that I have
permission to contribute this code.

If you have questions about any of the patches, please let me know.

Stefan

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7sqo8ACgkQnKSrs4Gr
c8gNQwf/aXNom7foIVRT/ZH+l6291vTBILaaYXrThlUBQCv1npWSu2i9jLJd98Ty
XQLrzIdK1hUAkR9fJf8rVYAY7+IsHULlaeei8ebhO8uz22V/2Jiz8yeP6E8/fFBK
dLXAarxprlgN/ff5eEiUkD/mC9JX5S+kpKarmULXjlvSNYw9fRhJlQHHfgv7BL+p
p2fLOu1R+emSwMCChQRj9dsPqHVPW6JoRGGDIouZ4zvf83sDUahdKCxfUp5MfpA0
onxXKAL8PZi+Uj4B0GB3kZuYcJ3fZoK4uPU+k/2buYoTfgVnEemCMWOCs6Y2GfAK
0nUfXnGhdCL46kzBEqQHq+ufkRWEzA==
=rTQA
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--


