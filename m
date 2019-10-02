Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AEC1C35280
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A70521783
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 13:25:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A70521783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFed1-0004jl-IH
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 09:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iFecD-00044t-Iw
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:24:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iFecC-0006De-Ea
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:24:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iFecC-0006DO-5r
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 09:24:24 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2C1A12A09A3
 for <qemu-devel@nongnu.org>; Wed,  2 Oct 2019 13:24:23 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s19so2108436wmj.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2019 06:24:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=DDhL8npWgd9EbiDLE6gx7aYCXf/7Uj9r+2RC1cLZ4xk=;
 b=Pg7Y3o6nExHD90qb0IvmU2QJwK3RmFHNS+8ypij6ZDNsVXWnMK7zWJnDGCnVnU0n1x
 4w7Sq0l9R/IbNA5YF+WsR4Zvzjmpg+DIr0C7pHy+KCYFk681R3gcf/jxRMZ7linPwOed
 SVnuHzK/bbiw9xLb35VafYnQ7b4tcMvsr+DpbUG2RpnPLL7oOxvdRIE0Gt8Q/M0g8iGp
 NuDO2xdWqXO/EHqlaqsbR9HCsQMzEobovFXmprmj4mpCdQ4+/nO2XBBtuN941Yv/q2f1
 ORjPccfAh5KdNBFpD0y0hIsfedmJC6wQCh2B0TMudn+feZm56zd0OeBvLrKOp7qc195P
 tgxg==
X-Gm-Message-State: APjAAAV50kSVHM3d5SC2D9miV8cRlNeDazkAVBNqSUVW3etQWPPzl1aN
 lvSuCH0W9iizDR8w2NaMLLjmytMKI0eXU3fCavGi8zxKBHSb9rKVa2FVS4b0v5eP+TcbSHi+HGP
 DzXe163rcN2iK2qs=
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr2776767wmi.73.1570022661920; 
 Wed, 02 Oct 2019 06:24:21 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxUTQPtr33rrz72oniy/2dP6VPuYW20N2KO+ql6YCR6xV6To1ZsqmuoT+8Y3Lq1ruNRCNh3sQ==
X-Received: by 2002:a05:600c:20e:: with SMTP id
 14mr2776757wmi.73.1570022661686; 
 Wed, 02 Oct 2019 06:24:21 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id s1sm26237954wrg.80.2019.10.02.06.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Oct 2019 06:24:20 -0700 (PDT)
References: <20191002113103.45023-1-slp@redhat.com>
 <20191002113103.45023-11-slp@redhat.com>
 <07749cf1-d60f-0485-253d-718d3322046b@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 10/10] hw/i386: Introduce the microvm machine type
In-reply-to: <07749cf1-d60f-0485-253d-718d3322046b@redhat.com>
Date: Wed, 02 Oct 2019 15:24:17 +0200
Message-ID: <871rvvgu0u.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, philmd@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Thomas Huth <thuth@redhat.com> writes:

> On 02/10/2019 13.31, Sergio Lopez wrote:
>> Microvm is a machine type inspired by Firecracker and constructed
>> after the its machine model.
>>=20
>> It's a minimalist machine type without PCI nor ACPI support, designed
>> for short-lived guests. Microvm also establishes a baseline for
>> benchmarking and optimizing both QEMU and guest operating systems,
>> since it is optimized for both boot time and footprint.
>>=20
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> ---
>>  default-configs/i386-softmmu.mak |   1 +
>>  hw/i386/Kconfig                  |   4 +
>>  hw/i386/Makefile.objs            |   1 +
>>  hw/i386/microvm.c                | 574 +++++++++++++++++++++++++++++++
>>  include/hw/i386/microvm.h        |  83 +++++
>>  5 files changed, 663 insertions(+)
>>  create mode 100644 hw/i386/microvm.c
>>  create mode 100644 include/hw/i386/microvm.h
>>=20
>> diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-sof=
tmmu.mak
>> index 4229900f57..4cc64dafa2 100644
>> --- a/default-configs/i386-softmmu.mak
>> +++ b/default-configs/i386-softmmu.mak
>> @@ -28,3 +28,4 @@
>>  CONFIG_ISAPC=3Dy
>>  CONFIG_I440FX=3Dy
>>  CONFIG_Q35=3Dy
>> +CONFIG_MICROVM=3Dy
>> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
>> index c5c9d4900e..d399dcba52 100644
>> --- a/hw/i386/Kconfig
>> +++ b/hw/i386/Kconfig
>> @@ -92,6 +92,10 @@ config Q35
>>      select SMBIOS
>>      select FW_CFG_DMA
>>=20=20
>> +config MICROVM
>> +    bool
>> +    select VIRTIO_MMIO
>
> You also need these switches, I think:
>
>     select I8259
>     select ISA_BUS
>     select SERIAL_ISA
>     select MC146818RTC
>
> (ideally, it should be possible to disable all the other machines in
> default-configs/i386-softmmu.mak and only compile with CONFIG_MICROVM=3Dy
> ... but seems like there are also some other indirect dependencies left)

Yes, probably others too. I didn't bother building an accurate list of
components, because when I tried disabling PC, the build broke (I don't
remember the details, I think it crashed somewhere around the floppy
disk and something else).

My intention was, if microvm gets merged, to work on the build system to
ensure to make possible a microvm-only build, and fill the actual list
of components then.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2UpQEACgkQ9GknjS8M
AjXt0w//bbH5Qr6Xw+F4xyZ24PfgUDbo6ujgiAJItn+mHS0hfeCzS0RzKPc3FkqT
OcME5UkpPtGFuXwZivd/X4TLWnUMRTo2qrcnYz7TL+W0MN6vYBDjwbyHW7kNr/t6
zYivMYmbOLnTgbig5maHLR/e7lh6QD+gGYUcYr4SwKMDqoy/c86oPuW2IXbtTJab
kp6qwGVgCUpPFZBdwxa59Y4kD2YMaaZ4QUgb14LhaTW2ZeiwfAY9CKMjNNvOBiS9
pjkNl2aYP2HuGM9u0WdWlRQAgm205I15TT6SZK89222ZxyWjYjH5oGCILe/HZ2sJ
iMvg6tm2VNwkPXM768N64HBhYkXxsTZUnNFK+8nXCpVE1kztXc5xc+qDIi8nsDqi
2Ki6Ide+fKCVlCbqNqYAcRdS8eKUubRlc99PnKgbNEeINLpbutsU/dmb/XG9o/1P
BojzWsLjXeVvMXoFAjAeQjtOZMvqSRl4drg6o46Lwi8WETZdYh7aHrW4kvjLQd8J
C6DopdKFZCsnqKFT0ovsp58mfr/7ut+Y1ui6XaAQ9IIM2lUCE8Fybq3lFWiicDyB
fDnE6Ivj8nyaBXK7E9tQ75/Ia/ggVCKlWGlcoxO76D98x03S2yE0XVtx54SV4bqF
BvESq2EbPLRSpnIZclf6Uu4Sflpm6LIY3WumDTK4846CbxTVPAs=
=bLdz
-----END PGP SIGNATURE-----
--=-=-=--

