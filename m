Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B42C433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A24712225F
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 13:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6Gr4dCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A24712225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kREgH-0005FB-MR
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 09:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kREf5-0004oL-PT
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 09:11:47 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:39827)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kREf4-0007au-6t
 for qemu-devel@nongnu.org; Sat, 10 Oct 2020 09:11:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id y12so7712100wrp.6
 for <qemu-devel@nongnu.org>; Sat, 10 Oct 2020 06:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FUJPkiefBSBDt5AoaL05DM+Cp27byJG71lK3V/aaY1k=;
 b=m6Gr4dCM8sYwAWOgtsyls8hQUUTdQbURbsjh1rqqxUIzy3hygYLC1AsW0wQL5KVe50
 2Kdv2g/wCOhW9rxX80NfpY/imlfQi+VPTnuTwN9nCEQsxLcXN7CgawPZSGpZdj7pK42i
 b1ZSmlpMq2ieh60cmpM0l87hZmbhKbxHa2et84taJZRGpkXY7wXQ8OSnOIitl+rlwaYj
 L1zCckQEzCnO1+r8yeqLBvgyS1hVXz5zFlG+5oDPN8978Dkqjda3Zazzuc+S2ZKS5nX/
 Flk5HDnHWNRaToPfC3wKgPC85PaLg0M5TbjM53oQSni6wC+z01TZjTGAMbVtnsgQWsVh
 l2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FUJPkiefBSBDt5AoaL05DM+Cp27byJG71lK3V/aaY1k=;
 b=NhzJkjtbXok+nGE3zVeLJf8aaWUWdniCs0jv3uj7YbmJlpqC8AdxzfrC9ZcjW0VN05
 Gjo52ph05duCAyJehtZ1uFAb7ldLCbwxrirOKV1dFfHsIpeK4fTTTl39AOHQOXlHllSP
 onv1EFe1HwTTCEHux0aB/Z1u3X1kS3phPgdqM0D0y+goKt4u/Z0KNxBaJlbj3gWiGdmA
 iaGaN3WNSz3+O+/nw8eLCxhRxHkFVl9e07yE3+mK2A6Cr5IhCqtgoLAqM/hwhvpxuw2i
 oqYRUt4j3E3Rkrf6Z4hia2yrNYkgv0CXgMItH7/ES/yarMp500X+nZzgsubFYJIX8rTH
 oNCg==
X-Gm-Message-State: AOAM531ocmBXr3K/qtjRcuSTxpb5h6uxLhY+ixRhCow61zPDTdnflELJ
 dtXIzziJvlzHg5LDMJy8UT8=
X-Google-Smtp-Source: ABdhPJzz1rxVZze2hNgKqSjccNm1LlquB5ExuTsAngFbathOr1iReBF9QY2c6MCatnMTvp8rLlr6fQ==
X-Received: by 2002:adf:f2ce:: with SMTP id d14mr18698737wrp.32.1602335504742; 
 Sat, 10 Oct 2020 06:11:44 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t19sm3086240wmi.26.2020.10.10.06.11.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 06:11:43 -0700 (PDT)
Subject: Re: [PATCH V13 1/9] linux-headers: Update MIPS KVM type defintition
To: Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <zltjiangshi@gmail.com>
References: <1602059975-10115-1-git-send-email-chenhc@lemote.com>
 <1602059975-10115-2-git-send-email-chenhc@lemote.com>
 <CAFEAcA9fFN6+-FLwiYrFPaz+rtriZKDwwD1b1nSDzvhx-LYEvQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fd34ee4c-752a-663f-23c4-3e101d12bd5e@amsat.org>
Date: Sat, 10 Oct 2020 15:11:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9fFN6+-FLwiYrFPaz+rtriZKDwwD1b1nSDzvhx-LYEvQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.207,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/20 2:59 PM, Peter Maydell wrote:
> On Wed, 7 Oct 2020 at 09:44, Huacai Chen <zltjiangshi@gmail.com> wrote:
>>
>> Update MIPS KVM type defintition from Linux 5.9-rc6.
>>
>> Signed-off-by: Huacai Chen <chenhc@lemote.com>
>> ---
> 
> Is this a sync using scripts/update-linux-headers.sh ?
> 
> (I vaguely had the idea of adding a --make-commit option to
> that script so it would automatically create a git commit
> with a header message saying it was a sync against the
> kernel git commit, but I never got round to it.)

I just realized you merged this change as commit 94c7fefcb45
("linux headers: sync to 5.9-rc7") =)

> 
> thanks
> -- PMM
> 

