Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D1EC3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3868D2166E
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 15:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3868D2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MeE-0005iU-Af
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 11:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1i3Mcn-00057U-SC
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:46:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1i3Mcl-0004VT-Jp
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:46:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39146)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1i3Mcl-0004T4-AZ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 11:46:11 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8BD07C05686D
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 15:46:09 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id a2so2299208wrs.8
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 08:46:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version;
 bh=QUlxRPZ79pzZQaBq9bVZWvbaH/za4xgBwRhLtHmd984=;
 b=T3VXpPaxyKDH+Wn96AiUNTjDIrWpoOeGEIdPdEfwnqsx8/9GwInHt4ThZxGVS/tm9f
 ruEdwkpzb+sKNbSHfTQi7fIkVB9XwaCtwylWcCoZOyyb415Q08cD2MNzVtos1AJubcrI
 oZYU99cotVApUrEJIe0BmFa+64Cck/GXoudEJmB0PG8askteYzAuMHc0EMet/cVfOdmb
 rFaQuhpSGLhxL2mE0XfJgA+smDYVrT8HNGaZ33keFpNV4LTQn223qDapybO/+ltMNLHk
 RsiQrC0r39RLCElOe1PahI9t68cGOXbzXL8RvZrxUZpON34wBl/4wBpYq5cVnIK38W07
 ylqg==
X-Gm-Message-State: APjAAAVrFnrudIvcz8zEEt3yaRL12KK2HjhaXn41JFw0zD/TMDjMSzUU
 oYzoZ+0SiSxj4pt/dqTgtgCok84aVgDajzDL/pg4lfncMwYJ5I1giWVApvdXAoDanADVGvXeKv9
 lu6A19WF7HxQCgBg=
X-Received: by 2002:a05:600c:114e:: with SMTP id
 z14mr11911330wmz.161.1567093567988; 
 Thu, 29 Aug 2019 08:46:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxdYecrU0mdgdzg98kS9QTNR1YfXF9+M879iwX4T9cTLlJfyzYnkMa1AexmLCFyhJ0nXiapTA==
X-Received: by 2002:a05:600c:114e:: with SMTP id
 z14mr11911300wmz.161.1567093567724; 
 Thu, 29 Aug 2019 08:46:07 -0700 (PDT)
Received: from dritchie.redhat.com (139.red-95-120-215.dynamicip.rima-tde.net.
 [95.120.215.139])
 by smtp.gmail.com with ESMTPSA id m7sm5375568wmi.18.2019.08.29.08.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Aug 2019 08:46:06 -0700 (PDT)
References: <20190702121106.28374-1-slp@redhat.com>
 <879c7f68-95a3-3bf6-cba8-d3465770d399@linux.intel.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Jing Liu <jing2.liu@linux.intel.com>
In-reply-to: <879c7f68-95a3-3bf6-cba8-d3465770d399@linux.intel.com>
Date: Thu, 29 Aug 2019 17:46:04 +0200
Message-ID: <87lfvc3rgj.fsf@redhat.com>
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
> The idea is interesting and I tried to launch a guest by your
> guide but seems failed to me. I tried both legacy and normal modes,
> but the vncviewer connected and told me that:
> The vm has no graphic display device.
> All the screen in vnc is just black.

The microvm machine type doesn't support any graphics device, so you
need to rely on the serial console.

> kernel config:
> CONFIG_KVM_MMIO=y
> CONFIG_VIRTIO_MMIO=y
>
> I don't know if any specified kernel version/patch/config
> is needed or anything I missed.
> Could you kindly give some tips?

I'm testing it with upstream vanilla Linux. In addition to MMIO, you
need to add support for PVH (the next version of this patchset, v4, will
support booting from FW, so it'll be possible to use non-PVH ELF kernels
and bzImages too).

I've just uploaded a working kernel config here:

https://gist.github.com/slp/1060ba3aaf708584572ad4109f28c8f9

As for the QEMU command line, something like this should do the trick:

./x86_64-softmmu/qemu-system-x86_64 -smp 1 -m 1g -enable-kvm -M microvm,legacy -kernel vmlinux -append "earlyprintk=ttyS0 console=ttyS0 reboot=k panic=1" -nodefaults -no-user-config -nographic -serial stdio

