Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415F8C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:03:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C51820833
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 13:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpyNpmkM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C51820833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iblMS-0007Xc-1p
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 08:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55115)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iblKy-0006r6-Ee
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:02:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iblKw-0000HE-2Q
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:01:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43335
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iblKv-0000F3-Lw
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 08:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575291714;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GzPSrbbnRQzS8PE/34E97Ue/tvVZvt4K2cDgx0sRg7g=;
 b=NpyNpmkMGlcBP98NjqmRxrlQ68LK/Xkw9GZNUkaBwlGFgh5qBHoT86zLhOatuN/AbcPX4O
 Mw/G/w1G9T7BKdFHIRZUOceT0eAgVl8+z3rRgpd36oueKftM80RgM10lUyEEmMpIi+ILqf
 7n93h+GBLu6QlQhv7oTIY01eY/UHpZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-rO62Vu6pPee6W8BVLb3XrA-1; Mon, 02 Dec 2019 08:01:52 -0500
X-MC-Unique: rO62Vu6pPee6W8BVLb3XrA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70EF2801E72;
 Mon,  2 Dec 2019 13:01:51 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C9E0B6764D;
 Mon,  2 Dec 2019 13:01:47 +0000 (UTC)
References: <20191018105315.27511-1-slp@redhat.com>
 <87imn58gyd.fsf@dusky.pond.sub.org>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v11 00/15] Introduce the microvm machine type
In-reply-to: <87imn58gyd.fsf@dusky.pond.sub.org>
Date: Mon, 02 Dec 2019 14:01:42 +0100
Message-ID: <87k17e3mq1.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: berrange@redhat.com, ehabkost@redhat.com, mst@redhat.com, philmd@redhat.com,
 groug@kaod.org, qemu-devel@nongnu.org, marcandre.lureau@gmail.com,
 kraxel@redhat.com, imammedo@redhat.com, pbonzini@redhat.com, rth@twiddle.net,
 lersek@redhat.com, sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Markus Armbruster <armbru@redhat.com> writes:

> Sergio Lopez <slp@redhat.com> writes:
>
>> microvm is a machine type inspired by Firecracker and constructed
>> after its machine model.
>>
>> It's a minimalist machine type without PCI nor ACPI support, designed
>> for short-lived guests. microvm also establishes a baseline for
>> benchmarking and optimizing both QEMU and guest operating systems,
>> since it is optimized for both boot time and footprint.
>
> I know this has been merged, but I ask anyway: got some boot time and
> memory footprint measurements?

It's been a while since I ran an instrumented kernel, but I've been
playing a bit with OSv (thanks to a question in qemu-discuss), which is
aggressively optimized for boot time, and I have some numbers.

This is using a QEMU build with some patches to be able to do a
microvm-only build that "I have not yet submitted but shouldn't be
controversial" (TM) [1]. The Q35 binary was also built having only the
Q35 machine type enabled.

In this test, OSv runs to userspace and then shuts down. OSv gives us
its boot time (from entry point to userspace), and I also get the
execution totals with "time". Variation between runs is +-2%:

------------
| qemu-q35 |
------------

Boot time
=3D=3D=3D=3D=3D=3D=3D=3D=3D

time ./x86_64-softmmu/qemu-system-x86_64 -M q35 -enable-kvm \
 -cpu host -m 64m -kernel ~/osv/build/release/loader-stripped.elf \
 -append "/hello" -serial stdio -nodefaults -no-user-config \
 -nographic -no-reboot -device virtio-blk,id=3Dblk0,drive=3Dhd0,scsi=3Doff =
\
 -drive file=3D~/osv/build/release/usr.img,if=3Dnone,id=3Dhd0,cache=3Dnone =
\
 -global virtio-mmio.force-legacy=3Doff -no-reboot

SeaBIOS (version rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org)
Booting from ROM..OSv v0.54.0-26-gcccc7d40
Booted up in 11.77 ms
Cmdline: /hello
Hello from C code

