Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8CAC4CECE
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9300520872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 06:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9300520872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKzcG-000153-Jt
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 02:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iKzaN-0008Nz-6c
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iKzaK-0003SK-9S
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:48:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44384)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iKzaI-0003RJ-Bq
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 02:48:31 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 065D684A5
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:48:29 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id m16so579639wmg.8
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 23:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=ARSdBxmQzeKBfXYiyc8l14Y2/QvEX79Z2MbxTAg0kfg=;
 b=VoO1l0Vz0XWgmNpVR00Q0yqVvxpN2AOJU9WcrzszIzFuuiRMLUtS1+a+a70WQHek5N
 4YMSMB9Mc3GqXWJ0ezgnZ8//yfG/UK8/a7CDridOLQ+0YlMZL9ATaa8GD6GJn0Ba0FAZ
 3+emgsEWE1vBvgkVBAiKbXMnABeSZ4NT5SCjSoZcGM7zc8lf8P+PSyEzhEc217JBKbK9
 LAoln4gV0CryLLhPmKwOA889yrnMX0tNMFjTB0apDFMx04jQVks9T0y3wboqcjEpHpCd
 wYcGiI8N/ndXtvT/uNw9ni9bNYG+pGsbWYTPEWHPkykedEBsdbCqYtWxkvJOsYavmy3R
 tqCg==
X-Gm-Message-State: APjAAAVa1yTlbN/Gzp0qed+2kh8QKC9/FGYSYxVj3Ek7zXaX5I+99ZtF
 IMI5kBps/8LIrd4ywj3G5pjTa0u9KiDQVwldJLrIeVzVGK75af0lK2JVt9wH555MLN+HnCNaQiK
 OlXq0/z87VHIZjbk=
X-Received: by 2002:a1c:2d88:: with SMTP id t130mr1384281wmt.75.1571294907631; 
 Wed, 16 Oct 2019 23:48:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwWZMc9Nmhg9Yhmn+orOfBgoV3Y7XHuprVnCxHfV2hJytMsmyyAAE0N8rDS2Wgmm2ptWPK+gQ==
X-Received: by 2002:a1c:2d88:: with SMTP id t130mr1384255wmt.75.1571294907317; 
 Wed, 16 Oct 2019 23:48:27 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id o70sm1491985wme.29.2019.10.16.23.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2019 23:48:26 -0700 (PDT)
References: <20191016101241.24405-1-slp@redhat.com>
 <20191016101241.24405-14-slp@redhat.com>
 <CAJ+F1CJK51sDUKsAp5z7UOSyb-+GbWHR19hk2wr1qW4THZc-RA@mail.gmail.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Subject: Re: [PATCH v10 13/15] docs/microvm.rst: document the new microvm
 machine type
In-reply-to: <CAJ+F1CJK51sDUKsAp5z7UOSyb-+GbWHR19hk2wr1qW4THZc-RA@mail.gmail.com>
Date: Thu, 17 Oct 2019 08:48:23 +0200
Message-ID: <87h847hnpk.fsf@redhat.com>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, groug@kaod.org,
 QEMU <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Laszlo Ersek <lersek@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Wed, Oct 16, 2019 at 12:19 PM Sergio Lopez <slp@redhat.com> wrote:
>>
>> Document the new microvm machine type.
>>
>> Signed-off-by: Sergio Lopez <slp@redhat.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
>>  docs/microvm.rst | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 98 insertions(+)
>>  create mode 100644 docs/microvm.rst
>>
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
>
> server? doesn't make sense here :)

Heh, good catch!

Thanks,
Sergio.

>> +     -device virtio-serial-device \
>> +     -device virtconsole,chardev=3Dvirtiocon0 \
>> +     -drive id=3Dtest,file=3Dtest.img,format=3Draw,if=3Dnone \
>> +     -device virtio-blk-device,drive=3Dtest \
>> +     -netdev tap,id=3Dtap0,script=3Dno,downscript=3Dno \
>> +     -device virtio-net-device,netdev=3Dtap0
>> --
>> 2.21.0
>>
>>
>
> seem to work with appropriate kernel otherwise, so
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl2oDrcACgkQ9GknjS8M
AjV7HhAAjlxmfXN6vry0eOTvq6m0YtkOX0MwI6XBvdSL0AZRsURLXtEGGBcvUr2r
l9edypBJRxXtnjd+KvQyDl+JMf/U62U2QcurNGEe8VeEcDmDk1mftRLRvJUTHeIb
sDxJMNTku+U7Jd3a4dZUScIZnfVOosQvuSwacjfyhhYe0v8m3PfpvPB4zJCabi7n
JVWbeCSNnhhxOoQ1zp8jl5idarLt8UA6pRZ+hy4QR6Xnb6vmgkieDfG7wPZr6+SV
L4YKDSFep5nqzYk6dytVPt0UHgyj5YF+eo59hgWdLlHb1uAEpd3l2dPmAkw8OkUY
Otuu7JAw86ReiysBNtTTHe+318bbVjzdizHfAfSoUIPh2A/5JacEPYK7Xs9sLkt+
LQMVJVjbZGCXvQQz/3YJ7K0bJ/pmqMs2ghTwGYdGcGWf0sHBTIptooPagfXig0D+
lbx/CCUehwItRPIktAiqJtedjYnghu5MlHvswF804DwC9ceu5GhoxXNkyLW5RD3F
AwlEIFIaQErYDfSRA6Bq9/7VS+Xm43FLdIHOJrxIuP91DJHPGY+PypPvR52ezHCG
KhV/Cy8aRFZELxAYIR5Zgam0Qg2z5mC69Gw5EDGiUgEdMLyidrTHH+7h7Cc2JoYA
6+vrAvxwdwIHxJeDa0VDsuzQunJjmim8uhL5TpvXx1tX9PTaAsU=
=hEh2
-----END PGP SIGNATURE-----
--=-=-=--

