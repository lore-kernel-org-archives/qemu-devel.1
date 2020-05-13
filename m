Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5E5C2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 07:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74803206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 07:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="AEN/tkoa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74803206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYm4z-0005h7-IB
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 03:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jYm2b-0004EK-VR
 for qemu-devel@nongnu.org; Wed, 13 May 2020 03:42:57 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:54138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc.michel@greensocs.com>)
 id 1jYm2a-0006Qf-BO
 for qemu-devel@nongnu.org; Wed, 13 May 2020 03:42:57 -0400
Received: from [172.17.10.14] (unknown [172.17.10.14])
 by beetle.greensocs.com (Postfix) with ESMTPSA id F2C6296EF0;
 Wed, 13 May 2020 07:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1589355771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMwdZkT30SoG5B/pP6AiyvynZ/VCT5RUVG6G//PFVgY=;
 b=AEN/tkoa3fSJpr9XLhJTCmKUcUcU6izqfAgKgjO721tUgeZXBfu+O2aAsmSfR7mK+odmCJ
 REuS2FrufSN5pjyacuh2MQr7Tjnaq7U/1aDU8QxnztdyfOuG9LsWtK0p0wdrdCu8/VuEex
 4YHGyFxTj1RdT/dqlYsBZqA3golYvVM=
Subject: Re: [PATCH v1 1/1] target/microblaze: Add MFS Rd,EDR translation
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
References: <20200512143649.21655-1-edgar.iglesias@gmail.com>
 <20200512143649.21655-2-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <1bdab726-5a41-40c9-1d3c-811a7c32b53a@greensocs.com>
Date: Wed, 13 May 2020 09:42:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200512143649.21655-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1589355772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TMwdZkT30SoG5B/pP6AiyvynZ/VCT5RUVG6G//PFVgY=;
 b=hvNIIDVCfVlB3UMyPGwQ9qyoKib3VQkSCDYV16/NAE8FXVkEHk3kt63wDec6UtTuyLrcGQ
 QGo/ORoTCpiF8U97StqU/WxG0wu4GKczAklenqwbMe75/7ATfRTt+zIlax4exI5sFE+K1K
 4dQjV0yG8IEZEE5n9Wrk2QSsUMlIKNM=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1589355772; a=rsa-sha256; cv=none;
 b=jSd3lMHfiMzTBOvJ7k3ghiUT+WT6Ki+jOOsR759abtvlsiIFRgSMSQxDtJnrb6vp1bjD+f
 4BAbyGAAdJeZACRzKL58GkK2SYcRgpGRQBKJvuqJFmQXNSALHwHag1E4LPstB5r8LfWfeb
 SYLRfLpp8xtmciBRslssuRoshHIOn8M=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=luc smtp.mailfrom=luc.michel@greensocs.com
Received-SPF: pass client-ip=5.135.226.135;
 envelope-from=luc.michel@greensocs.com; helo=beetle.greensocs.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 03:42:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 tong.ho@xilinx.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 4:36 PM, Edgar E. Iglesias wrote:
> From: Tong Ho <tong.ho@xilinx.com>
> 
> This is to fix cpu-abort with 'qemu: fatal: unknown mfs reg d'
> (in the default case) when microblaze guest issues 'MFS Rd,EDR'
> instruction.
> 
> Since embeddedsw release 2019.2, XPlm_ExceptionHandler() issues
> the instruction on exception, and microblaze model aborts when
> PLM firmware guest encounters an exception.
> 
> Signed-off-by: Tong Ho <tong.ho@xilinx.com>
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  target/microblaze/translate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
> index 20b7427811..92b3630804 100644
> --- a/target/microblaze/translate.c
> +++ b/target/microblaze/translate.c
> @@ -581,6 +581,7 @@ static void dec_msr(DisasContext *dc)
>              case SR_ESR:
>              case SR_FSR:
>              case SR_BTR:
> +            case SR_EDR:
>                  tcg_gen_extrl_i64_i32(cpu_R[dc->rd], cpu_SR[sr]);
>                  break;
>              case 0x800:
> 

