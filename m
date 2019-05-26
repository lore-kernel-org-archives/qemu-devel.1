Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDFDC282E3
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 13:08:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01C92075E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 13:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01C92075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55269 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUssp-00024Z-J4
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 09:08:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUss0-0001nS-4E
	for qemu-devel@nongnu.org; Sun, 26 May 2019 09:07:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hUsrz-0001La-9U
	for qemu-devel@nongnu.org; Sun, 26 May 2019 09:07:24 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:53539)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hUsrz-0001GT-0a
	for qemu-devel@nongnu.org; Sun, 26 May 2019 09:07:23 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MtO4E-1gcM0D33K2-00usjZ; Sun, 26 May 2019 15:07:07 +0200
To: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>, qemu-devel@nongnu.org
References: <20190526075056.33865-1-lucienmp_antispam@yahoo.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <76fe1f78-2d24-5d66-0271-5c7d60b637b1@vivier.eu>
Date: Sun, 26 May 2019 15:07:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190526075056.33865-1-lucienmp_antispam@yahoo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lbIc+0ok/gfG1o0OA6NEbiT1TVDa6p8/r+yyFaVYJ/PP7zpcewx
	AFRxPecq3IjyVP7eiXXYRSWevsGq1zuou640sEb4XRmI3enJ+wPBoOicmJyopy5VzfaTvv8
	V7vVi1tyQ9xChmbspkyZngvs9E85v0WooMwyCIVWah4PGDqTW5pKSQhX/Ld6EP8V+F5lbLk
	oqvFGL9F5zPZ94AItaTKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gkjqGP5Jv7k=:rFb6hPOGORZf+vwpoG2XF1
	iUj5RaHARm9SFMR5ZU15pMk2GqLbTnGGPyMR067si5pv39tvUDRnov48RSr4oG4AcqOV+Y/17
	CI1kIDn36pq9v91wcs7rTXGhrwKXEHSDXN2an1w1f13Td//zb3RFutrkq2oDE92+lfVmPXzRk
	0KVg3PrIuDfuw8LRckmk2bA2QB4DL9ff7qyyjppR3I81AWYUnLjjCQxsE5cOaDhOcVOD+9D5o
	7fLlJ/5f+BC9680qL/db78pfDKXUq0zYP25vNNODJyDGLuQredy+822ObgbW7fGbjze7yEZHE
	su31FfI6zqSdVJav+KiQEGy8GWNF/5hyBHOFuohkKvzsvrWDiRkCrRWa3yNvYwQMkdcTbXT8E
	qR/VJHznak/K4atjW0ynv7dtJFpbN5VRzvH7C7MVAX8U5xbsF57meQflWORku0mNJ1Oupb1gU
	gO6/pKGup+9/uGNxhWWcRTEWhGnNF221E6BAK3qXT6q91zSH+LE6T1xZ4Et0/WysSMznzXmo+
	zvHdvTVJRHKFt4S2cqx6XN1RnGI+DaeWxgotnvlzeLAryee3bcquKBqo9FkoedNRLNVSAt/nE
	U9i/cUXpm8jK8CMbgodVOCQrgByOkzPvA+wVF1h5dhdDurqH6+xSJEcLaMS4oda9zIXeugMTg
	LBMtosaTaoksF/oEWFTrV3LF1Qoz3KId5BeMIaqryH/vqxDi0YOWgw5LDqg7hPqlgu7UcPojD
	+F6ouKqmNqdIpMnw8WC9xWsHu6PZKFXEig/KUHzN3S7zF1Ij0H+3eIL15xo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.130
Subject: Re: [Qemu-devel] [PATCH] Regression for m68k causing Single-Step
 via GDB/RSP to not single step
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
Cc: Thomas Huth <huth@tuxfamily.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Emilio G . Cota" <cota@braap.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/05/2019 09:50, Lucien Murray-Pitts wrote:
> A regression that was introduced, with the refactor to TranslatorOps,
> drops two lines that update the PC when single-stepping is being performed.
> ( short commit 11ab74b )
> 
> This patch resolves that issue.
> 
> Signed-off-by: Lucien Murray-Pitts <lucienmp_antispam@yahoo.com>
> ---
>   target/m68k/translate.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index f0534a4ba0..2922ea79c3 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -6130,6 +6130,8 @@ static void m68k_tr_tb_stop(DisasContextBase *dcbase, CPUState *cpu)
>           return;
>       }
>       if (dc->base.singlestep_enabled) {
> +        update_cc_op(dc);
> +        tcg_gen_movi_i32(QREG_PC, dc->pc);
>           gen_helper_raise_exception(cpu_env, tcg_const_i32(EXCP_DEBUG));
>           return;
>       }
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


