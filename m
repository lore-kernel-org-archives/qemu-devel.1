Return-Path: <SRS0=DGTm=W2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E601C3A59B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40F4223407
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2019 14:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40F4223407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60648 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3hwl-0005hF-EG
	for qemu-devel@archiver.kernel.org; Fri, 30 Aug 2019 10:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58070)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i3hsH-0002mi-O9
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:27:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i3hs3-0003U2-9a
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:27:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56110)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i3hs2-0003Hk-Nd
 for qemu-devel@nongnu.org; Fri, 30 Aug 2019 10:27:23 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7C10089AC4
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 14:27:19 +0000 (UTC)
Received: by mail-ed1-f69.google.com with SMTP id b5so4301707eds.22
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2019 07:27:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=8Rzf2qw3kfGMPBrdQnkWwTg/svk9CTfljtdshOW51yo=;
 b=fNFj+FucXfN6TwUtonQScuIKTWkNxvJS2Ktld916sapAUUfE2SXc7cvixVNxrkjJse
 lQKS8PVvpxtd8RdWRPq5zyxfLeqyki6/ceq9/dB3bZtEd3pEA5wlGtcZ5ztxV0+LhiN2
 B/8LmzoKb83WR8WBgYG67kJzcsqbz7132wlc7Af2EiueW+TxlIyGZ1386lm25+e/m2Oh
 be8KsMvTgTpu/+yQbzZil7kSnTyvDGkPXIqv4Mf4mbowF/2384P1P4GeeTjtJ+xoSspd
 xP4qc0F1WpMmQlWmVpNUhdjXL2kjiWki0E+t8cLi5AsBA13/lQlNO99HyOFdnHDxPATD
 IU7g==
X-Gm-Message-State: APjAAAVmcK3a11NPjga5cU2f7bEc5waBjnToiPhw+sv1wiJK1r34Kle8
 NpsBNuKwrtfmhdyziWxiuJb30/AdBrg/aGIboxOQaoWyieg7V7EfudGuhv6jKBbSJnTT4ur+3Tf
 WmAL+yJ/P5vZhlHs=
X-Received: by 2002:a17:906:938a:: with SMTP id
 l10mr13443768ejx.232.1567175237663; 
 Fri, 30 Aug 2019 07:27:17 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzJ2djwQJxOx0Apt1vtbPkj99tH3DqA4TIDAwbQxDeik1hHPBBv4oO+6Pb8DddFqKX2aOaMqw==
X-Received: by 2002:a17:906:938a:: with SMTP id
 l10mr13443739ejx.232.1567175237407; 
 Fri, 30 Aug 2019 07:27:17 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id i24sm322517eds.27.2019.08.30.07.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2019 07:27:16 -0700 (PDT)
References: <20190702121106.28374-1-slp@redhat.com>
 <879c7f68-95a3-3bf6-cba8-d3465770d399@linux.intel.com>
 <87lfvc3rgj.fsf@redhat.com>
 <18777980-a2ca-fe27-419b-6e2bd213dd17@linux.intel.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Jing Liu <jing2.liu@linux.intel.com>
In-reply-to: <18777980-a2ca-fe27-419b-6e2bd213dd17@linux.intel.com>
Date: Fri, 30 Aug 2019 16:27:11 +0200
Message-ID: <87ftlibuf4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, maran.wilson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, pbonzini@redhat.com,
 sgarzare@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Jing Liu <jing2.liu@linux.intel.com> writes:

