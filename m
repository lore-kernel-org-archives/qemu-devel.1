Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E1AC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:30:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0692084B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 14:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ9UDKIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0692084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42570 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDrlm-0003G2-6q
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 10:30:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDrkg-0002bz-8x
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hDrkf-0007dd-Bn
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:29:30 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hDrkf-0007d0-0b
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 10:29:29 -0400
Received: by mail-wr1-x442.google.com with SMTP id y13so21207060wrd.3
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 07:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=/RXEflJHKIMZqzoyxeCVgmiTSxT+pno2FaIbiXErn64=;
	b=RZ9UDKIVakcrzzjVIm+xn4lJIXIgfnPgRrxXCLiFnnEHfN/77NTuq1KEQ/39KOB3r2
	NNKZgMZfth3pFkHoTsoy6Z12qvwBGFn2p7y6p6AMU/En7soWp/6PV80P2GZ24njEiDM9
	RlyzOUQh2Gb7l/B23Ors7OPHz/1Kor7l6Xgm8GvoHOHnQXS+Cjd+Vz5Ujg7vhRpnwmc/
	vVr6sx1qdVU68DrBMTAtM+coDq+kA5TD5qVpDok8qVh7uX3V2D5kAx9dxgnnCMcTs6/U
	kDx07D6KOJomehos37Pm85fGpNKhupKPoVOd6MW+dPpFAlP3lFsK+lbCcaE1m4FKn5gb
	yXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=/RXEflJHKIMZqzoyxeCVgmiTSxT+pno2FaIbiXErn64=;
	b=N4l1JEinjsaSIHy2sIQd2KR4a+Nbgzo5+CPiIfq+AFAj92QNV/DEeksGtrTBxvLJl/
	HIZuhib7Li7+tyJieOkcAtdnGtQ8Dro2eRGmFhSJGJr9TROQKp4n0BRoaHH3dXMjgALr
	Mm1sHFhrAfz4z3xzE1ahbtMomdnTNzTxwPTayYdCNVHfOgXfSi6KAwKsw8VdRWAH3b3M
	S+BsXoGVAAkZhUPc63wUv+2vFFOO3I4i0O3z08IUlexwFCQkSxJrjVqLeiDnAUA7H3hf
	PdUc/km5+1O59cpubagNjSknv2Gj14T5I36anC+Px+xsHlsYEv5crUUQh9frRGPWKNSj
	KCSg==
X-Gm-Message-State: APjAAAU34wKx7qkHeL3CGqvnLdOyRSJWdbIAPFClFx9ziIy9KhOYiFRJ
	dp2ON+3iRSMyzhTytzVUv2k=
X-Google-Smtp-Source: APXvYqw/O+l/XNVbiA0CR7t8QfuKoDyRKz0u1MaKl4HVwA+tb/YcY0WuRgYwWQB0ColBbjYKX+3MDQ==
X-Received: by 2002:adf:f344:: with SMTP id e4mr25093016wrp.77.1554820167481; 
	Tue, 09 Apr 2019 07:29:27 -0700 (PDT)
Received: from localhost ([51.15.41.238]) by smtp.gmail.com with ESMTPSA id
	e16sm50563736wrs.0.2019.04.09.07.29.26
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 09 Apr 2019 07:29:26 -0700 (PDT)
Date: Tue, 9 Apr 2019 15:29:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Nir Weiner <nir.weiner@oracle.com>
Message-ID: <20190409142925.GG16944@stefanha-x1.localdomain>
References: <20190321075545.14929-1-nir.weiner@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <20190321075545.14929-1-nir.weiner@oracle.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH 0/3] vhost-scsi: Support live migration
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: liran.alon@oracle.com, qemu-devel@nongnu.org, bijan.mottahedeh@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409142925.-3DaImDzomcJsUOyNuB_PWMcclOxPKDqrLEqGEkr5wU@z>


--0z5c7mBtSy1wdr4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2019 at 09:55:42AM +0200, Nir Weiner wrote:
> Originally migration was not possible with vhost-scsi because
> as part of migration, the source host target SCSI device state
> needs to be saved and loaded into the destination host target SCSI
> device. This cannot be done by QEMU.
>=20
> As this can be handled either by external orchestrator or by having
> shared-storage (i.e. iSCSI), there is no reason to limit the
> orchestrator from being able to explictly specify it wish to enable
> migration even when VM have a vhost-scsi device.
>=20
> Liran Alon (1):
>   vhost-scsi: Allow user to enable migration
>=20
> Nir Weiner (2):
>   vhost-scsi: The vhost device should be stopped when the VM is not
>     running
>   vhost-scsi: Add vmstate descriptor
>=20
>  hw/scsi/vhost-scsi.c                  | 57 ++++++++++++++++++++++-----
>  include/hw/virtio/vhost-scsi-common.h |  1 +
>  2 files changed, 48 insertions(+), 10 deletions(-)

What happens when migration is attempted while there is in-flight I/O in
the vring?

Stefan

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcrKxFAAoJEJykq7OBq3PIfHUH/2+Eu9fW9wKaN1G8nTxzDKSD
N2Et4j0oUJJ9fFLq07zKmhvWGA5+YSLdRoqbouIc6pVmCOz9jkNID+OctDugVXaA
l6IvKSm3uVQJ+MIk4MGBKK0s6NPJuOKeAgoaqr8VRoPuY/DctUeUhPG3b9XR7i9c
rMmEMsku5cPiYeRmxa57bJp+JghL4e6MU15F+qUJgsEs+WLuIlzwFBjkqcJH+CDP
gEdeHBTb7QCBYZuRSugC+6tcArJYLkoytYxDFzDw6OOMQMLeWEIgzFPaBrSwPZlj
w2R7XS9VLcWZ7crlXlEGPF2Ud4MqXDWt4ddz8zVlAIj3WfQVWqa/DMCsj3wq7Mc=
=UJSi
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--

