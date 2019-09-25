Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90BBC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:51:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A48321D7B
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 05:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A48321D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD0Co-0006vR-LN
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 01:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iD0Ba-000685-6L
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:49:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iD0BY-0004Fg-TU
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:49:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36718)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iD0BY-0004FP-LE
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 01:49:56 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7ABFE80F7C
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 05:49:55 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id n3so1393161wmf.3
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 22:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=HSsroT4HC2j6oQ8x2w3C7SA7aQg1P5xbfLeT4Pk4g7M=;
 b=fSVq9+RlQGKKbRF7m4gpYpotHxSsMO3TiOaAH/bIbKMw4j/TczlvhSSpkCAJ7q6hze
 9XyZu/CGYqZN3hkHleio60JOZ/cbElsIpGVaOSwN7DdI9QVWze7tGFPC1v/f0hwtDoAV
 szTBLnghmSVjTwNIRJprSonCz0oMPB0uZ16zUxMsl4f9W8bo4L7jxyzAlTvvet1vmfLM
 Zmq/9AacQnJ1X2kL2qYk6y6dmMHIlzIKbhog0TdbFU5lIDYEtVTl6vsi/vy7kzHd/5yc
 9jVNwHg1h6/ABAwfNjOb+8mhnZRAB59lmPtCHUApDpiX9C7n+jwC6h+imkaw82PxMaow
 E1Qg==
X-Gm-Message-State: APjAAAUtjcAH85riYrO44Uk8+8r1PgpsDVaoikhhhD34k9sY0PxXnknO
 Da4vKQWnBC0UYVJUOheqbqfBYjrwZ6Sy+AZ8/VZLUEfyI7NlnkuW12vwdenJw9JYZhJ1l1vOApM
 He8TNf6n9LCvRY+s=
X-Received: by 2002:a5d:4689:: with SMTP id u9mr7042381wrq.78.1569390594248;
 Tue, 24 Sep 2019 22:49:54 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwL4FR1FGuJ/FPsehgfbn7DutFbGl1HOLQJUHAiJW+F9qMjTpY/JwpIrmNKmqUEzHoMHYG6eA==
X-Received: by 2002:a5d:4689:: with SMTP id u9mr7042354wrq.78.1569390594060;
 Tue, 24 Sep 2019 22:49:54 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id x5sm4280279wrt.75.2019.09.24.22.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 22:49:53 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
In-reply-to: <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com>
Date: Wed, 25 Sep 2019 07:49:50 +0200
Message-ID: <87r245rkld.fsf@redhat.com>
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
Cc: ehabkost@redhat.com, kvm@vger.kernel.org, mst@redhat.com, lersek@redhat.com,
 mtosatti@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com,
 imammedo@redhat.com, philmd@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 24/09/19 14:44, Sergio Lopez wrote:
>> +Microvm is a machine type inspired by both NEMU and Firecracker, and
>> +constructed after the machine model implemented by the latter.
>
> I would say it's inspired by Firecracker only.  The NEMU virt machine
> had virtio-pci and ACPI.

Actually, the NEMU reference comes from the fact that, originally,
microvm.c code was based on virt.c, but on v4 all that is already gone,
so it makes sense to remove the reference.

>> +It's main purpose is providing users a minimalist machine type free
>> +from the burden of legacy compatibility,
>
> I think this is too strong, especially if you keep the PIC and PIT. :)
> Maybe just "It's a minimalist machine type without PCI support designed
> for short-lived guests".

OK.

>> +serving as a stepping stone
>> +for future projects aiming at improving boot times, reducing the
>> +attack surface and slimming down QEMU's footprint.
>
> "Microvm also establishes a baseline for benchmarking QEMU and operating
> systems, since it is optimized for both boot time and footprint".

Well, I prefer my paragraph, but I'm good with either.

>> +The microvm machine type supports the following devices:
>> +
>> + - ISA bus
>> + - i8259 PIC
>> + - LAPIC (implicit if using KVM)
>> + - IOAPIC (defaults to kernel_irqchip_split = true)
>> + - i8254 PIT
>
> Do we need the PIT?  And perhaps the PIC even?

We need the PIT for non-KVM accel (if present with KVM and
kernel_irqchip_split = off, it basically becomes a placeholder), and the
PIC for both the PIT and the ISA serial port.

Thanks,
Sergio.

>> + - MC146818 RTC (optional)
>> + - kvmclock (if using KVM)
>> + - fw_cfg
>> + - One ISA serial port (optional)
>> + - Up to eight virtio-mmio devices (configured by the user)
>> +


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2K//4ACgkQ9GknjS8M
AjVmTw/9ElDYdyqk9aGcU379B23aC3XF0mWk40KFNEN6DxgVirVzkZwMuyajcxrq
nZE3rj155US21V8yFWSk3Wewuv0GTmL2YjIUBqWMbY5XZ/4BACPfpolJfhVnWP03
kn0usIuwAFPmIkrmy06I+eIF4/0Zu8W8TVe+cKA8QhTUL2W45o6hShTbFS4WQuvA
m7OK875wf4g1Ca3p306Yug2hrn9yvcUajyWVkhZNiheI0juj5shE2VM05veCdZTz
U/A7F7DBmJ2G61Fk4lyUggX6k/FRkdea/qwG8AfSBhD0DVCQFHvr5f/Ea0eqGs9r
qiMnTftjSDBS+1H92Gyx5bCqZeb8Vihdn+hoNQ52/XdV18Vrh8/zP11fqHP4mRj3
2zehKx0Qd7wLm+ZUwitgOif8+tE+Ehz8+hBdTbgloP5/2GqyM6QvhLrt9RNIbCqW
Z36k1Az56L4rdTTdKXUwyBBfqNCTvSUuroGo1sX4u9RJfW+SK3vdLufF985kBn4Y
65vSZlkS2t4geFo5F2PH0b6UlenrXdoIYKB+X1RD3r6FcSCGftn8EK5A63m5D81R
LYGJQPB+eO2/q2/v2+pBgsCtMotFgapGmw5uap10M+cV+BmJg6Q+sgYIhBXO81SW
oHa/DImvBu6FgvhRYblzjfGrJF2ixxBpqmYLf3xV52nS7ZdtVXM=
=skTF
-----END PGP SIGNATURE-----
--=-=-=--