> Hi Sergio,
>
> On 8/29/2019 11:46 PM, Sergio Lopez wrote:
>>
>> Jing Liu <jing2.liu@linux.intel.com> writes:
>>
>>> Hi Sergio,
>>>
>>> The idea is interesting and I tried to launch a guest by your
>>> guide but seems failed to me. I tried both legacy and normal modes,
>>> but the vncviewer connected and told me that:
>>> The vm has no graphic display device.
>>> All the screen in vnc is just black.
>>
>> The microvm machine type doesn't support any graphics device, so you
>> need to rely on the serial console.
> Got it.
>
>>
>>> kernel config:
>>> CONFIG_KVM_MMIO=y
>>> CONFIG_VIRTIO_MMIO=y
>>>
>>> I don't know if any specified kernel version/patch/config
>>> is needed or anything I missed.
>>> Could you kindly give some tips?
>>
>> I'm testing it with upstream vanilla Linux. In addition to MMIO, you
>> need to add support for PVH (the next version of this patchset, v4, will
>> support booting from FW, so it'll be possible to use non-PVH ELF kernels
>> and bzImages too).
>>
>> I've just uploaded a working kernel config here:
>>
>> https://gist.github.com/slp/1060ba3aaf708584572ad4109f28c8f9
>>
> Thanks very much and this config is helpful to me.
>
>> As for the QEMU command line, something like this should do the trick:
>>
>> ./x86_64-softmmu/qemu-system-x86_64 -smp 1 -m 1g -enable-kvm -M microvm,legacy -kernel vmlinux -append "earlyprintk=ttyS0 console=ttyS0 reboot=k panic=1" -nodefaults -no-user-config -nographic -serial stdio
>>
>> If this works, you can move to non-legacy mode with a virtio-console:
>>
>> ./x86_64-softmmu/qemu-system-x86_64 -smp 1 -m 1g -enable-kvm -M microvm -kernel vmlinux -append "console=hvc0 reboot=k panic=1" -nodefaults -no-user-config -nographic -serial pty -chardev stdio,id=virtiocon0,server -device virtio-serial-device -device virtconsole,chardev=virtiocon0
>>
> I tried the above two ways and it works now. Thanks!
>
>> If is still working, you can try adding some devices too:
>>
>> ./x86_64-softmmu/qemu-system-x86_64 -smp 1 -m 1g -enable-kvm -M microvm -kernel vmlinux -append "console=hvc0 reboot=k panic=1 root=/dev/vda" -nodefaults -no-user-config -nographic -serial pty -chardev stdio,id=virtiocon0,server -device virtio-serial-device -device virtconsole,chardev=virtiocon0 -netdev user,id=testnet -device virtio-net-device,netdev=testnet -drive id=test,file=alpine-rootfs-x86_64.raw,format=raw,if=none -device virtio-blk-device,drive=test
>>
> But I'm wondering why the image I used can not be found.
> root=/dev/vda3 and the same image worked well on normal qemu/guest-
> config bootup, but didn't work here. The details are,
>
> -append "console=hvc0 reboot=k panic=1 root=/dev/vda3 rw rootfstype=ext4" \
>
> [    0.022784] Key type encrypted registered
> [    0.022988] VFS: Cannot open root device "vda3" or
> unknown-block(254,3): error -6
> [    0.023041] Please append a correct "root=" boot option; here are
> the available partitions:
> [    0.023089] fe00         8946688 vda
> [    0.023090]  driver: virtio_blk
> [    0.023143] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(254,3)
> [    0.023201] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc3 #23
>
>
> BTW, root=/dev/vda is also tried and didn't work. The dmesg is a
> little different:
>
> [    0.028050] Key type encrypted registered
> [    0.028484] List of all partitions:
> [    0.028529] fe00         8946688 vda
> [    0.028529]  driver: virtio_blk
> [    0.028615] No filesystem could mount root, tried:
> [    0.028616]  ext4
> [    0.028670]
> [    0.028712] Kernel panic - not syncing: VFS: Unable to mount root
> fs on unknown-block(254,0)
>
> I tried another ext4 img but still doesn't work.
> Is there any limitation of blk image? Could I copy your image for simple
> test?

The kernel config I posted lacks support for DOS partitions. Adding
CONFIG_MSDOS_PARTITION=y should allow you to boot from /dev/vda3.

Anyway, in case you also want to try booting from /dev/vda (without
partitions), this is the recipe I use to quickly create a minimal rootfs
image:

