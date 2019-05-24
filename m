Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB44C282E1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 052BA20856
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 10:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 052BA20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52427 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU7uG-0006IX-BL
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 06:58:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hU7sy-0005iZ-JA
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hU7sx-0002Zb-6S
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:57:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hU7sw-0002PT-Up
	for qemu-devel@nongnu.org; Fri, 24 May 2019 06:57:15 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C8CDF74A0;
	Fri, 24 May 2019 10:57:03 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-245.rdu2.redhat.com
	[10.10.120.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 300D1646A0;
	Fri, 24 May 2019 10:56:56 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190520231008.20140-1-mst@redhat.com>
	<CAFEAcA80Q8zWxM4TBVMZHLuOzo0HSpT=4C76uAwdMjLn2Xye=w@mail.gmail.com>
	<20190521092553-mutt-send-email-mst@kernel.org>
	<20190522150642.3da34e6b@redhat.com>
	<4b230fb0-ae2c-5221-39cb-1bed7b6df8d0@redhat.com>
	<9d2e260c-c491-03d2-9b8b-b57b72083f77@redhat.com>
	<CAFEAcA8wMUrdH_-b38eWPRn-Qx1-6L_jZ2BRXH08MPUZbu9w-A@mail.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f1cec8c0-1a9b-f5bb-f951-ea0ba9d276ee@redhat.com>
Date: Fri, 24 May 2019 12:56:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8wMUrdH_-b38eWPRn-Qx1-6L_jZ2BRXH08MPUZbu9w-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.38]);
	Fri, 24 May 2019 10:57:03 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL v2 00/36] pci, pc, virtio: features, fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/23/19 10:37, Peter Maydell wrote:
> On Thu, 23 May 2019 at 01:51, Laszlo Ersek <lersek@redhat.com> wrote:
>> I have narrowed down the issue sufficiently that I think I can hand
>> it over to Peter and Ard now -- because they know AARCH32 and AARCH64
>> assembly, and "target/arm/translate-a64.c" and "tcg/arm/*" too.
>>
>> The summarize the issue for Ard, the symptom is that AARCH64
>> ArmVirtQemu runs perfectly fine with TCG on an x86-64 system, but it
>> crashes on an AARCH32 host system.
>
> Thanks for the investigation; this is probably more one for Richard
> than me.

I figured I'd provide some logs.

(1) To recap, the aarch64 assembly source code file that seems to be
mis-translated (from the aarch64 binary) lives at

  https://github.com/tianocore/edk2/blob/3604174718e2afc950c3cc64c64ba5165c8692bd/MdePkg/Library/BaseMemoryLibOptDxe/AArch64/CopyMem.S

The relevant functions are InternalMemCopyMem() and __memcpy().


(2) I disassembled the aarch64 binary with "objdump", and uploaded the
listing to:

  http://people.redhat.com/lersek/aarch64-to-arm-mistranslation/DxeCore.objdump.xz

The InternalMemCopyMem() function starts at hex offset 2b2ec. The
__memcpy() function starts at hex offset 2b180.


(3) I ran the guest with "-d in_asm,op,op_opt,op_ind,out_asm" and
uploaded the log file to:

  http://people.redhat.com/lersek/aarch64-to-arm-mistranslation/tcg.in_asm.op.op_opt.op_ind.out_asm.log.xz

The TBs that correspond to (parts of) the InternalMemCopyMem() and
__memcpy() functions are scattered over the file, but the offset between
the "nice" disassembly from (2), and the in-RAM TBs in (3), can be
determined from the fact that there is a single prfm instruction in the
entire binary. The instruction's offset is 0x2b180 in (2) -- at the
beginning of the __memcpy() function --, and its RAM address is
0x472d2180 in (3). Thus the difference (= the load address of
DxeCore.efi) is 0x472a7000.

(This is logged by the guest as well:

> Loading DXE CORE at 0x000472A7000 EntryPoint=0x000472A8000
)

Thanks
Laszlo

