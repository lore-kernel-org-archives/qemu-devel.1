Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFCEC2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 20:54:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B84D21734
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 20:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W75OsIMt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B84D21734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu0XY-00010y-Cx
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 15:54:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iu0Wn-0000Yy-Qh
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iu0Wk-0003Pu-Nk
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:53:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34669
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iu0Wk-0003Pg-Fy
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 15:53:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579640013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlwLnAYo0WvBeyCtnYZyLbeNpKAIhkkXcNcli61ng34=;
 b=W75OsIMtVAOAqPAsbx5SJ1Gm/hZP0LOEmhtd2p58TosCaT445Mk/uF6DwQbD06HTGYNpG2
 ZUocSTSC8YS2eR8lpBRHtm2QYWxtD2WP1Zqa6bF/3N2Aj+JYDTtpWHT3Js9FpZMoyYn7z8
 R5l/eX1ElNFOA0RTnZjECTwQc9mVz+4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-XfbrhuqINGumvWiQOSugrw-1; Tue, 21 Jan 2020 15:53:30 -0500
Received: by mail-wr1-f72.google.com with SMTP id w6so1969167wrm.16
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 12:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q4M7IN3YAdkjgr/t/GJjei8yzQoehZNyjG49QX4/k8A=;
 b=goM+hsb08C6LF5Kvj0meJkud72EOXWV8gEQGxQSN3kuOWZuvlOSvOfEi1GO4RhhMdn
 /wsCATmGfHSu3ry8YooKJ3BaFJSJdespaiLPYdiEL1SBTSaxZAiHBuNBTdyCsLgBvQkg
 /VJu/tslkRidkhBOGNceBMYQ94E7OJRRcpYSj4b9qKwFaQ5jRHk1vpdWxBs0AQYRzd6q
 U72fTWLM0Lbl6pHczJlyVxEzDTWknwbJotu+k+piE6cbf6Kqt9yQ2citliP5c/8GwOBx
 Vc5F1uBHJZJ8zZbX6fDkjm8xOJo/KT4zywlInURWdenG2lz1d0SKTSJkjKLUqjh7gU/E
 Zhig==
X-Gm-Message-State: APjAAAWEk0gThX8dQ0ITjoXcXb3H9Fvndr2zOcFVQEH73YF4i3ebFbmM
 27IGaxb41dABOZgDoxzg96yRX9PHwGaMd+D3qwqvbK6dH/kE17F23NzCnJSm4jogf/dEmRfEOKV
 WldtxJEmWdM/gQiM=
X-Received: by 2002:a7b:c851:: with SMTP id c17mr221928wml.71.1579640009622;
 Tue, 21 Jan 2020 12:53:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqxhN0ThgwCMncMTmOQ4Kfc3FslM5mS1VeJeIu9Z1prSBLqjFMSgn5KT3ZzzbB7rnr06RsreXA==
X-Received: by 2002:a7b:c851:: with SMTP id c17mr221912wml.71.1579640009252;
 Tue, 21 Jan 2020 12:53:29 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id d23sm488540wra.30.2020.01.21.12.53.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2020 12:53:28 -0800 (PST)
Subject: Re: [PATCH v2 051/109] virtiofsd: add seccomp whitelist
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-52-dgilbert@redhat.com>
 <ba916575-1496-8c3d-a568-573ebb07d4ec@redhat.com>
 <20200121194903.GQ2929@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <7f56415a-ea70-b98e-5948-613b88446844@redhat.com>
