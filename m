Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1962C4363A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:08:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2084E22276
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 20:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQ0s4GJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2084E22276
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWPpr-0003Le-59
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 16:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWPo0-0002Wc-1Y; Sat, 24 Oct 2020 16:06:24 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kWPnw-0001LD-GR; Sat, 24 Oct 2020 16:06:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id d78so6196745wmd.3;
 Sat, 24 Oct 2020 13:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gaGUXfj+4igL3ksAUaalL4a3tFJLwZ5Dv/u334hoUA4=;
 b=fQ0s4GJvOZZYxfcqio/UMXm346/PHeAnB8ODO2g/IjQopXWm/m8aTIPaZHwGw2sxiC
 PdW0JyaDEF+QgO0gtqKvWxJWb39Rd6kovsLp5eu3lIhKdZeXlZh5qkMNs5fgBRgFcUxg
 Zuh+jnBrjbTKjiw90sLPaXwAcF3zcDesHhyYBm6V17+o97DGcWWLw3ga18fx99RpSqpa
 IMB0IGVLrpJTga+3xWoWEPSZr6+oyn20lywZPmy4pz4Yjwcv4UJN6pc+6dSXY9U/t3xK
 6AHlFls3SzNNcn0+76EM/QD/Z9MiSPc4U02HxlzDgWky4utph8LklIckC/K8XQJfkVPf
 kOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gaGUXfj+4igL3ksAUaalL4a3tFJLwZ5Dv/u334hoUA4=;
 b=CUCzUaNUigP46FEVsaj/O0VKQRLaecmcAoX7siPeoQXRVDWb9oyGBycM3zW+oU57sb
 KmpzwVnksy4xy79SDj1wLTGRO+D0lvlqMfU8GHUzgNHNOYe13P6iZd1ZtDz3c4Xg2Co4
 2af+EwmqTGT5kCjdQg3WvXy8n00B+sGrATNrkQ528vQyGy/EmEfbpANPH3eTX0fEE8v+
 ZtnclrE3F/s0gEC4kOJ81q9jw7/b4phBSKgg1kNp3+NrgEeiXW8G9H8WKhxvDlGtrUj/
 gky6Ov2QrXiqIkkDv0xtJ+Qc+vW6xZYKFWcBa9xLYTQqXHDyXNpIBQ/q/+adwtwHdZlM
 nzmg==
X-Gm-Message-State: AOAM533tPKO8lEd7S+afhsxyJwqt94C6JVOPVdRXqLWykCqAyzfrj18R
 EnilbH8cRWjejnnBwfN5z+c=
X-Google-Smtp-Source: ABdhPJwLJq9/w7TpkRoVS5dMicWsxcsx+43GmZdQv8EGXXhAIdIAhPHCjIvtUyqnJa92vipUDL8Jtw==
X-Received: by 2002:a1c:495:: with SMTP id 143mr7896466wme.63.1603569976205;
 Sat, 24 Oct 2020 13:06:16 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id f14sm13484321wrr.80.2020.10.24.13.06.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Oct 2020 13:06:15 -0700 (PDT)
Subject: Re: [PATCH 1/3] hw/timer/sh_timer: Coding style clean-up
To: Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20201020153935.54315-1-thuth@redhat.com>
 <20201020153935.54315-2-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3059881f-08f6-cc9f-9bbb-0e179b1d4002@amsat.org>
Date: Sat, 24 Oct 2020 22:06:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201020153935.54315-2-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
> Replace TAB characters with spaces, put code after case-statement on
> separate lines and add some curly braces in related lines to keep
> checkpatch.pl happy.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/timer/sh_timer.c | 89 +++++++++++++++++++++++++++++----------------
>   1 file changed, 57 insertions(+), 32 deletions(-)

Easily reviewed with 'git-diff --color-words'.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

