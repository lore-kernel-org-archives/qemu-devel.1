Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68391C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:02:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D33A20659
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D33A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsmNk-0006VG-Iw
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 07:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38367)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hsmNF-00064y-8A
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:02:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hsmNE-0005OB-9n
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:02:25 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:53950)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hsmNE-0005MV-3Z
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:02:24 -0400
Received: by mail-wm1-f54.google.com with SMTP id x15so60366688wmj.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 04:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=ybAMINjCUTm0VSGcGnA4im04WP8zbXHcMZ7Ggen5xns=;
 b=FM7IboNfIyY5fc7dUaXekH3kk1hKdGp9vrAj1FkPBEgfX8d4jLLJzGz/vmBsW303OE
 FNDyhR8O4bgMpo097278+1xJ2WOjPCLV38khSXyBsyyycUrJYiJHCyXjUEg5xifjSEtX
 +abS4hUD7zGDd7+bweFvcgsnAo+aKV0uk/v2H45tNnvQbI4/ssePR7YYW+HQw7/mpa9p
 Gx/slgJh2s+Lnyk/3jQ9ar+WO4TVNlhkVVuWwT1lqGpeuyXpvq2JYJD50RjPCyBfVIJy
 NSzGnvH5PACHOrFhuRy1E3+2uQjjZ43HgJ/bIxLcdgTSbLdbOJy6Cy/OZEpDxAY9HVWn
 DOmg==
X-Gm-Message-State: APjAAAXCk/ITQqFDsSFs6EW6dCw0opbGRkKvsMZbQMaTc/A1/2bsAKVD
 u+xUrKWnv+gam27+WLphAno4zLftzDU=
X-Google-Smtp-Source: APXvYqwdDBYDZhEmUIdAvTfaJ/nwZ9uriOJlKfy093Z2bPX2QBDPcPUvHVp4pBX4qB5q4oK4FhBuDg==
X-Received: by 2002:a1c:720e:: with SMTP id n14mr29771973wmc.53.1564570942235; 
 Wed, 31 Jul 2019 04:02:22 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id f12sm73721732wrg.5.2019.07.31.04.02.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 04:02:21 -0700 (PDT)
References: <20190729125755.45008-1-slp@redhat.com>
 <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Andrea Bolognani <abologna@redhat.com>
In-reply-to: <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
Date: Wed, 31 Jul 2019 13:02:13 +0200
Message-ID: <87imriwjpm.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.54
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Andrea Bolognani <abologna@redhat.com> writes:

> On Mon, 2019-07-29 at 14:57 +0200, Sergio Lopez wrote:
> [...]
>>  /* virtio-mmio device */
>>=20=20
>>  static Property virtio_mmio_properties[] =3D {
>>      DEFINE_PROP_BOOL("format_transport_address", VirtIOMMIOProxy,
>>                       format_transport_address, true),
>> +    DEFINE_PROP_BOOL("modern", VirtIOMMIOProxy, modern, false),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>
> Not a QEMU developer so forgive me if I say something silly, but IIUC
> you'd be able to opt into the new feature by using eg.
>
>   -device virtio-net-device,modern=3Don
>
> However, virtio-pci devices already have a mechanism to control the
> VirtIO protocol version, where you use
>
>   -device virtio-net-pci,disable-modern=3Dno,disable-legacy=3Dyes
>
> to get a VirtIO 1.x-only device and
>
>   -device virtio-net-pci,disable-modern=3Dno,disable-legacy=3Dno
>
> for a transitional device.
>
> Can you please make sure virtio-mmio uses the existing interface
> instead of introducing a new one?

The problem here is that virtio-pci devices register an specific type
for each kind of supported device (virtio-net-pci, virtio-blk-pci...),
while virtio-mmio doesn't. This saves a lot of boilerplate, but also
implies that bus properties can't be passed through the attached device
(virtio-blk-device can't carry properties for it's virtio-mmio parent
bus).

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl1BdTUACgkQ9GknjS8M
AjW3sRAAodYAk/LZZJAGRs5JzHqpMlt8BbJu+uqzhSlPEUEaAfsQlecub4aeO32b
tuxpeYqOhlZCshSPTVASbKGFh3M5P6cAdaeyl482LU8JqFm3K70AHxe/wUS9KZlT
5JbU9i7UQP+5ASTwPxj43C/FG6wFD2wRUUA62fRi00Pt3fNxB3puPVzzRL2B62GE
9ZS8gGSM+8FOPjThYdTIxwvD3g1IfEjPvZrtaBrzefWARGnQiGzPuxPJLJM56OVG
ntFcxbo7DDHFNO9lJ1v13a1oVyIS1PVXqMLyr9YX6fIUXvKoptPo2/q+nTupvHZP
RXNlKIhLDOXYz67aKcLI3unk1sUl5mzKCUdRUTSmEA897JKZHOxEeUqDU7mfO/+1
N/BAcPpGFaLp7xvambOyoTQWU4U7WQSYkA2OFIfZvkORcTsz50xLfDFw3mE3+TYb
b138iOV7/Oi7LMtQ/mI79BY+pgzbgxR6e4w8nqTXNJVacsjA8rqGcZJljo8t3z5U
4g+L9aTVFjnEhM4TTYCRQYevgDtqcE2saXKXoY4EW7YpLU3f6bnbVuzKXHiLCV9n
fKHlc3eNXXMmqwMgAlnQf/yj+NwvZc8A0hveyvc+nSRuXaY33lsCAdrIWqKIQKuM
9oohHc+0rVV7kJ6M4FYVAL/UdVBdKH9SLcVcbpSy23chLJPovJk=
=Kgjq
-----END PGP SIGNATURE-----
--=-=-=--

