Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6CDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB6C23A78
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u7ZZ1pP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB6C23A78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6y6N-00027V-3W
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6y2t-0005KY-DT
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:24:35 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37256)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6y2r-0003FN-HX
 for qemu-devel@nongnu.org; Sat, 15 Aug 2020 11:24:35 -0400
Received: by mail-wm1-x342.google.com with SMTP id k8so10312606wma.2
 for <qemu-devel@nongnu.org>; Sat, 15 Aug 2020 08:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=i5/VDadN6rQer72jCuvXRfOgBZxeteYTAR+TNZRmS2c=;
 b=u7ZZ1pP8OVmNry0wRFkO+812TwxeFHnq3O0/oDTj7Wzr3Ug4jGD5OkP5hvIKbgyMHT
 YqDpYc5K512c8L62M+fY9JMZQ5nmkXBdIGizo/qE/WxL7ZKLp5Z+Krp8+qZxyprMIMDB
 sRiBnqCcZWifJMe7Q4maa227TRLwJPdrPEudUlGt1X01K0Ib6v48KoPNGk9+t6YCCg0M
 EDFkayzg5ROvkQm2LekSRKTbPONbVCHA1HP5z50kUuSHeQy8zpGmAb0l88lFDSjj4WFT
 rr///yFBwl7CiTIcWxzaJENTvRu34lD4b1CQA9arZBDSKoCQeorF63VKKiZMpIwIqUro
 M1rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=i5/VDadN6rQer72jCuvXRfOgBZxeteYTAR+TNZRmS2c=;
 b=aTY5lHCwwFaBCx6tUM1XSJI/9378+ibSyLekMDrRFGdbI90vOSiWtcLdby9anTqaZP
 Qi0eNxYOoKoLiGUiVivmGAua49GQNUQzSo4Z30v1fS6JsEAeDKnyCOEjrMw46S+KqsFV
 jgyNJ4wiaYiA+L1L+WJBUK0uqCuCoAicinP4syCwPMWXJ3Pvt1fbfJ1Bijlbw9i8ponX
 tAbODbkySnMmbrhmzewK88wW0e17hK9Fe5ajBA7T9n529iJgfQkWheBVj6T2J7+yMJy7
 NstwOf0QqC50MTpBtfzh+7kx6s+/XU9bUQB25uJiUKiZaxj/9AKQbTotaygMJsWmNIIg
 PkCg==
X-Gm-Message-State: AOAM532PNrIXdQsRHu2FFbV6oWJeF3Ebue3kFstWh/22fV+7VT1t4DLC
 Rm5GY9r2N2F/pIMNSxsBpp8=
X-Google-Smtp-Source: ABdhPJzDAdWxbrJD6Z403AhuFnOjUUOpv1dr51ms8F8Zn47UPwepfg2j8P6ubg5vLyiZiQncaEVeZw==
X-Received: by 2002:a1c:5a41:: with SMTP id o62mr7296688wmb.16.1597505071751; 
 Sat, 15 Aug 2020 08:24:31 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 3sm20434066wms.36.2020.08.15.08.24.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Aug 2020 08:24:31 -0700 (PDT)
Subject: Re: [PATCH] Fixes: Fallthrough warning on line 270 of
 qemu/qapi/opts-visitor.c
To: Rohit Shinde <rohit.shinde12194@gmail.com>, qemu-devel@nongnu.org
References: <20200815130046.5344-1-rohit.shinde12194@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d915c2a8-deba-1d88-d7d8-d16b8dcaf6d4@amsat.org>
Date: Sat, 15 Aug 2020 17:24:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200815130046.5344-1-rohit.shinde12194@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: armbru@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Rohit,

Congratulation for your first patch! It is in very
good shape already :)

It is easier for the reviewers if you start the patch subject with
the name of the subsystem concerned, or the file modified:

"qapi/opts-visitor: Add missing fallthrough annotations"

On 8/15/20 3:00 PM, Rohit Shinde wrote:
> Added the fallthrough comment so that the compiler doesn't emit an error on compiling with the -Wimplicit-fallthrough flag.

If possible align the description to 72 chars.

> 
> Signed off by: Rohit Shinde

The tag is written "Signed-off-by" with '-', then your "name <email>":

Signed-off-by: Rohit Shinde <rohit.shinde12194@gmail.com>

If you configure your git client, using 'git-commit -s' will
automatically add the S-o-b tag:

$ git config user.name "Rohit Shinde"
$ git config user.email "rohit.shinde12194@gmail.com"
$ git commit -s

> ---
>  qapi/opts-visitor.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/qapi/opts-visitor.c b/qapi/opts-visitor.c
> index 7781c23a42..43cf60d3a0 100644
> --- a/qapi/opts-visitor.c
> +++ b/qapi/opts-visitor.c
> @@ -266,6 +266,7 @@ opts_next_list(Visitor *v, GenericList *tail, size_t size)
>          }
>          ov->list_mode = LM_IN_PROGRESS;
>          /* range has been completed, fall through in order to pop option */
> +        __attribute__((fallthrough));

C uses attributes when declaring a type/variable/function.
Here this is inside a function body, not a declaration.
A simple "/* fallthrough */" comment will make the compiler happy.
You can see a similar patch for example:
https://git.qemu.org/?p=qemu.git;a=blobdiff;f=disas/sh4.c;h=dcdbdf26d8;hp=55ef865a3;hb=ccb237090f;hpb=7aa12aa215

When you find an issue that might have already been fixed elsewhere
in the repository, 'git-log -p' is your friend. Since the commits are
patches already accepted/merged, they might be a good source to learn
(how the issue was fixed, how the bug was described, ...).

Regards,

Phil.

>  
>      case LM_IN_PROGRESS: {
>          const QemuOpt *opt;
> 


