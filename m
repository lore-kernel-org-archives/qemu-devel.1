Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBD4C004EF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E42F7214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 11:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E42F7214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkoai-00024e-Ve
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 07:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48267)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hkoYl-0001Rz-EN
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hkoYj-0007AP-Lw
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:45:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hkoYj-00079I-G2
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 07:45:21 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so2886019wma.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 04:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qi1KGG3qWsH1jzwWsteQZqerXubugScphRwXNipFj58=;
 b=Dnjw6gXYiIjVGHLspWGkd1fFwUHUFiYYeKCKmW6DshwDcuJDrzzzLJZHz2qdsdEsDS
 fBhdmlsnCgwfzNaBH54xB3tgmbf0yuy+XiafKdEW8EyS1a1nfu3u968zqX8L9Fxe2W0y
 +0cOL2cnnQbtHCI1gO2hncxAp5GNWHQTIPRghSRQq3UfIIMbaSKWajFbwbL6BxxcegO2
 K8X6aBRuWGSZTzFSSMTrbJilnofGQcKKPa0y8IQjn8WFMULPKaPIXTnSdp1o5P6BkxLX
 OKZlcyLSjmD6gwCcM9hnqpjOckVFqwg9rLE5U7A+EJ04QDGAXxy8t2Mn2qiOnZlwGI5l
 KTyA==
X-Gm-Message-State: APjAAAW27FSUeVEbxjBOWcYR7VRvhn8HTq2tMQn2Vgd+B58mBvWs/dhU
 zJXZWyCFBoWQ1bjnpzdTCf94gA==
X-Google-Smtp-Source: APXvYqwGHx2dEUgjjZjOgLNvf1nflnBTxUB47Bi+/By2L8aUuRpebEG0brwvRbJZalNGrYDp20QHTg==
X-Received: by 2002:a1c:b68a:: with SMTP id g132mr23293075wmf.66.1562672719488; 
 Tue, 09 Jul 2019 04:45:19 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id a12sm23904817wrt.46.2019.07.09.04.45.18
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 09 Jul 2019 04:45:18 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>
References: <20190705161144.18533-1-philmd@redhat.com>
 <875zob8mrb.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <efde7707-f74f-f8ac-749a-2fca60913c00@redhat.com>
Date: Tue, 9 Jul 2019 13:45:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <875zob8mrb.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH-for-4.1] Revert "hw/block/pflash_cfi02:
 Reduce I/O accesses to 16-bit"
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/19 1:34 PM, Markus Armbruster wrote:
> Your subject matches the one git-revert creates (good), but you don't

I was wondering whether rewrite it as "Restore 32-bit I/O accesses",
keeping the original subject is better?

> have the rest of its commit message:
> 
>   This reverts commit 3ae0343db69c379beb5750b4ed70794bbed51b85.
> 
> Please add that line.

OK.

> The patch is a clean revert.
> 
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> 

Thanks!

