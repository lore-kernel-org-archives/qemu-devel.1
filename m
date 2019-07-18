Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F26C7618F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 19:07:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3230421019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 19:07:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3230421019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoBku-00045v-CF
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 15:07:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58351)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hoBki-0003h4-PZ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 15:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hoBkh-00028B-7g
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 15:07:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37918)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hoBkh-00027O-04
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 15:07:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B604930E7184;
 Thu, 18 Jul 2019 19:07:37 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-25.ams2.redhat.com
 [10.36.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1CB7318A7D;
 Thu, 18 Jul 2019 19:07:32 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
 <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
 <417cd887-aec4-d8ba-1dd2-810bc4c04977@redhat.com>
 <CAFEAcA_JntiaOOWisqLVqAV6jc=wk4nR548KbbUcG0XLabcNpA@mail.gmail.com>
 <8d06b8f2-7ee8-a77a-81d7-3219d5e43c45@redhat.com>
 <dfeab9fd-7ee1-01f2-dd38-cba449b1de63@redhat.com>
 <f625f1f1-ad97-1c75-e44d-3b0c015312b3@redhat.com>
 <cf9156f6-c3fa-ec7e-c51a-8b8d2fd1e6d6@redhat.com>
 <7b45c073-8653-28e0-9d06-9e3aaa6dc460@redhat.com>
 <CAFEAcA8RZuzv=KkATMozxfp8MTsCOPPsK7mN6oCJq_TfwWiPMA@mail.gmail.com>
 <97ca4042-a224-7480-cc94-b58c687c353a@redhat.com>
 <CAFEAcA_jasrCne5=iLGuciJmf9FSQTduQD8xfnzbES6527mbgQ@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <3f443103-782f-736d-f72a-a3e148d21aef@redhat.com>
Date: Thu, 18 Jul 2019 21:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_jasrCne5=iLGuciJmf9FSQTduQD8xfnzbES6527mbgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 18 Jul 2019 19:07:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 08/10] target/arm: Conditionalize some
 asserts on aarch32 support
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/18/19 14:30, Peter Maydell wrote:
> On Wed, 17 Jul 2019 at 16:08, Laszlo Ersek <lersek@redhat.com> wrote:
>>
>> On 07/17/19 15:46, Peter Maydell wrote:
>>> On Wed, 17 Jul 2019 at 14:36, Philippe Mathieu-Daud=C3=A9 <philmd@red=
hat.com> wrote:
>>>> I still wonder why this didn't assert on Peter's setup.
>>>
>>> My setup does not assert because my host kernel correctly
>>> provides the ID register values to QEMU. Laszlo's appears
>>> to be providing all-zeroes, which then obviously breaks
>>> assertions being made about the sanity of those ID register
>>> values...
>>
>> OK. Can you suggest a location that I should check in the host kernel?
>=20
> I was about to write out the process of how we get these values
> from the kernel, but as the first step of that I read through
> QEMU's target/arm/kvm64.c:kvm_arm_get_host_cpu_features(),
> which is the function which reads these values using the
> KVM_GET_ONE_REG ioctl. It starts with an attempt to read
> ID_AA64PFR0, and has a comment for the error-handling case:
>=20
>         /*
>          * Before v4.15, the kernel only exposed a limited number of sy=
stem
>          * registers, not including any of the interesting AArch64 ID r=
egs.
>          * For the most part we could leave these fields as zero with m=
inimal
>          * effect, since this does not affect the values seen by the gu=
est.
>          *
>          * However, it could cause problems down the line for QEMU,
>          * so provide a minimal v8.0 default.
>          *
>          * ??? Could read MIDR and use knowledge from cpu64.c.
>          * ??? Could map a page of memory into our temp guest and
>          *     run the tiniest of hand-crafted kernels to extract
>          *     the values seen by the guest.
>          * ??? Either of these sounds like too much effort just
>          *     to work around running a modern host kernel.
>          */
>=20
> I have 4.15, and don't hit this assert; you have 4.14 and do,
> so I think you're going to be going through this codepath which
> currently sets only ahcf->isar.id_aa64pfr0 and none of the other
> ID register fields in the isar struct.
>=20
> I'm not sure exactly which kernel commits added the ID register
> reading support. (The relevant kernel code is in
> arch/arm64/kvm/sys_regs.c I think.)

