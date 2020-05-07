Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8F59C38A24
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 06:30:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AA6520753
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 06:30:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSrr1bcR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AA6520753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWa2x-0001TW-LE
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 02:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWa2F-00013k-4t
 for qemu-devel@nongnu.org; Thu, 07 May 2020 02:29:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jWa2E-00083e-9N
 for qemu-devel@nongnu.org; Thu, 07 May 2020 02:29:30 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so4870676wra.7
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 23:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=9BB+65sXXmQfe6cDt0Y4RF0K3QYUCxhFTLxLUCEZ9Rs=;
 b=kSrr1bcRfnD0NdyTsRCbC61Ky3QXuxsfOJt8KIK/HSMmtxvx3odV60wshlrgpv8XtI
 Mc/fM95R8bMJO9eWuBkYSyDOB5pKKQrU8PtKHy2rxOyABMXIdJuAyl54ovjnMdJlbxIG
 oc0qVVQq23LGgTeRLfMsZy0DsbEHOWUB5whTRBCKYISwdLINzGaqS2Rko8mUh6FqujW+
 HimkqOIzORB0Iy4U61HujJZQW9xIsclx97HHn/syJjrLjGiEE6NtL8X2DczM3/vyKm1r
 p7qMVvIhb1SuCIRMHu74Mcg4pseqzzetqLx2W6wJlV8tg+/rHCknnRSjOJ7QB4ilEEwc
 keCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9BB+65sXXmQfe6cDt0Y4RF0K3QYUCxhFTLxLUCEZ9Rs=;
 b=FlRZEOp4JeHimJ8oqC0OCjQW13682+2dVr0OmwAtXGPEPbeXsOzb7DxrWADDiva05y
 ZEntPlgd/iOE8bEmlFzbj7txUbgw2YYg3uffffwyREUkF6H7kSwamWN+KdlvwNp4qpGf
 0/W6KPxWoDG9vP5S0opmojteckzQU9iwIU5IV/NUaTOMejQT6KmKVNsoL72WgoAgqK0N
 oq3jjiVwcIolDuo4oFmKZjhEYpSNotsDMIM9gVs6KNhQpEcghjHM3wqbghMjc6bdYvsV
 4DLSZytYtwr2b/iLNuWJL1lM5DvvOhGmHvcZI3v5EkUZDDWH280RuXATchk1ska9azpG
 +BEQ==
X-Gm-Message-State: AGi0Pubk1/IqYSTzZsdF5x5hBK7afUsVp8ksqg0KTq3Uo47kP3sqSJ3V
 +NghmpRI1f/7T0OmBLLRkF0=
X-Google-Smtp-Source: APiQypI/3BOb4bL/0p4dICoQm7rIulUAydbvGomDV6ADJlPNbZFNf6A7goDFRZ/cAfTdphrtRzjycA==
X-Received: by 2002:adf:d0c5:: with SMTP id z5mr14602513wrh.410.1588832967965; 
 Wed, 06 May 2020 23:29:27 -0700 (PDT)
Received: from [192.168.1.39] (248.red-88-21-203.staticip.rima-tde.net.
 [88.21.203.248])
 by smtp.gmail.com with ESMTPSA id g25sm6203406wmh.24.2020.05.06.23.29.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2020 23:29:27 -0700 (PDT)
Subject: Re: [PATCH] Fix stack corruption when handling PR_GETDEATHSIG
To: Stephen Long <steplong@quicinc.com>, qemu-devel@nongnu.org
References: <20200506234751.7920-1-steplong@quicinc.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f993c71c-78d0-ee5f-8998-2b7378e02b6c@amsat.org>
Date: Thu, 7 May 2020 08:29:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200506234751.7920-1-steplong@quicinc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: riku.voipio@iki.fi, efriedma@quicinc.com, laurent@vivier.eu,
 apazos@quicinc.com, pzheng@quicinc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Stephen,

On 5/7/20 1:47 AM, Stephen Long wrote:
> From: Ana Pazos <apazos@quicinc.com>
> 
> Signed-off-by: Ana Pazos <apazos@quicinc.com>
> ---
> Submitting this patch on behalf of Ana Pazos. The bug was triggered by
> the following c file on aarch64-linux-user.

This is fine, but you have to add your own S-o-b tag too.
See the link from 
https://wiki.qemu.org/Contribute/SubmitAPatch#Patch_emails_must_include_a_Signed-off-by:_line

     By making a contribution to this project, I certify that:

     (c) The contribution was provided directly to me by some other
         person who certified (a), (b) or (c) and I have not modified
         it.

> 
>> #include <signal.h>
>> #include <sys/prctl.h>
>>
>> int main() {
>>    int PDeachSig = 0;
>>    if (prctl(PR_GET_PDEATHSIG, &PDeachSig) == 0 && PDeachSig == SIGKILL)
>>      prctl(PR_SET_PDEATHSIG, 0);
>>    return (PDeachSig == SIGKILL);
>> }
> 
>   linux-user/syscall.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 05f03919ff..4eac567f97 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -10253,10 +10253,10 @@ static abi_long do_syscall1(void *cpu_env, int num, abi_long arg1,
>           switch (arg1) {
>           case PR_GET_PDEATHSIG:
>           {
> -            int deathsig;
> +            uint32_t deathsig;

I think the bug here is deathsig should be abi_long, the put_user_ual() 
call seems fine. But I don't know well user-mode, so don't rely on my 
comment :)

>               ret = get_errno(prctl(arg1, &deathsig, arg3, arg4, arg5));
>               if (!is_error(ret) && arg2
> -                && put_user_ual(deathsig, arg2)) {
> +                && put_user_u32(deathsig, arg2)) {
>                   return -TARGET_EFAULT;
>               }
>               return ret;
> 