Date: Tue, 21 Jan 2020 21:53:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121194903.GQ2929@work-vm>
Content-Language: en-US
X-MC-Unique: XfbrhuqINGumvWiQOSugrw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: m.mizuma@jp.fujitsu.com, berrange@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, misono.tomohiro@jp.fujitsu.com, stefanha@redhat.com,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 8:49 PM, Dr. David Alan Gilbert wrote:
> * Philippe Mathieu-Daud=C3=A9 (philmd@redhat.com) wrote:
>> On 1/21/20 1:23 PM, Dr. David Alan Gilbert (git) wrote:
>>> From: Stefan Hajnoczi <stefanha@redhat.com>
>>>
>>> Only allow system calls that are needed by virtiofsd.  All other system
>>> calls cause SIGSYS to be directed at the thread and the process will
>>> coredump.
>>>
>>> Restricting system calls reduces the kernel attack surface and limits
>>> what the process can do when compromised.
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>>> with additional entries by:
>>> Signed-off-by: Ganesh Maharaj Mahalingam <ganesh.mahalingam@intel.com>
>>> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>>> Signed-off-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
>>> Signed-off-by: piaojun <piaojun@huawei.com>
>>> Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
>>> Signed-off-by: Eric Ren <renzhen@linux.alibaba.com>
>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> ---
>>>    Makefile                         |   2 +-
>>>    tools/virtiofsd/Makefile.objs    |   5 +-
>>>    tools/virtiofsd/passthrough_ll.c |   2 +
>>>    tools/virtiofsd/seccomp.c        | 150 +++++++++++++++++++++++++++++=
++
>>>    tools/virtiofsd/seccomp.h        |  14 +++
>>>    5 files changed, 171 insertions(+), 2 deletions(-)
>>>    create mode 100644 tools/virtiofsd/seccomp.c
>>>    create mode 100644 tools/virtiofsd/seccomp.h
>>>
>>> diff --git a/Makefile b/Makefile
>>> index a87e06ad93..967d59c98a 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -327,7 +327,7 @@ HELPERS-y +=3D vhost-user-gpu$(EXESUF)
>>>    vhost-user-json-y +=3D contrib/vhost-user-gpu/50-qemu-gpu.json
>>>    endif
>>> -ifdef CONFIG_LINUX
>>> +ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP),yy)
>>>    HELPERS-y +=3D virtiofsd$(EXESUF)
>>
>> Something is weird here, because I got:
>>
>> $ make virtiofsd
>>    ...
>>    CC      tools/virtiofsd/seccomp.o
>> tools/virtiofsd/seccomp.c:14:21: fatal error: seccomp.h: No such file or
>> directory
>>   #include <seccomp.h>
>>                       ^
>>
>> Indeed I don't have libseccomp installed, ./configure reported:
>>
>> ...
>> QGA MSI support   no
>> seccomp support   no
>> coroutine backend ucontext
>> coroutine pool    yes
>> debug stack usage no
>> ...
>>
>> Note also:
>>
>> $ make print-CONFIG_LINUX
>> CONFIG_LINUX=3Dy
>> $ make print-CONFIG_SECCOMP
>> CONFIG_SECCOMP=3D
>> $ make print-CONFIG_LIBCAP_NG
>> CONFIG_LIBCAP_NG=3Dy
>> $ make print-HELPERS-y
>> HELPERS-y=3Dqemu-bridge-helper
>=20
> The same thing happens if you uninstall mesa-libgbm-devel and do a
> 'make vhost-user-gpu'
>=20
> These ifeq's don't remove the definition of the target, they just remove
> it from the HELPERS-y list, so stop it being built on an unqualified
> 'make' but don't change the behaviour when you explicitly ask for the
> target.
>=20
> Can you try:
>=20
> diff --git a/Makefile b/Makefile
> index ba7e2e5ebc..346a981f0e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -676,8 +676,9 @@ vhost-user-blk$(EXESUF): $(vhost-user-blk-obj-y) libv=
host-user.a
>   rdmacm-mux$(EXESUF): LIBS +=3D "-libumad"
>   rdmacm-mux$(EXESUF): $(rdmacm-mux-obj-y) $(COMMON_LDADDS)
>          $(call LINK, $^)
> -
> -ifdef CONFIG_LINUX # relies on Linux-specific syscalls
> +#
> +# relies on Linux specific syscalls
> +ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
>   virtiofsd$(EXESUF): $(virtiofsd-obj-y) libvhost-user.a $(COMMON_LDADDS)
>          $(call LINK, $^)
>   endif

$ make print-HELPERS-y
HELPERS-y=3Dqemu-bridge-helper

$ make virtiofsd
   GEN     config-host.h
