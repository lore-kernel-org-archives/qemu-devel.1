Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512F2C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:17:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DF712184E
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 00:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bW22tHFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DF712184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnXcy-0001Cu-8i
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 20:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45004)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hnXcl-0000mU-Q2
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hnXck-0007ou-7D
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 20:16:47 -0400
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:44960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hnXcj-0007oV-VO; Tue, 16 Jul 2019 20:16:46 -0400
Received: by mail-lf1-x142.google.com with SMTP id r15so10140208lfm.11;
 Tue, 16 Jul 2019 17:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OgPVlsbrorWi18Tla4KQmw9FL8bnAGlRzO4TGzSi/EQ=;
 b=bW22tHFWkMvxKEjj1f4yWkA+YVD08gk+KvRSbJ35V6wNxNTOGxKtFUaH0RW20gMhNt
 f3yOS4odO4Hu4uZoybkpG57/58ukSYWbiZ5f9QWm57utUA+rQuQeCvExejVEWsmluTZp
 21iW7evz8hqYKjlEyE43B+/17YjYTphbUt05FmR7TtHts9AeMkcnOo6n0HM4jDhC+qxO
 oZnN2VOGT1YTJPZLms+CF+TJ3w9WFPMuXk1WITWqaRi1xWiBM7RzV7tNBcHEz6mJ1IWZ
 okLq+ZsR5ySLEG5Nm7riMFTLzCRwtgLv19aUq488E2A8oTa9VwaXFDneEPEZhduS6dIG
 FPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OgPVlsbrorWi18Tla4KQmw9FL8bnAGlRzO4TGzSi/EQ=;
 b=TEQwKZ6qbzp8fP8A1fg+s5CXRUsDTZzbePJJoNoWt7XjGRZjkeE1MdHlmITKF+XnsR
 IzoElbVXSMiD8gsYSYr/Al9+AULfXT0blTiFYqoA/1jSNY/9VFKO7lto0Njy4o2+1AnV
 DgfnMY2EbWcySB7KRts4YpgUukXBAVInt/cQTQ3pMqxWC8FWrfCyK1NgFqlaaLNz5Sn3
 YpAiAB6yByS5Ixm/9yZ8Xw2MghktrNuNOzf4Ru8MWC5A/OUkO9+mtdej2PDySvKfzlR0
 oFB9hJCYdeO42qqCnvuvJbyOWYoixU4ygDtJeLizj7g5sgg8CT/v01JigxWR+sMLkiF/
 py4Q==
X-Gm-Message-State: APjAAAUhtzxV9qAV/iOQWvD1Lyq//bNEeN3NoY5aoEg/Z7976NumrebM
 ySUytjiICrbYtmewYxICq9Ee07VGldALJNscA+k=
X-Google-Smtp-Source: APXvYqw7ajG+ZF8BnG3zQp0p0BgcoxEe1oaOudPeqCugkwm8hBRHZsf1RpW+2IxyCYLpKlvYmSKqx6OgdHX4Ff+nbd4=
X-Received: by 2002:a19:7006:: with SMTP id h6mr15966240lfc.5.1563322603906;
 Tue, 16 Jul 2019 17:16:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1559944445.git.alistair.francis@wdc.com>
 <CAEiOBXWT=npMfc5kJ_kiRPk4LQe7Nfj13-sEYFtaJ_zHRdCxSQ@mail.gmail.com>
