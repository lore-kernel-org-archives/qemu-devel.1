Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C0AC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:04:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DACF21882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 20:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DACF21882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hilU0-0003bw-QW
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 16:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53061)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hilQp-00021h-2P
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:00:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hilQn-0001iY-LW
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:00:42 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55433)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hilQn-0001hu-Ca
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 16:00:41 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MxmBi-1iSdI20L6M-00zFjR; Wed, 03 Jul 2019 22:00:36 +0200
To: Aleksandar Markovic <amarkovic@wavecomp.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <BN6PR2201MB12513A40434D1750AAF40020C6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c2660cf1-d23d-69ed-0f6b-2c450542cb18@vivier.eu>
Date: Wed, 3 Jul 2019 22:00:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <BN6PR2201MB12513A40434D1750AAF40020C6FB0@BN6PR2201MB1251.namprd22.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tcCAXWisJarJTGy4qRI79856yEonuvX9bKksP7oB6erC0FGyJ2+
 4Z7i5t8o8WI3M6lNj3M0F577Rqj7TX0cGGaE45tuC7MtUSOb82/B7Vr/0Q1K793KS4SwbXx
 30ulqfSdJqmJ1qsQu67RXbqHlPpIZdHq6z3rHsOdh9jEN4t9ymYn85v7fkwJ+44ol/Jx9YW
 JVx9x3ECBGbK7wCNLSpRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:prs7PD7VBuY=:/Cko6VwjV0YpdURJ6AsFRt
 QEVQtYHFAYN0EkJAUoV0a7/MnpzGUnMiBt/DEfk+GF/75izdg0zR0JEJLnqhnQol6fo+EU8k5
 8AjZ4e8JE6XbMdSXqlm2YY9yNtrtBUVRBASoo4K29081iUmcT7UyP/Eq6olEX/dDhVM0akRlz
 RBJIIyK+xh4a9jwJPohYFWbnb816UtTUNZsO2ZWYHq/tI3cPrgajT4xIjFA7ENwkRx25O76le
 X8baJtizGcG1+Pda4rJ5c0ilKN42hzhADBckGHTKsRgHdTNIK2UrT3nUwzgzfK0Dlxtwuzt3Z
 S6ymvbypMScnnZwaYcR31rALJR51YnqrtbGSW3nR2wNE+p8AgIBgD+RBP1rTM3wMqSxmt+qjQ
 lGoV4W+5EO7NK8duwQRxApe/9Llch0enzy8I4oVIrc80IE/t2xu7R/qbHQB3L3jvSH9Ur2l1d
 2iQTpLCXfElofoqCKOMH65B/MVS5q3Aeel5RU6jqyVez418Hz8xqD4ivN6fZvzo2x3PfHoWSV
 SRw1EKd0ujhgwRkJbtatYhR5mW/EGfnk35Uhf5AI5e8kpQcjR2lqU6MK0X3b3eO3anMCLl/+E
 9PHwRNJDBPH2N5pceOWWXTvRF91VcuFqT7TQzRPmUPFcnbQNR3he1s8eclAi2SRGylaJVY+jo
 Q8kfVxCB2HiP4EIS/IdEvtcsPmYTQj7/78e5RT0Ny59iL8kWZb0ptJR+mXQIAe2sIaQGmPxgL
 WQzdzcWI5GRvoMwX3eeFb59FaXrer65W9f9uUGBQiafwhOPucUOirtczJEQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.134
Subject: Re: [Qemu-devel] [BUG] Inappropriate size of target_sigset_t
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 03/07/2019 à 21:46, Aleksandar Markovic a écrit :
> Hello, Peter, Laurent,
> 
> While working on another problem yesterday, I think I discovered a long-standing bug in QEMU Linux user mode: our target_sigset_t structure is eight times smaller as it should be!
> 
> In this code segment from syscalls_def.h:
> 
> #ifdef TARGET_MIPS
> #define TARGET_NSIG	   128
> #else
> #define TARGET_NSIG	   64
> #endif
> #define TARGET_NSIG_BPW	   TARGET_ABI_BITS
> #define TARGET_NSIG_WORDS  (TARGET_NSIG / TARGET_NSIG_BPW)
> 
> typedef struct {
>     abi_ulong sig[TARGET_NSIG_WORDS];
> } target_sigset_t;
> 
> ... TARGET_ABI_BITS should be replaced by eight times smaller constant (in fact, semantically, we need TARGET_ABI_BYTES, but it is not defined) (what is needed is actually "a byte per signal" in target_sigset_t, and we allow "a bit per signal").

TARGET_NSIG is divided by TARGET_ABI_BITS which gives you the number of
abi_ulong words we need in target_sigset_t.

> All this probably sounds to you like something impossible, since this code is in QEMU "since forever", but I checked everything, and the bug seems real. I wish you can prove me wrong.
> 
> I just wanted to let you know about this, given the sensitive timing of current softfreeze, and the fact that I won't be able to do more investigation on this in coming weeks, since I am busy with other tasks, but perhaps you can analyze and do something which you consider appropriate.

If I compare with kernel, it looks good:

In Linux:

  arch/mips/include/uapi/asm/signal.h

  #define _NSIG           128
  #define _NSIG_BPW       (sizeof(unsigned long) * 8)
  #define _NSIG_WORDS     (_NSIG / _NSIG_BPW)

  typedef struct {
          unsigned long sig[_NSIG_WORDS];
  } sigset_t;

_NSIG_BPW is 8 * 8 = 64 on MIPS64 or 4 * 8 = 32 on MIPS

In QEMU:

TARGET_NSIG_BPW	is TARGET_ABI_BITS which is  TARGET_LONG_BITS which is
64 on MIPS64 and 32 on MIPS.

I think there is no problem.

Thanks,
Laurent

