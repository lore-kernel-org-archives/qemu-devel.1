Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A5DC10F0B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D199E20693
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 08:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D199E20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37725 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH27Y-0003J6-Q6
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 04:10:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hH26M-0002hD-Bo
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Mateja.Marjanovic@rt-rk.com>) id 1hH26K-0007Y2-UL
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:08:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35594 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Mateja.Marjanovic@rt-rk.com>)
	id 1hH26K-0007XC-Ac
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 04:08:56 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 6DBCF1A209D;
	Thu, 18 Apr 2019 10:08:53 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from [10.10.13.97] (rtrkw310-lin.domain.local [10.10.13.97])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 3F5A81A2060;
	Thu, 18 Apr 2019 10:08:53 +0200 (CEST)
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <1555491867-5922-1-git-send-email-mateja.marjanovic@rt-rk.com>
	<BN6PR2201MB1251516C13CAE873ADDA73DBC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Message-ID: <c9417268-906f-1731-b253-fbc3ec7259d9@rt-rk.com>
Date: Thu, 18 Apr 2019 10:08:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB1251516C13CAE873ADDA73DBC6250@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format="flowed"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: Re: [Qemu-devel] [PATCH] target/mips: Amend tests for MSA binary
 integer operations
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
	"aurelien@aurel32.net" <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418080852.V5HcK87HWPEbWYaVOqQ8R1mjwLWwB-vI5cyq_wHkjvQ@z>


On 17.4.19. 18:41, Aleksandar Markovic wrote:
>> From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> Subject: [PATCH] target/mips: Amend tests for MSA binary integer operations
>>
>> Amend tests for certain MSA binary integer instructions
>> (for example DIV_S.B) by appending two missing test cases
>> to complete standard battery of 80 test cases for each
>> such instruction. Expected values were pulled from the
>> results of the MIPS64r6 machine that executed those
>> instruction, and QEMU emulation should produce the same
>> results.
>>
>> Signed-off-by: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
>> ---
> I'm afraid your patch doesn't apply to the tip of the source tree:
>
> $ git am target-mips-Amend-tests-for-MSA-binary-integer-operations.patch Applying: target/mips: Amend tests for MSA binary integer operations
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_b.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_d.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_h.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_add_a_w.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_b.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_d.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_h.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_a_w.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_b.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_d.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_h.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_s_w.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_b.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_d.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_h.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_adds_u_w.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_b.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_d.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_h.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_addv_w.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_d.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_h.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_s_w.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_d.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_h.c: patch does not apply
> error: patch failed: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c:2
> error: tests/tcg/mips/user/ase/msa/int-add/test_msa_hadd_u_w.c: patch does not apply
> Patch failed at 0001 target/mips: Amend tests for MSA binary integer operations
> The copy of the patch that failed is found in: .git/rebase-apply/patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
>
> Please update/rebase your tree before sending patches in future.

I will do that from now on.

Thanks,
Mateja

>
> Thanks,
> Aleksandar

