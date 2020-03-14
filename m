Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03C3C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 10:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78B612076D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 10:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YK9h6D0E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78B612076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD4Um-0004u2-M5
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 06:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jD4U9-0004Vd-Ae
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 06:57:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jD4U8-0004DE-Bm
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 06:57:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:37917
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jD4U8-0004Af-8Y
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 06:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584183459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2arRauNidtV4qxBuT9MfO7B/zotsvSymvbXgoXR+Bw=;
 b=YK9h6D0E57W17h7z4JIasamPRpx62i8m72IUDhQ+EWKxRtp2OZCp6Xzr0nn/qFDleYRrVs
 F9IuIPENlflBnmXwGE7HvELFv7zuJkRT3LEPvLWDcjzl5QW1kx2A7CDgx1Kmdng6sp9cNK
 AcLp9mj5w0XQYxO/r2ppMsnNwYzPYeE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-PkzBCy18PzeSg7ghADD-7Q-1; Sat, 14 Mar 2020 06:57:38 -0400
X-MC-Unique: PkzBCy18PzeSg7ghADD-7Q-1
Received: by mail-wm1-f72.google.com with SMTP id a23so4092253wmm.8
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 03:57:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0704kwWrLd1YISA7NwCFRdIbGEXOpfQiRtjFZbLDS3g=;
 b=dQI8fRlYw3tDHY4p6NFbwRgz0uKuGDo7DJNfeAtLKPZsQFxVskn/kqzFbEyecav3Rt
 HaTCgHy50DFwgaeVir43gaG4pSmznmLjbN912xhOQ3IZYbBLxFHNUsAhPQNTuBBama3x
 TonJ4vmxigT8nP/VNxEZ3CNOa3GY9zifsHnUNeXy7D37BeFTHOwG5LG4uCEyuqt+XbfT
 XyeNz98y6JNsJtnEiL5vJBkjZ18rJlkP7DMZ7o7rq60swqocYIp/YOOrph9xmg6Ox5/3
 +NbSnU2pzjt2s5AJEqX/dIwgkanY1gTIRBobNuVJ2SW966nLDpme0eUsApmunINjOIFh
 KrwA==
X-Gm-Message-State: ANhLgQ1nRmQc6hCqz0Nc4as9K8wPbXdjiiOZ6adzjlbuRd9kRzodTIhd
 eCB0MFNCGJ40+Jr+2R+TkfuwjJ98watJoCGWSku6JO/a1+9Nn2rqw6k50o9SOhsw1NjZxvB/+gL
 BUlF8Czod8OY1sTU=
X-Received: by 2002:a7b:cf33:: with SMTP id m19mr7525900wmg.168.1584183456906; 
 Sat, 14 Mar 2020 03:57:36 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vu8fen9GXjFV2Hn4ADxsm8zyxPEGbunl1rbGhAzb5kI+KK1IWGoUstsA5Ay606iaEvo/ZgFPg==
X-Received: by 2002:a7b:cf33:: with SMTP id m19mr7525867wmg.168.1584183456166; 
 Sat, 14 Mar 2020 03:57:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7de8:5d90:2370:d1ac?
 ([2001:b07:6468:f312:7de8:5d90:2370:d1ac])
 by smtp.gmail.com with ESMTPSA id s2sm20011542wmj.15.2020.03.14.03.57.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 03:57:35 -0700 (PDT)
Subject: Re: [PATCH 8/9] hw/core: Add qdev stub for user-mode
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200313184607.11792-1-philmd@redhat.com>
 <20200313184607.11792-9-philmd@redhat.com>
 <7775dd60-7c5d-e973-162d-5eb742b41c07@redhat.com>
 <9118c5b3-196b-9002-dcb8-1d3b91b59fc3@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e06976a-b58d-a66e-8a13-5e3d7a325dc1@redhat.com>
Date: Sat, 14 Mar 2020 11:57:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9118c5b3-196b-9002-dcb8-1d3b91b59fc3@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/03/20 11:49, Philippe Mathieu-Daud=C3=A9 wrote:
>>>
>>> diff --git a/hw/core/Makefile.objs b/hw/core/Makefile.objs
>>> index 6215e7c208..89bf247173 100644
>>> --- a/hw/core/Makefile.objs
>>> +++ b/hw/core/Makefile.objs
>>> @@ -8,6 +8,7 @@ common-obj-y +=3D vmstate-if.o
>>> =C2=A0 # irq.o needed for qdev GPIO handling:
>>> =C2=A0 common-obj-y +=3D irq.o
>>> +common-obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D qdev-stubs.o
>>
>> This should be:
>>
>> =C2=A0=C2=A0=C2=A0 obj-$(call lnot,$(CONFIG_SOFTMMU)) +=3D qdev-stubs.o
>=20
> Actually I moved it to stub-obj-y which makes things easier.

No, common-obj- is the right thing, followed by

common-obj-$(CONFIG_ALL) +=3D qdev-stubs.o

Paolo


