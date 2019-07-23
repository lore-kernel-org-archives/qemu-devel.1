Return-Path: <SRS0=3Ld+=VU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3AAC76190
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 08:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A8022511
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2019 08:43:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A8022511
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpqOe-0001cD-Rv
	for qemu-devel@archiver.kernel.org; Tue, 23 Jul 2019 04:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34384)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <slp@redhat.com>) id 1hpqOU-0001Dq-Tr
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 04:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1hpqOT-0002T2-Mc
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 04:43:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50757)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1hpqOT-0002Qp-FW
 for qemu-devel@nongnu.org; Tue, 23 Jul 2019 04:43:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id v15so37672422wml.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2019 01:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=ZGFKgkG4KP7/1h2z7MRFez0Ci8HWjDrguAXcBtfhbH0=;
 b=s7hAQ0DlQQdArSBeQ+yin5vA1P5VxT2ZzMWbryH515WNleaNbHFfjXAGEIumt3RciI
 SwvNYzPghKQGertFNZZQTu1nUrj/VWjtZijY1WXx0X0wiD+/mYExXRFGRczZ3qAZf0V3
 OWHCZfryUd0yRPJCpDBWBqDvEiiy5l2jXqCs75E0E7otw/S+dGzhW1gi6Vr9hveejGWa
 4mwkIOItUmFMEZkx4tz7VSo3JJP/JEZjjIA9eY4Nk/20EALRsI+2pGOn+Rw7iZDo1NzU
 15r5KTDBj23mybkTf/nCRTQd/uWoy0X5/kNXqytx2Ie1r3ihlB36/FC6Tw+4PpyniqAj
 lc3A==
X-Gm-Message-State: APjAAAUMBncBp86mUSBLARfTsx82vUYN/2PU2MDzN07UUeJvoN+bEqeO
 OHKpVKct+RPYR2W0mliO8KZ7Ng==
X-Google-Smtp-Source: APXvYqxz7wWg0FRESge21l9sUul6QaE8sF23er86mJ+a/klA7q6FJRsWQKxbsKOnKXUqkv5I8MEPOQ==
X-Received: by 2002:a1c:a686:: with SMTP id p128mr4433439wme.130.1563871411673; 
 Tue, 23 Jul 2019 01:43:31 -0700 (PDT)
Received: from dritchie.redhat.com (18.red-83-35-20.dynamicip.rima-tde.net.
 [83.35.20.18])
 by smtp.gmail.com with ESMTPSA id o11sm38315921wmh.37.2019.07.23.01.43.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 23 Jul 2019 01:43:30 -0700 (PDT)
References: <20190702121106.28374-1-slp@redhat.com>
 <20190703095825.GE11844@stefanha-x1.localdomain> <87d0i7tlkl.fsf@redhat.com>
 <20190719102915.GG18585@stefanha-x1.localdomain> <8736j2p22w.fsf@redhat.com>
 <CAJSP0QXTSwk4eJteC0wTB7LGoHY3=7t4G-eNfgREQ6k+GzV2_w@mail.gmail.com>
 <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: "Montes\, Julio" <julio.montes@intel.com>
In-reply-to: <904248411098104fcf7db22382172057e50db76c.camel@intel.com>
Date: Tue, 23 Jul 2019 10:43:28 +0200
Message-ID: <87tvbdrvin.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "stefanha@gmail.com" <stefanha@gmail.com>,
 "maran.wilson@oracle.com" <maran.wilson@oracle.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>,
 "sgarzare@redhat.com" <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Montes, Julio <julio.montes@intel.com> writes:

