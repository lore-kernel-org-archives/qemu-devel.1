Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B648C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:23:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17336206F7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 09:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17336206F7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMpsU-00011h-7h
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 05:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1jMprB-0000UF-WB
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:21:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1jMprB-0002Dq-1C
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:21:49 -0400
Received: from mailout11.t-online.de ([194.25.134.85]:47946)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1jMprA-0002CW-R9
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 05:21:48 -0400
Received: from fwd26.aul.t-online.de (fwd26.aul.t-online.de [172.20.26.131])
 by mailout11.t-online.de (Postfix) with SMTP id 77FDC4219028;
 Fri, 10 Apr 2020 11:21:45 +0200 (CEST)
Received: from [192.168.211.200]
 (bp-YK8Z1whO7zLXi+t5ssLECQSEmqE6kOhHuGDSGQJQSB0l0Z46yNXO3hLMzPD6wWz@[46.86.48.198])
 by fwd26.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1jMpr6-0742uO0; Fri, 10 Apr 2020 11:21:44 +0200
Subject: Re: [PATCH] hax: Windows doesn't like posix device names
To: Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Wenchao Wang <wenchao.wang@intel.com>, Colin Xu <colin.xu@intel.com>
References: <20200322210211.29603-1-vr_qemu@t-online.de>
 <e38bcea7-4fce-724f-d154-d3ffc3d3d33f@redhat.com>
 <f50df9e0-4115-c9fb-8823-4d0e7b254f1e@weilnetz.de>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Message-ID: <13ab012c-c1a1-bfcb-5c34-395a820b842f@t-online.de>
Date: Fri, 10 Apr 2020 11:21:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <f50df9e0-4115-c9fb-8823-4d0e7b254f1e@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ID: bp-YK8Z1whO7zLXi+t5ssLECQSEmqE6kOhHuGDSGQJQSB0l0Z46yNXO3hLMzPD6wWz
X-TOI-MSGID: 9afd0f05-0c7f-4d88-94c3-084332195922
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.85
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
Cc: Julio Faracco <jcfaracco@gmail.com>, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> Is this relevant? Or should we drop HAX support for Windows? Personally
> I have no experience with hardware acceleration for QEMU on macOS.

There's another reason to keep hax for Windows. You can't enable the Hyper-V role on Windows 10 Home. Without hax and whpx there's no usable hypervisor left.

With best regards,
Volker

> Stefan
>
>
>


