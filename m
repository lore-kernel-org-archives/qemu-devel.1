Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37D0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:09:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AECB6207E8
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0agxZu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AECB6207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jajGg-0001mW-T7
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jajFl-0000cY-46
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:08:37 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jajFk-00058H-9t
 for qemu-devel@nongnu.org; Mon, 18 May 2020 13:08:36 -0400
Received: by mail-wm1-x341.google.com with SMTP id w64so317850wmg.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 10:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ukxF3ybCb/hAATcqpSWOHb1E6hJjVYC+QbKbLYb5R0o=;
 b=E0agxZu4o4UqJEeBE7CYhsq755NlRCWteyvv01BFnICKhtvUfukUyn/cC0wypMeSNQ
 0bnnhhB1b9poGm09k4BjU0WBPNhdV108NfZ7Zsi8N1W89AMtcoRhI+m+ClhLR+4CLBKX
 gXLdnrVxEmRHPkKV9kS1RiASjxqGZYIsy3jH7glf1pEg7liEaqIP6qeGbLit0eItLK8k
 6huH39aQueWpN05PTKhCtoCLlp73C2hU40xIa+VuqCoJZgBn+9Gz7PTwcaZkqQyMa8SH
 J+B/ciBdfMLL/LJQAZIURQEihrwLpuHgnFIyK9Q8v3tSmUG6xMVmkTPfn7om/4Yg8jXn
 3KyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ukxF3ybCb/hAATcqpSWOHb1E6hJjVYC+QbKbLYb5R0o=;
 b=XdPoin3RPoEDmGeVORzZxAGFCfW06OQ+0QOjULbLNJoGd6mzzg2s2onCYxqQ5dZEZY
 lCL9hAo1C//+4jQDTUPMR5V8YHilZAhRGpSNlPOYqcMULX0AJVO2so+N0xdad9z6jPHD
 q6yudTbckPtnKrSaUEpOC8A7rRpexp8QMGKtMSMsM2SkmRWkI3tvK6Sr+KCXVcxnnVTR
 BIuy46V/rabeRR9gn7SlsZsC82yeyamHji8XnohmvdkSUUi5gJZ4/Ekt45px5JtrMHfr
 nz9lWVs7TLWsBeB4oKwCfZ8G3ZPV80khOP0qSwYWOQ7LRhCqn3GbKzBZOpwBnwkBD9TL
 flSg==
X-Gm-Message-State: AOAM532QROmYoNh7TPqo/KxCnghGfta717hRnRlf8ojT7fnz2n2ByL9l
 8vp3JJm7tYGG7obgwofsWtE=
X-Google-Smtp-Source: ABdhPJyiMtG+6OdiLL2YZWtliFItoIFGk8seHBgaLoXFBWhRrarkQIbzsf04Kw/ElQcfuCbrTzclCg==
X-Received: by 2002:a1c:3984:: with SMTP id g126mr305286wma.169.1589821714740; 
 Mon, 18 May 2020 10:08:34 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id v205sm260591wmg.11.2020.05.18.10.08.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 10:08:34 -0700 (PDT)
Subject: Re: [PATCH] hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask()
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20200518094904.24226-1-f4bug@amsat.org>
 <6a1d8e73-9417-2e52-a2a9-e5d1c00a0a2a@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6dc504aa-1fea-e5dd-1ba9-d1d59fbcb198@amsat.org>
Date: Mon, 18 May 2020 19:08:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6a1d8e73-9417-2e52-a2a9-e5d1c00a0a2a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <huth@tuxfamily.org>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 6:32 PM, Thomas Huth wrote:
> On 18/05/2020 11.49, Philippe Mathieu-Daudé wrote:
>> hw_error() calls exit(). This a bit overkill when we can log
>> the accesses as unimplemented or guest error.
> 
> Good idea. hw_error() is also mainly for CPU errors, it really should
> not be used for non-CPU devices.

Are you sure?

$ git grep hw_error target | wc -l
5
$ git grep hw_error hw | wc -l
137

[...]

