Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB5EC4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43840222BA
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:12:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoX3b/ZT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43840222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWPtf-0005QR-Am
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32958)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWPsG-0004Lb-Ge; Sat, 24 Oct 2020 16:10:48 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39194)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWPsE-0001xP-Vc; Sat, 24 Oct 2020 16:10:48 -0400
Received: by mail-wr1-x444.google.com with SMTP id y12so6929535wrp.6;
 Sat, 24 Oct 2020 13:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iwqDWawN4yHV2wS3lQhrrQziWlCFkYgrnQkpFiVzIAY=;
 b=UoX3b/ZTMbbC/5SNEA4tCVp1Zg5sXVn9gCaO6jNHeboKPqBX3pZ5dlDO2obGzLBC7P
 Ivh3ue0gGnHULzPYP8m54pfFrd39XRmmw3dRWrlDN5lZjzyWIi+31D9HW6ZQpKaQKYAo
 uGq+qnJ21rIbhVxqZOQMk0HvF9N8Mqm1/HJYeNgdrwjkH33tuoUbPmJhgc3upZyAuKaF
 hELBq6lt0+q8Fsd5ShkGBA47eY8aUbbRSh9o1CiBVa1V2yGedr6zoyyTXDrjNZpmwfom
 YMN2YMH1Xi1nQOraZ/N5/AgC75dhARHsETy5GM+2Tycfmrd56E6XUfxnyDW9PLGNJn99
 XDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iwqDWawN4yHV2wS3lQhrrQziWlCFkYgrnQkpFiVzIAY=;
 b=NZgerMjtPCDkDID4bB+gy7P/KURS0gLpwBwYLVbcH8oWcF1F4Q2Nm0C5eyH2EG//wS
 cLGjGYA/6BikzmyXFbA/3n6a/PvD7ZhqvGDbMbjcbTYW/lalUQl+jibUi/EgT1yBHLNq
 MqrOqEmwtRa7qTJHa4zBnpYyywRwb81f+dnZ2uwXuyg4RdFZnCwUFpdLLL05gVxd5wnQ
 RCIbtgR3xtpPjlmxcUP1CkjMasU9UwwEu2a64dUOryetWkvtVGzugZWCb/0mLZwMG+pE
 ClmUrcleMRDEDl8zAnh+IvF7N8m9UTmFIkSlN+y/FnPQNsXGDETYmyWQblCE9J0UtAp2
 DBIQ==
X-Gm-Message-State: AOAM532w6kGRntGwTMEbOjhYJUht4n9YX2Uk9ulINhLbMJDzbpkzULun
 oU88Qpixubs74UePPfDKNPE=
X-Google-Smtp-Source: ABdhPJx6szxUafVoDgBLF9+REZVIT8OWvazHBs4gUq2GsBcRuZXV961lA+EJR/FCXoPTThEgkhPA5Q==
X-Received: by 2002:a5d:6345:: with SMTP id b5mr9578448wrw.288.1603570245112; 
 Sat, 24 Oct 2020 13:10:45 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id i126sm12837150wmi.0.2020.10.24.13.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 13:10:44 -0700 (PDT)
Subject: Re: [PATCH 3/3] hw/timer/sh_timer: Remove superfluous "break"
 statements
To: Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20201020153935.54315-1-thuth@redhat.com>
 <20201020153935.54315-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eb29a32b-9fb1-8876-c76f-defd710c5b28@amsat.org>
Date: Sat, 24 Oct 2020 22:10:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020153935.54315-4-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 5:39 PM, Thomas Huth wrote:
> hw_error() is marked as QEMU_NORETURN, so the "break" statements
> after this function are just dead code.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/timer/sh_timer.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