make[1]: Entering directory 'slirp'
   CC      slirp/src/state.o
   CC      slirp/src/tcp_timer.o
   CC      slirp/src/dhcpv6.o
   CC      slirp/src/ip_input.o
   CC      slirp/src/ip6_icmp.o
   CC      slirp/src/bootp.o
   CC      slirp/src/ip6_input.o
   CC      slirp/src/slirp.o
   CC      slirp/src/vmstate.o
   CC      slirp/src/ip_output.o
   CC      slirp/src/ncsi.o
   CC      slirp/src/tcp_output.o
   CC      slirp/src/ndp_table.o
   CC      slirp/src/version.o
   CC      slirp/src/misc.o
   CC      slirp/src/ip6_output.o
   CC      slirp/src/mbuf.o
   CC      slirp/src/tftp.o
   CC      slirp/src/arp_table.o
   CC      slirp/src/util.o
   CC      slirp/src/socket.o
   CC      slirp/src/sbuf.o
   CC      slirp/src/stream.o
   CC      slirp/src/dnssearch.o
   CC      slirp/src/udp.o
   CC      slirp/src/tcp_input.o
   CC      slirp/src/if.o
   CC      slirp/src/cksum.o
   CC      slirp/src/tcp_subr.o
   CC      slirp/src/udp6.o
   CC      slirp/src/ip_icmp.o
   AR      slirp/libslirp.a
make[1]: Leaving directory 'slirp'
          DEP dtc/libfdt/fdt_overlay.c
          DEP dtc/libfdt/fdt_addresses.c
          DEP dtc/libfdt/fdt_empty_tree.c
          DEP dtc/libfdt/fdt_strerror.c
          DEP dtc/libfdt/fdt_rw.c
          DEP dtc/libfdt/fdt_sw.c
          DEP dtc/libfdt/fdt_wip.c
          DEP dtc/libfdt/fdt_ro.c
          DEP dtc/libfdt/fdt.c
          DEP dtc/util.c
          DEP dtc/fdtoverlay.c
          DEP dtc/fdtput.c
          DEP dtc/fdtget.c
          DEP dtc/fdtdump.c
          DEP convert-dtsv0-lexer.lex.c
          DEP dtc/srcpos.c
          DEP dtc-parser.tab.c
          DEP dtc-lexer.lex.c
          DEP dtc/treesource.c
          DEP dtc/livetree.c
          DEP dtc/fstree.c
          DEP dtc/flattree.c
          DEP dtc/dtc.c
          DEP dtc/data.c
          DEP dtc/checks.c
          CC libfdt/fdt.o
          CC libfdt/fdt_ro.o
          CC libfdt/fdt_wip.o
          CC libfdt/fdt_sw.o
          CC libfdt/fdt_rw.o
          CC libfdt/fdt_strerror.o
          CC libfdt/fdt_empty_tree.o
          CC libfdt/fdt_addresses.o
          CC libfdt/fdt_overlay.o
          AR libfdt/libfdt.a
