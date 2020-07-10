Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2DFC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:37:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AE220725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 16:37:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OJSjmaC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AE220725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtw1z-0004VK-BU
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 12:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtvrE-0001lm-0O
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:26:40 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36797)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtvrC-0006p7-4P
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 12:26:39 -0400
Received: by mail-wm1-x341.google.com with SMTP id 17so6486737wmo.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=3s478deOtkUPFKIhLl/EcsPM0RzNKQYs5vdQkkQwchY=;
 b=OJSjmaC0fTfsbNJOHPEHJROwFQePateQOWvUZgLkVRwpFYb0trMDs+WkpaDlJT1lgC
 Rc2aJjEB/tEMkBluEV0Cp2zyeoAW00HKcq506GLKUeAOf49ewNC8gwwE5s8GQI7qNT3n
 N8HvW+cik59KNia3lDjePHLm/zbzSCWlxH+l39kjCy9W29foVVM0z8zSQtGNlbZ/F/g1
 Ef48DqyZez46kPh1RTdq/3zCi3KFC66RQ3Z9A8vTF/DcjBMf2/LZS/wlJUiXnZsdiAWo
 r3YqxvwPhAmAcd8K6gh+LELZh0d5snD8WPxhzsS8VsCwFWVmSpAeI03KbM++Ub/+PL73
 Iinw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=3s478deOtkUPFKIhLl/EcsPM0RzNKQYs5vdQkkQwchY=;
 b=fpNGFPy/UcTWCQDGGB8VZ4Pp96v2Zc9oS/5NKFph+GkTrN2ep1FXwnkc+XFRcs6ewx
 qjztWOnpYFUl97/xuzCenRKlqE+z5xzjcqagtMwrbtCAmcwZ+uMgOI3EVS8uX97A6ZtG
 NRN6kECnRZWFKGPGIlrST/uFuRJxnxISUmHck1cnQLIY5ZLNnMqsOh+gJ1ePT846+0UX
 LYvCOBvfctAPGglsFTJU4eYAapOUZ+qNNlPeTp6GcUfBYNhx30dK6XOMsh9KD54O6DxB
 nbh3tIzxtE4OsFvPltcVHUZJT4ujtjg+md81Xkh9TS9YNTAEmnNLamE9Y4zIgPFMKiXY
 2u4Q==
X-Gm-Message-State: AOAM5334E/jmZNUKSB8JuAsthpxFOfXJhxxfQrBeH0GV2zIcndY9xGkV
 YqJ9SromTwcsRJtVTEjGgyOGNw==
X-Google-Smtp-Source: ABdhPJz9oZoOGW/8R2E6LKAw8xW5Foh/JYUqWjf1opS/I4KYo5SWYPJc+RLY2hCeBKf+7ybXOTpQSA==
X-Received: by 2002:a7b:c197:: with SMTP id y23mr6310693wmi.114.1594398396428; 
 Fri, 10 Jul 2020 09:26:36 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d81sm24871401wmc.0.2020.07.10.09.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 09:26:35 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 704841FF7E;
 Fri, 10 Jul 2020 17:26:34 +0100 (BST)
References: <20200701135652.1366-1-alex.bennee@linaro.org>
 <20200701135652.1366-37-alex.bennee@linaro.org>
 <03ef8691-5839-12aa-4649-b4e04172a15c@redhat.com>
 <87365zl8mi.fsf@linaro.org>
 <b2b2b438-5879-e3cb-0ddb-017bd0fa77df@amsat.org>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v4 36/40] gitlab: split build-disabled into two phases
In-reply-to: <b2b2b438-5879-e3cb-0ddb-017bd0fa77df@amsat.org>
Date: Fri, 10 Jul 2020 17:26:34 +0100
Message-ID: <87tuyfjpz9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 7/10/20 4:58 PM, Alex Benn=C3=A9e wrote:
>>=20
>> Thomas Huth <thuth@redhat.com> writes:
>>=20
>>> On 01/07/2020 15.56, Alex Benn=C3=A9e wrote:
>>>> As we run check-qtest in "SLOW" mode this can timeout so split into
>>>> two jobs.
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>
>>>  Hi Alex,
>>>
>>> I think you can drop this patch and use "[PATCH v2] tests: improve
>>> performance of device-introspect-test" instead.
>>=20
>> As I'm re-rolling the PR sure...
>
> Also maybe:
>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg721458.html

I don't think it's directly related - can we just avoid pilling a bunch
of stuff in on a re-roll please.

--=20
Alex Benn=C3=A9e

