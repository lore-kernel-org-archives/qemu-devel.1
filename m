Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18829FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF4EA2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:50:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4EA2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL4IJ-0005Ew-1u
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 07:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iL4HY-0004pI-Br
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:49:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iL4HX-0004T8-2h
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:49:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iL4HW-0004St-Qh
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:49:27 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C9E138553F
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 11:49:25 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id e14so814454wrm.21
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 04:49:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=4krLb12OnICKjaMwH7B3tTaL3awfMGRuLrOJzZJZDNU=;
 b=pi55hoYWKluF+71X7JelWfiC4H699NLgQAW3hs7zEevA15R1sRDL5wU2Deirppc8qB
 nupWIQqRc/RjBRY846/2Cgq2csKRuJoSIt0nV2ah/k0/BBbWrnoM8rO+/wXvUjwW+1ID
 5O/As1vhEXRGCloLxscEiUDRYHNWLCasz4RP6bEOrLHb700ZhTvusOYsuW4YMemac3tk
 F436wR3+JzoVIcTSbVpW9dCuH1XXKGDNWhO9gPf0EtpqfBKK1v05alI4sDZGCaJxbWmZ
 QPzssaQ81Ca+iGUtwW4gJ2dP2QtVBNfnLFH9NjgUebemM7MDHq2wWpVoMj+ciHC2Xg60
 FdWQ==
X-Gm-Message-State: APjAAAUBs7Ajv0FoCS4xxqHB2x5Vero4Ff59v/FKVj+bsEfcekehgM6C
 KYm4qK3Tk+tfNR3MyErWXi7dZ+Lvop8kIxroUMxXuYG6/Bl+0UZnySnzSIyHxdgorUpcUSofzW3
 /f9ZOntg2pTVSoww=
X-Received: by 2002:adf:ed49:: with SMTP id u9mr2594901wro.229.1571312964458; 
 Thu, 17 Oct 2019 04:49:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxDZuoh6NQoXkaDkROe2ccgO2d6DmZpRLdcVfci9SPyjrAQOBeVc8xAv1+MYolNBydHH3KWMw==
X-Received: by 2002:adf:ed49:: with SMTP id u9mr2594868wro.229.1571312964167; 
 Thu, 17 Oct 2019 04:49:24 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id b5sm1925178wmj.18.2019.10.17.04.49.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 04:49:23 -0700 (PDT)
References: <20191016101241.24405-1-slp@redhat.com>
 <20191016101241.24405-14-slp@redhat.com> <20191017110051.GH31072@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v10 13/15] docs/microvm.rst: document the new microvm
 machine type
In-reply-to: <20191017110051.GH31072@redhat.com>
Date: Thu, 17 Oct 2019 13:49:20 +0200
Message-ID: <87eezbh9rz.fsf@redhat.com>
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
Cc: ehabkost@redhat.com, mst@redhat.com, philmd@redhat.com, groug@kaod.org,
 qemu-devel@nongnu.org, kraxel@redhat.com, imammedo@redhat.com,
 pbonzini@redhat.com, rth@twiddle.net, lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Oct 16, 2019 at 12:12:40PM +0200, Sergio Lopez wrote:
>> Document the new microvm machine type.
>>=20
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  docs/microvm.rst | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 98 insertions(+)
>>  create mode 100644 docs/microvm.rst
>>=20
>> diff --git a/docs/microvm.rst b/docs/microvm.rst
>> new file mode 100644
>> index 0000000000..0aab55576c
>> --- /dev/null
>> +++ b/docs/microvm.rst
>> @@ -0,0 +1,98 @@
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +microvm Machine Type
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> +
>> +``microvm`` is a machine type inspired by ``Firecracker`` and
>> +constructed after its machine model.
>> +
>> +It's a minimalist machine type without ``PCI`` nor ``ACPI`` support,
>> +designed for short-lived guests. microvm also establishes a baseline
>> +for benchmarking and optimizing both QEMU and guest operating systems,
>> +since it is optimized for both boot time and footprint.
>
> I'm wondering about live migration support across QEMU versions.
>
> IIUC, this is not intended to be a versioned machined type, so
> live migration won't be supportable across QEMU versions.
>
> Given that its for short lived guests, this shouldn't be an
> issue, but it might be worth saying something explicit here
> about migration to avoid any risk of misunderstanding.

It may be worth adding a Limitations section. Something like this:

Limitations
=2D----------

Currently, microvm does *not* support the following features:

 - PCI-only devices.
 - Hotplug of any kind.
 - Live migration across QEMU versions.

Any other thing we should highlight there?

Thanks,
Sergio.

