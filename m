Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E2AC4360D
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 06:25:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61A9221A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 06:25:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61A9221A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDND2-0004Af-Mw
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 02:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iDNBY-0003Ws-0D
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 02:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iDNBW-0002qG-Sx
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 02:23:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57890)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iDNBW-0002mu-8p
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 02:23:26 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D08CA909
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 06:23:24 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id l6so494472wrn.2
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 23:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=p3wX4b3nJ/jsCclxFnCk6NvSH0CLX35aM42bWXitoow=;
 b=L7xxv+7DLiwE/zoleti/+/HYYuUw8Tfu/KjFzS4pWR9ABoeM1BY/TLE5nHoMIuJs87
 q7drvHGK43OxXXWVoU/OHdsHXRwolThSGmAgPW1DWyBvKs3x5Q1aI2l/usJOsN1//STF
 MCXHGuVko9RyUgMZE3YCv86pcCvNtt2Rf+Gqiyepxrrkm7JOl1fiLbfHTditZKtaVWGM
 1W5Pu0WBrFKoJtKCvcMAKRB5JRP9dl79VJ/S5/xxqQ6zENOW73y8sta8KheJFqLRstzw
 kRrcHgQim1y9arBDKqKVCdDSl0nrRZBiu/rodwpb91M+cf3q49zAzhwzyFeU007Y0sJ1
 m2Zg==
X-Gm-Message-State: APjAAAVGJ2pifWsBfKFjVPXgdj6qevphXNX4+9OD7qQOZcDLHEkNSKYH
 FzKRvlKAEDIoi+i5sv7RNzt7U3GO+tLuyGppGfb8PPxWyo71/S7AGEp2RP35bFXkwNNS1VzjhvI
 62lwlizCFF3OqPPA=
X-Received: by 2002:a05:600c:241:: with SMTP id
 1mr1475337wmj.162.1569479003010; 
 Wed, 25 Sep 2019 23:23:23 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzC2N2A2UZ1Jh9B72qAvk1MOTXDqnAblHO1dJoblmrbdIZLLJK3Z5zO4H4Zf6ks4uwENDT3AQ==
X-Received: by 2002:a05:600c:241:: with SMTP id
 1mr1475318wmj.162.1569479002801; 
 Wed, 25 Sep 2019 23:23:22 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id w125sm2798555wmg.32.2019.09.25.23.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 23:23:21 -0700 (PDT)
References: <20190924124433.96810-1-slp@redhat.com>
 <20190924124433.96810-8-slp@redhat.com>
 <23a6e891-c3ba-3991-d627-433eb1fe156d@redhat.com> <87a7ass9ho.fsf@redhat.com>
 <d70d3812-fd84-b248-7965-cae15704e785@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 7/8] docs/microvm.txt: document the new microvm machine
 type
In-reply-to: <d70d3812-fd84-b248-7965-cae15704e785@redhat.com>
Date: Thu, 26 Sep 2019 08:23:13 +0200
Message-ID: <87o8z737am.fsf@redhat.com>
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
Content-Transfer-Encoding: quoted-printable


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 25/09/19 17:04, Sergio Lopez wrote:
>> I'm going back to this level of the thread, because after your
>> suggestion I took a deeper look at how things work around the PIC, and
>> discovered I was completely wrong about my assumptions.
>>=20
>> For virtio-mmio devices, given that we don't have the ability to
>> configure vectors (as it's done in the PCI case) we're stuck with the
>> ones provided by the platform PIC, which in the x86 case is the i8259
>> (at least from Linux's perspective).
>>=20
>> So we can get rid of the IOAPIC, but we need to keep the i8259 (we have
>> both a userspace and a kernel implementation too, so it should be fine).
>
> Hmm...  I would have thought the vectors are just GSIs, which will be
> configured to the IOAPIC if it is present.  Maybe something is causing
> Linux to ignore the IOAPIC?

Turns out it was a bug in microvm. I was writing 0 to FW_CFG_NB_CPUS
(because I was using x86ms->boot_cpus instead of ms->smp.cpus), which
led to a broken MP table, causing Linux to ignore it and, as a side
effect to disable IOAPIC symmetric I/O mode.

After fixing it we can, indeed, boot without the i8259 \o/ :

/ # dmesg | grep legacy
[    0.074144] Using NULL legacy PIC
/ # cat /pr[   12.116930] random: fast init done
/ # cat /proc/interrupts=20
           CPU0       CPU1=20=20=20=20=20=20=20
  4:          0        278   IO-APIC   4-edge      ttyS0
 12:         48          0   IO-APIC  12-edge      virtio0
NMI:          0          0   Non-maskable interrupts
LOC:        124         98   Local timer interrupts
SPU:          0          0   Spurious interrupts
PMI:          0          0   Performance monitoring interrupts
IWI:          0          0   IRQ work interrupts
RTR:          0          0   APIC ICR read retries
RES:        476        535   Rescheduling interrupts
CAL:          0         76   Function call interrupts
TLB:          0          0   TLB shootdowns
HYP:          0          0   Hypervisor callback interrupts
ERR:          0
MIS:          0
PIN:          0          0   Posted-interrupt notification event
NPI:          0          0   Nested posted-interrupt event
PIW:          0          0   Posted-interrupt wakeup event

There's still one problem. If the Guest doesn't have TSC_DEADLINE_TIME,
Linux hangs on APIC timer calibration. I'm looking for a way to work
around this. Worst case scenario, we can check for that feature and add
both PIC and PIT if is missing.

>> As for the PIT, we can omit it if we're running with KVM acceleration,
>> as kvmclock will be used to calculate loops per jiffie and avoid the
>> calibration, leaving it enabled otherwise.
>
> Can you make it an OnOffAuto property, and default to on iff !KVM?

Sure.

Thanks,
Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2MWVEACgkQ9GknjS8M
AjVo2A//bzXUzuyTvFY3Yt7pa7vPg6BGH262M/NtpiZL+t8EF/mGaNsf9DbakPhk
WTOxCu8LHLsqDdzk3eI8L1MD8AsxvUUzncGBnf1AA0TYRugzNHc0ukSALz2FYHS+
q4DzpBx2g98n/UQGnfnew8qjEwQtgp7feMwyvOIY/6PDQlWWx7qwUN7rc0aBdC9o
Q8WrAJM/23/nKZKkfaaGKmuOQatodWrvXFn4HenhjXbScpUSSPTRtzuVYSVTemrq
yPqju2Qa10GIeG5kaIdfqM6jvS0X1usilwG98iouvYugXeMDy6tl2oljougZzxmd
wlnmnLlOf9GPyWVLIWxFDSnsQ8OjHTQOmrVFXHzToYkv85Lue2HDvtp93rvCdD63
DXBhFv7dotkMGfmGY01QcFIlGODUuYOlk8AXSglqW+LgVO1T58myXCbQG4XN6/zr
LKEEDICx3AVK6r+S/CTkR4p5Pnyv6L3kW5W6zUCiwV1qCTUm27P138OLYdTnufkx
wmwP2DJv1u5Br/LhgEO0luaUyRmZnpcrXfJJ2X/hpRl3C+wS8DyW5m+zrgpXizSb
gtHUAcXS6CJ7TXK4JdHr9dZBpjV1oYj0fmJgXkwfMrPs+iNpEklObsdoWCWnP3TO
6p5vk+NAhnvH6bsIOit1arENW40njETT+H1MqDLITILpWCOXcV4=
=/gyD
-----END PGP SIGNATURE-----
--=-=-=--

