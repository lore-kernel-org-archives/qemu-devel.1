Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEC1C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:12:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8D17206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQbNcsrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8D17206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnCU-0007EB-TD
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXn58-0000O4-53
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXn52-0000Ix-23
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:05:13 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iXn51-0000HS-R7
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:05:08 -0500
Received: by mail-wr1-x441.google.com with SMTP id 4so1237900wro.7
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 06:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=eaL6TIbv2OnLy9IWunp9cYuTXz3N2vnIHj2Vs0jxT2E=;
 b=fQbNcsrf+HzSDSbmvEwF84Y+sZELoIWX1KS13ld0NAHIh/rWnGMzds4rqAS3rVSqdg
 ND5oKp3cgVrSZi4w2uBvkKlwwgNykGoS4g2kKlUqOkAUfUJQXJ+Zyf7jhJMqd2y5+j/i
 mtF9bLAQN8JAbJE4nxgvd2VQUV7f5NkWml5/rcX7Nu7xPWChfzlgmaGhpin+zUTUaA0x
 NlC8DQ7EgZddY3PRcp0+H8ii2XDEKFrvpPxdhr3fN/EYocBenpfp/ULlrYyyQm4FY4uY
 iKUvT3BLCZCGZ0OdFC7E86toNfQ6dH2s5u0yrZCKaiZeDYD8lDgJmGql/k9hXMmiwrPR
 gn4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=eaL6TIbv2OnLy9IWunp9cYuTXz3N2vnIHj2Vs0jxT2E=;
 b=Fea78wSKsgiAXNIKZfMazZfGy12zEkctjvM+cTKtZm9jPPulA6+6sqfpChyhnPrtjO
 019Yb8mMbrv6sZPqLXbwnxtG5yImpw+qHLN2CaPaaPjU5wBXxIHjECpogyGq3TP8jJWd
 8aeV4Ban2mccb3dMi3GkHtdL4EK90wmWrfICuzn440ngxspgzcYa3rig2qkHfOMZm1kv
 +CtkpjhCoosLTpa8xH4Hl/HigG3ktzbYmdYCY+tVkTcvytHLl1PFEUABt2UOUqnt9a65
 XG0BBRxogDXMU99Y2jYZpNowJ4nb2q3xpiosah0lA/YGXAwIc5WYo29t8kel0q0OZnxR
 zQhg==
X-Gm-Message-State: APjAAAXIVyBIh4KwKixFQ6jYlGRkWYuSqcmSGlDflPIAWdj0bHWQJGX9
 T6eWq7bzBgp0c7PpZHYzkwUNruVRwTg=
X-Google-Smtp-Source: APXvYqyhR8/1chuTxCTJ0Yjo/agCDr1McAaVU6H3BfZ9H7B91TPTpIXzkTzDmEcqhEzd3mZyyExZcw==
X-Received: by 2002:adf:e545:: with SMTP id z5mr10724067wrm.321.1574345105489; 
 Thu, 21 Nov 2019 06:05:05 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id h97sm366065wrh.56.2019.11.21.06.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 06:05:04 -0800 (PST)
Date: Thu, 21 Nov 2019 14:05:02 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: ASM <asm@asm.pp.ru>
Subject: Re: PCI memory sync question (kvm,dpdk,e1000,packet stalled)
Message-ID: <20191121140502.GX439743@stefanha-x1.localdomain>
References: <CAMmAVbWzrYWZBXwKxSd-f5SXmq6qP1ok8abvyKJhp3=REEaMPA@mail.gmail.com>
 <CAMmAVbXNMjk=FasuySEcUa0U8CqGkCghehsJsWbVV2VHCAPA-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="i6WX/W6h5xa4jqsd"
