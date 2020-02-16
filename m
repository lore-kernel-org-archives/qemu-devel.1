Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C01F8C3B1BF
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:48:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 849A02084E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 21:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+LwukPF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 849A02084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3RmP-0007Kp-NY
	for qemu-devel@archiver.kernel.org; Sun, 16 Feb 2020 16:48:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47941)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jtomko@redhat.com>) id 1j3RiY-0002Lp-7x
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:44:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jtomko@redhat.com>) id 1j3RiW-00071y-MU
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:44:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50621
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jtomko@redhat.com>) id 1j3RiU-0006yh-TN
 for qemu-devel@nongnu.org; Sun, 16 Feb 2020 16:44:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581889481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zhXMmBAXCgfQTjLqgf6lExerRDkJGfplaaRy6BL/Cmk=;
 b=S+LwukPFiC4rG+fIQwMKfsG9YWGva9SyTxeJ+Cr7DZx+52/y6ltAIX6yOnptGRCb7QtwS2
 D0yED2mvvZm72ncace1DPyyJBnabVR8ebDVEUYVCUNSpzabNrL8VXabggo1fwCbLrvnZfi
 KXBWxKZ8LkBqyTcHphQID1S1BHVa5JU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-Fip3BdIWMT-dsi1jlz7pCA-1; Sun, 16 Feb 2020 16:44:37 -0500
X-MC-Unique: Fip3BdIWMT-dsi1jlz7pCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AB77813E5;
 Sun, 16 Feb 2020 21:44:36 +0000 (UTC)
Received: from lpt (ovpn-200-18.brq.redhat.com [10.40.200.18])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 385CB90F54;
 Sun, 16 Feb 2020 21:44:34 +0000 (UTC)
Date: Sun, 16 Feb 2020 22:44:30 +0100
From: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/7] qapi: Document meaning of 'ignore' BlockdevOnError
 for jobs
Message-ID: <20200216214430.GE745061@lpt>
References: <20200214200812.28180-1-kwolf@redhat.com>
 <20200214200812.28180-2-kwolf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200214200812.28180-2-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7LkOrbQMr4cezO2T"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 mreitz@redhat.com, nsoffer@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--7LkOrbQMr4cezO2T
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2020 at 09:08:06PM +0100, Kevin Wolf wrote:
>It is not obvious what 'ignore' actually means for block jobs: It could
>be continuing the job and returning success in the end despite the error
>(no block job does this). It could also mean continuing and returning
>failure in the end (this is what stream does). And it can mean retrying
>the failed request later (this is what backup, commit and mirror do).
>
>This (somewhat inconsistent) behaviour was introduced and described for
>stream and mirror in commit ae586d6158. backup and commit were

fatal: ambiguous argument 'ae586d6158': unknown revision or path not in the=
 working tree.

>introduced later and use the same model as mirror.
>
>Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>---
> qapi/block-core.json | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>

Reviewed-by: J=E1n Tomko <jtomko@redhat.com>

Jano

--7LkOrbQMr4cezO2T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEQeJGMrnL0ADuclbP+YPwO/Mat50FAl5Jt7oACgkQ+YPwO/Ma
t512gAf/XFP7lWWz82iH0vzR6gig/asJjHBMPw4XiKkdUmZEQmDNci6a9vmU3RgK
tlyZfLB7Zl3hStrtl834WRwuPtgjR/iPjWA1J7xY3mK2VrEDeSSEuhHc+TNypnz4
hnqckHxavHYGVPORnBQLGWATEzfYYSilhPyqqDqstTt59RC3F57EvclWkOVsYAlH
xcFxWFw9/YnQjbz9+s1Aa8s161b5ywpQJzVdBP458TZ6/2lbYwe5r7yPAhlNksBI
30rFSrEmGdFmHCFb0ZS82WZ4RzGjMCXvKsu1e/GMa1r5OvRJS9LguQlxFdMYAoez
AolHt40Cx29sox0djh+LBBcoa7xZFA==
=VrzI
-----END PGP SIGNATURE-----

--7LkOrbQMr4cezO2T--