# wget http://dl-cdn.alpinelinux.org/alpine/v3.10/releases/x86_64/alpine-minirootfs-3.10.2-x86_64.tar.gz
# qemu-img create -f raw alpine-rootfs-x86_64.raw 1G
# sudo losetup /dev/loop0 alpine-rootfs-x86_64.raw
# sudo mkfs.ext4 /dev/loop0
# sudo mount /dev/loop0 /mnt
# sudo tar xpf alpine-minirootfs-3.10.2-x86_64.tar.gz -C /mnt
# sudo umount /mnt
# sudo losetup -d /dev/loop0

The rootfs will be missing openrc, so you'll need to add "init=/bin/sh"
to the command line.

Sergio.

> Thanks in advance,
> Jing
>
>> Sergio.
>>
>>> Thanks very much.
>>> Jing
>>>
>>>
>>>
>>>> A QEMU instance with the microvm machine type can be invoked this way:
>>>>
>>>>    - Normal mode:
>>>>
>>>> qemu-system-x86_64 -M microvm -m 512m -smp 2 \
>>>>    -kernel vmlinux -append "console=hvc0 root=/dev/vda" \
>>>>    -nodefaults -no-user-config \
>>>>    -chardev pty,id=virtiocon0,server \
>>>>    -device virtio-serial-device \
>>>>    -device virtconsole,chardev=virtiocon0 \
>>>>    -drive id=test,file=test.img,format=raw,if=none \
>>>>    -device virtio-blk-device,drive=test \
>>>>    -netdev tap,id=tap0,script=no,downscript=no \
>>>>    -device virtio-net-device,netdev=tap0
>>>>
>>>>    - Legacy mode:
>>>>
>>>> qemu-system-x86_64 -M microvm,legacy -m 512m -smp 2 \
>>>>    -kernel vmlinux -append "console=ttyS0 root=/dev/vda" \
>>>>    -nodefaults -no-user-config \
>>>>    -drive id=test,file=test.img,format=raw,if=none \
>>>>    -device virtio-blk-device,drive=test \
>>>>    -netdev tap,id=tap0,script=no,downscript=no \
>>>>    -device virtio-net-device,netdev=tap0 \
>>>>    -serial stdio
>>>>
>>


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl1pMj8ACgkQ9GknjS8M
AjXwQg//Ruo/05XPqLUerodkCfnBEOdhh81RRs8Rlmje2WYAsYolNwyTE3BAmkc4
1YkOL4qBziSsyhqm35QQqBfAJHPInF4/wtr42y8K9HRyZg5028jglA13zadNEh/p
ooatJX940e9mfd0e5DKlj1zp30bmHRv9cNV2s9Q98CvMfCtnuXPbC91dSAB3LUYP
RwAQek0HjtVMOzHuaEvcsDhlQVIvf4QBE7CDh9oS/Z+X7ckdEvqSEF4QDSNoqF3/
arE21CA8LZ92ibll5rD+jp80LtDPevk42EGfoZWCuO56dtHsGareJwbUqzdXaggw
s9xgFHnfrbaQUrZaQIIArlPvKzdU4BoI540EQ+XEnl+uuTgrWXjDKmKb0rqCFMa7
Zic594mpL6oLIlaIDDtiBHpiJvU00OFICFNjlrzrbXEYo9gtyLri5RdKyGWFB/XZ
bz+q3uxX57roB212Ef4n2od4+HhGXY5OByyiV2dGxCZ/wYWSaESp95ltwuZ0inBm
E6BcIwWvA79AkKpiVrgmJDicjhaFYzCtlsXgKIs9zubRMN+TWtl4B+j2uoLrjtnN
JRoRlA08uHP23islrfsGEjZeefPGvZmeRH2Fb44u58hhhvVC5MjoCoXcVRhfukK/
HXU4a9FmZ0WzdcEL8LTgurL2SbfOrqp9ncDJDttuYJM4ViewcUs=
=UetG
-----END PGP SIGNATURE-----
--=-=-=--

