Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B86C43446
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16138206F4
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTdO+vj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16138206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtwHt-0002dK-DT
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtwHK-0002Cn-9v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:53:38 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtwHI-0002RJ-PO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:53:38 -0400
Received: by mail-wr1-x441.google.com with SMTP id j4so6639835wrp.10
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 09:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=elEKphLvDMnyDq45eEH/ldMXLhgJJmjrR+KUzEwLf8U=;
 b=nTdO+vj21C+5fyhXK23Pj4963l1mfJ/fTF4dK9XYvk8Xg3cbpYGZniuX73L7PNsYu6
 pSRuC8FS1sRzNo4wwixoCA64SLUGrl6IyC46RmnA8AUcm9JgwBUTnh32oBSwf60/ylcy
 PxspTw/o1kOr8VN1s+AmKqadTE63Y0BkfBTbNpBwEZcg55PEpIerKUIWOasfo4HhuamN
 OHLQBPt8euAgeAVoduu7OBnpH3d8f0e5H/KK8axxUE3amoh57hr7uqmO1JjRpLH3Cvzf
 TUR2PGt4z4BPhLx84+xO11U4Q73/+6rrYfWkv2cNgtDY1tbfHZjt3IKmyGyJiD8NhSFl
 1hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=elEKphLvDMnyDq45eEH/ldMXLhgJJmjrR+KUzEwLf8U=;
 b=hlrmACtAYf4CiWzhgHlWcQC+BwIIRHgjeyogxAAthcOkXknyOfUqdSTbZ1CmLskTkp
 aL7Zd4x7D5x6R1GcDyYxckxNXV2P9frFNUOe86kCSbzP93+xZiG9BqE2H4Ut8S8jJcrx
 i/5+VflvlrAQF0/4v4oHKC+M/3LHfqM2FwpRMMMP3rlP3uvOHkIYFgjuCOuCOOZKpELa
 50FldsplM///sIlrut059Ltz+daS0ydNEKk/tEP05lZtPl8zjW0G9DHmM6ReSnzAYVSf
 CI0kPdL07S63wi6HdXvSiht6nP7SGK0cPwoyemZteFJYlnFXsKtu+eXNOTmdhYOysuyp
 2HWA==
X-Gm-Message-State: AOAM532fUwcFe8cGuz/QQfo0lnouPDGgnMw6zHbv8QEzbZElRi4vBZsc
 nOoHAQUwVzazlgzZeJDbxQg=
X-Google-Smtp-Source: ABdhPJwQVkrLvWmmTKCNArGgQE52Girwu299rvr7Qe1QjuIf9Ny/SsF5rncPCumZx79pA7Vt/cH4Vg==
X-Received: by 2002:a05:6000:11cc:: with SMTP id
 i12mr67754770wrx.224.1594400015215; 
 Fri, 10 Jul 2020 09:53:35 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id y17sm11162765wrd.58.2020.07.10.09.53.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 09:53:34 -0700 (PDT)
Subject: Re: [PATCH v4 36/40] gitlab: split build-disabled into two phases
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-37-alex.bennee@linaro.org>
 <03ef8691-5839-12aa-4649-b4e04172a15c@redhat.com> <87365zl8mi.fsf@linaro.org>
 <b2b2b438-5879-e3cb-0ddb-017bd0fa77df@amsat.org> <87tuyfjpz9.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5d57e361-7044-782c-2ee1-4fc8b5b13296@amsat.org>
Date: Fri, 10 Jul 2020 18:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87tuyfjpz9.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 richard.henderson@linaro.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, cota@braap.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 6:26 PM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 7/10/20 4:58 PM, Alex Bennée wrote:
>>>
>>> Thomas Huth <thuth@redhat.com> writes:
>>>
>>>> On 01/07/2020 15.56, Alex Bennée wrote:
>>>>> As we run check-qtest in "SLOW" mode this can timeout so split into
>>>>> two jobs.
>>>>>
>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>
>>>>  Hi Alex,
>>>>
>>>> I think you can drop this patch and use "[PATCH v2] tests: improve
>>>> performance of device-introspect-test" instead.
>>>
>>> As I'm re-rolling the PR sure...
>>
>> Also maybe:
>>
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg721458.html
> 
> I don't think it's directly related

I thought it was.

> - can we just avoid pilling a bunch
> of stuff in on a re-roll please.

Understood, sorry.

