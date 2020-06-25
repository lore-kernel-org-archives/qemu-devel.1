Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1BDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9D982067D
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 08:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VUV3eBax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9D982067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joN0i-0006HT-5u
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 04:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1joMzv-0005LL-N9; Thu, 25 Jun 2020 04:12:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36744)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1joMzu-00050S-7d; Thu, 25 Jun 2020 04:12:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id k6so4860268wrn.3;
 Thu, 25 Jun 2020 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2nrmsGqfm7tqQzXIna5sGzQu8wm/8SJKvn06MtkbL1s=;
 b=VUV3eBaxNv0ZFjl654/ZxTDFbQt/gDmm1BLA1US7al64ZXFiT1B61I/CjM3EmZ9MxM
 jSvf7ikUG9B+BhjaZkIjgh/TED4rhWCpYF4Pm/i5jpvnnXpcPXWNw6G1jiUmfvO40oag
 qCpsZAZQbQgu2sRTcYZqxE1BGQ77VwPgY3T7FOAgiCs63WbvHp3VeQQxHaMXtouRVsbd
 xK4H3ApF2KdMQ6tyWUodw3SvbUkzDeqtLcKwGpyM0Ay+rT+AmqWbS9jEuwdTPaOvApxN
 kuwIYAzqP0AqO3YjAsI7mgv0bx4x2AMKydPu5nu92wDNyUYQ0e/rAlc6hx+XQxSScyK/
 k7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2nrmsGqfm7tqQzXIna5sGzQu8wm/8SJKvn06MtkbL1s=;
 b=GyPj9DIPo7lGvqNd9WvPlFqN/3D+3yOOJs50i8FrXy7AyaLd+WcL1PdgMvedMVSdMF
 EuM/f9PSUqKFjEAbtJLlP5NApj9z9Tb5O/9coj1l6Fc2feiqKM4+B8X4fux2efEthq0N
 NDTXaFRdwJeMSlyMKJBVN7QHTqcnyVBYv7ibgxuy+ZiZJTQu5hz2MG/3j2cbnl/6DgT+
 k7CDD7pQVqMEKalq29c4qEO+HQeFg1KPfaPLYIzCVD/ATQHkbSl/aA+1YXspjtIdSFTR
 VbxHg8Rv7dnoAXQ0yFiPOMPHSey5lPsZPqxXaAeYGzdrrMZs8YaHTrMis3t/2EWspGQT
 vNXg==
X-Gm-Message-State: AOAM530Kotsg/KLIWtbMBYXcdyR4Z1V+z3I3+2b3gDIv/JDjSZReswen
 5wITSUkgGEP7/nzNZ1nGNoQ=
X-Google-Smtp-Source: ABdhPJyhQIWU/SENaAbxirpuT16EQrWaDNJ988mzPdnGLTaOd3eMxfRK8E7LLMBZSVQWWOHH+fNILA==
X-Received: by 2002:adf:f14c:: with SMTP id y12mr34969431wro.30.1593072756071; 
 Thu, 25 Jun 2020 01:12:36 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id h14sm14607344wrt.36.2020.06.25.01.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 01:12:35 -0700 (PDT)
Subject: Re: [PATCH v4 4/8] hw/misc/pca9552: Add a 'description' property for
 debugging purpose
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
References: <20200620225854.31160-1-f4bug@amsat.org>
 <20200620225854.31160-5-f4bug@amsat.org>
 <4d335933-9669-43e1-0966-5f0255142012@kaod.org>
 <34fe3d2b-6b41-0509-f172-5b45486fdf0c@amsat.org>
 <deccf836-48ef-7112-d66e-a8d3cc4a9681@kaod.org>
 <877dvv4pmg.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2d1b8b24-3b2c-d84e-8026-e369f6531247@amsat.org>
Date: Thu, 25 Jun 2020 10:12:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <877dvv4pmg.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 8:37 AM, Markus Armbruster wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> On 6/22/20 10:31 AM, Philippe Mathieu-Daudé wrote:
>>> On 6/22/20 8:27 AM, Cédric Le Goater wrote:
>>>> On 6/21/20 12:58 AM, Philippe Mathieu-Daudé wrote:
>>>>> Add a description field to distinguish between multiple devices.
> 
> Pardon my lack of imagination: how does this help you with debugging?

Ah, the patch subject is indeed incorrect, this should be:
"... for *tracing* purpose" (I use tracing when debugging).

In the next patch, we use the 'description' property:

+# pca9552.c
+pca9552_gpio_status(const char *description, const char *buf) "%s GPIOs
0-15 [%s]"

So when the machine has multiple PCA9552 and guest accesses both,
we can distinct which one is used. For me having "pca1" / "pca0"
is easier to follow than the address of the QOM object.

> 
>>>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>>>
>>>> Could it be a QOM attribute ? 
>>>
>>> What do you call a 'QOM attribute'?
>>> Is it what qdev properties implement?
>>> (in this case via DEFINE_PROP_STRING).
>>
>> I meant a default Object property, which would apply to all Objects. 
> 
> Good point.  Many devices have multiple component objects of the same
> type.
> 
>> What you did is fine, so :
>>
>> Reviewed-by: Cédric Le Goater <clg@kaod.org>
>>
>> but, may be, a well defined child name is enough for the purpose.
> 
> object_get_canonical_path() returns a distinct path for each (component)
> object.  The path components are the child property names.
> 
> Properties can have descriptions: object_property_set_description().

TIL object_property_set_description :>

Ah, there is no equivalent object_property_get_description(),
we have to use object_get_canonical_path(). Hmm, not obvious.

> 
> Sufficient?

I don't know... This seems a complex way to do something simple...
This is already a QDEV. Having to use QOM API seems going
backward, since we have the DEFINE_PROP_STRING() macros available
in "hw/qdev-properties.h".

Maybe I'm not seeing the advantages clearly. I'll try later.

Thanks for your review,

Phil.

