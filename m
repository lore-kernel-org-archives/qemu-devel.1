Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E3AC83006
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980A220737
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L59ExiEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980A220737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTPFT-0001WT-MQ
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 08:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTPEm-0000vY-NX
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:21:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jTPEl-00027w-NH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:21:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:35387
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jTPEl-00027e-40
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:21:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588076477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YhG7CYn4+btGuNQ0nYMVfSZeixhd34W/0pIEPdLDmXI=;
 b=L59ExiEd0sZFC5Ga+8K9jlVX70fiDWzVYmLDw9LOHJ76QIvGJvSG+PxZO/nkZzmcMAssF6
 D9+Km/GzRbZ4JXTUH164E+ccEwgBtvdPCdKoPNoVS3EBJ/OlYxZxtclfCgaacD+BMyINyd
 iZqtVvE6X1YJ1RmPuy1QEh01Cayn4gA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-bE1rHe3eNga-2Pr_rQ8BDQ-1; Tue, 28 Apr 2020 08:21:12 -0400
X-MC-Unique: bE1rHe3eNga-2Pr_rQ8BDQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24CDD80572D;
 Tue, 28 Apr 2020 12:21:11 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-37.ams2.redhat.com [10.36.114.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 405FE60C87;
 Tue, 28 Apr 2020 12:21:09 +0000 (UTC)
Date: Tue, 28 Apr 2020 14:21:07 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Subject: Re: [PATCH v10 00/14] iotests: use python logging
Message-ID: <20200428122107.GD5789@linux.fritz.box>
References: <20200331000014.11581-1-jsnow@redhat.com>
 <a63ac7e2-51fd-7d02-3e7d-be14912bd103@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a63ac7e2-51fd-7d02-3e7d-be14912bd103@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: ehabkost@redhat.com, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, armbru@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--f2QGlHpHGjS2mn6Y
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.04.2020 um 13:46 hat Max Reitz geschrieben:
> On 31.03.20 02:00, John Snow wrote:
> > This series uses python logging to enable output conditionally on
> > iotests.log(). We unify an initialization call (which also enables
> > debugging output for those tests with -d) and then make the switch
> > inside of iotests.
> >=20
> > It will help alleviate the need to create logged/unlogged versions
> > of all the various helpers we have made.
> >=20
> > Also, I got lost and accidentally delinted iotests while I was here.
> > Sorry about that. By version 9, it's now the overwhelming focus of
> > this series. No good deed, etc.
>=20
> Seems like nobody else wants it, so I thank you and let you know that
> I=E2=80=99ve applied this series to my block-next branch:
>=20
> https://git.xanclic.moe/XanClic/qemu/commits/branch/block-next

John said he wanted to address my comment on patch 14, so I expected him
to send another version. This need not stop this series (we can still
fix that on top), but just as an explanation why I didn't take it yet.

Kevin

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE3D3rFZqa+V09dFb+fwmycsiPL9YFAl6oH7MACgkQfwmycsiP
L9b+IRAAsMTzErdGMjoqRtiAiD6thUFGb4KypgMaa20OoNaKk0iXtDAC35+AQ8qu
1awk78ElVqWSqbWxK3jmGnpCqIRFSQPTu2XxOLVMHvO7vkYcTI98WeJqdbbIJayp
IOUfoH2Wc6uS/QzBIhbRdZMcvWsS4M/DyEbzApP71FdI/69e6FLFpvRq/4G3EJqo
kFiRtG9p8ZkndMaTG1FH5wGVG0Zm4dP5umxJ/VmcjATl8fDGfxFEu6SnSzvsvfqa
OP98p4ye7Aw/T9OhA/CAhEDDRlXUgs6KvfLDlj67Jziz6ujp2NI0A1IMOP+mm38p
eKNFlAh4D2CIbapvfNMMKJYi8OHytly9OHRs3JkIs0ua7w54UNrdpVzr6MnBwxlR
knaAxng8xYYeU8v7wgY4VZE6Ss311tTooN+DZV41zDryGrR89//JLkWArCanXo1T
7pjYshb0CelqTNpvymd7L4ZtyYE0PR75GIMpu58TRnuNtyYRMZAP5Qebtuintbbx
1VEULg5ldXipow2PsuWxvo9JNInz5zHFnd0qKCcksNljrLFnB3S3y3RKejKZMzB1
v+4E4i21k8CdNQ9J8fM3qyMoc6TNTP0+/m6bueFdZJFeVJDU3PUZDcUDVDfutqXE
9avlplCUMKxCD6j4zzQaLcjUCKsqtpY72KDnz8OW48YrHtpQWa0=
=albf
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--