If this works, you can move to non-legacy mode with a virtio-console:

./x86_64-softmmu/qemu-system-x86_64 -smp 1 -m 1g -enable-kvm -M microvm -kernel vmlinux -append "console=hvc0 reboot=k panic=1" -nodefaults -no-user-config -nographic -serial pty -chardev stdio,id=virtiocon0,server -device virtio-serial-device -device virtconsole,chardev=virtiocon0

If is still working, you can try adding some devices too:

./x86_64-softmmu/qemu-system-x86_64 -smp 1 -m 1g -enable-kvm -M microvm -kernel vmlinux -append "console=hvc0 reboot=k panic=1 root=/dev/vda" -nodefaults -no-user-config -nographic -serial pty -chardev stdio,id=virtiocon0,server -device virtio-serial-device -device virtconsole,chardev=virtiocon0 -netdev user,id=testnet -device virtio-net-device,netdev=testnet -drive id=test,file=alpine-rootfs-x86_64.raw,format=raw,if=none -device virtio-blk-device,drive=test

Sergio.

> Thanks very much.
> Jing
>
>
>
>> A QEMU instance with the microvm machine type can be invoked this way:
>>
>>   - Normal mode:
>>
>> qemu-system-x86_64 -M microvm -m 512m -smp 2 \
>>   -kernel vmlinux -append "console=hvc0 root=/dev/vda" \
>>   -nodefaults -no-user-config \
>>   -chardev pty,id=virtiocon0,server \
>>   -device virtio-serial-device \
>>   -device virtconsole,chardev=virtiocon0 \
>>   -drive id=test,file=test.img,format=raw,if=none \
>>   -device virtio-blk-device,drive=test \
>>   -netdev tap,id=tap0,script=no,downscript=no \
>>   -device virtio-net-device,netdev=tap0
>>
>>   - Legacy mode:
>>
>> qemu-system-x86_64 -M microvm,legacy -m 512m -smp 2 \
>>   -kernel vmlinux -append "console=ttyS0 root=/dev/vda" \
>>   -nodefaults -no-user-config \
>>   -drive id=test,file=test.img,format=raw,if=none \
>>   -device virtio-blk-device,drive=test \
>>   -netdev tap,id=tap0,script=no,downscript=no \
>>   -device virtio-net-device,netdev=tap0 \
>>   -serial stdio
>>


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl1n8zwACgkQ9GknjS8M
AjW4/w//XQ6zazh7zk4x3mWpgkLpizUsYtlBkExplngiVhST3bwG+ZeAKzypIeTO
cUu7OVC7cEnR0eRwrPCCN2Soggay3pQt7whMKNz8lrd1EUr8yw3QGhiK8m1upMjZ
HNH2pdTNNUsIeKXWNpfo6/H0fUDsj7CytLBJX7dWBUoC7QoiLC9V65gk9rb6MlXC
5EZ70YCV8VmgxX1eHrIje1Dm7vOZTMv8YaomCSwaag3Q7qhZhSOiHkgN57JL3MTN
t68xvS4zgWRMQIuAjVNhV/Am3lgHpGfYDrvLoBRZ+SOA9wFDHUQtW9CTTx+itcE/
3bkzFoakU4z17aqnmZg6+cKr6O0hagnvvIkWzl2xDiEZUYESxAHl5Q4a4XkUo6hP
7Kw01Fo6weo5ZHpAIKF1835dTsIgb8n8eCJecv+w2j9f+kgbcVje244jzhBI2c86
l75dhYBjQPyGObb/HI9X8jNU0kkbZZ27qhcmwzUMJwHF9vbRtKmM2LeG0Acy1haF
LObURt6GPUjpR5vBVECx0O9bnLu1gjndY/W6WP8RgVouJ7a8jezEc+JgQFpiGTSs
MO5SiMOpnkIfXzT/K/uPLbUrqDr464C2jguZta1HwjpiUFXoRqTvG5lqtsDW4wEu
9FLgGJBUbDL7MUA+trP4TVmQoPLxylSTlp5sS4YoF43lhDJDkiY=
=llzG
-----END PGP SIGNATURE-----
--=-=-=--

