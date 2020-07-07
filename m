Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08999C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:58:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBE6206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mAHGuaQk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBE6206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsrrN-0002Vx-4a
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsrqY-00023d-QA
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:57:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46712)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jsrqX-0008Mg-4e
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 13:57:34 -0400
Received: by mail-wr1-x442.google.com with SMTP id r12so46105731wrj.13
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uxDzyuXqBQzdCYGEyxLAMgLcxs4jxqgv8xQ9zPs64rc=;
 b=mAHGuaQkTfqkXv3/Zt6yUYPtkHWqWxoONNTZa6EBm5V8HAGIgngMgEvrR9EwJRtXR0
 92Ok87kA/CpJegGER4yevce3aWCBGdDqd5gT1u60pVK6aRPfRGLGmJs9k1uetoaVeaSE
 U0qn7TGlraHYfepvMNxA0ytMsDhM0WgewqMzSzI4lNExs6ALW/vhc7t6lPZeSAy0CO4d
 QgtvrXgYeZKNIT7NHLDhHqpnIgC7b2F6vyIpkMB/fxhNMADZIYa2s0TjrbMyX4AiXg2A
 bwDzIa9eJZFr9m5pOOYzhUQ4NodPlMYGIppPC1039iTVtRNO/GD5ZSA2b2lwI3KgannG
 IGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uxDzyuXqBQzdCYGEyxLAMgLcxs4jxqgv8xQ9zPs64rc=;
 b=PGB2HhihWevOdyTz2vdxKUJCgHhSB/S3IzJhUfgPhtNz0dcpem6ScT2NOh+Hz/gIYs
 iXK0UJ3s/g9y87qdTyqg3wWY1qsscEZqEZArRrActytf8LhYxGtX6A/WSGzZy84G5l1Q
 reR9HP+yUB6UeTjbCm9rNxeILC0llBU62k+ipT/QRcI3llL1Dm5YWCRIW0Wf9ibfzA+2
 FNSlE3Lj5RUR4EJjT3WpqVeyVQ90CwTOrnWC9inJWW7CqKwlJuIJ7eGZU49uTC1+JASg
 AbQC/byDbb7DgX7s5lW3D5bfdhLX3p7FXiDdn+AHrH/OQ81g1ZiFWHvsrk7ojgJHtOdJ
 ysCQ==
X-Gm-Message-State: AOAM530shlEo/OgB2a/dMohJ4FlG7KU4tHAhC33HzqBmDUY11I3/kZp+
 iH7KZAuPJceJHquvOT7PsZo=
X-Google-Smtp-Source: ABdhPJyyDr0NuMEr4oXrtrUPf3NKX6tm/u/jESHTO0d11dZITyUWsJGYMiMwegvbiM2kHsmICwI5yg==
X-Received: by 2002:adf:e850:: with SMTP id d16mr57265938wrn.426.1594144650976; 
 Tue, 07 Jul 2020 10:57:30 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id x5sm2117762wmg.2.2020.07.07.10.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2020 10:57:30 -0700 (PDT)
Subject: Re: [PATCH rc6 00/30] target/avr merger
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Michael Rolnik <mrolnik@gmail.com>, Richard Henderson <rth@twiddle.net>
References: <20200705140315.260514-1-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6b362e28-a2a9-1b4b-8714-c5f3163fe29a@amsat.org>
Date: Tue, 7 Jul 2020 19:57:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200705140315.260514-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/5/20 4:02 PM, Thomas Huth wrote:
> This is the AVR port from Michael, release (merge) candidate 6.
> 
> I've rebased rc5 to the current master branch, fixed the conflicts,
> and updated the APIs where necessary (e.g. qdev_create() had to be
> replaced).
> 
> These patches have been on the list for a long time. Let's try to
> get them finally merged.
> 
> You can also find the patches in my repo here:
> 
>  https://gitlab.com/huth/qemu/-/tree/avr
> 
> rc6:
> - Rebased to master, fixed conflicts
> - Changed the object_initialize_child() and qdev_create() calls
>   where necessary
> - Converted the texi doc to Sphinx
> - Dropped the travis.yml patch - the acceptance CI is currently moved
>   to gitlab, so we should add it later there instead
> - Dropped the patch to clean up MAINTAINERs - and do it correctly
>   right from the start instead.

Thanks for this Thomas!

I am queuing the patches and will send a pull request.

Regards,

Phil.