In-Reply-To: <CAEiOBXWT=npMfc5kJ_kiRPk4LQe7Nfj13-sEYFtaJ_zHRdCxSQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jul 2019 17:13:25 -0700
Message-ID: <CAKmqyKMVPUvkaXLZ7_3yjU-byHA9Ohhy=kWr+ExKW3e38=AkMw@mail.gmail.com>
To: Chih-Min Chao <chihmin.chao@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::142
Subject: Re: [Qemu-devel] [PATCH v1 00/27] Add RISC-V Hypervisor Extension
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 15, 2019 at 4:50 AM Chih-Min Chao <chihmin.chao@sifive.com> wrote:
>
>
>
> On Sat, Jun 8, 2019 at 6:03 AM Alistair Francis <alistair.francis@wdc.com> wrote:
>>
>> This patch series adds the RISC-V Hypervisor extension 0.3. This is the
>> latest draft spec of the Hypervisor extension.
>>
>> The Hypervisor extension is disabled by default, so this series should
>> result in no changes to anyone using QEMU unless they enable the
>> extension. The extention can be enabled with the -cpu property (see
>> below).
>>
>> At the moment the spec does not include information about the mstatush
>> register. As it is not in the spec I haven't added it to QEMU. This
>> means the extension won't work correctly for 32-bit guests. This should
>> be a small fix to add the CSR once the spec is updated.
>>
>> All testing of this implementation has been done by using the baremetal
>> Xvisor Hypervisor. We are able to run two Linux guests (that's all I
>> have tried) as guests.
>>
>> At the moment this spec is in a draft state and is subject to change. As
>> QEMU is extreamly useful in early bring up I think it makes sense for
>> QEMU to support non-frozen extensions. I would like to decide with this
>> series how QEMU will handle all future non-frozen extensions. That is a
>> standard way that QEMU users can test future RISC-V extensions while
>> still understanding things will change. One idea is just to disable it by
>> default, another option is to maybe use the Kconfig to make it a compile
>> time option which developers can use. Should we also display a warning
>> when running non-frozen extensions?
>>
>> Thanks to Anup for doing the initial port of Xvisor. The port is avaliable here:
>> https://github.com/avpatel/xvisor-next and will run on QEMU.
>>
>> Also thanks to Atish for implementing the SBI call support in Xvisor and
>> for lots of help debugging.
>>
>> To run this yourself:
>>  1. Apply this patch series to QEMU. The latest branch can be found here:
>>       https://github.com/alistair23/qemu/tree/mainline/alistair/riscv-hyp-work.next
>>  2. Get the version of OpenSBI that supports the H extension. This can
>>     be found here:
>>       https://github.com/riscv/opensbi/tree/hyp_ext_changes_v1
>>  3. Build the next release of Xvisor. It is available here:
>>       https://github.com/avpatel/xvisor-next
>>  4. Make sure you build the Xvisor tests, see here for details:
>>       https://github.com/avpatel/xvisor-next/tree/master/tests/riscv/virt64/linux
>>  5. Run QEMU:
>>      ./riscv64-softmmu/qemu-system-riscv64 -nographic \
>>        -machine virt -cpu rv64,h=true\
>>        -serial mon:stdio -serial null -m 4G \
>>        -device loader,file=vmm.bin,addr=0x80200000 \
>>        -kernel fw_jump.elf \
>>        -initrd vmm-disk-linux.img \
>>        -append "vmm.console=uart@10000000 vmm.bootcmd=\"vfs mount initrd /;vfs run /boot.xscript;vfs cat /system/banner.txt\""
>>
>>    Once you get to the prompt you can start the geust by running:
>>      guest kick guest0
>>    You can then bind to the serial port using:
>>      vserial bind guest0/uart0
>>    Then you can start Linux using:
>>      autoexec
>>
>>  This was all tested with the mainline 5.1 kernel. I don't know if it
>>  will work on older kernels.
>>
>> So far all of the QEMU work has been tested on Xvisor.
>>
>> Known Issues/TODO:
>>  - Add mstatush to support 32-bit Hypervisors
>>  - Fix the random hang that sometimes appears when running a Hypervisor guest (~5%)
>>
>> There is also on going work from Anup to port KVM.
>> We have code complete implementation of RISC-V KVM kernel module and
>> RISC-V KVMTOOL. Currently, we are debugging KVM on QEMU and we will
>> send-out RFC PATCHES for KVM in June/July 2019.
>> The KVM RISC-V kernel module is available in riscv_kvm_v1
>> branch at: https://github.com/avpatel/linux.git
>> The KVMTOOL RISC-V port is available in riscv_v1 branch of
>> https://github.com/avpatel/kvmtool.git
>>
>> There is very early work on a Xen port as well which is avaliable here:
>> https://github.com/alistair23/xen/tree/alistair/riscv-port
>>
>> Changes from RFC:
>>  - Rebase on latest master
>>  - Add floating point changes from Hypervisor extension
>>
>> Alistair Francis (27):
>>   target/riscv: Don't set write permissions on dirty PTEs
>>   target/riscv: Add the Hypervisor extension
>>   target/riscv: Add the virtulisation mode
>>   target/riscv: Add the force HS exception mode
>>   target/riscv: Add the Hypervisor CSRs to CPUState
>>   target/riscv: Dump Hypervisor registers if enabled
>>   target/riscv: Remove strict perm checking for CSR R/W
>>   target/riscv: Create function to test if FP is enabled
>>   target/riscv: Add support for background interrupt setting
>>   target/riscv: Add Hypervisor CSR access functions
>>   target/riscv: Add background CSRs accesses
>>   target/riscv: Add background register swapping function
>>   target/ricsv: Flush the TLB on virtulisation mode changes
>>   target/riscv: Generate illegal instruction on WFI when V=1
>>   riscv: plic: Remove unused interrupt functions
>>   riscv: plic: Always set sip.SEIP bit for HS
>>   target/riscv: Add hypvervisor trap support
>>   target/riscv: Add Hypervisor trap return support
>>   target/riscv: Add hfence instructions
>>   target/riscv: Disable guest FP support based on backgrond status
>>   target/riscv: Mark both sstatus and bsstatus as dirty
>>   target/riscv: Respect MPRV and SPRV for floating point ops
>>   target/riscv: Allow specifying MMU stage
>>   target/riscv: Allow specifying number of MMU stages
>>   target/riscv: Implement second stage MMU
>>   target/riscv: Call the second stage MMU in virtualisation mode
>>   target/riscv: Allow enabling the Hypervisor extension
>>
>>  hw/riscv/sifive_plic.c                        |  24 +-
>>  include/hw/riscv/sifive_plic.h                |   3 -
>>  target/riscv/cpu.c                            |  31 ++
>>  target/riscv/cpu.h                            |  32 +-
>>  target/riscv/cpu_bits.h                       |  32 +-
>>  target/riscv/cpu_helper.c                     | 443 ++++++++++++++++--
>>  target/riscv/csr.c                            | 216 ++++++++-
>>  target/riscv/insn32.decode                    |  23 +-
>>  .../riscv/insn_trans/trans_privileged.inc.c   |  40 ++
>>  target/riscv/op_helper.c                      |  71 ++-
>>  target/riscv/translate.c                      |  26 +
>>  11 files changed, 839 insertions(+), 102 deletions(-)
>>
>> --
>> 2.21.0
>>
>
>   tested with Linux kernel v5.2 and related opensbi/xvisor branches described above.
>
>  Tested-by: Chih-Min Chao <chihmin.chao@sifive.com>

Thanks for testing!!!

Unfortunately I don't think this is going to be merged. It is too late
to have this in the 4.1 release and I'm about to start working on
upgrading this to the v0.4 Hypervisor spec. So hopefully we can have
that in 4.2.

Alistair

>