> On Fri, 2019-07-19 at 16:09 +0100, Stefan Hajnoczi wrote:
>> On Fri, Jul 19, 2019 at 2:48 PM Sergio Lopez <slp@redhat.com> wrote:
>> > Stefan Hajnoczi <stefanha@gmail.com> writes:
>> > > On Thu, Jul 18, 2019 at 05:21:46PM +0200, Sergio Lopez wrote:
>> > > > Stefan Hajnoczi <stefanha@gmail.com> writes:
>> > > >=20
>> > > > > On Tue, Jul 02, 2019 at 02:11:02PM +0200, Sergio Lopez wrote:
>> > > >  --------------
>> > > >  | Conclusion |
>> > > >  --------------
>> > > >=20
>> > > > The average boot time of microvm is a third of Q35's (115ms vs.
>> > > > 363ms),
>> > > > and is smaller on all sections (QEMU initialization, firmware
>> > > > overhead
>> > > > and kernel start-to-user).
>> > > >=20
>> > > > Microvm's memory tree is also visibly simpler, significantly
>> > > > reducing
>> > > > the exposed surface to the guest.
>> > > >=20
>> > > > While we can certainly work on making Q35 smaller, I definitely
>> > > > think
>> > > > it's better (and way safer!) having a specialized machine type
>> > > > for a
>> > > > specific use case, than a minimal Q35 whose behavior
>> > > > significantly
>> > > > diverges from a conventional Q35.
>> > >=20
>> > > Interesting, so not a 10x difference!  This might be amenable to
>> > > optimization.
>> > >=20
>> > > My concern with microvm is that it's so limited that few users
>> > > will be
>> > > able to benefit from the reduced attack surface and faster
>> > > startup time.
>> > > I think it's worth investigating slimming down Q35 further first.
>> > >=20
>> > > In terms of startup time the first step would be profiling Q35
>> > > kernel
>> > > startup to find out what's taking so long (firmware
>> > > initialization, PCI
>> > > probing, etc)?
>> >=20
>> > Some findings:
>> >=20
>> >  1. Exposing the TSC_DEADLINE CPU flag (i.e. using "-cpu host")
>> > saves a
>> >     whooping 120ms by avoiding the APIC timer calibration at
>> >     arch/x86/kernel/apic/apic.c:calibrate_APIC_clock
>> >=20
>> > Average boot time with "-cpu host"
>> >  qemu_init_end: 76.408950
>> >  linux_start_kernel: 116.166142 (+39.757192)
>> >  linux_start_user: 242.954347 (+126.788205)
>> >=20
>> > Average boot time with default "cpu"
>> >  qemu_init_end: 77.467852
>> >  linux_start_kernel: 116.688472 (+39.22062)
>> >  linux_start_user: 363.033365 (+246.344893)
>>=20
>> \o/
>>=20
>> >  2. The other 130ms are a direct result of PCI and ACPI presence
>> > (tested
>> >     with a kernel without support for those elements). I'll publish
>> > some
>> >     detailed numbers next week.
>>=20
>> Here are the Kata Containers kernel parameters:
>>=20
>> var kernelParams =3D []Param{
>>         {"tsc", "reliable"},
>>         {"no_timer_check", ""},
>>         {"rcupdate.rcu_expedited", "1"},
>>         {"i8042.direct", "1"},
>>         {"i8042.dumbkbd", "1"},
>>         {"i8042.nopnp", "1"},
>>         {"i8042.noaux", "1"},
>>         {"noreplace-smp", ""},
>>         {"reboot", "k"},
>>         {"console", "hvc0"},
>>         {"console", "hvc1"},
>>         {"iommu", "off"},
>>         {"cryptomgr.notests", ""},
>>         {"net.ifnames", "0"},
>>         {"pci", "lastbus=3D0"},
>> }
>>=20
>> pci lastbus=3D0 looks interesting and so do some of the others :).
>>=20
>
> yeah, pci=3Dlastbus=3D0 is very helpful to reduce the boot time in q35,
> kernel won't scan the 255.. buses :)

I can confirm that adding pci=3Dlastbus=3D0 makes a significant
improvement. In fact, is the only option from Kata's kernel parameter
list that has an impact, probably because the kernel is already quite
minimalistic.

Average boot time with "-cpu host" and "pci=3Dlastbus=3D0"
 qemu_init_end: 73.711569
 linux_start_kernel: 113.414311 (+39.702742)
 linux_start_user: 190.949939 (+77.535628)

That's still ~40% slower than microvm, and the breach quickly widens
when adding more PCI devices (each one adds 10-15ms), but it's certainly
an improvement over the original numbers.

On the other hand, there isn't much we can do here from QEMU's
perspective, as this is basically Guest OS tuning.

Sergio.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl02yLAACgkQ9GknjS8M
AjV2ABAAncHj9E6b+eLj9mRxTfddDVZHxzdFqpvBOFpOHE0RsGbHiZ5QhkW/kqHJ
5nmYYdp23v+fhan8GdMCdGyMWkZ9RezU3zIEk/vcw467WwNDy7e7tF0yi7lVMHIX
FfYwIezQmc5fwEZH8GFHRKtjSJLD+0E1NMR2VVSJCSDgZ5RkqILo9m18tMKAImAv
e6c5BYYtO+nVK/Fvtzp10oxtKUUtQ/KZIBqDnfdYPQCDhgdvpHLevFBBO5ZsDEtc
8XdC/Dgw+DaowqoQ6jKXTM37uaQKsXw0JjUtAuFYmU27oMp/slHdl0q+sl+AhCqS
uX9Y6hCqx4is3fedjHVam5G1L3s4jmq+RUQIKtavpjcKbvhCSwA/HCxM9db7F63Y
wm+2FAonmW9pQiW/0+zLtwX6/Ky3u6fCe5J/VycC5v82vRUULwgeM0PT3SbJNgwb
5k9ZQD0FfRjigZkDfeoS0rYanSLYq1A5v3pIdkLhbpPZaepoz3e6qbCDAjKtYp4+
24b48znWF6NGdzb18fcUCC+MAp8E8XYHnFNYwzJlcj6SvAYlux2V+7nuE4gRGmbo
GCl5xtY8wZ6StDHAoFq7FnGPlZiOOLorEQwK04nNLjMma1DS9uOr451o1qsqd1fc
cTsrpAlgSWPrpCLZX8+5SbcREd9P52diNiM6GmMqcJsWkeNb9OE=
=c1iA
-----END PGP SIGNATURE-----
--=-=-=--

