Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C815BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:43:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B05221FE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 17:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di5bDTXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B05221FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQZxB-0008HL-Pl
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 13:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQZwW-0007pQ-6P
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:43:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:50187)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQZwU-0002UL-Mm
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 13:43:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id 13so7338078wmf.0
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 10:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=U2rVO0NSdBgmlltw9sGv1pYDe2kEE0Ih/cyTu6bZ8F0=;
 b=di5bDTXCmMzyzCn0gJfrwHXam2MJ5rHv4EoF9r3eQzJkiVDOXeszIeVDHOXu0tsshh
 06Y7wkKxirqtI10gUIMxUG+RgAIkPH7KNQXV2Sicb5pOBKQFquQZTmYk2cRCZYACL2Kt
 KtQWkIKj2bYyN7cJ5DvLM8E/ep+/UnYUep8iPrW4ATLMXUH5JUzW2SEhXP7TmBJ3HWWm
 AnOGISW9lFJtIiBOkqnEMKmd1km/uq7VNzI7O87P01AcfObcUmIa8n1qyD72HRZfsJLd
 VdtV4N3CZvpwjVTHdzCger1d0gDvwPZvtNXeUJPMNp+eDVVwxk1bSF/IRlLvx8O4X1Ol
 +rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=U2rVO0NSdBgmlltw9sGv1pYDe2kEE0Ih/cyTu6bZ8F0=;
 b=MR8QPg84irF6+qVBqE9tC+QnCBR4HgmDeh6C0L529z3hi6/y4Kw4LseB5zBvIIHhZK
 VsK7CmoEHJEszKfVKHm8a8TWS3+a/uwlHlkWcfchirIXADQHpwuch65QvHCtabexpcQ4
 6RWIfiaMznqzb5n095djATjDSC7VzHVrfs7ITF4soU1U2RLfcGcgmfgJ0vFXApEOIWBf
 4ax73FkwoZp2YtQuD6MXBWCzGZnmXr+oI2rWNLGfuN17e+yPM+9C1YpDvS04T0r18yBq
 nl83KcWmvHHhqzLm9Z2iJLWtMMkl8oECRVXFGZk6AP4MNdMpZcrf/aMDPvxMLnYeCxm1
 A3uQ==
X-Gm-Message-State: AOAM5300CwgNe9v8XIM56QHXLAVunFZqghEGrGbeaqFcUyuS7vsBfht6
 iprmSzw1qSnHJsnm3H6vx7U=
X-Google-Smtp-Source: ABdhPJzjWnnIVh+K/cFZpGmnKOVWKIxiGtj+aqNKDSicp88V4xkgNVVEOMdXcynKDWhoYhooL1Yktw==
X-Received: by 2002:a7b:c7c9:: with SMTP id z9mr10528739wmk.91.1602178981139; 
 Thu, 08 Oct 2020 10:43:01 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z127sm7828475wmc.2.2020.10.08.10.42.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2020 10:43:00 -0700 (PDT)
Subject: Re: [PATCH v2] mingw: fix error __USE_MINGW_ANSI_STDIO redefined
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20201008165953.884599-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48fa7bd8-d07f-80af-1c66-9cb083f5c34c@amsat.org>
Date: Thu, 8 Oct 2020 19:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20201008165953.884599-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.214,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: sw@weilnetz.de, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/8/20 6:59 PM, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Always put osdep.h first, and remove redundant stdlib.h include.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  migration/dirtyrate.c | 3 ++-
>  tests/test-bitmap.c   | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

