Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D93C4360F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:42:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43DB521871
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 11:42:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43DB521871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40343 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCNEX-0003OS-7V
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 07:42:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCNCp-0001X4-S9
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:40:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hCN2a-00018U-Hx
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:29:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hCN2Z-00013I-GE
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 07:29:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id g3so7527661wrx.9
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 04:29:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to;
	bh=bidDB/lfhg/3lyPaJpBO7RjPSRIYhHpNCfIQIpnQk0Q=;
	b=cc4BO83X7B1Fom4ULCiTrnbKCmxJaGXBiJXN1PDFllaPmrPRWC2gBbRRqphcmUqIfJ
	lunoubOsDvzVQMchveoqZ76vN+T2WwkDFzpfPF6N7tdfMkpM6xuMX1FLPe7T0kIySyMp
	SV34ke+9xPIf8QYDEcXcO8ZsuWm32mBR2w4mBjhAKcHp9hywL01Oo8HKiOI7YgvFiQW2
	DQh7mEkq3b36ZJf4pUzZCeS7efVuFdBDIguNxCx5jwNnWIRDE9Xn2ioyxPeu9x/cLsJw
	ZbRSOLo8o278TWKV4gDQYiAhZzX4tD6D1m+oFe82LFblpIqyjzhxtZJEoJkxpbNCVx93
	STOA==
X-Gm-Message-State: APjAAAV2KsgVD/OED/6rKUOLhTNOeJ1nHw1/8VrLrQy490E6pPNA7S1E
	FiPnA+XcF5IDR9jBSrj3fruYUQ==
X-Google-Smtp-Source: APXvYqxwbh3IRg6CBleqM63J/x0oilqR3ysRlgeVxW88HbgBAg5/jmMnfGzYu51xGvuHiwTm3am7KQ==
X-Received: by 2002:adf:e78e:: with SMTP id n14mr8176051wrm.14.1554463786217; 
	Fri, 05 Apr 2019 04:29:46 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	z13sm28774820wrw.36.2019.04.05.04.29.45
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 05 Apr 2019 04:29:45 -0700 (PDT)
To: Olaf Hering <olaf@aepfle.de>
References: <20190405123928.70da87e2.olaf@aepfle.de>
	<1cec1873-9962-f258-a052-167efec620e9@redhat.com>
	<20190405125918.462c6ae4.olaf@aepfle.de>
	<20190405131616.071a6390.olaf@aepfle.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b1c37e96-4679-b342-bf26-7043cc754220@redhat.com>
Date: Fri, 5 Apr 2019 13:29:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190405131616.071a6390.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SuHnBdERStGcRcRGIhVH6i7ipi1GC56IY"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
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
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405112944.VpTgGOdtwju3SfoH2wdCkeDqynAD7SxbgGvt998-6Ow@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SuHnBdERStGcRcRGIhVH6i7ipi1GC56IY
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: qemu-devel@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <b1c37e96-4679-b342-bf26-7043cc754220@redhat.com>
Subject: Re: [Qemu-devel] edk2 fails to compile in v4.0.0-rc2
References: <20190405123928.70da87e2.olaf@aepfle.de>
 <1cec1873-9962-f258-a052-167efec620e9@redhat.com>
 <20190405125918.462c6ae4.olaf@aepfle.de>
 <20190405131616.071a6390.olaf@aepfle.de>
In-Reply-To: <20190405131616.071a6390.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 4/5/19 1:16 PM, Olaf Hering wrote:
> Am Fri, 5 Apr 2019 12:59:18 +0200
> schrieb Olaf Hering <olaf@aepfle.de>:
>=20
>> This used to work still in January with c9d18c1c150c84e7a976df989ad04d=
df01083f46.
>=20
> It is not possible to just override EFIROM=3D$(type -P EfiRom) because =
this variable is also used by ipxe.git.

Yes, lets got back with the overridable form previous to f590a812c210:

-- >8 --
diff --git a/roms/Makefile b/roms/Makefile
index 78d5dd18c30..fc501a6c30c 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -49,3 +49,3 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
 #
-EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
+EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom

---

I'll submit that patch.

Thanks,

Phil.


--SuHnBdERStGcRcRGIhVH6i7ipi1GC56IY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlynPCgACgkQoqP9bt6t
wN6k4w/+PmHNHwibZHNfXo8PzO6jCq2m8yr8cRz2HWHboYojjeBuNfTeo/sBKnIh
clegStBhmEzMhjVAqEe5BfxDG5cwZ8dK5jY/Ep0pz7NH1IA/Sz4NNU98pxkTir2B
h8HwmgBENKMH7WnWgGcjvOxERFvt/9NuqKb6SmURDip8DUpdrLWT4KJWRS5UlbSg
v/a90XAh7wLxp40E1FF8mm20sPdonNJqVW3YR4hB1BsuyqZPxgYbipp/ze1Kh4tU
aceDon7lCz4x/pR2zY96BqR4WlUaI7BP8lLa0co6I3fNF8WxE24kJrkW8LE8witP
wyuN4xGyq0kHx2WrvJOlU0omSlxuABOXuEjbWujxcnF2+KEnHOKKNZjtmWdxpSNZ
WvVPPUY1raRihSIcCMfpLH7fWP0iXS1qfDd0gchagXPsbIUc3xyOkfUNxl7p/znt
u1dC3mb33yrBJ+Qxxi5uKJcfcSrps+K4jFpf2uUZ4jddXWpNcc65rvZSaJGh4Roh
n0vyjM7zAEvwRlGFWruRVJZFGX4DmkRWs8tjPwkm/um7H/R+XUxxYyO5KFQy45ME
Rzpy8LHb2698a8yQZow3f1FUhwPYfPEz5/AThmGNIjIpI1q6b5v2oFO+xpBM3TkP
SeccH3FdGeXhhir1xtNDpmdwNomjKniE0DWKweErsV1eluUfxFY=
=6oag
-----END PGP SIGNATURE-----

--SuHnBdERStGcRcRGIhVH6i7ipi1GC56IY--

