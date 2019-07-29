Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A98E4C7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E447206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E447206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5jc-0000lO-8h
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43609)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hs5jC-0000HL-4i
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:30:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hs5jB-00011y-75
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:30:14 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53987)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hs5jA-00010F-UR
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:30:13 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MpUpW-1iAbZA13Rk-00pxs4; Mon, 29 Jul 2019 15:29:56 +0200
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
References: <1564405791-9147-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1564405791-9147-8-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=jCQ_Fe++XQh7jYoZqAxro9rH6Mo0jj7FZV_Pd7ezCHYA@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8b484eaa-8246-691e-ee8e-e2d53085a476@vivier.eu>
Date: Mon, 29 Jul 2019 15:29:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jCQ_Fe++XQh7jYoZqAxro9rH6Mo0jj7FZV_Pd7ezCHYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TfB2lQjGsJ2tr1gi/MiQXf/wGVtNaXqjIguXyDQNxepGJeQuqSp
 BpzHE4cSDgU162CdpvNr25aBHaF5X73La54jJBe616NILnqdk0rIEMwy8n2yTzwlhsBwWXW
 +nPv+Mrkz7prwGLIMCOJltbpCTq/u8iCP/PmXuBLswY8v0n5O2fZxzEuzBRUQeMLgewtqoW
 0gxRPJwgPPuv44z6Z8BfQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rIMOgOQ9D2s=:3hCDN/cRf5hNahO1vEZEq8
 zK9LGYMYN6oRLIpC8ElCO/1ZlKn9m1zzCCOHz2IjOS64TVSgvKufDWr7Xv95cUvesf13tLyQM
 C+YolgDS4PzIZVZRvxIYTHQqP0x7VfgCkqrbaY47af28IhAyamPx4mBzbokeIx76HHqgoUrZL
 pochRih1aa5venRHqXcf41NLyl5ao0AjjzQOblMcBj67QqP42zxWPxchiAIt/jxAALwCScwmv
 TOALuFSS33YbBI4WNhr6Oy1jwjRmEX9V00gDfQna1RgmctxKIYEL0S1zdfKfqKgieuxfc2wO3
 UcBOKYbCYm5Fnpj+XelIgj+UCITuriKp7gTY73oOqxRh7jdFrb2E6yvAQZFF3bf7FR3j6NFEB
 dyu9eOoBvjSISli8iVJWj+bX9mx51P8OAvKqNq3OcyOP25FBiELb425zsL2oZbCWQrOploWqq
 SWfrdZ3JbYSyEdS2YV4y9KksFKC1+6Jgcf4MdVmockBlfXsXGgXh8O+fcdlQr8GCgEwLb+v5w
 4rkHY67ostaOX72aj5h/BRyE1XPYnkHapO8GkadOzhEk7ebAGY3STkf548K14+AwAaRnHioEO
 LI8WSd6neVnbg8hyytW1hZIT/aOmo001IpQG9TsNSx8UXojpslcdV/kABdd5gJSxZdgWrlj/e
 +UmrY4W4tcGuoxVzFdeqmgJhyiH6s+zojnn1UKODmoMXKqzlUqnbxtGWv9DqQKr4StKPvx85y
 sz5bD6RJRU6vmTGeJIPS+JR6J2A8+/Je4GqilAQ6wB3Fi21wQ0naYN5cu5w=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] [PATCH for 4.1 v2 7/7] linux-user: Add support for
 semtimedop() syscall
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 29/07/2019 à 15:26, Aleksandar Markovic a écrit :
> 
> 
> On Mon, Jul 29, 2019 at 3:11 PM Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com <mailto:aleksandar.markovic@rt-rk.com>>
> wrote:
> 
>     From: Aleksandar Rikalo <arikalo@wavecomp.com
>     <mailto:arikalo@wavecomp.com>>
> 
>     Add support for semtimedop() emulation. It is based on invocation
>     of safe_semtimedop().
> 
>     Conversion is left out of safe_semtimedop(), since other safe_xxx()
>     usually don't contain similar conversions.
> 
>     Signed-off-by: Aleksandar Rikalo <arikalo@wavecomp.com
>     <mailto:arikalo@wavecomp.com>>
>     Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com
>     <mailto:amarkovic@wavecomp.com>>
>     ---
> 
> 
> Aleksandar R., Laurent,
> 
> Please note that I just rebased the patch compared to its last
> incarnation - no code change.
> 
> Laurent's hints were as follows last time:
> 
> "To avoid duplicate code (and cleanup the stack allocation), you should
> 
> remove do_semop()  and call do_semtimedop(..., NULL) from IPCOP_semop
> and TARGET_NR_semop.
> 
> Thanks, Laurent"
> 
>  I guess they are still valid.

Yes, I didn't remember my comment and do the same again...

Thanks,
Laurent