r - libfdt/fdt.o
r - libfdt/fdt_ro.o
r - libfdt/fdt_wip.o
r - libfdt/fdt_sw.o
r - libfdt/fdt_rw.o
r - libfdt/fdt_strerror.o
r - libfdt/fdt_empty_tree.o
r - libfdt/fdt_addresses.o
r - libfdt/fdt_overlay.o
   CC      cs.o
   CC      utils.o
   CC      SStream.o
   CC      MCInstrDesc.o
   CC      MCRegisterInfo.o
   CC      arch/ARM/ARMDisassembler.o
   CC      arch/ARM/ARMInstPrinter.o
   CC      arch/ARM/ARMMapping.o
   CC      arch/ARM/ARMModule.o
   CC      arch/AArch64/AArch64BaseInfo.o
   CC      arch/AArch64/AArch64Disassembler.o
   CC      arch/AArch64/AArch64InstPrinter.o
   CC      arch/AArch64/AArch64Mapping.o
   CC      arch/AArch64/AArch64Module.o
   CC      arch/Mips/MipsDisassembler.o
   CC      arch/Mips/MipsInstPrinter.o
   CC      arch/Mips/MipsMapping.o
   CC      arch/Mips/MipsModule.o
   CC      arch/PowerPC/PPCDisassembler.o
   CC      arch/PowerPC/PPCInstPrinter.o
   CC      arch/PowerPC/PPCMapping.o
   CC      arch/PowerPC/PPCModule.o
   CC      arch/Sparc/SparcDisassembler.o
   CC      arch/Sparc/SparcInstPrinter.o
   CC      arch/Sparc/SparcMapping.o
   CC      arch/Sparc/SparcModule.o
   CC      arch/SystemZ/SystemZDisassembler.o
   CC      arch/SystemZ/SystemZInstPrinter.o
   CC      arch/SystemZ/SystemZMapping.o
   CC      arch/SystemZ/SystemZModule.o
   CC      arch/SystemZ/SystemZMCTargetDesc.o
   CC      arch/X86/X86DisassemblerDecoder.o
   CC      arch/X86/X86Disassembler.o
   CC      arch/X86/X86IntelInstPrinter.o
   CC      arch/X86/X86ATTInstPrinter.o
   CC      arch/X86/X86Mapping.o
   CC      arch/X86/X86Module.o
   CC      arch/XCore/XCoreDisassembler.o
   CC      arch/XCore/XCoreInstPrinter.o
   CC      arch/XCore/XCoreMapping.o
   CC      arch/XCore/XCoreModule.o
   CC      MCInst.o
   AR      libcapstone.a
   GEN     trace/generated-tcg-tracers.h
   GEN     trace/generated-helpers-wrappers.h
   GEN     trace/generated-helpers.h
   GEN     trace/generated-helpers.c
   GEN     module_block.h
   GEN     trace-root.h
   GEN     accel/kvm/trace.h
   GEN     accel/tcg/trace.h
   GEN     backends/trace.h
   GEN     crypto/trace.h
   GEN     monitor/trace.h
   GEN     linux-user/trace.h
   GEN     authz/trace.h
   GEN     block/trace.h
   GEN     io/trace.h
   GEN     nbd/trace.h
   GEN     scsi/trace.h
   GEN     chardev/trace.h
   GEN     audio/trace.h
   GEN     hw/9pfs/trace.h
   GEN     hw/acpi/trace.h
   GEN     hw/alpha/trace.h
   GEN     hw/arm/trace.h
   GEN     hw/audio/trace.h
   GEN     hw/block/trace.h
   GEN     hw/block/dataplane/trace.h
   GEN     hw/char/trace.h
   GEN     hw/dma/trace.h
   GEN     hw/hppa/trace.h
   GEN     hw/i2c/trace.h
   GEN     hw/i386/trace.h
   GEN     hw/i386/xen/trace.h
   GEN     hw/ide/trace.h
   GEN     hw/input/trace.h
   GEN     hw/intc/trace.h
   GEN     hw/isa/trace.h
   GEN     hw/mem/trace.h
   GEN     hw/mips/trace.h
   GEN     hw/misc/trace.h
   GEN     hw/misc/macio/trace.h
   GEN     hw/net/trace.h
   GEN     hw/nvram/trace.h
   GEN     hw/pci/trace.h
   GEN     hw/pci-host/trace.h
   GEN     hw/ppc/trace.h
   GEN     hw/rdma/trace.h
   GEN     hw/rdma/vmw/trace.h
   GEN     hw/rtc/trace.h
   GEN     hw/s390x/trace.h
   GEN     hw/scsi/trace.h
   GEN     hw/sd/trace.h
   GEN     hw/sparc/trace.h
   GEN     hw/sparc64/trace.h
   GEN     hw/timer/trace.h
   GEN     hw/tpm/trace.h
   GEN     hw/usb/trace.h
   GEN     hw/vfio/trace.h
   GEN     hw/virtio/trace.h
   GEN     hw/watchdog/trace.h
   GEN     hw/xen/trace.h
   GEN     hw/gpio/trace.h
   GEN     hw/riscv/trace.h
   GEN     migration/trace.h
   GEN     net/trace.h
   GEN     ui/trace.h
   GEN     hw/display/trace.h
   GEN     qapi/trace.h
   GEN     qom/trace.h
   GEN     target/arm/trace.h
   GEN     target/hppa/trace.h
   GEN     target/i386/trace.h
   GEN     target/mips/trace.h
   GEN     target/ppc/trace.h
   GEN     target/riscv/trace.h
   GEN     target/s390x/trace.h
   GEN     target/sparc/trace.h
   GEN     util/trace.h
   GEN     hw/core/trace.h
   GEN     trace-root.c
   GEN     accel/kvm/trace.c
   GEN     accel/tcg/trace.c
   GEN     backends/trace.c
   GEN     crypto/trace.c
   GEN     monitor/trace.c
   GEN     linux-user/trace.c
   GEN     authz/trace.c
   GEN     block/trace.c
   GEN     io/trace.c
   GEN     nbd/trace.c
   GEN     scsi/trace.c
   GEN     chardev/trace.c
   GEN     audio/trace.c
   GEN     hw/9pfs/trace.c
   GEN     hw/acpi/trace.c
   GEN     hw/alpha/trace.c
   GEN     hw/arm/trace.c
   GEN     hw/audio/trace.c
   GEN     hw/block/trace.c
   GEN     hw/block/dataplane/trace.c
   GEN     hw/char/trace.c
   GEN     hw/dma/trace.c
   GEN     hw/hppa/trace.c
   GEN     hw/i2c/trace.c
   GEN     hw/i386/trace.c
   GEN     hw/i386/xen/trace.c
   GEN     hw/ide/trace.c
   GEN     hw/input/trace.c
   GEN     hw/intc/trace.c
   GEN     hw/isa/trace.c
   GEN     hw/mem/trace.c
   GEN     hw/mips/trace.c
   GEN     hw/misc/trace.c
   GEN     hw/misc/macio/trace.c
   GEN     hw/net/trace.c
   GEN     hw/nvram/trace.c
   GEN     hw/pci/trace.c
   GEN     hw/pci-host/trace.c
   GEN     hw/ppc/trace.c
   GEN     hw/rdma/trace.c
   GEN     hw/rdma/vmw/trace.c
   GEN     hw/rtc/trace.c
   GEN     hw/s390x/trace.c
   GEN     hw/scsi/trace.c
   GEN     hw/sd/trace.c
   GEN     hw/sparc/trace.c
   GEN     hw/sparc64/trace.c
   GEN     hw/timer/trace.c
   GEN     hw/tpm/trace.c
   GEN     hw/usb/trace.c
   GEN     hw/vfio/trace.c
   GEN     hw/virtio/trace.c
   GEN     hw/watchdog/trace.c
   GEN     hw/xen/trace.c
   GEN     hw/gpio/trace.c
   GEN     hw/riscv/trace.c
   GEN     migration/trace.c
   GEN     net/trace.c
   GEN     ui/trace.c
   GEN     hw/display/trace.c
   GEN     qapi/trace.c
   GEN     qom/trace.c
   GEN     target/arm/trace.c
   GEN     target/hppa/trace.c
   GEN     target/i386/trace.c
   GEN     target/mips/trace.c
   GEN     target/ppc/trace.c
   GEN     target/riscv/trace.c
   GEN     target/s390x/trace.c
   GEN     target/sparc/trace.c
   GEN     util/trace.c
   GEN     hw/core/trace.c
