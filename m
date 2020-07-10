Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2E7C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8606C2078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B5cAvvwE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8606C2078D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtvUt-0001Qj-LL
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:03:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtvTF-000753-1q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:01:53 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36569)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtvTC-0002Xz-TE
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:01:52 -0400
Received: by mail-wr1-x443.google.com with SMTP id k6so6508123wrn.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 09:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DN9AkGAf9SefWz/TktqdW0P3y1nNRGRiJCiRHlfiwaA=;
 b=B5cAvvwEGp5llc4RRFl4HLgGol03NEJ33eEwRwR8x5GMOqHoP7W6oIlgSBdOethWLA
 YQ+9e2vmp+1PQUvRErkcSjt7YrIonSSj2I0tfsM+qbvRX7XtADyWzlD4rCyuNqwTlCTL
 ocojYfKEFRpRv0NbNUCvQcpZNOrMDLAobw/lTYTPurrlUZEkDel2xc4kuJLnIimHvsCY
 aVqoOmXfqUuTW94zWg3hUEModIt91++5Hr5zxwz5HOqchNe6k7arVZBKLKx57x0c4mk8
 0SkwslUS5r8K+U0HHRJbxtlf/b3QFixpmM5L/3KmA69eHpGITGjBu/Nyq8qTSGZmr0v9
 ygIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DN9AkGAf9SefWz/TktqdW0P3y1nNRGRiJCiRHlfiwaA=;
 b=eltgG5ofLR2oHsS6/9NeSD1HTMWqcqTpe/Mn72bEJatdGlqC4Kp4dx7YtlXSS5jPBV
 7yxhkKuxBhGBal0aN9N9pYVYH6sIjLiybtVl1hwwAbFoCnkPEZnU+T+F1UptoaiZ+ZAo
 4En2sRFHnKbfyLhl5MbBIwQJecuCXd7aCMMCZP4hIDY46zroHw6BJ7M/gL4+tyveWoaV
 EFIjTwiXssHYIFtl/0JuhhLLVTt5ucJbq/LDg1NZWGz+4wSteb8cBwZg2abaTykUkVY2
 pELs+2Q5C0obpWLdfdHiA5f3iJoAo7fc/TDqM9zQJkmgw8E5Otguz57XfgIHt2SwbJgO
 I5kg==
X-Gm-Message-State: AOAM530RCFRuY8cAbTcPOhSJG0j2AfhFpzmbEI23EZUeIVmCJGxmpeAu
 utuagVtUdQHz2YJO5LBizeY=
X-Google-Smtp-Source: ABdhPJyvigIHtgmiNfoU/XuS165fOEwUQgUHbFjubMRSmev9t46vsEMf05s0V/I+iqsWkDNIaPvhZg==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr69062101wrr.266.1594396908875; 
 Fri, 10 Jul 2020 09:01:48 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id t4sm10525133wmf.4.2020.07.10.09.01.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 09:01:48 -0700 (PDT)
Subject: Re: [PATCH v4 36/40] gitlab: split build-disabled into two phases
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-37-alex.bennee@linaro.org>
 <03ef8691-5839-12aa-4649-b4e04172a15c@redhat.com> <87365zl8mi.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b2b2b438-5879-e3cb-0ddb-017bd0fa77df@amsat.org>
Date: Fri, 10 Jul 2020 18:01:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87365zl8mi.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
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
Cc: fam@euphon.net, berrange@redhat.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 cota@braap.org, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 4:58 PM, Alex Bennée wrote:
> 
> Thomas Huth <thuth@redhat.com> writes:
> 
>> On 01/07/2020 15.56, Alex Bennée wrote:
>>> As we run check-qtest in "SLOW" mode this can timeout so split into
>>> two jobs.
>>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>
>>  Hi Alex,
>>
>> I think you can drop this patch and use "[PATCH v2] tests: improve
>> performance of device-introspect-test" instead.
> 
> As I'm re-rolling the PR sure...

Also maybe:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg721458.html

