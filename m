Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90489C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F3C820872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F3C820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2Cu-0007B1-Dd
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iD2BN-0006Y9-2m
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:57:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iD2BK-0007Kk-A1
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:57:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58412)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iD2BK-0007KY-1E
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:57:50 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id ACFEE2A09A7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 07:57:48 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id m14so1903009wru.17
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 00:57:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=BBQ1WGoO/qpGXB8rTiM/z99z3rGQOB6O69irsJbKsnU=;
 b=S/PI9FD2sZzkO3kt/npWfI49AsfihEvIg/UChRLKuwbu24n43a2xdE6VoSVPGPpy4d
 LiF/dYgXYphwxf9Jh+7P8CvX2zzvVlGUnwnPjqBQRnZK1ruumMiYFfybL3X0yg2PFLtY
 cXf73y0WrUUvFXTbRke+ZVtanh1DwGnAyw7APO0ZrBaSLiEAO6/Cm0wT+v9ZPgcL2y3I
 OeNBIXIRp4w+2LdKLgmkNe0+gZe7FDjtFP9te2t5v61uaPlZDuXa0ThLVUFQX/Wo5rHl
 LPpCj1GETDtyaDaZhKWe6MuF3rWYT7srLTzdWqYUxQ9lMS2bt/JoIoVhxVYyq8cXl3O4
 TGPw==
X-Gm-Message-State: APjAAAXEJBtA4QWqsnsiRAnY6ImrFXQ4na3nyNKdDp+ZcancHXNNp0W5
 /ioilDiYB+Jh5+aeIx4vgaP3vxB6wTkfdiwDNab6KRzv32FxsIpayzxzED++k9+vpqsPWWKx5dW
 NYqJd7KPrlrOkaVk=
X-Received: by 2002:adf:e612:: with SMTP id p18mr7411316wrm.218.1569398267317; 
 Wed, 25 Sep 2019 00:57:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwd4+QLxS9sts/MKqAeE/q13HOjkkPx3B9bGMmHMxIRdr2EEBa0pQkRo+6Kv7Nvkky4+4R+sg==
X-Received: by 2002:adf:e612:: with SMTP id p18mr7411287wrm.218.1569398267049; 
 Wed, 25 Sep 2019 00:57:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id y5sm3056418wma.14.2019.09.25.00.57.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Sep 2019 00:57:46 -0700 (PDT)
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
To: Sergio Lopez <slp@redhat.com>
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87r245rkld.fsf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <317e53b1-d658-4b6b-c782-4b2a0dd091b2@redhat.com>
Date: Wed, 25 Sep 2019 09:57:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87r245rkld.fsf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mDVZVal97fA1LjnG3jStglsB6w8rGOwz9"
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mDVZVal97fA1LjnG3jStglsB6w8rGOwz9
Content-Type: multipart/mixed; boundary="9K0MbSTT8fXB0xcZQYs5vcslLqWEvV6qU";
 protected-headers="v1"
From: Paolo Bonzini <pbonzini@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, imammedo@redhat.com,
 marcel.apfelbaum@gmail.com, rth@twiddle.net, ehabkost@redhat.com,
 philmd@redhat.com, lersek@redhat.com, kraxel@redhat.com,
 mtosatti@redhat.com, kvm@vger.kernel.org
Message-ID: <317e53b1-d658-4b6b-c782-4b2a0dd091b2@redhat.com>
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87r245rkld.fsf@redhat.com>
In-Reply-To: <87r245rkld.fsf@redhat.com>

--9K0MbSTT8fXB0xcZQYs5vcslLqWEvV6qU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25/09/19 07:49, Sergio Lopez wrote:
>>> +serving as a stepping stone
>>> +for future projects aiming at improving boot times, reducing the
>>> +attack surface and slimming down QEMU's footprint.
>>
>> "Microvm also establishes a baseline for benchmarking QEMU and operati=
ng
>> systems, since it is optimized for both boot time and footprint".
>=20
> Well, I prefer my paragraph, but I'm good with either.

You're right my version sort of missed the point.  What about
s/benchmarking/benchmarking and optimizing/?

>>> +The microvm machine type supports the following devices:
>>> +
>>> + - ISA bus
>>> + - i8259 PIC
>>> + - LAPIC (implicit if using KVM)
>>> + - IOAPIC (defaults to kernel_irqchip_split =3D true)
>>> + - i8254 PIT
>>
>> Do we need the PIT?  And perhaps the PIC even?
>=20
> We need the PIT for non-KVM accel (if present with KVM and
> kernel_irqchip_split =3D off, it basically becomes a placeholder)

Why?

> and the
> PIC for both the PIT and the ISA serial port.

Can't the ISA serial port work with the IOAPIC?

Paolo


--9K0MbSTT8fXB0xcZQYs5vcslLqWEvV6qU--

--mDVZVal97fA1LjnG3jStglsB6w8rGOwz9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl2LHfgACgkQv/vSX3jH
roOpQgf/aiQvLFYTNQI5a6Bco3E6++pojDnNgz29HoMJn52fu5lGxi5AVMra2FjG
uMSNDat8wB1yUkCIbjMGPmhFf2pcYfRu+AP7iN1ULr4Xg9EEdD1piIJPaKPry8PU
qdrNFe1TYgZeTrjRaxCedEYl9y9u68y0YnqGGgfXuNz/hGgSrpKj9psBs9V6oJnZ
QYU26ahyJ5w7SV0BnIK//TkNwhme4XBNwKMjAiicm8hfkY8PwdM6QkHzvyOuKvHn
50rjvAR+jlaHJiJTbn4Z7+XYrGIZrPq0mYWU3NU0TBk/aOpTRUVRKx3DmJQzM3vI
s3W5rayLrNXsf14sKp/hfxpwQ1Utlg==
=dw3J
-----END PGP SIGNATURE-----

--mDVZVal97fA1LjnG3jStglsB6w8rGOwz9--