real    0m0.073s
user    0m0.034s
sys     0m0.029s


Size
=3D=3D=3D=3D

# ls -l x86_64-softmmu/qemu-system-x86_64*
-rwxr-xr-x. 1 root root 13400680 Dec  2 07:31 x86_64-softmmu/qemu-system-x8=
6_64
-rwxr-xr-x. 1 root root 11707344 Dec  2 07:51 x86_64-softmmu/qemu-system-x8=
6_64.stripped


----------------
| qemu-microvm |
----------------

Boot time
=3D=3D=3D=3D=3D=3D=3D=3D=3D

time ./x86_64-softmmu/qemu-system-x86_64 -M microvm -enable-kvm \
 -cpu host -m 64m -smp 1 \
 -kernel ~/osv/build/release/loader-stripped.elf \
 -append "--nopci /hello" -serial stdio -nodefaults -no-user-config \
 -nographic -no-reboot \
 -device virtio-blk-device,id=3Dblk0,drive=3Dhd0,scsi=3Doff \
 -drive file=3D~/osv/build/release/usr.img,if=3Dnone,id=3Dhd0 \
 -global virtio-mmio.force-legacy=3Doff=20

OSv v0.54.0-26-gcccc7d40
Booted up in 3.64 ms
Cmdline: /hello=20
Hello from C code

real=090m0.020s
user=090m0.009s
sys     0m0.011s


Size
=3D=3D=3D=3D

# ls -l x86_64-softmmu/qemu-system-x86_64*
-rwxr-xr-x. 1 root root 7823344 Dec  2 07:35 x86_64-softmmu/qemu-system-x86=
_64
-rwxr-xr-x. 1 root root 6486992 Dec  2 07:55 x86_64-softmmu/qemu-system-x86=
_64.stripped


I don't have numbers for memory footprint. It'd be nice coming up with
some reasonable methodology for getting them, as there a significant
amount of moving parts there that can have an impact on memory
consumption.

Sergio.

[1] https://github.com/slp/qemu/tree/microvm_only

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl3lCzYACgkQ9GknjS8M
AjVF5A//T6Sz6kbUVznpxcx2V/HX3DARKY9V2ho57u8otHpEYhHh9DBIXXWEe7QT
eYkmzVobFFk/44QHtrXiljra9ZChAEwz16AxC139Mf3gUfVP8YR5+hxbZg9d6UC6
3bqjfrG/h/jXuT+jU2ci0BSLzmj5CY2SO0SVhSL01XKcwAFxqx3g6XOtML0Id4Ng
9xNDyAlr5PRlxSJdnJFmM8vHJZ91roODlj3zNQbV/JNtYFyIIday0ViMMdZXbvk5
/qF+yRKqIkhYHMr/pC52Jc1UXmgKd8BYA/Lo5ksOez4x7z/RiIEpyWrxDRKverqd
31NlYazwsA9KPB76cIHT7sLnAlcudYpD1v7DMBPABPQoyCrjek8WzjhyyYb6IyCg
1IGoa5qJHe3qKZANR4YRONLTIiSWe6A5Hd6mjbxRrN68SE5Q5Zd8Go94LNSj1n7d
8q8xfSJs5fwwxtcW7DMPjZMm1UFqWoDGlH6dvBW25/1Ubm8esjMPGUwMbkp07Dbv
EfC6FXoFmgqkVwPZ0By9a+uWmlxBt8NVOPFYPCy9rew6sxKBP5jPB28lW7uomLT1
hCF/2KSVlotVh/qFufWU6VtGLJXVe2BwAx3VgIkLELOu5ZV0yJXsSEAJLz76clwo
N1XjzplB4nJGihSjwIFdaWG27wQDqGbj8qF3Sh7iKE71kpTvUr0=
=uy3q
-----END PGP SIGNATURE-----
--=-=-=--


