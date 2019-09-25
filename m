Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD6EC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:20:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20CF52054F
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 15:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CF52054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD964-0001ZJ-Cp
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 11:20:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58137)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iD8qT-0003i6-41
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iD8qR-0005P1-Ss
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:04:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50186)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iD8qR-0005OO-IN
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 11:04:43 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5E5B92DD43
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 15:04:41 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id w10so2513578wrl.5
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 08:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=pLATcdGpRsaJe0HMHluCJ9++bIY/2wR5B6HNVL8voTk=;
 b=Vp/HnLMbFcq8Nvjq8O9Cir70dbKWka76ALzRGc2oe1eLT24+dKcwHEouImLXaNyalH
 DuhAr9lh3HJ7skIXLQhOybImDV3rmNVQM+6fdmxd/NfT5EsDABUczB4LJTK/VDKUzbKo
 pA9cJnip3QCsV/ArT95Rql/e4ztdMc22irst4vUbSlM2Lrg9LfMcfkHNC2v8s+TRpmVe
 qdQrjfHyXSzfAScpdYQwqLQh0SDv5eoMQRdEoo5V/Mv+GEwhncOSTxsWV85fpc8wloXS
 DmvdOIJbt5O6GOWrimuZGeOdAZQzOEujBlPAVwwkaSvO7xxM1nc2si0g36fVpDe1p+vs
 /PbQ==
X-Gm-Message-State: APjAAAUSeLMD1eQeHc2MaVLVYmukT9QCMw5WC3COLplIjrrSOt0YdsmR
 VIKMzS6JHgOD6RBvy6EAKTd2L8eMb4zq78lrNLrLvNLay2EcQSCYoQbNtU2P/IpHP2TlooAABIO
 GuuqPObjGGyJcXWg=
X-Received: by 2002:a1c:658b:: with SMTP id z133mr8495196wmb.130.1569423880126; 
 Wed, 25 Sep 2019 08:04:40 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwstO6O1CI8De4rqaohqlMbBBY47FrzUX4GAHLRSeSPlpVuyJ+L9+SDKUZQU+6rM5EaySPTNQ==
X-Received: by 2002:a1c:658b:: with SMTP id z133mr8495167wmb.130.1569423879921; 
 Wed, 25 Sep 2019 08:04:39 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id c10sm8745245wrf.58.2019.09.25.08.04.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 08:04:38 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
In-reply-to: <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com>
Date: Wed, 25 Sep 2019 17:04:19 +0200
Message-ID: <87a7ass9ho.fsf@redhat.com>
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
>
>> +It's main purpose is providing users a minimalist machine type free
>> +from the burden of legacy compatibility,
>
> I think this is too strong, especially if you keep the PIC and PIT. :)
> Maybe just "It's a minimalist machine type without PCI support designed
> for short-lived guests".
>
>> +serving as a stepping stone
>> +for future projects aiming at improving boot times, reducing the
>> +attack surface and slimming down QEMU's footprint.
>
> "Microvm also establishes a baseline for benchmarking QEMU and operating
> systems, since it is optimized for both boot time and footprint".
>
>> +The microvm machine type supports the following devices:
>> +
>> + - ISA bus
>> + - i8259 PIC
>> + - LAPIC (implicit if using KVM)
>> + - IOAPIC (defaults to kernel_irqchip_split = true)
>> + - i8254 PIT
>
> Do we need the PIT?  And perhaps the PIC even?
>

I'm going back to this level of the thread, because after your
suggestion I took a deeper look at how things work around the PIC, and
discovered I was completely wrong about my assumptions.

For virtio-mmio devices, given that we don't have the ability to
configure vectors (as it's done in the PCI case) we're stuck with the
ones provided by the platform PIC, which in the x86 case is the i8259
(at least from Linux's perspective).

So we can get rid of the IOAPIC, but we need to keep the i8259 (we have
both a userspace and a kernel implementation too, so it should be fine).

As for the PIT, we can omit it if we're running with KVM acceleration,
as kvmclock will be used to calculate loops per jiffie and avoid the
calibration, leaving it enabled otherwise.

Thanks,
Sergio.




--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2LgfMACgkQ9GknjS8M
AjVOng/8D9mG+yeOmoGNjoqwhkfwuEOAeFQyZh577lA14fZmUL/2Ll1POHzG+VUR
JEtcR7MMYoF7vpZetsuuuvxUmxG9euzAxtpDEi7DcIeIpevAUQClLFpNk/YCk+UG
PoubELTebT4VLw8UoeCGnew8FzglDYpTvL/JJ+aGH4NROy6S7dzjIjCGkLGyHIE0
kqZx98/SI7yrByCP6GvND9dQAl2fHjQroYhrYUZH5sK+rCFdtMFY7eSjmWjezjLL
wY2k1yaRkmURkqflPZKUeudKG3bMltnZpv0kfadyJS6m5d0RMC7dMz/roDjHJfbQ
sKrjFTBKmV0bM2gKefDKt40Aui/7iBcXj2/Eieb9au7MWKSmsVwDl9O0W3kNRiXV
G5HD8RSE+vyQ1PVrNs3voRGTjr3q0GnScakWsmJ8NfV5LDP0ST3hYea0JqYb51Dx
snIjkR5foEIEnYJoGsstr8cpbipHJQ8xnPYF3cpMmO6B1xuJL+5gjbwUHxmbHy6G
WvP4srKnB1QaAKZ4lA0UDtEgw1Wt13Tt9uY1iGmiyTOF4kp7x/LomPIFsGz5Urde
gDXh1VCQ9AOFjDGNoTpSHoNFaiCoEeBBn0vYxNCjaInT8AeYZHQNCSGXmR7yZws6
n6Emm/n8cawrcopXAPPn0S/ks+PnOC+5aN5EFgsmWdSwy2o4nDM=
=zIjv
-----END PGP SIGNATURE-----
--=-=-=--

