Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95121C76195
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:42:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798FE21743
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798FE21743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnSPV-0004u3-Hu
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 14:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35449)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hnSPL-0004Vf-Pa
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hnSPK-0006qV-Po
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:42:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50888)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hnSPK-0006qC-J9
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:42:34 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7EF8F7FDFB;
 Tue, 16 Jul 2019 18:42:33 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-117-187.ams2.redhat.com
 [10.36.117.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3637E101E1CD;
 Tue, 16 Jul 2019 18:42:29 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20181102171638.24069-1-peter.maydell@linaro.org>
 <20181102171638.24069-9-peter.maydell@linaro.org>
 <3e3d2018-3993-f651-8e94-5bea612bd776@redhat.com>
 <CAFEAcA_FtoHOUv_cPgfO7GrZ8Ug9cKCvmY2z75i9DaAQ8Qx+gQ@mail.gmail.com>
 <417cd887-aec4-d8ba-1dd2-810bc4c04977@redhat.com>
 <CAFEAcA_JntiaOOWisqLVqAV6jc=wk4nR548KbbUcG0XLabcNpA@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8d06b8f2-7ee8-a77a-81d7-3219d5e43c45@redhat.com>
Date: Tue, 16 Jul 2019 20:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_JntiaOOWisqLVqAV6jc=wk4nR548KbbUcG0XLabcNpA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Tue, 16 Jul 2019 18:42:33 +0000 (UTC)
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/16/19 18:59, Peter Maydell wrote:
> On Tue, 16 Jul 2019 at 17:51, Laszlo Ersek <lersek@redhat.com> wrote:
>> The issue still reproduces, so it makes sense for me to look at the host
>> kernel version... Well, I'm afraid it won't help much, for an upstream
>> investigation:
>>
>>   4.14.0-115.8.2.el7a.aarch64
>>
>> This is the latest released kernel from "Red Hat Enterprise Linux for
>> ARM 64 7".
> 
> OK. (I'm using 4.15.0-51-generic from ubuntu).
> 
> Could you run with QEMU under gdb, and when it hits the
> assertion go back up a stack frame to the arm_cpu_realizefn()
> frame, and then "print /x cpu->isar" ? That should show us
> what we think we've got as ID registers from the kernel.
> (You might need to build QEMU with --enable-debug to get
> useful enough debug info to do that, not sure.)

(My qemu build script always builds QEMU in two configs, the difference
being --prefix and --enable-debug.)

This is what I got:

(gdb) frame 4
#4  0x00000000006a063c in arm_cpu_realizefn (dev=0x1761140,
    errp=0xffffffffe540)
    at .../qemu/target/arm/cpu.c:1159
1159            assert(no_aa32 || cpu_isar_feature(arm_div, cpu));
(gdb) print /x cpu->isar
$1 = {id_isar0 = 0x0, id_isar1 = 0x0, id_isar2 = 0x0, id_isar3 = 0x0,
  id_isar4 = 0x0, id_isar5 = 0x0, id_isar6 = 0x0, mvfr0 = 0x0,
  mvfr1 = 0x0, mvfr2 = 0x0, id_aa64isar0 = 0x0, id_aa64isar1 = 0x0,
  id_aa64pfr0 = 0x11, id_aa64pfr1 = 0x0, id_aa64mmfr0 = 0x0,
  id_aa64mmfr1 = 0x0}

Thanks!
Laszlo

