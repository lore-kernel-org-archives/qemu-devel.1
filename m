Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF52C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18C8D20759
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 08:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yx6KI/SA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18C8D20759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqBSj-0007vi-CY
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 04:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBPc-0003Ng-RS; Tue, 30 Jun 2020 04:14:40 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:42466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jqBPa-0003Ki-FT; Tue, 30 Jun 2020 04:14:40 -0400
Received: by mail-ej1-x644.google.com with SMTP id i14so19582797ejr.9;
 Tue, 30 Jun 2020 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TudWM1wkL52+YWCkl1Dxv9SRDhDpUoJlZG8pQ7k5sm8=;
 b=Yx6KI/SASjGSSGtYxS+OXZxdKukRBnSPeZcWwrJ9ePr2yfiUsje3Fas5mrR7IeOXKo
 zoFHv5QfLpA3sVyA6dGAJbkvPUes51cmAW97XHzdWU2Hq5gITo5u+WSMkSwXAcVYDF6o
 U53O4ivtG+2k5an2ec+gU6afRLvIOktv8qlgcN/UrcpKM2lqtfB2xZgA+cRuhB46jxEL
 BvCf2fLc8JHK2+dpHzf86P+CA3bm+8jtDYz6phBBwfBHUo+t+LN3PdytzosHi5IRD6a0
 RovQSexSCDlg8iWW2FTA8ps0wZvnmhFSB4uHDvFoRuYiRPqbZnrvloDMef8S3SPIAkfA
 1qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TudWM1wkL52+YWCkl1Dxv9SRDhDpUoJlZG8pQ7k5sm8=;
 b=khzj+vmMheuQD4xcF2qO+a5xZy94T7y4abVAmub4m73HFyiWt01P/zAzf7UUhWXJfo
 Elg3zrVcVwfeAxmYdZqq0AAz1g33P7qF/obnL/YeKljmzULeSOBGeUvJhN7lIkb1Erep
 9ppTols78C8KLSlJ3dNHMeVNrifrVBdld74uORBXycNzSng6fOUS1px1T3WItohPbvqI
 Uk13ADL/OzL5LmpZ+NCedDTQXK4hp8/MGq0tWcsao3Tbqr3B3x2A4JaO1VZybPcz/Ien
 js4whGJrfJnlecPzkc7uMm7lk+aRAb7VvZ8eZYB8+XMEFrjkLyVqO3LFc1IxE6zxXfBd
 PHQw==
X-Gm-Message-State: AOAM5333gNE3+44+pn3s9z+7XwXQmPeLr1mv/wBAEPAD8roh/A1KY5CA
 EsHZd5VF9jOgpcNDkI7bdow=
X-Google-Smtp-Source: ABdhPJzIjtKP+rBOXYTiFYnpmXATCqJNlE5rSyXCQYdFPFb6nB3slVvyFhAk4Ezhi6nVdhVW2DXhow==
X-Received: by 2002:a17:906:3958:: with SMTP id
 g24mr16638205eje.26.1593504876419; 
 Tue, 30 Jun 2020 01:14:36 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id jo25sm1422045ejb.116.2020.06.30.01.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 01:14:35 -0700 (PDT)
Subject: Re: [PATCH] hw/misc/pca9552: Add missing TypeInfo::class_size field
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200629074704.23028-1-f4bug@amsat.org>
 <CAFEAcA_uAJzddqVfttgZ9PjNfbrjt3q1=HaTwRNPs+=smrDkjg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bc93f3ed-a2bb-1b4a-d249-cf964bd43488@amsat.org>
Date: Tue, 30 Jun 2020 10:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_uAJzddqVfttgZ9PjNfbrjt3q1=HaTwRNPs+=smrDkjg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe DUBOIS <jcd@tribudubois.net>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 11:07 PM, Peter Maydell wrote:
> On Mon, 29 Jun 2020 at 08:47, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> When adding the generic PCA955xClass in commit 736132e455, we
>> forgot to set the class_size field. Fill it now to avoid:
> 
> Thanks; I've applied this to master since it fixes a memory
> corruption that affects all arm targets and I'm not otherwise
> planning an arm pullreq for a bit.

Thanks Peter!

