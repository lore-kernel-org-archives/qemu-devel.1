Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B8AC5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2D2C216E3
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2D2C216E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjWNP-0002ru-He
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 18:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53517)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hjWMe-0002PN-Ul
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hjWMd-0007LL-W7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:07:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hjWMd-0007KQ-P0
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:07:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id s3so10450489wms.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 15:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hKSCCMnahA6DJngqRQ0yZRtPwzoZ+ia7P3wJ3Zsg1i4=;
 b=kf6OTXVJkMczlBR0GvcfFnV1QMgPvGf/i8JsKi8ntfdnyxOw/79jDXqcMygThLC0vl
 dG66jvKWxlL8VhTRvEjM/AhqeA5o8mgK0kRqB2kH/0CmOo3wL7P3lob+WlL537yggb7I
 /FKY+gTIzeBFO36cBm+eLRKI39ToHWVVm5SB/megaF3b4J3ZlkDSMDkWVWyufdRiBjeW
 U80HPewCwBCg0KrILOpbj3XmbR8B0fMO1xsZdXf99HaRdN7mjmvsGPCiUN8toK3bUNL2
 X87P+oYgmy/Z2mOKhKvqBVPh+HhOxxmpXd+DCPjWTJcrifaLE40KrYMTUtXO2KySz7AR
 u4iw==
X-Gm-Message-State: APjAAAWXnarRuxI9bHWQATcNkJhdv37IuGunJiRHuv0UP7Kw3cxPNYzE
 RUn4vw2soUhEeWBupb4s+6pUiw==
X-Google-Smtp-Source: APXvYqzhW+lRRLEalerATLhZ6Ul+SAiQqO+gCoQdhtc+BJrbi49RHz4bdY0DAuUbUvTeArkDs0dcLQ==
X-Received: by 2002:a1c:9d53:: with SMTP id g80mr4723878wme.103.1562364450563; 
 Fri, 05 Jul 2019 15:07:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423?
 ([2001:b07:6468:f312:19db:ad53:90ea:9423])
 by smtp.gmail.com with ESMTPSA id d9sm13988207wrb.71.2019.07.05.15.07.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 15:07:30 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <1562079681-19204-2-git-send-email-pbonzini@redhat.com>
 <20190705203728.GE5198@habkost.net>
 <0c1f3a3f-c59d-9866-7fc9-3d9c99af17e5@redhat.com>
 <20190705214446.GI5198@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2cc393a3-1f8c-896b-ed35-64ca58e70407@redhat.com>
Date: Sat, 6 Jul 2019 00:07:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705214446.GI5198@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH 1/7] target/i386: handle filtered_features
 in a new function mark_unavailable_features
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
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/07/19 23:44, Eduardo Habkost wrote:
> On Fri, Jul 05, 2019 at 11:32:07PM +0200, Paolo Bonzini wrote:
>> On 05/07/19 22:37, Eduardo Habkost wrote:
>>> Filtering and reporting is separate because
>>> x86_cpu_filter_features() is also called from a QMP command
>>> handler that is not supposed to generate any warnings on stderr
>>> (query-cpu-model-expansion).
>>
>> But that one should not set check_cpuid or enforce_cpuid, should it?
> 
> check_cpuid is set to true by default.

Ok, that's what I missed.

>>
>> (I can still split the filtering and reporting if you prefer).
> 
> Maybe it will work if we just add a 'bool verbose' parameter to
> x86_cpu_filter_features().
> 
> x86_cpu_realizefn() would call:
>   x86_cpu_filter_features(cpu, cpu->check_cpuid);

... "|| cpu->enforce_cpuid".

> x86_cpu_class_check_missing_features() would call:
>   x86_cpu_filter_features(cpu, false);

Or set check_cpuid to false there after creating the object?

Paolo

