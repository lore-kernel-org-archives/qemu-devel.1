Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC0DC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:12:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C76B20829
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 13:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="da8MeSXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C76B20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIAkd-0006TF-1G
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 09:12:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59254)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIAXf-00065i-VT
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:58:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35309)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIAXe-0005ay-8o
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 08:58:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id e16so3247866wrm.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 05:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aL8sdTkn90UqpWmmOm3xpASNajpCEK3JYVRWPXbX83o=;
 b=da8MeSXAjrY3D7cnRUVmsrSuVU4jF263L1sKeJRuRQv1ctBmdw4n6Lrjv7VSN8MiX3
 UQEWhnHF9Pfah6PZlVKL/+du+48r50OXgW78FA0gTMiHpcXN0D4SFnKHY2KGoiOgy3g8
 57RIv6osrQYEXSZRX2TwpbctRHT4Rw4WsCerUt2qpXo15AAt05C3W8stR7hf2oNh1aBz
 keR4IQBBIgi3INza015eUyQQSYJrMFQq/o3QxEI6nMyhd+c+ygaHUFwHBi8eWai29Iri
 +EZuMwC2wWfGs/ky332fdd7sbgR5n70r+9XTgWS1LnNBiJgwt0Ptk+cr3CPO/qEIePwO
 CPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aL8sdTkn90UqpWmmOm3xpASNajpCEK3JYVRWPXbX83o=;
 b=W3dmeh6+G/FGioVowcaJ5KmCYhmMqPtBiQ0pea5k1v6D7dc6ptfdmSp7f+X6b+BGDM
 jLhgm9ZeJMyRJVWZ436ejMxI6cw0thMatrnssgg0WlVO86O0A0KHLHRY//oDXnDijYVD
 1qfbC6bLCmjE/StEVkCoKKlvnqwSUrqca8PyKbDPLQwpbbJuyoQDBFRDO/V6+tX+vJO4
 TWfrEQGvvqFs5jwJirFix/gouhOO/Opx0tcMFsml7VLiA775XaAIoBvDeoPDKQYgmCZo
 WeiXrSfUmUmTzh+JP1/Lx3pmzkL1xmCXzNo8q//Zrdq+L7CM/kHAUSVqJQFWV16bNvvL
 /cww==
X-Gm-Message-State: AOAM533ZPzPk6cA2zjNYBMNwjgmGIg/c34EWethNcuXX5K7tomMpIUnF
 2UV726bkbJHzUgser/sxHvXQVLgrKlk=
X-Google-Smtp-Source: ABdhPJy/VGnP9GrGsYxw9Nkc095kdSx4iaLAurmMnUUc8m2kLAlTbrJlKfH78UQCzZ2Ixn+MZlLEDg==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr20499409wrt.13.1600174715908; 
 Tue, 15 Sep 2020 05:58:35 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id z9sm26158568wmg.46.2020.09.15.05.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 05:58:35 -0700 (PDT)
Subject: Re: [PATCH v1 4/6] configure: include tilegx-linux-user in the
 auto-exclude logic
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200914150716.10501-1-alex.bennee@linaro.org>
 <20200914150716.10501-5-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <26a12957-26a3-09d0-e619-8a187658dba5@amsat.org>
Date: Tue, 15 Sep 2020 14:58:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200914150716.10501-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/14/20 5:07 PM, Alex Bennée wrote:
> The target is already marked as deprecated in the documentation.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 50052378e417..d998723cccc3 100755
> --- a/configure
> +++ b/configure
> @@ -1725,7 +1725,7 @@ fi
>  # If the user doesn't explicitly specify a deprecated target we will
>  # skip it.
>  if test -z "$target_list"; then
> -    deprecated_targets_list=ppc64abi32-linux-user
> +    deprecated_targets_list=ppc64abi32-linux-user,tilegx-linux-user
>      if test -z "$target_list_exclude"; then
>          target_list_exclude="$deprecated_targets_list"
>      else
> @@ -7719,6 +7719,7 @@ case "$target_name" in
>      gdb_xml_files="s390x-core64.xml s390-acr.xml s390-fpr.xml s390-vx.xml s390-cr.xml s390-virt.xml s390-gs.xml"
>    ;;
>    tilegx)
> +    add_to deprecated_features tilegx
>    ;;
>    tricore)
>    ;;
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


