Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D467C46478
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:07:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 963DA20836
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 963DA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGdR-00073U-OK
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51812)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hiGOp-0002FW-8o
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hiGOn-000722-13
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:52:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50443)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hiGOm-0006vv-Of
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:52:32 -0400
Received: by mail-wm1-f68.google.com with SMTP id n9so403912wmi.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=EuvAflXMAR9YVsEoIjEyPO3DNj428NjGb140FXnFjpM=;
 b=LKXZPBoDOemXPbXkVyYXjx4amgmGygicIN6wP7/ejOF8+UrWM4/Gyuuz+u4CKyNajl
 1R6CMU2UIG3kp1XiSMr+l1bBeGFv5QvbNGh14FsLI9KQ5n161Dp3/KztUIC+bUgsel/0
 56kSVAundHbjSzIXN2eqUuxALj43XW+/HV++PGA13ZLtHJVgVIWf0ZIWenBFkwjoywmA
 1Aaftt+87YIFH/n3P0jqZX7DJybGR4niMvQ8bselHG17hiDyDHg8Xodk5G+W4JGtpoXd
 TnPN7v7FReihedmZ5H851UEr/G23gKbCmfE77a16o7civ7lMLnvh4vuZEsdKtsWBnVC1
 W0Uw==
X-Gm-Message-State: APjAAAXNJXElqzPObuBnRqtM6OY/xwQZAaGB49MmA4eNttqrKJtdxjzE
 bQ4hezDbLiBhLp4HeUMRD4DpBphtDkhreg==
X-Google-Smtp-Source: APXvYqy5mfBokw4isYX+q47p1l7nEdln3cfZUDxBpkI7PfgZYbwveaDe8aEkbcd308PgQf8jvwZZpg==
X-Received: by 2002:a05:600c:c4:: with SMTP id u4mr3179902wmm.96.1562064750063; 
 Tue, 02 Jul 2019 03:52:30 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id e7sm1759510wmd.0.2019.07.02.03.52.28
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 02 Jul 2019 03:52:29 -0700 (PDT)
References: <20190701144705.102615-1-slp@redhat.com>
 <20190701144705.102615-5-slp@redhat.com>
 <20190702081733.ff6cboiddln5wmti@sirius.home.kraxel.org>
 <878stgygiu.fsf@redhat.com>
 <20190702101625.trsg5dnnf2a4woqs@sirius.home.kraxel.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
In-reply-to: <20190702101625.trsg5dnnf2a4woqs@sirius.home.kraxel.org>
Date: Tue, 02 Jul 2019 12:52:27 +0200
Message-ID: <875zokyahg.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
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
 qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Gerd Hoffmann <kraxel@redhat.com> writes:

>   Hi,
>
>> > Can we get rid of the kernel command line hacking please?
>> > The virtio-mmio devices should be discoverable somehow.
>> >
>> > Device tree (as suggested by paolo) would work.
>> > Custom acpi device (simliar to fw_cfg) is another option.
>> > I'd tend to pick acpi, I wouldn't be surprised if we'll
>> > need acpi anyway at some point.
>> >
>> > Maybe even do both, then switch at runtime depending on -no-acpi
>> > (simliar to arm/aarch64).
>>=20
>> Microvm tries to do things in the cheapest possible way.
>
> But taking too many shortcuts tends to hurt in the long run.
> It also cuts off useful use cases.

Sure, but the consideration about whether there are too many shortcuts,
or just enough of them, is quite subjective. Microvm's code base is
small enough to keep its quirks in check without a becoming a
significant maintenance burden, and doesn't invalidate how other, more
conventional machine types work.

> I think microvm has more value than just the reduced boot time.
> Specifically the reduced attack surface is useful I think, even
> beyond container-style workloads.  Being able to boot standard
> cloud images (with the cloud image kernel loaded via cloud image
> boot loader) in microvm would be useful for example.

Agreed.

> So, yes, I want microvm being designed in a way that it can run
> firmware and have it handle the boot process.  For starters just
> qboot for fast direct kernel boot, but longer term also seabios
> and/or ovmf.

As I said, I'm also in favor of microvm supporting booting from
firmware in the future, as long we keep the simple mode too.

> Can look at the seabios side, but probably not before I'm back
> from my summer vacation in august.  For seabios a simple & reliable
> time source would be quite useful.  Direct kernel boot might be doable
> without that, but as soon as any I/O (read from cloud image disk) is
> involved a time source is needed.  Right now seabios uses the acpi
> pm_timer.  tsc should work too if seabios can figure the frequency
> without a calibration loop (invtsc should be enough).  Maybe seabios
> needs kvmclock support ...

My main concern about supporting SeaBIOS, in addition to boot times, is
having to support ACPI, which due to its complexity and size, is a clear
candidate to be stripped out from a minimalistic QEMU build.

> Is there any way to detect microvm from the guest?  pc/q35 can be
> easily detected by looking at the pci host bridge.

One option would be using the fields MPC_OEM and MPC_PRODUCT_ID from the
MP Table to give a hint to the guest.

> Do you have boot time numbers for qboot vs. no-firmware boot?
> Is the difference big enough that it makes sense to maintain both?

AFAIK, qboot can't boot a guest without both ACPI and PCI.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl0bN2sACgkQ9GknjS8M
AjXgWg/+IVYAKICb6sy0xQF7xtGhl7EEn1Gukjiof8Qw0eS4g+FraS0crOyR6vtl
+xEtI55jdpl7sEnDtACzwTErOQdm1/160nLfscMe98VUl5ZbW3JqmvQ7WYFIixn5
eheTxk3CJnVqA5AR25dYG+zZ15ULaxMjEZ2pwIcjOPXjYWZrs/GVcqYW69VYUDzw
pF5Lh5GbkwOJWjdwjhxdZ2WLsRUqN+J0ZzS1DZh/aQVzI/XhBRFP77SBsfN9jBYo
LIRIhtzRmjvk8XvDecbZAI6xhQPBjadRiY9IXWoPI4OCRXPIRk1tJKJFOr6lKvZn
0PYcDOmf+Nb+c/fign/iF1ekkF5tWcI500Z2bDxiVuuOVJYtcRwagdB1KiLbuGKA
DNOvgznTHtxHDW9qS4eM8cDxMjdCgLRYJ8GAYkYzMdj5MqllY6qd1fDE/rQR6EJr
Z+1ha/4FwIi2P6NOg9p7nOqA2LRFuYviXxo24WaC9ZYdF0AdpO5umuLJtMhELXso
JnDAJmCF/ClqPcK4qwMpTLHfNx3OQWDbLGLGNJHgdoT+DYQBvdy2pOI5ZXqGABle
fPbU/llhYkiiMyy9PepKWGaebsmnZkSdx5fN2hYhRjZ0LSy/95FvAYg0jyfjilmB
xdLtEymA3IrH8c5nRswxDDfoOFE6E4ihl55rQm4tnyxdZ8JWK7Q=
=sW3N
-----END PGP SIGNATURE-----
--=-=-=--

