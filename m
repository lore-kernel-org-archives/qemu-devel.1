Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:16:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A974A20747
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 17:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A974A20747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqgLs-0001Ii-Uv
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 13:16:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jqgKt-0000fI-KB
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:15:51 -0400
Received: from indium.canonical.com ([91.189.90.7]:60940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1jqgKr-0000o7-53
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 13:15:51 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1jqgKn-0006hZ-JK
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2020 17:15:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 316EE2E810C
 for <qemu-devel@nongnu.org>; Wed,  1 Jul 2020 17:15:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2020 17:09:48 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <1878645@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: a1xndr ajbennee philmd
X-Launchpad-Bug-Reporter: Alexander Bulekov (a1xndr)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <158947246472.30762.752698283456022174.malonedeb@chaenomeles.canonical.com>
 <20200701135652.1366-2-alex.bennee@linaro.org>
 <85314d31-813a-8c20-7522-5186d5f31884@redhat.com> <87pn9fqjcd.fsf@linaro.org>
 <838d4d01-cd9e-d74a-5cd2-b23644172c9f@redhat.com>
Message-ID: <87k0znqi03.fsf@linaro.org>
Subject: [Bug 1878645] Re: [PATCH v4 01/40] hw/isa: check for current_cpu
 before generating IRQ
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="1cbd0aa39df153c901321817f9b57cf3f232b507";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 600cf9813e7d5d84894a113652dbd1508f2400f0
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 10:05:42
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1878645 <1878645@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20200701170948.ZlMtFKcvykjjNQisrIjMV3MtA4GNy6HvkoNGABF0Bgk@z>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/1/20 6:40 PM, Alex Benn=C3=A9e wrote:
>> =

>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>> =

>>> On 7/1/20 3:56 PM, Alex Benn=C3=A9e wrote:
>>>> It's possible to trigger this function from qtest/monitor at which
>>>> point current_cpu won't point at the right place. Check it and
>>>> fall back to first_cpu if it's NULL.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Cc: Bug 1878645 <1878645@bugs.launchpad.net>
>>>> ---
>>>>  hw/isa/lpc_ich9.c | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
>>>> index cd6e169d47a..791c878eb0b 100644
>>>> --- a/hw/isa/lpc_ich9.c
>>>> +++ b/hw/isa/lpc_ich9.c
>>>> @@ -439,7 +439,7 @@ static void ich9_apm_ctrl_changed(uint32_t val, vo=
id *arg)
>>>>                  cpu_interrupt(cs, CPU_INTERRUPT_SMI);
>>>>              }
>>>>          } else {
>>>> -            cpu_interrupt(current_cpu, CPU_INTERRUPT_SMI);
>>>> +            cpu_interrupt(current_cpu ? current_cpu : first_cpu, CPU_=
INTERRUPT_SMI);
>>>
>>> I'm not sure this change anything, as first_cpu is NULL when using
>>> qtest accelerator or none-machine, see 508b4ecc39 ("gdbstub.c: fix
>>> GDB connection segfault caused by empty machines").
>> =

>> Good point - anyway feel free to ignore - it shouldn't have been in this
>> series. It was just some random experimentation I was doing when looking
>> at that bug.
>
> See commit c781a2cc42 ("hw/i386/vmport: Allow QTest use without
> crashing") for a similar approach, but here I was thinking about
> a more generic fix, not very intrusive:
>
> -- >8 --
> diff --git a/hw/isa/apm.c b/hw/isa/apm.c
> index bce266b957..809afeb3e4 100644
> --- a/hw/isa/apm.c
> +++ b/hw/isa/apm.c
> @@ -40,7 +40,7 @@ static void apm_ioport_writeb(void *opaque, hwaddr
> addr, uint64_t val,
>      if (addr =3D=3D 0) {
>          apm->apmc =3D val;
>
> -        if (apm->callback) {
> +        if (apm->callback && !qtest_enabled()) {
>              (apm->callback)(val, apm->arg);
>          }

But the other failure mode reported on the bug thread was via the
monitor - so I'm not sure just checking for qtest catches that.

>      } else {
> ---


-- =

Alex Benn=C3=A9e

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1878645

Title:
  null-ptr dereference in ich9_apm_ctrl_changed

Status in QEMU:
  New

Bug description:
  Hello,
  While fuzzing, I found an input which triggers a NULL pointer dereference=
 in
  tcg_handle_interrupt. It seems the culprint is a "cpu" pointer - maybe th=
is bug
  is specific to QTest?

  =3D=3D23862=3D=3DERROR: AddressSanitizer: SEGV on unknown address 0x00000=
00000b4 (pc 0x55b9dc7c9dce bp 0x7ffc346a0900 sp 0x7ffc346a0880 T0)
  =3D=3D23862=3D=3DThe signal is caused by a READ memory access.
  =3D=3D23862=3D=3DHint: address points to the zero page.
      #0 0x55b9dc7c9dce in tcg_handle_interrupt /home/alxndr/Development/qe=
mu/accel/tcg/tcg-all.c:57:21
      #1 0x55b9dc904799 in cpu_interrupt /home/alxndr/Development/qemu/incl=
ude/hw/core/cpu.h:872:5
      #2 0x55b9dc9085e8 in ich9_apm_ctrl_changed /home/alxndr/Development/q=
emu/hw/isa/lpc_ich9.c:442:13
      #3 0x55b9dd19cdc8 in apm_ioport_writeb /home/alxndr/Development/qemu/=
hw/isa/apm.c:50:13
      #4 0x55b9dc73f8b4 in memory_region_write_accessor /home/alxndr/Develo=
pment/qemu/memory.c:483:5
      #5 0x55b9dc73f289 in access_with_adjusted_size /home/alxndr/Developme=
nt/qemu/memory.c:544:18
      #6 0x55b9dc73ddf5 in memory_region_dispatch_write /home/alxndr/Develo=
pment/qemu/memory.c:1476:16
      #7 0x55b9dc577bf3 in flatview_write_continue /home/alxndr/Development=
/qemu/exec.c:3137:23
      #8 0x55b9dc567ad8 in flatview_write /home/alxndr/Development/qemu/exe=
c.c:3177:14
      #9 0x55b9dc567608 in address_space_write /home/alxndr/Development/qem=
u/exec.c:3268:18
      #10 0x55b9dc723fe7 in cpu_outb /home/alxndr/Development/qemu/ioport.c=
:60:5
      #11 0x55b9dc72d3c0 in qtest_process_command /home/alxndr/Development/=
qemu/qtest.c:392:13
      #12 0x55b9dc72b186 in qtest_process_inbuf /home/alxndr/Development/qe=
mu/qtest.c:710:9
      #13 0x55b9dc72a8b3 in qtest_read /home/alxndr/Development/qemu/qtest.=
c:722:5
      #14 0x55b9ddc6e60b in qemu_chr_be_write_impl /home/alxndr/Development=
/qemu/chardev/char.c:183:9
      #15 0x55b9ddc6e75a in qemu_chr_be_write /home/alxndr/Development/qemu=
/chardev/char.c:195:9
      #16 0x55b9ddc77979 in fd_chr_read /home/alxndr/Development/qemu/chard=
ev/char-fd.c:68:9
      #17 0x55b9ddcff0e9 in qio_channel_fd_source_dispatch /home/alxndr/Dev=
elopment/qemu/io/channel-watch.c:84:12
      #18 0x7f7161eac897 in g_main_context_dispatch (/usr/lib/x86_64-linux-=
gnu/libglib-2.0.so.0+0x4e897)
      #19 0x55b9ddebcb84 in glib_pollfds_poll /home/alxndr/Development/qemu=
/util/main-loop.c:219:9
      #20 0x55b9ddebb57d in os_host_main_loop_wait /home/alxndr/Development=
/qemu/util/main-loop.c:242:5
      #21 0x55b9ddebb176 in main_loop_wait /home/alxndr/Development/qemu/ut=
il/main-loop.c:518:11
      #22 0x55b9dcb4bd1d in qemu_main_loop /home/alxndr/Development/qemu/so=
ftmmu/vl.c:1664:9
      #23 0x55b9ddd1629c in main /home/alxndr/Development/qemu/softmmu/main=
.c:49:5
      #24 0x7f7160a5ce0a in __libc_start_main /build/glibc-GwnBeO/glibc-2.3=
0/csu/../csu/libc-start.c:308:16
      #25 0x55b9dc49c819 in _start (/home/alxndr/Development/qemu/build/i38=
6-softmmu/qemu-system-i386+0xc9c819)

  =

  I can reproduce this in qemu 5.0 built with AddressSanitizer using these =
qtest commands:

  cat << EOF | ./qemu-system-i386 \
  -qtest stdio -nographic -monitor none -serial none \
  -M pc-q35-5.0
  outl 0xcf8 0x8400f841
  outl 0xcfc 0xaa215d6d
  outl 0x6d30 0x2ef8ffbe
  outb 0xb2 0x20
  EOF

  Please let me know if I can provide any further info.
  -Alex

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1878645/+subscriptions

