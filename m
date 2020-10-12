Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D474C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49EBF20776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnMBkhzs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49EBF20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0X8-00085m-6S
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kS0Hv-0003tN-V6
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:03:03 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42097)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kS0Ht-0002LQ-Q6
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:03:03 -0400
Received: by mail-wr1-x442.google.com with SMTP id e18so19775308wrw.9
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gFVkK9oJhwisTN4IwdM+gsPOVQdJ+VZmV2jHWsg11K4=;
 b=UnMBkhzs5TYSot3vaGssXGqBi7m9pOTb0zryU9DIkdJacGirVvmgAnwHlbSCnYzRMx
 JUa3LsHO8/6kr0WNdgh1NJd5qi6cwivM0dfGwX8Uf5SS8jOo9W3S7eahca4ak4ZCzs4E
 Bxaje2LcUoHZdPfg0b3S+T5hhJOo6ME90ZZRoZnYSTT5nw7wU1n2unTl7uZyTz4ngL+l
 r0aYAbLtcrE+5foyTQp6v7jBFKXQ2cLZAmf27Fp9sRQsNcTZlmt10WlgRivy/BhKkf5u
 ExirJGrjAbjKmf/EnrG/AprA2ASePvMP+y4ygmT6nGXBH2VJrZ10/JbW8aOme8rX/nwh
 8nlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gFVkK9oJhwisTN4IwdM+gsPOVQdJ+VZmV2jHWsg11K4=;
 b=s2BnfuedmanyIALgyOWBSFhaMd6JJaBdXD/FDaYiMb3dg1jhtEb93jSheRkRM5qhbU
 ld5M1WQJoZb1VgbyOMioyFJcA2dafPNAlZIO0v8IxOAeUmvoEukM+EQbvo48RqQVE5I6
 3stWxzBvzSfI6PHV2BXRsLI4yNigBU2CSEoamuch45BBCwojwdRxpKnnmBMVgJjYE1WE
 nKu4vfyK/MfsRnlBBXNjB+GgJmlR0+sz9oqR8cIBLCARjthZmc5cmKqm17MzqTTCHCsL
 A8o4EOEeohZn+ly3xEGoasUoREqYd92mWdLbJ0h2tH9BQegjUqV2xWgRAGiE8PRUgQN2
 Xvqg==
X-Gm-Message-State: AOAM531OufyXeezOt/jvlt1gX8j5TOsYxb1JOAzg3nwa7panVl31djtx
 MZqyY8yf6gjGPMPfZm+ekYwPTg==
X-Google-Smtp-Source: ABdhPJzaOTSXcGG5Vz1OK7msWJLku2QSIYUxBAJPIAxQibfwAaOddlemTihXk5/31YoLxap/MpApJg==
X-Received: by 2002:adf:c3c2:: with SMTP id d2mr31716628wrg.191.1602518580059; 
 Mon, 12 Oct 2020 09:03:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 64sm4911060wmd.3.2020.10.12.09.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 09:02:58 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EC7731FF7E;
 Mon, 12 Oct 2020 17:02:57 +0100 (BST)
References: <20201009170742.23695-1-alex.bennee@linaro.org>
 <CAKmqyKNKAaYCR_LgROZYHjTjFn2FeAJ5nhikCF2g+XeNU1J2MQ@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alistair Francis <alistair23@gmail.com>
Subject: Re: [RFC PATCH 0/4] generic loader FDT support (for direct Xen boot)
In-reply-to: <CAKmqyKNKAaYCR_LgROZYHjTjFn2FeAJ5nhikCF2g+XeNU1J2MQ@mail.gmail.com>
Date: Mon, 12 Oct 2020 17:02:57 +0100
Message-ID: <87lfgbzb2m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 takahiro.akashi@linaro.org, stefano.stabellini@xilinx.com,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Alistair Francis <alistair23@gmail.com> writes:

