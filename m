Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C91C76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:31:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A45D21849
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 10:31:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A45D21849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoQAR-0001Ny-IY
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 06:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54198)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hoQA9-0000nq-04
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:30:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hoQA7-00012Q-Pm
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:30:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35129)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hoQA5-00010Z-SR
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 06:30:50 -0400
Received: by mail-wm1-f67.google.com with SMTP id l2so28532093wmg.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 03:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=e2SDRn5pEsKZqe/qwBnBjuuAUmVtuvwc6DdbBznUFmo=;
 b=FyHZDrJU8EPdFkISyfG5JR4nAAf9CHUMFXLRyZzQM4BaXLvGTD+E3a1KyTNoCX2Tso
 B2eKFP/6NAfugZ4Bn6EQWZcxrc2azdN9JaOXIAsNsl/GUnS1fxEiqw0G9hKASTRRnVTx
 V6XXwOkfCXP8PjDQCnheR1v2Zeki8MySs9uxR45iESgaOZkhnqaJEhoCsWDd4LrzcQk4
 pztCVxQFgC7lU00Dd/BR4GrpkyqkmEu1x+JjlIYV1T4SdtG25x11N3kCyaBIWhBIFfx9
 0J7RNiPMi2WacoCtd9bU0dPV8fXJkijJ3+tZ0hm8fmT3EXs42x7O/he0Asnq2u6C/Nmr
 BvNg==
X-Gm-Message-State: APjAAAW91jOOD6R33pmPIdGZOZRXPLEUioJUuEhnuGIVx9p7VtAfy8F4
 al5ISM7LUwfrI3/D2NgYSxQIijsw450=
X-Google-Smtp-Source: APXvYqzt80TumI4jIQvGfUv1UU9W9AEdcGHDerBOPExVvzdFxWfaX8vE7V7Xeo37aqShzSkHOFsVbQ==
X-Received: by 2002:a1c:f505:: with SMTP id t5mr16662625wmh.67.1563532248543; 
 Fri, 19 Jul 2019 03:30:48 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id y7sm23340550wmm.19.2019.07.19.03.30.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 03:30:47 -0700 (PDT)
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
 <878stgygiu.fsf@redhat.com>
 <20190702101625.trsg5dnnf2a4woqs@sirius.home.kraxel.org>
 <875zokyahg.fsf@redhat.com> <8c3b4619-f779-fb0c-7a53-b67150036a07@redhat.com>
 <8736joxzv4.fsf@redhat.com> <87ef2ntnr1.fsf@redhat.com>
 <8cc45a56-1d12-838c-e746-e10df8804bc9@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
In-reply-to: <8cc45a56-1d12-838c-e746-e10df8804bc9@redhat.com>
Date: Fri, 19 Jul 2019 12:30:43 +0200
Message-ID: <875znypb8s.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v2 4/4] hw/i386: Introduce the microvm
 machine type
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Paolo Bonzini <pbonzini@redhat.com> writes:

