Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325A8C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:19:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080BB20449
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 21:19:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080BB20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjVbw-0003b4-96
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 17:19:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44357)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hjVVW-0008B7-Pl
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:12:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hjVVV-00039D-3w
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:12:38 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hjVVU-0002uC-Rd
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 17:12:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id f17so10888538wme.2
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2019 14:12:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BoItjlm7TBPzwqQbCeRpmsJxMm7J7xkLF4z9/XerCT8=;
 b=bK3Q4pxy2hmdjXUJ8yji+Ljd6oAG0aqPURqDYmZAgu5uwDMzp4Rx78cFi+Vhq9nGmi
 upvRhNQ0c+byF69af/c1vbvGgKy+aAjYvvWYbUt6LnnZesCPrAxEYO8vymPkvOnZAgZR
 b8zEDxYni7Oyz5H7cbfY1PU18jFWMlYxlqa3zgpvMVe/pu4K+I7RaubR7PSKGB+7bJVk
 owKIIdOi9wICfOU7O6JuBqyWuS6VJv2gMvqjLSdeo1eILxdYVrHy6wNk9hOz8rQLmrW5
 7B7hdA4cIJZDbHVCgFqwPLI3UHHBFu6qih1byo9cagHH9039yt6cVwIIove7hE+zKltU
 AJ8g==
X-Gm-Message-State: APjAAAUg6l/TC87cl5fgwbgXH1WnFTZrppOHO31qR7IBsT8ct8i6Ed4w
 w3MpmgTPBjGuK6ORHD07cGD+kw==
X-Google-Smtp-Source: APXvYqwG+pX1Igf/nmPg62P66GQ8SLnwSBvfREc/rzxD6QRIV0UvEsJ2eXbH0KMd6vL/AjixQWdbyg==
X-Received: by 2002:a05:600c:212:: with SMTP id
 18mr4522649wmi.88.1562361132904; 
 Fri, 05 Jul 2019 14:12:12 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423?
 ([2001:b07:6468:f312:19db:ad53:90ea:9423])
 by smtp.gmail.com with ESMTPSA id u6sm9891090wml.9.2019.07.05.14.12.12
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Jul 2019 14:12:12 -0700 (PDT)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <1562079681-19204-1-git-send-email-pbonzini@redhat.com>
 <1562079681-19204-3-git-send-email-pbonzini@redhat.com>
 <20190705205228.GF5198@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2015601d-8979-e5d6-fb14-ed74dc420813@redhat.com>
Date: Fri, 5 Jul 2019 23:12:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190705205228.GF5198@habkost.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH 2/7] target/i386: introduce generic feature
 dependency mechanism
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

On 05/07/19 22:52, Eduardo Habkost wrote:
>> +typedef struct FeatureDep {
>> +    uint16_t from, to;
> 
> Why uint16_t and not FeatureWord?

Ok.

>> +    uint64_t from_flag, to_flags;
> 
> There are other parts of the code that take a
> FeatureWord/uint32_t pair (which will become uint64_t).  I'd wrap
> this into a typedef.  I also miss documentation on the exact
> meaning of those fields.
> 
>     typedef struct FeatureMask {
>         FeatureWord w;
>         uint64_t mask;
>     };

Sounds good, I was optimizing the layout by putting small fields
together.  Perhaps prematurely. :)

>> +    for (l = plus_features; l; l = l->next) {
>> +        const char *prop = l->data;
>> +        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
>> +        if (local_err) {
>> +            goto out;
>> +        }
>> +    }
>> +
>> +    for (l = minus_features; l; l = l->next) {
>> +        const char *prop = l->data;
>> +        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
>> +        if (local_err) {
>> +            goto out;
>> +        }
>> +    }
> 
> Maybe getting rid of plus_features/minus_features (as described
> in the TODO comment below) will make things simpler.

This is just moving code.  I can look at getting rid of plus_features
and minus_features but I was wary of the effects that global properties
have on query_cpu_model_expansion.

In any case, that would basically be rewriting "+foo" and "-foo" to
"foo=on" and "foo=off" respectively, right?

>> +
>> +    for (i = 0; i < ARRAY_SIZE(feature_dependencies); i++) {
>> +        FeatureDep *d = &feature_dependencies[i];
>> +        if ((env->user_features[d->from] & d->from_flag) &&
>> +            !(env->features[d->from] & d->from_flag)) {
> 
> Why does it matter if the feature was cleared explicitly by the
> user?

Because the feature set of named CPU models should be internally
consistent.  I thought of this mechanism as a quick "clean up user's
choices" pass to avoid having to remember a multitude of VMX features,
for example it makes "-cpu host,-rdtscp" just work.

>> +            uint64_t unavailable_features = env->features[d->to] & d->to_flags;
>> +
>> +            /* Not an error unless the dependent feature was added explicitly.  */
>> +            mark_unavailable_features(cpu, d->to, unavailable_features & env->user_features[d->to],
>> +                                      "This feature depends on other features that were not requested");
>> +
>> +            /* Prevent adding the feature in the loop below.  */
>> +            env->user_features[d->to] |= d->to_flags;
>> +            env->features[d->to] &= ~d->to_flags;
>> +        }
>> +    }
> 
> Maybe move this entire block inside x86_cpu_filter_features()?

It has to be done before expansion, so that env->user_features is set
properly before -cpu host is expanded.

Paolo

>> +
>>      /*TODO: Now cpu->max_features doesn't overwrite features
>>       * set using QOM properties, and we can convert
>>       * plus_features & minus_features to global properties
>> @@ -5106,22 +5143,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
>>          }
>>      }
>>  
>> -    for (l = plus_features; l; l = l->next) {
>> -        const char *prop = l->data;
>> -        object_property_set_bool(OBJECT(cpu), true, prop, &local_err);
>> -        if (local_err) {
>> -            goto out;
>> -        }
>> -    }
>> -
>> -    for (l = minus_features; l; l = l->next) {
>> -        const char *prop = l->data;
>> -        object_property_set_bool(OBJECT(cpu), false, prop, &local_err);
>> -        if (local_err) {
>> -            goto out;
>> -        }
>> -    }
>> -
>>      if (!kvm_enabled() || !cpu->expose_kvm) {
>>          env->features[FEAT_KVM] = 0;
>>      }
>> -- 
>> 1.8.3.1
>>
>>
>>
> 