> On Fri, Oct 9, 2020 at 10:07 AM Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
>>
>> Hi,
>>
>> This series adds the ability to append FDT data for blobs loaded by
>> the generic loader. My principle use-case was to be able to directly
>> boot Xen with a kernel image which avoided having to:
>>
>>   - get the kernel image into my system image
>>   - deal with bugs in FDT munging by -bios firmware and/or grub
>>
>> as such this currently a developer hack that makes *my* life easy and
>> is thus presented as an RFC for discussion. While I've tested it with
>> Xen I'm sure the approach would be applicable to other hypervisors or
>> firmware which expect to consume FDT data pointing at various blobs.
>
> An interesting idea. I think this comes up enough that it's worth
> thinking about.
>
>>
>> An example command line that launches this is (magic from -kernel):
>>
>>   ./aarch64-softmmu/qemu-system-aarch64 -cpu cortex-a57 \
>>     -machine type=3Dvirt,virtualization=3Don -display none \
>>     -serial mon:stdio \
>>     -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22 \
>>     -device virtio-net-pci,netdev=3Dunet,id=3Dvirt-net,disable-legacy=3D=
on \
>>     -device virtio-scsi-pci,id=3Dvirt-scsi,disable-legacy=3Don \
>>     -blockdev driver=3Draw,node-name=3Dhd,discard=3Dunmap,file.driver=3D=
host_device,file.filename=3D/dev/zen-disk/debian-buster-arm64 \
>>     -device scsi-hd,drive=3Dhd,id=3Dvirt-scsi-hd \
>>     -smp 4 -m 4096 \
>>     -kernel ~/lsrc/xen.git/xen/xen \
>>     -append "dom0_mem=3D1G,max:1G loglvl=3Dall guest_loglvl=3Dall" \
>>     -device loader,addr=3D0x47000000,file=3D$HOME/lsrc/linux.git/builds/=
arm64/arch/arm64/boot/Image,len-fdt-compat=3D2,fdt-compat[0]=3D'multiboot,,=
module',fdt-compat[1]=3D'multiboot,,kernel',fdt-bootargs=3D"root=3D/dev/sda=
2 ro console=3Dhvc0 earlyprintk=3Dxen"
>
> You are loading the kernel `Image` file, but changing the device tree
> that was generated by QEMU and is being loaded in memory. As a user
> that is really confusing.

Well in this case the "kernel" is Xen which helpfully comes with a
kernel compatible header that the kernel loaded understand. The blob
could be any Dom0 kernel - it just happens to be a Linux kernel in this
case.

>
>>
>> So a couple of choices I've made doing this:
>>
>> Promoting *fdt to MachineState
>>
>> This seemed the simplest approach to making the fdt available to the
>> global state, especially as MachineState already has a *dtb pointer.
>> I've converted the ARM virt machine and a RISCV machine but if this is
>> acceptable I can convert the others.
>
> This seems fine to me.
>
>>
>> "Polluting" the generic loader arguments
>>
>> This was mainly out of convenience as the loader already knows the
>> size of the blob being loaded. However you could certainly argue it
>> makes sense to have a more generic "FDT expander" virtual device that
>> could for example query the QOM model somehow to find the details it
>> needs.
>
> That seems like a better option. Why not have a generic way to modify
> the device tree with a specific argument? It could either be -device
> loader,file=3Dfdt,... or -fdt ...

Well it comes down to how much of a special case this is? Pretty much
all FDT (and ACPI for the matter) is basically down to the board level
models - and not all of them just the funky configurable ones. For other
board models we just expect the user to pass the FDT they got with their
kernel blob.

For modern VirtIO systems the only thing you really need to expose is
the root PCI bus because the rest of the devices are discover-able
there.

So the real question is are there any other -devices that we want to be
able to graft FDT entries on or is the generic loader enough of a
special case that we keep all the logic in there?

>
> Alistair
>
>>
>> FDT isn't the only way of passing system information up the boot
>> chain. We could reasonably want to do a similar thing with ACPI which
>> is what should be being used on SBSA like devices to communicate with
>> the hypervisor.
>>
>> Also relying on ,, in the QemuOpt parser is ugly. It might be worth
>> having better quoting support if I press on with this.
>>
>> So what do people think? Something worth developing?
>>
>>
>> Alex Benn=C3=A9e (4):
>>   hw/board: promote fdt from ARM VirtMachineState to MachineState
>>   hw/riscv: migrate fdt field to generic MachineState
>>   device_tree: add qemu_fdt_setprop_string_array helper
>>   generic_loader: allow the insertion of /chosen/module stanzas
>>
>>  include/hw/arm/virt.h            |   1 -
>>  include/hw/boards.h              |   1 +
>>  include/hw/core/generic-loader.h |   4 +
>>  include/hw/riscv/virt.h          |   1 -
>>  include/sysemu/device_tree.h     |  17 ++
>>  device_tree.c                    |  26 +++
>>  hw/arm/virt.c                    | 322 ++++++++++++++++---------------
>>  hw/core/generic-loader.c         |  42 ++++
>>  hw/riscv/virt.c                  |  18 +-
>>  9 files changed, 268 insertions(+), 164 deletions(-)
>>
>> --
>> 2.20.1
>>
>>


--=20
Alex Benn=C3=A9e

