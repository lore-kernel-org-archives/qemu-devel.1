Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F5BFC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 23:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E23BB22245
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 23:40:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5RdLrn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E23BB22245
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kR20N-0000zL-N1
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 19:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kR1yO-0000Jd-B3
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 19:38:52 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:43535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kR1yM-00061D-8b
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 19:38:52 -0400
Received: by mail-il1-x141.google.com with SMTP id t7so9574911ilf.10
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 16:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3zOjGZz0+D4D+6u+ar2OrfIXWj1/fx5JIXD9ruN+WlI=;
 b=j5RdLrn59TqwE1O7uqfspNDOfVAzdzEd6E1+vLeBBlEQMgkh6LTIkJhBwMwbu1NlC1
 63fKLuL3jc8NjeXVxFZtps5yeKH2N46cq5z4cQoJWDDjvWpbYRHcijqvhHEr5gO0R5N6
 NU+fc6DyctWWXR9zCDtJyPLb//ypa7ENZNqTlYlsxYOEc67X5A9e/i+FpaCuoc97VGrf
 Jnu67vdZ8LkPkE8HhCutOlEQNALTpDBd38PWO3i17xHJBNQG9r8fO0haaV/vE40Gvlhl
 f7+pYHMyKNWZ+lRgfDNUOruwNu65K2nMStYgwi+L/l4vQCQXWLcQoXR60LK1gXvViccZ
 yeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3zOjGZz0+D4D+6u+ar2OrfIXWj1/fx5JIXD9ruN+WlI=;
 b=DRwF69zehzQrK9794bT5L4vTtjdP5qh2lMks41AhEYVnLDMyNgrq0r8c0PYLE0OhKh
 v1petekX+HY+/vvIPnO2S56VaajpIDerHFECn/y8pq6BT96NNuLZ4Y3+ayh5RSgay6yN
 e2sB4825+0sLdki8E/kvvg9qxHygMDey+PYM0l8moi7CO5xj74H8UnhP80fIquX7r0wf
 GbiTxpEz7pawjWUP75y1Kc70jWXr0LNSONMWQLf06jqUmQSzD+stKOzkPrQHhl8SvC6z
 LYaNsmOQ2nzcvUxsSensGDfWEFBJ716IiDUdF4rrHTq6f1/6m21NKkqXFdCn9l++13dL
 ri/w==
X-Gm-Message-State: AOAM530V75uNQ9d4pR4B+V0UWzUp2PJQx1SV/OIBHBTRZIwQ3YFrasu3
 PFKsbJ6ebMp2gW4mp2XoffBFH6iWVai+El/Ai/M=
X-Google-Smtp-Source: ABdhPJwlpOJdj2e4DpQEAtItezbvM+pyceRNsZCddWN06NBcKE99h4V3CWakHmv/075B/9Ohf1IlZ/Wpea1n9scyyVQ=
X-Received: by 2002:a92:84c5:: with SMTP id y66mr12767631ilk.131.1602286729071; 
 Fri, 09 Oct 2020 16:38:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201009170742.23695-1-alex.bennee@linaro.org>
In-Reply-To: <20201009170742.23695-1-alex.bennee@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 9 Oct 2020 16:27:14 -0700
Message-ID: <CAKmqyKNKAaYCR_LgROZYHjTjFn2FeAJ5nhikCF2g+XeNU1J2MQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] generic loader FDT support (for direct Xen boot)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Oct 9, 2020 at 10:07 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> Hi,
>
> This series adds the ability to append FDT data for blobs loaded by
> the generic loader. My principle use-case was to be able to directly
> boot Xen with a kernel image which avoided having to:
>
>   - get the kernel image into my system image
>   - deal with bugs in FDT munging by -bios firmware and/or grub
>
> as such this currently a developer hack that makes *my* life easy and
> is thus presented as an RFC for discussion. While I've tested it with
> Xen I'm sure the approach would be applicable to other hypervisors or
> firmware which expect to consume FDT data pointing at various blobs.