Content-Disposition: inline
In-Reply-To: <CAMmAVbXNMjk=FasuySEcUa0U8CqGkCghehsJsWbVV2VHCAPA-w@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--i6WX/W6h5xa4jqsd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 08:36:32PM +0300, ASM wrote:
> I trying solve the problem, with packets stopping (e1000,tap,kvm).
> My studies led to the following:
> 1. From flatview_write_continue() I see, what e1000 writes the number
> "7" to the STAT register.
> 2. The driver from target OS reads STAT register with number "7" and
> writes to the register the number "0".
> 3. From flatview_write_continue() (I make edits):
>             memcpy(ptr, buf, l);
>             new1=3Dptr[0xc];
>             usleep(100);
>             new2=3Dptr[0xc];
>             invalidate_and_set_dirty(mr, addr1, l);
>             new3=3Dptr[0xc];
> printf("Old: %i, new1, %i, new2: %i, new3: %i\n", old,new1,new2,new3);
>=20
> I see what memory in first printf is "7", but after usleep() is "0".
> Do I understand correctly that this should not be? Or RCU lock
> suggests the ability to the multiple writers?
>=20
> The problem is that qemu(e1000) writes the number 7, after which
> target(dpdk driver) reads 7, on the basis of this it writes the number
> 0, but as a result (extremely rarely), the value STATUS still remains
> 7. Therefore, packet processing is interrupted. This behavior is
> observed only on kvm (it is not observed on tcg).
>=20
> Please help with advice or ideas.

Hi Leonid,
Could you be seeing weird behavior with KVM due to MMIO write
coalescing?

  static void e1000_mmio_setup(E1000State *d)
  {
      int i;
      const uint32_t excluded_regs[] =3D {
          E1000_MDIC, E1000_ICR, E1000_ICS, E1000_IMS,
          E1000_IMC, E1000_TCTL, E1000_TDT, PNPMMIO_SIZE
      };

      memory_region_init_io(&d->mmio, OBJECT(d), &e1000_mmio_ops, d,
                            "e1000-mmio", PNPMMIO_SIZE);
      memory_region_add_coalescing(&d->mmio, 0, excluded_regs[0]);
      for (i =3D 0; excluded_regs[i] !=3D PNPMMIO_SIZE; i++)
          memory_region_add_coalescing(&d->mmio, excluded_regs[i] + 4,
                                       excluded_regs[i+1] - excluded_regs[i=
] - 4);
      memory_region_init_io(&d->io, OBJECT(d), &e1000_io_ops, d, "e1000-io"=
, IOPORT_SIZE);
  }

MMIO write coalescing means that QEMU doesn't see the register writes
immediately.  Instead kvm.ko records them into a ring buffer and QEMU
processes the ring when the next ioctl(KVM_RUN) exit occurs.

See Linux Documentation/virt/kvm/api.txt "4.116
KVM_(UN)REGISTER_COALESCED_MMIO" for more details.

I don't really understand your printf debugging explanation.  It would
help to see the DPDK code and the exact printf() output.

Also, is DPDK accessing the e1000 device from more than 1 vCPU?

Stefan

--i6WX/W6h5xa4jqsd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WmY4ACgkQnKSrs4Gr
c8guZAgAidNinR5kQfnYuEShoI1Q3gDx/CClSdDu+5b7KKXF9TQ4gwFz+1Y0cSZa
yz2Bz+lUwJol4K0MfmMkoHLIo0Xts0X/9fanWzYR6qYhY5bgqPVRz2uiy6kOLVL8
37Sj/qFZj0aZTggi+KezwEX1rnxDHpZo6IA/jiCc8GpYWbN/qgz5KlVeVMkpyUho
1MVMhQnCNHO6/AjLb9Jq8g09wsAC4ND4nciYoKKr9qNPLWSnsam7SsLJ8C3CQCZz
TbUG8n2tuQoil9vp92D3yP9oRVFnlSZj8CDj7VF5GaBib9WlJbONuLbvz9tcft1K
C5tvv1b96R80G7YDY+kVQ5mixO0y2A==
=ZQiR
-----END PGP SIGNATURE-----

--i6WX/W6h5xa4jqsd--

