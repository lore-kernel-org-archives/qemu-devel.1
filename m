Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B48C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0A22067D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 17:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oFj4Z4kw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0A22067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS1bd-000114-Sk
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 13:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kS1aE-0000BX-DH
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:26:02 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:46796)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kS1aC-00052v-KQ
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 13:26:02 -0400
Received: by mail-lf1-x141.google.com with SMTP id v6so3477769lfa.13
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 10:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=h7EY1lxRl2b2hr54oytsqpMoXqo80RReAUYd/rDjxm8=;
 b=oFj4Z4kwvPaClXYo5sPBikSkJxm1o2orc9nDnwMWLB5IrnVp0n6R3wLWdI/baPMdBS
 gxdCYPZDIHY67dBirTifwJ105megKmIZqPao8WgXlsQbyNdg6pGYsIhQWtZEHKPY3v9b
 hpZCJ2iPF+u0tv8syTSxyLYSRzKGSQmeXOMLSu0GJQaxq/Vd/5O1i3fbxuPv955XHOTZ
 Pzt/TJgmeXAMSfg6kzq4wRCIiePK3BoHK4+2GrF8qXKFR6F3U73yn+NECZZZqKFM/pZL
 QLoFsS42+qhaiePydc9fS+CKeGhGxHl9FzDOzGMTXivnJSLNRBLtUF/kIpoDGZGgXOrj
 zxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=h7EY1lxRl2b2hr54oytsqpMoXqo80RReAUYd/rDjxm8=;
 b=ii+2Z9d+KMD/Wuij5QVWWjDuT7DpFUhI3NHftDUreNJuaLjRIxcm2Hix5y1cxT8PE6
 cneGznDIA0u4Kffrxao8UGBU3KhCDmWHCBg7VnTBaOM/KPqDJLJcEbg6F1Q9pTIVSwCg
 6xM3cqPvzKnrLSdIsr+Y+L7AqJmJ8pEe7npfaqUvWzX67cAr36nuxYfnLE3tyliUA3Ft
 r+TPRFnbRHsbnEUaS+LeLhMka3te17/LizDEcYwLqk9rh5LqOzgzegS+VWS6GoOpAGWj
 MnpBoLQEoEHoluB9oWSUDp7n8ulneMp6HKPadwaY5rUysQ7Afty6FXIOC8hZHgZ3CAWe
 sMyA==
X-Gm-Message-State: AOAM531Nz9CUZg0PzdI8V/d4+ufiRWhGHakQ9X5zxhCLsxWtOJoP8K0Y
 wpaSvCcWU3ptNJOoJJS3XTo=
X-Google-Smtp-Source: ABdhPJwzX7GrEiM9AjHZfyZmsmTkxhBTA9nx05dUlD7bJz4OBkeVe+JpYdGKUGkp9sOrxlZ8gPjXkg==
X-Received: by 2002:a19:68a:: with SMTP id 132mr7951152lfg.429.1602523558210; 
 Mon, 12 Oct 2020 10:25:58 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id q22sm3468160lfm.51.2020.10.12.10.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2020 10:25:57 -0700 (PDT)
Date: Mon, 12 Oct 2020 19:25:56 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 0/4] generic loader FDT support (for direct Xen boot)
Message-ID: <20201012172556.GF2954729@toto>
References: <20201009170742.23695-1-alex.bennee@linaro.org>
 <CAKmqyKNKAaYCR_LgROZYHjTjFn2FeAJ5nhikCF2g+XeNU1J2MQ@mail.gmail.com>
 <87lfgbzb2m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87lfgbzb2m.fsf@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
 takahiro.akashi@linaro.org, Alistair Francis <alistair23@gmail.com>,
 stefano.stabellini@xilinx.com, stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 12, 2020 at 05:02:57PM +0100, Alex Bennée wrote:
> 
> Alistair Francis <alistair23@gmail.com> writes:
> 
> > On Fri, Oct 9, 2020 at 10:07 AM Alex Bennée <alex.bennee@linaro.org> wrote:
> >>
> >> Hi,
> >>
> >> This series adds the ability to append FDT data for blobs loaded by
> >> the generic loader. My principle use-case was to be able to directly
> >> boot Xen with a kernel image which avoided having to:
> >>
> >>   - get the kernel image into my system image
> >>   - deal with bugs in FDT munging by -bios firmware and/or grub
> >>
> >> as such this currently a developer hack that makes *my* life easy and
> >> is thus presented as an RFC for discussion. While I've tested it with
> >> Xen I'm sure the approach would be applicable to other hypervisors or
> >> firmware which expect to consume FDT data pointing at various blobs.
> >
> > An interesting idea. I think this comes up enough that it's worth
> > thinking about.
> >
> >>
> >> An example command line that launches this is (magic from -kernel):
> >>
> >>   ./aarch64-softmmu/qemu-system-aarch64 -cpu cortex-a57 \
> >>     -machine type=virt,virtualization=on -display none \
> >>     -serial mon:stdio \
> >>     -netdev user,id=unet,hostfwd=tcp::2222-:22 \
> >>     -device virtio-net-pci,netdev=unet,id=virt-net,disable-legacy=on \
> >>     -device virtio-scsi-pci,id=virt-scsi,disable-legacy=on \
> >>     -blockdev driver=raw,node-name=hd,discard=unmap,file.driver=host_device,file.filename=/dev/zen-disk/debian-buster-arm64 \
> >>     -device scsi-hd,drive=hd,id=virt-scsi-hd \
> >>     -smp 4 -m 4096 \
> >>     -kernel ~/lsrc/xen.git/xen/xen \
> >>     -append "dom0_mem=1G,max:1G loglvl=all guest_loglvl=all" \
> >>     -device loader,addr=0x47000000,file=$HOME/lsrc/linux.git/builds/arm64/arch/arm64/boot/Image,len-fdt-compat=2,fdt-compat[0]='multiboot,,module',fdt-compat[1]='multiboot,,kernel',fdt-bootargs="root=/dev/sda2 ro console=hvc0 earlyprintk=xen"
> >
> > You are loading the kernel `Image` file, but changing the device tree
> > that was generated by QEMU and is being loaded in memory. As a user
> > that is really confusing.
> 
> Well in this case the "kernel" is Xen which helpfully comes with a
> kernel compatible header that the kernel loaded understand. The blob
> could be any Dom0 kernel - it just happens to be a Linux kernel in this
> case.
> 
> >
> >>
> >> So a couple of choices I've made doing this:
> >>
> >> Promoting *fdt to MachineState
> >>
> >> This seemed the simplest approach to making the fdt available to the
> >> global state, especially as MachineState already has a *dtb pointer.
> >> I've converted the ARM virt machine and a RISCV machine but if this is
> >> acceptable I can convert the others.
> >
> > This seems fine to me.
> >
> >>
> >> "Polluting" the generic loader arguments
> >>
> >> This was mainly out of convenience as the loader already knows the
> >> size of the blob being loaded. However you could certainly argue it
> >> makes sense to have a more generic "FDT expander" virtual device that
> >> could for example query the QOM model somehow to find the details it
> >> needs.
> >
> > That seems like a better option. Why not have a generic way to modify
> > the device tree with a specific argument? It could either be -device
> > loader,file=fdt,... or -fdt ...
> 
> Well it comes down to how much of a special case this is? Pretty much
> all FDT (and ACPI for the matter) is basically down to the board level
> models - and not all of them just the funky configurable ones. For other
> board models we just expect the user to pass the FDT they got with their
> kernel blob.
> 
> For modern VirtIO systems the only thing you really need to expose is
> the root PCI bus because the rest of the devices are discover-able
> there.
> 
> So the real question is are there any other -devices that we want to be
> able to graft FDT entries on or is the generic loader enough of a
> special case that we keep all the logic in there?
>

Hi,

Another option is to allow the user to pass along a DTB overlay with the
generic loader option (or with a separate option as Alistair suggested).
With overlways we wouldn't need all the command-line options to enable
construction of dtb fragments, it would be more or less transparent to
QEMU. There may be limitations with the overlay flows that I'm not aware
of though...

Cheers,
Edgar


