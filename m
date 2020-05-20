Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E97CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:55:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C3E62053B
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 05:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCU09/hZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C3E62053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbHhB-0000KC-4r
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 01:55:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jbHgd-000880-Pn
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:54:39 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jbHgc-0000JY-TK
 for qemu-devel@nongnu.org; Wed, 20 May 2020 01:54:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id v12so1768109wrp.12
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 22:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AK8v7Pz8aKYJxIEtSZlFf6t4Mf0SfRajIhnUVkIChhE=;
 b=YCU09/hZNGaBHmN3mkNduae8AUpePr+Il3dXQjQmNZsM6rNSam5ifnBJffPVmd43gF
 PJ08PQTSleqsteQA2sgzUxMLXMA1RNzD8gTwlc02pPrvqB+bWR8iSIe0PUe+w5alldvy
 e7uSB9wnmRr2k58fogW2c5KgMqc/5b2NpN0mfoCbLVa4awQe/LIaXwb1GU9tgae3BibR
 K37pOczLVx/ddDiO844UNvZVnyBibXwrzUsjI6jIGN2PtyJAohsS6xjgIyZ23pCjNeAm
 i9KXUUlKuDB95Tx798b9sm0AneNBVukwyPgExwPcj0XJ6FOsym1SwFRuh8lkyuBOCgaO
 bqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AK8v7Pz8aKYJxIEtSZlFf6t4Mf0SfRajIhnUVkIChhE=;
 b=GQNlx2cvA02JdQOeDrxE3cvfwSUuHBvImX9cYn44CAzTb54Kv0kCA6wqNDHJMS1Uvt
 941fXoSIkUk5seevidvMr4FTu2t/1FGv7UsnaVFePFz9/cP6CbW3nbBoAY4YdZMNpAPC
 w3zhzCkfVzyn6oe7iN5FM8Xb2EZA1ilDN+kHmnoCwI11OIkm2MzG6pZP311ytrh2otgT
 ZnGdq/cEHSXbW7CkWoVui0BygrNz+wmZtn5o123E0c4j8GfgYEVdVzZLEgFjH7l4Mn5/
 BS65Qrkd38ANQ6vM8Smm0B5Ch2GQIlyeKLrNDgXxdhcvKoHVK0kpRBSwy0bDBzFoJ1u/
 8bjA==
X-Gm-Message-State: AOAM532j49m17I0/AtYMnshHFVQhod46Ss2P2ho409fiqJOS+G76xTXx
 isyy3g18JMsZG1O7A34Yb4tBsdePUXs=
X-Google-Smtp-Source: ABdhPJzGJyQp4xUvsisLOytllF1fICg84ilPYPMos3LWGN1EK1yyc4IH9sImtHV9HpJbEo7WESavsQ==
X-Received: by 2002:adf:fb08:: with SMTP id c8mr2449528wrr.421.1589954077514; 
 Tue, 19 May 2020 22:54:37 -0700 (PDT)
Received: from [192.168.1.38] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id l12sm1834469wrh.20.2020.05.19.22.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 22:54:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] linux-user: Adjust guest page protection for the host
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200519185645.3915-1-richard.henderson@linaro.org>
 <20200519185645.3915-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b94bf851-93c3-31c0-7079-3004a58d0331@amsat.org>
Date: Wed, 20 May 2020 07:54:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200519185645.3915-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/19/20 8:56 PM, Richard Henderson wrote:
> Executable guest pages are never directly executed by
> the host, but do need to be readable for translation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/mmap.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/mmap.c b/linux-user/mmap.c
> index 36fd1e2250..84662c3311 100644
> --- a/linux-user/mmap.c
> +++ b/linux-user/mmap.c
> @@ -76,8 +76,12 @@ static int validate_prot_to_pageflags(int *host_prot, int prot)
>        * don't bother transforming guest bit to host bit.  Any other
>        * target-specific prot bits will not be understood by the host
>        * and will need to be encoded into page_flags for qemu emulation.
> +     *
> +     * Pages that are executable by the guest will never be executed
> +     * by the host, but the host will need to be able to read them.
>        */
> -    *host_prot = prot & (PROT_READ | PROT_WRITE | PROT_EXEC);
> +    *host_prot = (prot & (PROT_READ | PROT_WRITE))
> +               | (prot & PROT_EXEC ? PROT_READ : 0);
>   
>       return prot & ~valid ? 0 : page_flags;
>   }
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

