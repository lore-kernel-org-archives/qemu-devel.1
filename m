Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7C4C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FF622286
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f766XkHc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FF622286
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXiL-0008Gb-Bg
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIXhR-0007qZ-A0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:42:17 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35019)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIXhP-0007Ch-Nk
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:42:16 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so7008298wrm.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 06:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LAQYqrtADh+Z0VVc8gO2AJIHU/IYacQSiMbYQls30U0=;
 b=f766XkHcUVxEdOacvHVdYSHdCdqCmKbf673dipLlYfcSStG0a7Nu3lpn4oycqrIDPL
 s+J1R0Ghw6+zoNBmSnbBsCZ7rweebcYAP58O3L0r1vt9nd3urq4Cxw2nWr8eZT1vPXoP
 wPSHh7OrkvBBOAr81G68anijvEyIlP/fniwnGfZJmqsUAf0lYCi/o1PrLiJou1nPn/V7
 tc/lNvyXlqidjWiwmHCSY3/VoALu+hRaVZzEnFcRaf+9YpRUTXNZb3MPOn93RhQiJGfH
 dCnredzACKYRkjHN5r/4yNz65GQ01tKj/rVgIRritsr93RFrsh2bz5PckeVXMo8YFb47
 sySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LAQYqrtADh+Z0VVc8gO2AJIHU/IYacQSiMbYQls30U0=;
 b=E79QkBexLV70FG8PGSGSKlJNNXE7+5RCSjon3QfS7gprxJHRzN9Hh4YxSpJ01h08Cn
 7Nm5dxJ54DX7eUWWZqHI5jijJKRIdJjiJfAZSMfnLMoT+x5FmdH1RdB4qD/EtRORNS3A
 WLjUzyIQu3NBu5jIHAkMcmXoKy27Fvh0Fa8iAtvWDJv2fU32+AZJKzMYGVYI39lvAYsB
 9j5YzoSaqEtr2ODU85sosp9/xvUNSnA/HmzRcmkKp6108irLkkZQQYqS0DvdDlIgZldc
 Z5mqupS4002X3VoFwLzqaoZa/1ajHs0ZhBUMShPRYWYUzuxJDhBN2pBQgZUxvY5RbM1U
 sAXg==
X-Gm-Message-State: AOAM533D41z0uVcaDZzR54l8eIuyMD7Mq25HxQ1lejFFx1pvO3obTYGC
 QXu+oi5dgvEGxJrLyAEErWI=
X-Google-Smtp-Source: ABdhPJz5+zpZMJUzpqVM+l9No8iEIofy55BxYiyps52SH1tureW0aZ1TfF/+N+NWpCs81CBUT95krw==
X-Received: by 2002:adf:e292:: with SMTP id v18mr26583062wri.256.1600263734288; 
 Wed, 16 Sep 2020 06:42:14 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id l8sm32369088wrx.22.2020.09.16.06.42.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Sep 2020 06:42:13 -0700 (PDT)
Subject: Re: [RFC PATCH] travis.yml: Drop the default softmmu builds
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20200805185403.15227-1-thuth@redhat.com>
 <20200916131658.GM1535709@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ae6c0734-0d88-e024-0b7f-c5bba4f06930@amsat.org>
Date: Wed, 16 Sep 2020 15:42:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200916131658.GM1535709@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.062,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 3:16 PM, Daniel P. Berrangé wrote:
> On Wed, Aug 05, 2020 at 08:54:03PM +0200, Thomas Huth wrote:
>> The total runtime of all Travis jobs is very long and we are testing
>> all softmmu targets in the gitlab-CI already - so we can speed up the
>> Travis testing a little bit by not testing the softmmu targets here
>> anymore.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  Well, ok, we do not test all the softmmu targets on gitlab-CI with
>>  that same ancient version of Ubuntu ... but do we still care about
>>  testing all softmmut targets on Ubuntu Xenial at all? ... at least
>>  according to our support policy, we do not care about Xenial anymore.
> 
> Yep, we explicitly don't care about Xenial. Even if we did care about
> Xenial, we could put such a job on GitLab CI instead.
> 
> IIUC, the main unique feature wrt Travis vs GitLab are potential for
> non-x86 hardware testing, and functional use of KVM. So if the job
> isn't using one of the unique Travis features, we should cull it
> from Travis and GitLab if the job is still appicable.

Agreed.

Acked-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
(Sorry for missing this patch)

> 
>>  .travis.yml | 14 --------------
>>  1 file changed, 14 deletions(-)
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> 
> 
> Regards,
> Daniel
> 


