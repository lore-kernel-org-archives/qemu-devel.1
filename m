Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD50C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:39:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6D9720782
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOhmXlYM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6D9720782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7nJ-0007YX-Me
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <74cmonty@gmail.com>)
 id 1kQ7kS-0005DV-Bf; Wed, 07 Oct 2020 07:36:44 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c]:36530)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <74cmonty@gmail.com>)
 id 1kQ7kQ-0007Xl-BB; Wed, 07 Oct 2020 07:36:44 -0400
Received: by mail-ed1-x52c.google.com with SMTP id l16so1796159eds.3;
 Wed, 07 Oct 2020 04:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=kUN9GfVZhNkFseUOzxN2TPWLs4ulAQhdGEVJBlOHxuI=;
 b=oOhmXlYMCYBRp8sI9pDhpqaFZkl2rRC2Dx4XlJ55ijcm/XO1kciZ1gYdeh7YQWC9+i
 OQlYSNGaD1vfBxhEi6/wj2lNwukdjipHT8zcpXxPt3KaRk3Hyc9miIhUuaXEP7J2EEpU
 buGpQcjeQEh6rnOpBP6QE3gTStu7WOGiJJWm1GH+11mpiDgE0KbSfjdFJsJnn8QHiPNr
 eWsf+18DOOPa0/WW8J75ASMLkCmd/0xuWlwLDDsdHLw2tg8wNzbgmmKPvw0jiCvKNn4M
 v/PRkXxou79L4D8SzOjJkDvjEABdNMAqNFImtmsK8eL3YvDdZUexx6KcuojNn2j7MC/i
 mgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=kUN9GfVZhNkFseUOzxN2TPWLs4ulAQhdGEVJBlOHxuI=;
 b=RAB4ukFjvDrj+cviXoLRtEoor1oNLwRJLfV/geyHBnIEn+tD7acWS7WHQasIeaW/ME
 71yznxq0NPcZeI9JQdTc+5LuUnT7TNdKo8EIzcpRLVEk3j6Dn2XLUvzU4VCyiy98HNXJ
 cUzbYpxpNhRhKEsp8Z5tTsvAgOvFu5LlE3P7stqHBQ7u02bxrhdrWObdFUc7z+6tvdSY
 m4JYNXd+3VKapHQCgdAy39AjLCvOJQfaJ5myCKJLVMgubxNMYRxukhg6Z3Q5JwxN3Yty
 yNN9rXKgJi50YshnPCwF3kO3u2bCVHoYuzasqipRcCxtTola/d31L03RPXecA3qjQlUn
 qreg==
X-Gm-Message-State: AOAM533JlVO09GnxnNXeHDf0zAvOm6FiaUr+lBYMV+OyiaAmaUFvEXrB
 P3R03RR36km0scVL2P5rxHA=
X-Google-Smtp-Source: ABdhPJz4uz6W6G2Tnngh0JL61HTUes2dMM1KJIPD+yB0SOSDWcFLi1oVhHL5CIvNGaNjYu+t4CA1Ag==
X-Received: by 2002:aa7:dbc5:: with SMTP id v5mr3181510edt.54.1602070600292;
 Wed, 07 Oct 2020 04:36:40 -0700 (PDT)
Received: from [10.177.66.61] ([193.16.224.13])
 by smtp.gmail.com with ESMTPSA id d6sm1284995edr.26.2020.10.07.04.36.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2020 04:36:39 -0700 (PDT)
Subject: Re: Emulate Rpi with QEMU fails
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org> <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
 <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
 <d8d79b4c-aeb4-4f07-7110-91d8d1afd701@gmail.com> <87362r3cbt.fsf@linaro.org>
 <61c49583-c548-a8b2-7106-59011196f430@gmail.com>
 <CADBGO7-BaTH3MBZa6Dbv2+uxKNbv3ztwQ=iu_FCgrcrKBUzCPw@mail.gmail.com>
 <4da67d13-a774-f62e-ad89-de062cbe81da@gmail.com> <87blhe1esd.fsf@linaro.org>
From: Thomas Schneider <74cmonty@gmail.com>
Message-ID: <f32593d0-e87b-0549-7b59-f58da24c9130@gmail.com>
Date: Wed, 7 Oct 2020 13:36:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <87blhe1esd.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=74cmonty@gmail.com; helo=mail-ed1-x52c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Are you referring to this tool?
https://github.com/stefano-garzarella/qemu-boot-time 
<https://github.com/stefano-garzarella/qemu-boot-time>


Am 07.10.2020 um 13:00 schrieb Alex Bennée:
> perf to record your boot


