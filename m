Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE24C432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:11:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D8C2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D8C2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2OS-0006rr-Bq
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iD2Nj-0006Mp-CJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iD2Ni-0004dW-Dn
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:10:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iD2Ni-0004d2-5L
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:10:38 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 15D2B81DE0
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:10:37 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id f63so1526529wma.7
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 01:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=sSedf1PSQ4+XVQg27whbHXC5BsZOA0msBaOP6O2nXYA=;
 b=HqSgjF3cA3feO4L7OrmEXNCa/m8bYTBR+0s5Pg3cbHAMVULOKh5l1WJO22u9reA7/L
 T8PuHv8eUlFk+iYGCQRg+OXAyqPPDYCpcLTvz6eX4NcrXSbDu47TYZa32QNpoJlRZRBq
 kGT158+TerRv8uBLvKqDrAQHxjve0mTjawxGLS0x8SDC7HlLpLlrku3Z+lsIGWeMB9lO
 jGnWNMdkdPSB4im0Og30ddUSm7ev+3VblnZUkO5IVb56JRaUAEOwOu3IihYM4ipUXsCa
 BAtnn6nzz2pTbr9Hu+ACkb3qgKiSWTt/JvDhAD4QfTTvhOs5h19w12cKa7aQ9VtKEYpS
 JkpA==
X-Gm-Message-State: APjAAAVpJ9UEC6cHFLVvoazQoEUfHVF7Q+j/PaXX+CGCxHI6dLgCZ0D1
 Rbwe7cI+RsrkWYh6HsBKRsMwq3Tm76VGXemXjEYiZNZSgSqf+zQI2qx6CASUSCWQV0wTJW0QfmT
 +4yHzoYaM18ft3BY=
X-Received: by 2002:a5d:4044:: with SMTP id w4mr8299103wrp.281.1569399035707; 
 Wed, 25 Sep 2019 01:10:35 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyRVq+g1VfZMi0d6Wj/uqNnTxYdPTROhRi471HFmLSLWvA0bKAZQLSNyzFlC9+e4gKyKQ97bg==
X-Received: by 2002:a5d:4044:: with SMTP id w4mr8299057wrp.281.1569399035412; 
 Wed, 25 Sep 2019 01:10:35 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id d10sm2181806wma.42.2019.09.25.01.10.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 01:10:34 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <c689e275-1a05-7d08-756b-0be914ed24ca@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
In-reply-to: <c689e275-1a05-7d08-756b-0be914ed24ca@redhat.com>
Date: Wed, 25 Sep 2019 10:10:32 +0200
Message-ID: <87h850ssnb.fsf@redhat.com>
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
Cc: Pankaj Gupta <pagupta@redhat.com>, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, lersek@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, philmd@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


David Hildenbrand <david@redhat.com> writes:

> On 24.09.19 14:44, Sergio Lopez wrote:
>> Microvm is a machine type inspired by both NEMU and Firecracker, and
>> constructed after the machine model implemented by the latter.
>>=20
>> It's main purpose is providing users a minimalist machine type free
>> from the burden of legacy compatibility, serving as a stepping stone
>> for future projects aiming at improving boot times, reducing the
>> attack surface and slimming down QEMU's footprint.
>>=20
>> The microvm machine type supports the following devices:
>>=20
>>  - ISA bus
>>  - i8259 PIC
>>  - LAPIC (implicit if using KVM)
>>  - IOAPIC (defaults to kernel_irqchip_split =3D true)
>>  - i8254 PIT
>>  - MC146818 RTC (optional)
>>  - kvmclock (if using KVM)
>>  - fw_cfg
>>  - One ISA serial port (optional)
>>  - Up to eight virtio-mmio devices (configured by the user)
>
> So I assume also no ACPI (CPU/memory hotplug), correct?

Correct.

> @Pankaj, I think it would make sense to make virtio-pmem play with
> virtio-mmio/microvm.

That would be great. I'm also looking forward for virtio-mem (and an
hypothetical virtio-cpu) to eventually gain hotplug capabilities in
microvm.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2LIPgACgkQ9GknjS8M
AjWl+A/+PSvLIkJIXkisI+8HPInHsOhI7krvdkj88nvO3vWQbDvRZR4wjKpzJls+
QuB7L+5sZh4afO4t0zOOZ54AcN91lSMUL3ovOFbN2zsS3yWO3H1BIgroEdD3Ho2g
wePVPnB65l10c2X6zqvLZlE06amQ1rG2ooYHJmF6AHl7L6ouHjTqioFoe3itzfqc
5t3xdJx43IpXY5Zng6S8mNGji7q1PX/tKqYdoOSqafMxN9s9HqX6t9F6/kbUkH9j
Q+xKcSg5wSHAV000jokgfgJe21Z3/O329Zckb+Vdp8RqZZaR5p1tYThevyshqvLK
K2QKsT8hxflVPtyXe326UGaRQd/n+Uq9d9BFj4M+imvMsYu6EkV9hXDOq5U9PRtN
uwiCQj3OlHjzvad18+ZbnPnjfkPDFnYTzgdiQ8o99+a8AK1SbdVi8ePMmFy8tvBF
szKMv7fzfOGYNJnmd0At1nWMon+0qQKW7v/Ee4qMN+Xg5900ycDhsyf1fMdCj/52
DkQaFc5Bo94CjhDjQetZd/EHJKfqd4NKACCUNs7Hkubrlj7p+xkI+Oj8jtI96cWK
ytI43gzylvznVvlH16E0BTiEhAduBY5PGkGBOqpAkjk2wLUmGK7BsFAzpjtMDxdH
XSR81ecBqDHJXAA0JekepxcEK+S3ho6j2NJpJ2jvuXsKCl8UGiI=
=DOyt
-----END PGP SIGNATURE-----
--=-=-=--

