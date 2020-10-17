Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E714C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 07:02:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A0B2076A
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 07:02:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A0B2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTgEd-0000zl-NC
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 03:02:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kTgDR-0000Y8-0z
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 03:01:21 -0400
Received: from mailout02.t-online.de ([194.25.134.17]:39686)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1kTgDN-00007s-4Y
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 03:01:20 -0400
Received: from fwd08.aul.t-online.de (fwd08.aul.t-online.de [172.20.26.151])
 by mailout02.t-online.de (Postfix) with SMTP id 2114241F0C65;
 Sat, 17 Oct 2020 09:01:12 +0200 (CEST)
Received: from [192.168.211.200]
 (TD0ycvZAZhJdukzh3hhpdqbSvodQBXfrUC2uJekWElq1Ywgjt3l-lhUDZ2HSRO7g+S@[46.86.52.112])
 by fwd08.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1kTgDF-4Tj7Wy0; Sat, 17 Oct 2020 09:01:09 +0200
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: aio_poll() assertion fail on Windows
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>
References: <2baf958b-80bd-778e-e0e8-b03364a942a6@ilande.co.uk>
Message-ID: <395294f6-9e33-e982-08e7-98b786cd17f8@t-online.de>
Date: Sat, 17 Oct 2020 09:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <2baf958b-80bd-778e-e0e8-b03364a942a6@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ID: TD0ycvZAZhJdukzh3hhpdqbSvodQBXfrUC2uJekWElq1Ywgjt3l-lhUDZ2HSRO7g+S
X-TOI-EXPURGATEID: 150726::1602918070-000072E4-F4E14FFB/0/0 CLEAN NORMAL
X-TOI-MSGID: 22dc5fc6-d9f0-4f39-a05c-b487a5dafd71
Received-SPF: none client-ip=194.25.134.17; envelope-from=vr_qemu@t-online.de;
 helo=mailout02.t-online.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/17 03:01:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Whilst testing a Windows build of git master of qemu-system-ppc in MSYS2/MingW64 I noticed the following assertion message in the console after booting into OpenBIOS and then closing the GTK GUI window without booting a client OS:
>
> $ ./qemu-system-ppc
> **
> ERROR:../util/aio-win32.c:337:aio_poll: assertion failed: (in_aio_context_home_thread(ctx))
> Bail out! ERROR:../util/aio-win32.c:337:aio_poll: assertion failed: (in_aio_context_home_thread(ctx))
>
> Has anyone else seen this at all?
>

This error appears since commit 9ce44e2ce2 "qmp: Move dispatcher to a coroutine". I think I can see the problem, but I'll have to ask Kevin. I really don't know the qmp code.

With best regards,
Volker