An interesting idea. I think this comes up enough that it's worth
thinking about.

>
> An example command line that launches this is (magic from -kernel):
>
>   ./aarch64-softmmu/qemu-system-aarch64 -cpu cortex-a57 \
>     -machine type=3Dvirt,virtualization=3Don -display none \
>     -serial mon:stdio \
>     -netdev user,id=3Dunet,hostfwd=3Dtcp::2222-:22 \
>     -device virtio-net-pci,netdev=3Dunet,id=3Dvirt-net,disable-legacy=3Do=
n \
>     -device virtio-scsi-pci,id=3Dvirt-scsi,disable-legacy=3Don \
>     -blockdev driver=3Draw,node-name=3Dhd,discard=3Dunmap,file.driver=3Dh=
ost_device,file.filename=3D/dev/zen-disk/debian-buster-arm64 \
>     -device scsi-hd,drive=3Dhd,id=3Dvirt-scsi-hd \
>     -smp 4 -m 4096 \
>     -kernel ~/lsrc/xen.git/xen/xen \
>     -append "dom0_mem=3D1G,max:1G loglvl=3Dall guest_loglvl=3Dall" \
>     -device loader,addr=3D0x47000000,file=3D$HOME/lsrc/linux.git/builds/a=
rm64/arch/arm64/boot/Image,len-fdt-compat=3D2,fdt-compat[0]=3D'multiboot,,m=
odule',fdt-compat[1]=3D'multiboot,,kernel',fdt-bootargs=3D"root=3D/dev/sda2=
 ro console=3Dhvc0 earlyprintk=3Dxen"

You are loading the kernel `Image` file, but changing the device tree
that was generated by QEMU and is being loaded in memory. As a user
that is really confusing.

>
> So a couple of choices I've made doing this:
>
> Promoting *fdt to MachineState
>
> This seemed the simplest approach to making the fdt available to the
> global state, especially as MachineState already has a *dtb pointer.
> I've converted the ARM virt machine and a RISCV machine but if this is
> acceptable I can convert the others.

This seems fine to me.

>
> "Polluting" the generic loader arguments
>
> This was mainly out of convenience as the loader already knows the
> size of the blob being loaded. However you could certainly argue it
> makes sense to have a more generic "FDT expander" virtual device that
> could for example query the QOM model somehow to find the details it
> needs.

That seems like a better option. Why not have a generic way to modify
the device tree with a specific argument? It could either be -device
loader,file=3Dfdt,... or -fdt ...

Alistair

>
> FDT isn't the only way of passing system information up the boot
> chain. We could reasonably want to do a similar thing with ACPI which
> is what should be being used on SBSA like devices to communicate with
> the hypervisor.
>
> Also relying on ,, in the QemuOpt parser is ugly. It might be worth
> having better quoting support if I press on with this.
>
> So what do people think? Something worth developing?
>
>
> Alex Benn=C3=A9e (4):
>   hw/board: promote fdt from ARM VirtMachineState to MachineState
>   hw/riscv: migrate fdt field to generic MachineState
>   device_tree: add qemu_fdt_setprop_string_array helper
>   generic_loader: allow the insertion of /chosen/module stanzas
>
>  include/hw/arm/virt.h            |   1 -
>  include/hw/boards.h              |   1 +
>  include/hw/core/generic-loader.h |   4 +
>  include/hw/riscv/virt.h          |   1 -
>  include/sysemu/device_tree.h     |  17 ++
>  device_tree.c                    |  26 +++
>  hw/arm/virt.c                    | 322 ++++++++++++++++---------------
>  hw/core/generic-loader.c         |  42 ++++
>  hw/riscv/virt.c                  |  18 +-
>  9 files changed, 268 insertions(+), 164 deletions(-)
>
> --
> 2.20.1
>
>

