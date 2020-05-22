Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C51AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 11:19:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D32F2206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 11:19:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="geCg3Sjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32F2206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50334 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc5hb-0001X7-Vn
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 07:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34446)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc5h5-000163-RL
 for qemu-devel@nongnu.org; Fri, 22 May 2020 07:18:27 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532]:34017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jc5h4-0006fy-PO
 for qemu-devel@nongnu.org; Fri, 22 May 2020 07:18:27 -0400
Received: by mail-ed1-x532.google.com with SMTP id i16so9021673edv.1
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 04:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WtqINlqb8xCqnElOE1P5YfGKpo/PO63lLO1Khfq8Gt0=;
 b=geCg3SjtC1pQbVP637nnnhWl5onG/7oijdW7ROOO4iH3o0wCIoANct5V3U+s4gyC/S
 8cYL7UWIL63ZprCtUhTjYN58i67nkdsOndpkHFpEfqk4Ue5r24sJpta0Bfd9LtBStguz
 7sBqKPPMkLUtUCB/tN7nWHQIczKEQKPb+Y0XjfdDfms3Me79R4zzv2HBdd0JkZ5ZhIAX
 jB0OCq6q9lTUXCzJYFw4FruVH2OKS5qF4M42glfBC3iH9M50QrjQzI8g74+B2GRFODh0
 fhbu/05WOhKR+Kvmz0dQ1olgeUglaVZid0/qHNEFwrIQOtCxKnu3dbKO6A8Ki8wQeefN
 Yanw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=WtqINlqb8xCqnElOE1P5YfGKpo/PO63lLO1Khfq8Gt0=;
 b=J4pdM0eUwmy8FWbar8eGtaiJ7pMgBQChfLXbYiKp+HH94vh8n9lXZsZ34CYb7/UY9T
 tEKkrrptCtzjHLU9GXobOxz9O90c+KG4/CYbwEUiHBx/nzRoSmnes16xOeeMHms45gpV
 DK2S/p9KtRCM1fTBQ3Z5dEA9ooEPm214kxVM+FVUP6z+tbV16c74OQjBqMIAxLOAd5Q7
 hYMluwbRstNzOi8mQpfUCuTH3lmdRvHxl7svVLT89YgBzcZXrMPTlXaG0MeGXLydmfCr
 4EJc+TKdQaPBMON1spDeNgjFOkhuCoL8eenCu8WKQRKbmXHlIHQO1uOBDn3LTN3TDii2
 QGMQ==
X-Gm-Message-State: AOAM530FKlBvCJO/MrUep/KqhGI2F/YOcsvRqklswOlQtgKV5kwU9a29
 U9fp3V5qim9NUdG/HczIVBUS6w==
X-Google-Smtp-Source: ABdhPJxCg92GGC6ciiUGa1vA2HtWSRfo+HUY9BurzHkSz4PseBlBxXEbYIQJ0v+lr9WPTaUOLQ/Pbw==
X-Received: by 2002:aa7:d84b:: with SMTP id f11mr2576445eds.288.1590146305011; 
 Fri, 22 May 2020 04:18:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id si16sm7786009ejb.101.2020.05.22.04.18.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 04:18:23 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6CDF01FF7E;
 Fri, 22 May 2020 12:18:22 +0100 (BST)
References: <20200521185407.25311-1-cfontana@suse.de>
 <20200521185407.25311-2-cfontana@suse.de>
 <1934989075.27890087.1590127622669.JavaMail.zimbra@redhat.com>
 <e64d5b81-8759-15ca-2486-dcc8ed10edc0@suse.de> <87r1vce04i.fsf@linaro.org>
 <e3c07225-b502-6bbc-3c6d-eda54b429c91@suse.de>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC 1/3] cpu-throttle: new module, extracted from cpus.c
In-reply-to: <e3c07225-b502-6bbc-3c6d-eda54b429c91@suse.de>
Date: Fri, 22 May 2020 12:18:22 +0100
Message-ID: <87mu60dxq9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Roman Bolshakov <r.bolshakov@yadro.com>,
 "open list:X86 HAXM CPUs" <haxm-team@intel.com>, Colin Xu <colin.xu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <rth@twiddle.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> On 5/22/20 12:26 PM, Alex Benn=C3=A9e wrote:
>>=20
>> Claudio Fontana <cfontana@suse.de> writes:
>>=20
>>> On 5/22/20 8:07 AM, Thomas Huth wrote:
>>>>> From: "Claudio Fontana" <cfontana@suse.de>
>>>>> Sent: Thursday, May 21, 2020 8:54:05 PM
>>>>>
>>>>> this is a first step in the refactoring of cpus.c.
>>>>
>>>> Could you maybe extend the commit message in the next version a little=
 bit? ... say something about *what* you are moving to a separate file (and=
 maybe why it is ok to move it), etc.?
>>>>
>>>>  Thanks,
>>>>   Thomas
>>>>
>>>>
>>>
>>> Hello Thomas,
>>>
>>> thanks for taking a look, I will add an explanatory message.
>>>
>>> I was thinking something along the lines of:
>>>
>>> "
>>> move the vcpu throttling functionality into its own module.
>>> It contains the controls to adjust and inspect vcpu throttling settings=
, start (set) and stop
>>> vcpu throttling, and the throttling function itself that is run periodi=
cally on vcpus
>>> to make them take a nap.
>>> Execution of the throttling function on all vcpus is triggered by a tim=
er,
>>> registered at module initialization.
>>>
>>> No functionality change.
>>> "
>>=20
>> Is vcpu throttling a TCG only feature?
>>=20
>
> No, are you suggesting we only refactor code out of cpus.c based on
> whether it's tcg or not?

No - but  we should make it clear in the commit message that it is used
by both. I must admit I thought it was only a TCG feature which just
goes to show what I know ;-)

>
> Ciao,
>
> Claudio


--=20
Alex Benn=C3=A9e

