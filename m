Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2AFC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:29:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B011A2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 10:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B011A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvfg7-00038r-R3
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 06:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33442)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvfff-0002IK-GI
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:29:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvffe-00038i-Jk
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:29:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42314)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvffe-00038Q-Cp
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 06:29:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so44472866wrr.9
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 03:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XzdWe+OWmPnP/dShEMimTxj3Z5JfbbPKrQ4TuepH83U=;
 b=PsTzgHBa4IofgfGNTklQHZWlQUmRSAD8Bfspvyxvwkk7hdDBBaNcbOf5jhD3NJrbqI
 BBt9ryU5VspqtN5S6SooGLnUFlkyrLyM3JwC7gdHGdd9DZqSC0dWzyxwkLM9MhkYJnQC
 KCT2IDTqsG7S4Tsos/oPRs3YQN3ZBc8i+JfJay03tRd2Xzve5yaYPE5D4ShhPMuKu/kr
 +V12mv5pddAx1Tvod52pwQlADLOvVzVV28y6VNaIlFvTQ3nNvAVe/e1dHlOqrfaSB6HH
 VNmzCDyiYQNVnl6nPG8aIGlewMtuxLano4dpKBHC/ow4mUFlwTNEPiYkOw2uTw8Ysdbi
 gbQg==
X-Gm-Message-State: APjAAAUk7kTDsZKpiHUEaIWrCOaBVCicArvi1JW8EAsDv5vjZKuY4hXb
 7aQS9uKN3/Vooocold4rdatm6RmiTIs=
X-Google-Smtp-Source: APXvYqyjVtsT6EWvFzeWa1JlKowz9/lpW5SQzUtvtGmgrQs/zSUq7MssL47btt6wQ6R6ivlcr36S/A==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr1567349wrw.90.1565260160847; 
 Thu, 08 Aug 2019 03:29:20 -0700 (PDT)
Received: from [192.168.1.39] (214.red-83-51-160.dynamicip.rima-tde.net.
 [83.51.160.214])
 by smtp.gmail.com with ESMTPSA id n5sm1500044wmi.21.2019.08.08.03.29.19
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Aug 2019 03:29:20 -0700 (PDT)
To: P J P <ppandit@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20190808063340.23833-1-ppandit@redhat.com>
 <aa654255-8124-8a76-56c8-47c8bdf19a08@redhat.com>
 <nycvar.YSQ.7.76.1908081510580.30966@xnncv>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b356c088-1ec7-428a-e20f-0114bd3261f7@redhat.com>
Date: Thu, 8 Aug 2019 12:29:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <nycvar.YSQ.7.76.1908081510580.30966@xnncv>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] scsi: lsi: exit infinite loop while
 executing script (CVE-2019-12068)
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
Cc: Fam Zheng <fam@euphon.net>, Bugs SysSec <bugs-syssec@rub.de>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/8/19 11:48 AM, P J P wrote:
> +-- On Thu, 8 Aug 2019, Paolo Bonzini wrote --+
> | I am not sure this is worth a CVE. 
> 
> True, it is a low one, as QEMU consumes cycles on the host.
> 
> | The kernel can cause QEMU to break, but is there a practical case in which 
> | an unprivileged user can do that?
> 
> QEMU does not break, it keeps running in interruptible sleep 'S' state. 
> They've a reproducer wherein guest does mmio calls to trigger the issue.

From user-mode? As unprivileged user?