make: *** No rule to make target 'virtiofsd'.  Stop.

This is better, thanks!

(We should also fix vhost-user-gpu, but this is out of the scope of this=20
series).

>>>    vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
>>>    endif
>>> diff --git a/tools/virtiofsd/Makefile.objs b/tools/virtiofsd/Makefile.o=
bjs
>>> index 45a807500d..076f667e46 100644
>>> --- a/tools/virtiofsd/Makefile.objs
>>> +++ b/tools/virtiofsd/Makefile.objs
>>> @@ -5,5 +5,8 @@ virtiofsd-obj-y =3D buffer.o \
>>>                      fuse_signals.o \
>>>                      fuse_virtio.o \
>>>                      helper.o \
>>> -                  passthrough_ll.o
>>> +                  passthrough_ll.o \
>>> +                  seccomp.o
>>> +seccomp.o-cflags :=3D $(SECCOMP_CFLAGS)
>>> +seccomp.o-libs :=3D $(SECCOMP_LIBS)
>>> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthr=
ough_ll.c
>>> index 752beb459a..8748e64f33 100644
>>> --- a/tools/virtiofsd/passthrough_ll.c
>>> +++ b/tools/virtiofsd/passthrough_ll.c
>>> @@ -58,6 +58,7 @@
>>>    #include <unistd.h>
>>>    #include "passthrough_helpers.h"
>>> +#include "seccomp.h"
>>>    struct lo_map_elem {
>>>        union {
>>> @@ -2090,6 +2091,7 @@ static void setup_sandbox(struct lo_data *lo, str=
uct fuse_session *se)
>>>    {
>>>        setup_namespaces(lo, se);
>>>        setup_mounts(lo->source);
>>> +    setup_seccomp();
>>>    }
>>>    int main(int argc, char *argv[])
>>> diff --git a/tools/virtiofsd/seccomp.c b/tools/virtiofsd/seccomp.c
>>> new file mode 100644
>>> index 0000000000..2aa4d3cc66
>>> --- /dev/null
>>> +++ b/tools/virtiofsd/seccomp.c
>>> @@ -0,0 +1,150 @@
>>> +/*
>>> + * Seccomp sandboxing for virtiofsd
>>> + *
>>> + * Copyright (C) 2019 Red Hat, Inc.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "seccomp.h"
>>> +#include "fuse_i.h"
>>> +#include "fuse_log.h"
>>> +#include <errno.h>
>>> +#include <glib.h>
>>> +#include <seccomp.h>
>>> +#include <stdlib.h>
>>> +
>>> +/* Bodge for libseccomp 2.4.2 which broke ppoll */
>>> +#if !defined(__SNR_ppoll) && defined(__SNR_brk)
>>> +#ifdef __NR_ppoll
>>> +#define __SNR_ppoll __NR_ppoll
>>> +#else
>>> +#define __SNR_ppoll __PNR_ppoll
>>> +#endif
>>> +#endif
>>> +
>>> +static const int syscall_whitelist[] =3D {
>>> +    /* TODO ireg sem*() syscalls */
>>> +    SCMP_SYS(brk),
>>> +    SCMP_SYS(capget), /* For CAP_FSETID */
>>> +    SCMP_SYS(capset),
>>> +    SCMP_SYS(clock_gettime),
>>> +    SCMP_SYS(clone),
>>> +#ifdef __NR_clone3
>>> +    SCMP_SYS(clone3),
>>> +#endif
>>> +    SCMP_SYS(close),
>>> +    SCMP_SYS(copy_file_range),
>>> +    SCMP_SYS(dup),
>>> +    SCMP_SYS(eventfd2),
>>> +    SCMP_SYS(exit),
>>> +    SCMP_SYS(exit_group),
>>> +    SCMP_SYS(fallocate),
>>> +    SCMP_SYS(fchmodat),
>>> +    SCMP_SYS(fchownat),
>>> +    SCMP_SYS(fcntl),
>>> +    SCMP_SYS(fdatasync),
>>> +    SCMP_SYS(fgetxattr),
>>> +    SCMP_SYS(flistxattr),
>>> +    SCMP_SYS(flock),
>>> +    SCMP_SYS(fremovexattr),
>>> +    SCMP_SYS(fsetxattr),
>>> +    SCMP_SYS(fstat),
>>> +    SCMP_SYS(fstatfs),
>>> +    SCMP_SYS(fsync),
>>> +    SCMP_SYS(ftruncate),
>>> +    SCMP_SYS(futex),
>>> +    SCMP_SYS(getdents),
>>> +    SCMP_SYS(getdents64),
>>> +    SCMP_SYS(getegid),
>>> +    SCMP_SYS(geteuid),
>>> +    SCMP_SYS(getpid),
>>> +    SCMP_SYS(gettid),
>>> +    SCMP_SYS(gettimeofday),
>>> +    SCMP_SYS(linkat),
>>> +    SCMP_SYS(lseek),
>>> +    SCMP_SYS(madvise),
>>> +    SCMP_SYS(mkdirat),
>>> +    SCMP_SYS(mknodat),
>>> +    SCMP_SYS(mmap),
>>> +    SCMP_SYS(mprotect),
>>> +    SCMP_SYS(mremap),
>>> +    SCMP_SYS(munmap),
>>> +    SCMP_SYS(newfstatat),
>>> +    SCMP_SYS(open),
>>> +    SCMP_SYS(openat),
>>> +    SCMP_SYS(ppoll),
>>> +    SCMP_SYS(prctl), /* TODO restrict to just PR_SET_NAME? */
>>> +    SCMP_SYS(preadv),
>>> +    SCMP_SYS(pread64),
>>> +    SCMP_SYS(pwritev),
>>> +    SCMP_SYS(pwrite64),
>>> +    SCMP_SYS(read),
>>> +    SCMP_SYS(readlinkat),
>>> +    SCMP_SYS(recvmsg),
>>> +    SCMP_SYS(renameat),
>>> +    SCMP_SYS(renameat2),
>>> +    SCMP_SYS(rt_sigaction),
>>> +    SCMP_SYS(rt_sigprocmask),
>>> +    SCMP_SYS(rt_sigreturn),
>>> +    SCMP_SYS(sendmsg),
>>> +    SCMP_SYS(setresgid),
>>> +    SCMP_SYS(setresuid),
>>> +#ifdef __NR_setresgid32
>>> +    SCMP_SYS(setresgid32),
>>> +#endif
>>> +#ifdef __NR_setresuid32
>>> +    SCMP_SYS(setresuid32),
>>> +#endif
>>> +    SCMP_SYS(set_robust_list),
>>> +    SCMP_SYS(symlinkat),
>>> +    SCMP_SYS(time), /* Rarely needed, except on static builds */
>>> +    SCMP_SYS(tgkill),
>>> +    SCMP_SYS(unlinkat),
>>> +    SCMP_SYS(utimensat),
>>> +    SCMP_SYS(write),
>>> +    SCMP_SYS(writev),
>>> +};
>>> +
>>> +void setup_seccomp(void)
>>> +{
>>> +    scmp_filter_ctx ctx;
>>> +    size_t i;
>>> +
>>> +#ifdef SCMP_ACT_KILL_PROCESS
>>> +    ctx =3D seccomp_init(SCMP_ACT_KILL_PROCESS);
>>> +    /* Handle a newer libseccomp but an older kernel */
>>> +    if (!ctx && errno =3D=3D EOPNOTSUPP) {
>>> +        ctx =3D seccomp_init(SCMP_ACT_TRAP);
>>> +    }
>>> +#else
>>> +    ctx =3D seccomp_init(SCMP_ACT_TRAP);
>>> +#endif
>>> +    if (!ctx) {
>>> +        fuse_log(FUSE_LOG_ERR, "seccomp_init() failed\n");
>>> +        exit(1);
>>> +    }
>>> +
>>> +    for (i =3D 0; i < G_N_ELEMENTS(syscall_whitelist); i++) {
>>> +        if (seccomp_rule_add(ctx, SCMP_ACT_ALLOW,
>>> +                             syscall_whitelist[i], 0) !=3D 0) {
>>> +            fuse_log(FUSE_LOG_ERR, "seccomp_rule_add syscall %d",
>>> +                     syscall_whitelist[i]);
>>> +            exit(1);
>>> +        }
>>> +    }
>>> +
>>> +    /* libvhost-user calls this for post-copy migration, we don't need=
 it */
>>> +    if (seccomp_rule_add(ctx, SCMP_ACT_ERRNO(ENOSYS),
>>> +                         SCMP_SYS(userfaultfd), 0) !=3D 0) {
>>> +        fuse_log(FUSE_LOG_ERR, "seccomp_rule_add userfaultfd failed\n"=
);
>>> +        exit(1);
>>> +    }
>>> +
>>> +    if (seccomp_load(ctx) < 0) {
>>> +        fuse_log(FUSE_LOG_ERR, "seccomp_load() failed\n");
>>> +        exit(1);
>>> +    }
>>> +
>>> +    seccomp_release(ctx);
>>> +}
>>> diff --git a/tools/virtiofsd/seccomp.h b/tools/virtiofsd/seccomp.h
>>> new file mode 100644
>>> index 0000000000..86bce72652
>>> --- /dev/null
>>> +++ b/tools/virtiofsd/seccomp.h
>>> @@ -0,0 +1,14 @@
>>> +/*
>>> + * Seccomp sandboxing for virtiofsd
>>> + *
>>> + * Copyright (C) 2019 Red Hat, Inc.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#ifndef VIRTIOFSD_SECCOMP_H
>>> +#define VIRTIOFSD_SECCOMP_H
>>> +
>>> +void setup_seccomp(void);
>>> +
>>> +#endif /* VIRTIOFSD_SECCOMP_H */
>>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