I compared that file between the downstream kernel source and upstream v4=
.15, and it looks like the following series (indeed released as part of v=
4.15) is what's missing down-stream, for this particular use case:

     1  27e64b4be4b8 regset: Add support for dynamically sized regsets
     2  94ef7ecbdf6f arm64: fpsimd: Correctly annotate exception helpers =
called from asm
     3  abf73988a7c2 arm64: signal: Verify extra data is user-readable in=
 sys_rt_sigreturn
     4  93390c0a1b20 arm64: KVM: Hide unsupported AArch64 CPU features fr=
om guests
     5  b472db6cf8c6 arm64: efi: Add missing Kconfig dependency on KERNEL=
_MODE_NEON
     6  38b9aeb32fa7 arm64: Port deprecated instruction emulation to new =
sysctl interface
     7  9cf5b54fafed arm64: fpsimd: Simplify uses of {set,clear}_ti_threa=
d_flag()
     8  672365649cca arm64/sve: System register and exception syndrome de=
finitions
     9  1fc5dce78ad1 arm64/sve: Low-level SVE architectural state manipul=
ation functions
    10  ddd25ad1fde8 arm64/sve: Kconfig update and conditional compilatio=
n support
    11  d0b8cd318788 arm64/sve: Signal frame and context structure defini=
tion
    12  22043a3c082a arm64/sve: Low-level CPU setup
    13  bc0ee4760364 arm64/sve: Core task context handling
    14  79ab047c75d6 arm64/sve: Support vector length resetting for new p=
rocesses
    15  8cd969d28fd2 arm64/sve: Signal handling support
    16  7582e22038a2 arm64/sve: Backend logic for setting the vector leng=
th
    17  8f1eec57cdcc arm64: cpufeature: Move sys_caps_initialised declara=
tions
    18  2e0f2478ea37 arm64/sve: Probe SVE capabilities and usable vector =
lengths
    19  1bd3f93641ec arm64/sve: Preserve SVE registers around kernel-mode=
 NEON use
    20  fdfa976cae5c arm64/sve: Preserve SVE registers around EFI runtime=
 service calls
    21  43d4da2c45b2 arm64/sve: ptrace and ELF coredump support
    22  2d2123bc7c7f arm64/sve: Add prctl controls for userspace vector l=
ength management
    23  4ffa09a939ab arm64/sve: Add sysctl to set the default vector leng=
th for new processes
    24  17eed27b02da arm64/sve: KVM: Prevent guests from using SVE
    25  aac45ffd1f8e arm64/sve: KVM: Treat guest SVE use as undefined ins=
truction execution
    26  07d79fe7c223 arm64/sve: KVM: Hide SVE from CPU features exposed t=
o guests
    27  43994d824e84 arm64/sve: Detect SVE and activate runtime support
    28  ce6990813f15 arm64/sve: Add documentation

The differences found by the simple "diff" that I mention above are mainl=
y due to commit #4 (93390c0a1b20, "arm64: KVM: Hide unsupported AArch64 C=
PU features from guests", 2017-11-03).

I found a (likely non-final) version of the cover letter too, here: https=
://www.spinics.net/lists/arm-kernel/msg599528.html

I guess I should convince myself to install RHEL8 on the Mustang sometime=
...

Thanks!
Laszlo

> Anyway, I think we need to do at least one of:
>  * enhance the "provide a minimal v8.0 default" code in this
>    condition in kvm_arm_get_host_cpu_features() so that it
>    populates the ID registers sufficiently to avoid asserts
>    and other bad things
>  * make the asserts on ID register oddnesses be only for TCG
>    (ie where QEMU controls the values) and not for KVM
>=20
> thanks
> -- PMM
>=20