>> +
>> +
>> +Supported devices
>> +-----------------
>> +
>> +The microvm machine type supports the following devices:
>> +
>> +- ISA bus
>> +- i8259 PIC (optional)
>> +- i8254 PIT (optional)
>> +- MC146818 RTC (optional)
>> +- One ISA serial port (optional)
>> +- LAPIC
>> +- IOAPIC (with kernel-irqchip=3Dsplit by default)
>> +- kvmclock (if using KVM)
>> +- fw_cfg
>> +- Up to eight virtio-mmio devices (configured by the user)
>> +
>> +
>> +Using the microvm machine type
>> +------------------------------
>> +
>> +Machine-specific options
>> +~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +It supports the following machine-specific options:
>> +
>> +- microvm.x-option-roms=3Dbool (Set off to disable loading option ROMs)
>> +- microvm.pit=3DOnOffAuto (Enable i8254 PIT)
>> +- microvm.isa-serial=3Dbool (Set off to disable the instantiation an IS=
A serial port)
>> +- microvm.pic=3DOnOffAuto (Enable i8259 PIC)
>> +- microvm.rtc=3DOnOffAuto (Enable MC146818 RTC)
>> +- microvm.auto-kernel-cmdline=3Dbool (Set off to disable adding virtio-=
mmio devices to the kernel cmdline)
>> +
>> +
>> +Boot options
>> +~~~~~~~~~~~~
>> +
>> +By default, microvm uses ``qboot`` as its BIOS, to obtain better boot
>> +times, but it's also compatible with ``SeaBIOS``.
>> +
>> +As no current FW is able to boot from a block device using
>> +``virtio-mmio`` as its transport, a microvm-based VM needs to be run
>> +using a host-side kernel and, optionally, an initrd image.
>> +
>> +
>> +Running a microvm-based VM
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +By default, microvm aims for maximum compatibility, enabling both
>> +legacy and non-legacy devices. In this example, a VM is created
>> +without passing any additional machine-specific option, using the
>> +legacy ``ISA serial`` device as console::
>> +
>> +  $ qemu-system-x86_64 -M microvm \
>> +     -enable-kvm -cpu host -m 512m -smp 2 \
>> +     -kernel vmlinux -append "earlyprintk=3DttyS0 console=3DttyS0 root=
=3D/dev/vda" \
>> +     -nodefaults -no-user-config -nographic \
>> +     -serial stdio \
>> +     -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
>> +     -device virtio-blk-device,drive=3Dtest \
>> +     -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
>> +     -device virtio-net-device,netdev=3Dtap0
>> +
>> +While the example above works, you might be interested in reducing the
>> +footprint further by disabling some legacy devices. If you're using
>> +``KVM``, you can disable the ``RTC``, making the Guest rely on
>> +``kvmclock`` exclusively. Additionally, if your host's CPUs have the
>> +``TSC_DEADLINE`` feature, you can also disable both the i8259 PIC and
>> +the i8254 PIT (make sure you're also emulating a CPU with such feature
>> +in the guest).
>> +
>> +This is an example of a VM with all optional legacy features
>> +disabled::
>> +
>> +  $ qemu-system-x86_64 \
>> +     -M microvm,x-option-roms=3Doff,pit=3Doff,pic=3Doff,isa-serial=3Dof=
f,rtc=3Doff \
>> +     -enable-kvm -cpu host -m 512m -smp 2 \
>> +     -kernel vmlinux -append "console=3Dhvc0 root=3D/dev/vda" \
>> +     -nodefaults -no-user-config -nographic \
>> +     -chardev stdio,id=3Dvirtiocon0,server \
>> +     -device virtio-serial-device \
>> +     -device virtconsole,chardev=3Dvirtiocon0 \
>> +     -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
>> +     -device virtio-blk-device,drive=3Dtest \
>> +     -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
>> +     -device virtio-net-device,netdev=3Dtap0
>> --=20
>> 2.21.0
>>=20
>>=20
>
> Regards,
> Daniel


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2oVUAACgkQ9GknjS8M
AjVVxhAApC+vcWnK2ONLTirD1+eJVxLNOyJngLRL6ZbgK/dQIKgwl6r1rAdAi5Gh
5cjlh13q7NJ5l6PkfpUPzJTtkOa0ucPnPZ7UWIL3vm2/mtkYJHm4k9DqMQIkBDMc
k3jl3LKT9Qy3LyHyqYzuVjis5CnIJXT+RE4BJa4p+lhbtOJsgmVFLQNaYHbDASs4
etfSyOUsC6ICJY6d2xEpnHI2nBPBAonC6AAYJWlm7GW0ssBgylG4kSfVKW2VFwNI
nqZdhJWlC+yFUVcrYtclWON41hqwS8wzlPxuknZaWZYLwXgSFgzaqWHEqe/JxNGc
t9xA/880B2mm9kV/f5eYIacGVST/y7u7+t8RxXfdJDpIxq/3gi/KlmK1GAjb2MPR
h3P8Dh8EM6YT9XuBbd6pXYcdIzvaVm5uBPmstD8v+V6XkyhrIg/pGolbrYwFlVUO
nRZkIO25cNZjWaQ+LbuWdU+0jkxYc9I6x0QBolGtKOLVkt/2Gmaja8WJJqCVDVhr
RqVtp7Sj3KxEh7ZX9Zy9Idb5JTMQTIKMPAAX4F8HZXKUhyVDIJzGRkyQjlzDiUp0
C96j9lABgWtek90g3+bOZLWt9bsySLuKAtNBhASIJch0hpWzSfb0B6DrCvAJLVsJ
uVnIfK+5w9GprTLTWhFa06n1ShblGYFRAjeUZV/nI+TB1BR13Cw=
=U56e
-----END PGP SIGNATURE-----
--=-=-=--

