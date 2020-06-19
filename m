Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 346C0C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:57:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0521D20809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWlmrdCg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0521D20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJOr-0003Ov-AW
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:57:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmJNG-0001cI-4A
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:56:14 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35384)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmJNE-0008AT-3q
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:56:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id g21so5111848wmg.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9TFEoCIjWjm3xXaV29aFSeLFa+y+SkkIxMa8ILytMlI=;
 b=QWlmrdCgAL4kmd8hv4J57Wlek2y8Ay9vVkckdx7GXXmg/wu0qyde2NJV10erAj2n7j
 OiSUIgaTyOfIlRV4MlRusTxcHQSl5i796e2EK41ON3rjCERb/EYS61p73uZok7nhiXsA
 ReyIWkavmq8knoQWwU0YkrHeEIU1UpTpPy+qUdRYRLsiuhwycekjeBjkivzCLEJy21Cc
 vK2Cb1J+793hoIldu3mjkwxX+RPkl2NtXWFymZhwnaiKAJJ1JwO2moQo/UHm/l5DToZU
 kbrxDYtU1d9ZmgScs2c7YgFtIOzkBbvn8I6NXjpd24YorzKz31il4ApzAHBBQBP+qIol
 D3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9TFEoCIjWjm3xXaV29aFSeLFa+y+SkkIxMa8ILytMlI=;
 b=rUplrkTduc4cV/Utyfa/VwjkcFIVhdEyI+bAsOydpRzSs8RRq7RX6s2pgyjKxR1SFX
 csMo+wAW4dCEWydwuHXTnwke3Ke609MnjdUfHENoaXdxF6dlzSZO6TQpVrzbeLKczNuC
 YtWyuM58+rjHdYQZQaNQsIXtEHuHyLrTE/utqvPdIF+qV0hpAcwvd/LR+EB58bokZQ1b
 kLiKrtzPnrG9T/DG6FO3640DxLMjUvzn0Nl9PFW2xxhglPPKE4tSIFtCURwxIc5j2NE3
 fTvbX8O4ZTsHe0V2ppAEK2HF3VlcrSZB61MTYhrbsg3kOvrL4ULKnXLEnPISfpnQJ2o2
 1CwQ==
X-Gm-Message-State: AOAM531Aul5mOogt8HyEbK6WjPf3D7Os2A73VKrbOq1aHKIheibaNAmr
 XBu2cVCBnXEWNOOCrv7KxZBfkE3y
X-Google-Smtp-Source: ABdhPJxFgjxDPGzBVMcRoLe2Va3NdWYlEmHM7LmphzjkQ6Atix6xxw/LT/HreBRUcmYMZnsxdqRpJQ==
X-Received: by 2002:a7b:cbcc:: with SMTP id n12mr4196329wmi.127.1592582170245; 
 Fri, 19 Jun 2020 08:56:10 -0700 (PDT)
Received: from [192.168.1.37] (93.red-83-59-160.dynamicip.rima-tde.net.
 [83.59.160.93])
 by smtp.gmail.com with ESMTPSA id l17sm7247104wmi.16.2020.06.19.08.56.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 08:56:09 -0700 (PDT)
Subject: Re: [PATCH] Deprecate TileGX port
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200619154831.26319-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <46b0be6a-50ed-211d-7b3f-3ddf4f157fcd@amsat.org>
Date: Fri, 19 Jun 2020 17:56:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200619154831.26319-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Chen Gang <chengang@emindsoft.com.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/19/20 5:48 PM, Peter Maydell wrote:
> Deprecate our TileGX target support:
>  * we have no active maintainer for it
>  * it has had essentially no contributions (other than tree-wide cleanups
>    and similar) since it was first added
>  * the Linux kernel dropped support in 2018, as has glibc
> 
> Note the deprecation in the manual, but don't try to print a warning
> when QEMU runs -- printing unsuppressable messages is more obtrusive
> for linux-user mode than it would be for system-emulation mode, and
> it doesn't seem worth trying to invent a new suppressible-error
> system for linux-user just for this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> We discussed dropping this target last year:
>  https://patchew.org/QEMU/20191012071210.13632-1-philmd@redhat.com/
> and before that in 2018, when Chen told us he didn't have time
> to work on tilegx any more:
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg03955.html
> Given that tilegx is no longer in upstream Linux I think it makes sense
> to finally deprecate-and-drop our linux-user support for it.
> 
>  docs/system/deprecated.rst | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 3a255591c34..e9097e089bb 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -387,6 +387,17 @@ The above, converted to the current supported format::
>  
>    json:{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"}
>  
> +linux-user mode CPUs
> +--------------------
> +
> +``tilegx`` CPUs (since 5.1.0)
> +'''''''''''''''''''''''''''''
> +
> +The ``tilegx`` guest CPU support (which was only implemented in
> +linux-user mode) is deprecated and will be removed in a future version
> +of QEMU. Support for this CPU was removed from the upstream Linux
> +kernel in 2018, and has also been dropped from glibc.
> +
>  Related binaries
>  ----------------
>  

Thanks for writing this down, simple and effective!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>