> On 18/07/19 16:34, Sergio Lopez wrote:
>> I've just added support for starting the machine from SeaBIOS (Stefan
>> Hajnoczi pointed in another thread that it can be as fast as qboot, and
>> given that the latter doesn't support mptables, I just tested this
>> one). I tried to keep it as minimalistic as possible, but it still
>> required an RTC (mc146818), which dragged in an ISA BUS, and this one a
>> KVM PIT.
>>=20
>> I ran some numbers using Stefano Garzarella's qemu-boot-time scripts
>> [1] on a server with 2xIntel Xeon Silver 4114 2.20GHz, using the
>> upstream QEMU (474f3938d79ab36b9231c9ad3b5a9314c2aeacde) built with
>> minimal features [2]. The VM boots a minimal kernel [3] without initrd,
>> using a kata container image as root via virtio-blk (though this isn't
>> really relevant, as we're just taking measurements until the kernel is
>> about to exec init).
>>=20
>>  ---------------------
>>  | QEMU with SeaBIOS |
>>  ---------------------
>>=20
>>  qemu_init_end: 65.958714
>>  linux_start_kernel: 77.735803 (+11.777089)
>>  linux_start_user: 127.360739 (+49.624936)
>>=20
>>  -------------------
>>  | QEMU direct PVH |
>>  -------------------
>>=20
>>  qemu_init_end: 64.043264
>>  linux_start_kernel: 65.481782 (+1.438518)
>>  linux_start_user: 114.938353 (+49.456571)
>>=20
>>  --------------
>>  | Comparison |
>>  --------------
>>=20
>> Average boot time:
>>=20
>>  * Relying on SeaBIOS, when compared with direct PVH boot, as a total
>>    average overhead of ~12ms. The cost of initializing QEMU increases in
>>    ~2ms (probably due to need to instantiate more devices), while the
>>    other ~10ms is the SeaBIOS overhead.
>>=20
>>  ---------------
>>  | Conclusions |
>>  ---------------
>>=20
>> Objectively, the version that boots directly the kernel using PVH is 10%
>> faster and has a slightly larger exposed surface. Whether this is enough
>> to justify its existence is quite subjective.
>>=20
>> In my opinion, not only I think it makes sense to have it, but I also
>> think there's little reason to have the firmware reliant version, given
>> the nature and purpose of microvm.
>
> The advantage of firmware is support for vmlinuz and multiboot in
> addition to PVH, and removing code from QEMU.  So I think it's still
> worth doing a comparison with qboot, and trying to understand where
> SeaBIOS is spending its time (qboot should not need additional devices
> other than fw_cfg, and since SeaBIOS has never been optimized for
> microvm I expect it's possible to shave quite a few of those 12 ms).

I tweaked qboot a bit to make it work with microvm (basically, if it
can't identify a PCI vendor, it assumes it's running in a microvm, and
avoids PCI and ACPI initialization, writing an minimal mptable instead)
and I've just got some numbers:

Average boot time:
 qemu_init_end: 64.502199
 linux_start_kernel: 66.644311 (+2.142112)
 linux_start_user: 116.279127 (+49.634816)

To avoid having to scroll up, these are the numbers with the direct PVH
boot version:

Average boot time:
 qemu_init_end: 64.043264
 linux_start_kernel: 65.481782 (+1.438518)
 linux_start_user: 114.938353 (+49.456571)

So starting from qboot is just a bit over 1ms slower, which I think it's
quite reasonable. And, as you said, the only additional device is
fw_cfg:

address-space: I/O
  0000000000000000-000000000000ffff (prio 0, i/o): io
    000000000000007e-000000000000007f (prio 0, i/o): kvmvapic
    0000000000000510-0000000000000511 (prio 0, i/o): fwcfg
    0000000000000514-000000000000051b (prio 0, i/o): fwcfg.dma

If people feel more comfortable keeping QEMU on x86_64 starting on Real
Mode and having the firmware writing mptables, I'm fine with taking this
approach.

That said, to avoid confusing users, I think it'd be better to drop the
legacy mode for SeaBIOS, and support just qboot. That would mean having
to add a binary from the latter to "pc-bios" with some descriptive name
("qboot-microvm.bin"?) and making microvm look for that one by default.

Does this sound like a reasonable plan?

> On the other hand I agree that microvm is showing great promise compared
> to PCI-based machine types.
>
> Paolo


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0xm9MACgkQ9GknjS8M
AjViWw/+MbYxXprJsL6VUIgI1at1zmlF80K6bA616yFLJrvhnRW77C9HvrO7Gs/7
tiEIdB8oQfZ7G05/FxMRSXHpxDzR0uXfnGUEx4Lvp0F8fw+KMJqXSVdaqBeS4ioD
LdRHAmkNiQI7pirkc+2SRV2YaZWtZ7I2UicBrshmjNpWtA5pisN8DqHwnP+jHKxs
66aftDbFBopoe4ebLF19dCt/yiGLPKnMdjHnutzdWOr/6AjGzpXdNqFNwriY7GYe
yaW0GpQkg+B4eBcZZBiT/sAnjzXDG90l8iEaWGOLTE414ntREjw7ExoeFkNtJ3v8
/7O830FeH7ZxQZUn+hYNj6ti4ZEv9PX5ARbhdwaF7YOYncglWERPFXjYoyFHfy+G
wScjd2gebUdtGingWAYbZjDJHFzsY7l3SBQsfd0l36ULthVrc+nSt1lnnr6OEloU
Htl8IEdb3qiEItLTFsNpbyBKV3d1gJRU9N04Qpx7hWNGWrJJNtetbNVVdQbs4g4M
KfVHVSL+a4tg+d+L3pPgTo5No2qBNiiuo8PC2trVNzeEp4yUf0yQN+ak2CVugldH
QXyoXXkI0zo+t9ArjGfDtVAVTGlg3F0obkjqjFjrP7M4OpRRu6P+NqcM6j5b2ApW
KHbe7QHc0suR1bhbWVQPa/PvSHPPHV6OVuj6Uht3oQhLwcPsiIk=
=tOFH
-----END PGP SIGNATURE-----
--=-=-=--

