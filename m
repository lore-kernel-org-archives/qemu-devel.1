Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461ADC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:26:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A554E207BC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A554E207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPW7z-0004vR-KB
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 15:26:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kPW6T-0003oN-8c
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:24:57 -0400
Received: from mailout02.t-online.de ([194.25.134.17]:42250)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kPW6R-0003db-5v
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 15:24:56 -0400
Received: from fwd30.aul.t-online.de (fwd30.aul.t-online.de [172.20.26.135])
 by mailout02.t-online.de (Postfix) with SMTP id BC0AC41C1E4F;
 Mon,  5 Oct 2020 21:24:51 +0200 (CEST)
Received: from [192.168.211.200]
 (ZeRvQqZQ8h75NUWFfWM7sFhyfPEw8ukMPUO-SeT3OGwQTotbWp5NffYbibu1kNvQGh@[93.236.145.51])
 by fwd30.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kPW6N-0K6UhE0; Mon, 5 Oct 2020 21:24:51 +0200
Subject: Re: [RFC PATCH] contrib/gitdm: Add more individual contributors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201004182506.2038515-1-f4bug@amsat.org>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Message-ID: <3a5e2677-56c1-b230-f8e6-82e83a46a01a@t-online.de>
Date: Mon, 5 Oct 2020 21:24:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201004182506.2038515-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ID: ZeRvQqZQ8h75NUWFfWM7sFhyfPEw8ukMPUO-SeT3OGwQTotbWp5NffYbibu1kNvQGh
X-TOI-EXPURGATEID: 150726::1601925891-00014A27-E10E388C/0/0 CLEAN NORMAL
X-TOI-MSGID: c23216b0-95bd-4d63-b0d9-a3463ad10903
Received-SPF: none client-ip=194.25.134.17; envelope-from=vr_qemu@t-online.de;
 helo=mailout02.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 15:24:52
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> To the developers Cc'ed: If you agree with your entry, please
> reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
> care, please either reply with Nack-by or ignore this patch.
> I'll repost in 2 weeks as formal patch (not RFC) with only the
> entries acked by their author.
> ---
>  contrib/gitdm/group-map-individuals | 22 ++++++++++++++++++++++
>  contrib/gitdm/group-map-redhat      |  1 -
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/gitdm/group-map-individuals b/contrib/gitdm/group-map-individuals
> index cf8a2ce367..b478fd4576 100644
> --- a/contrib/gitdm/group-map-individuals
> +++ b/contrib/gitdm/group-map-individuals
> @@ -16,3 +16,25 @@ aurelien@aurel32.net
>  balaton@eik.bme.hu
>  e.emanuelegiuseppe@gmail.com
>  andrew.smirnov@gmail.com
> +sw@weilnetz.de
> +huth@tuxfamily.org
> +laurent@vivier.eu
> +atar4qemu@gmail.com
> +hpoussin@reactos.org
> +deller@gmx.de
> +alistair@alistair23.me
> +fthain@telegraphics.com.au
> +svens@stackframe.org
> +aleksandar.qemu.devel@gmail.com
> +jhogan@kernel.org
> +paulburton@kernel.org
> +vr_qemu@t-online.de
> +nieklinnenbank@gmail.com
> +devnexen@gmail.com
> +jcd@tribudubois.net
> +dirty.ice.hu@gmail.com
> +mrolnik@gmail.com
> +pauldzim@gmail.com
> +linux@roeck-us.net
> +sundeep.lkml@gmail.com
> +ahmedkhaledkaraman@gmail.com
> diff --git a/contrib/gitdm/group-map-redhat b/contrib/gitdm/group-map-redhat
> index d15db2d35e..4a8ca84b36 100644
> --- a/contrib/gitdm/group-map-redhat
> +++ b/contrib/gitdm/group-map-redhat
> @@ -3,6 +3,5 @@
>  #
>  
>  david@gibson.dropbear.id.au
> -laurent@vivier.eu
>  pjp@fedoraproject.org
>  armbru@pond.sub.org

Acked-by: Volker Rümelin <vr_qemu@t-online.de>

