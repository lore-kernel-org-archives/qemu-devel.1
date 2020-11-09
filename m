Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2E1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD4F20578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQJrxE+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD4F20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcB8W-0006WB-8O
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcB2Z-0007Sl-Po
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:33:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kcB2W-0006ss-EC
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:33:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604943191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G0JktIhnfCMtzxuorbhhCkI99M5iZWuJ4uUeyUO/nho=;
 b=UQJrxE+xIyD3FdqR53RCgr/4IAQO9sLS5kVM7divmwZNq2zPCod/6PEL2fgecTicfgciJb
 1P1qa19/ZlSabcOQv/kytOwOYSX+PghNCdNdmAAPVX5da53ywSxDj5BcnTPn/7Rm+b7fng
 mN8Z1/cjOknixzZFYR3pZeSjQ6uPn2c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-vmRGei5lPyGy6vH34MX1bQ-1; Mon, 09 Nov 2020 12:33:07 -0500
X-MC-Unique: vmRGei5lPyGy6vH34MX1bQ-1
Received: by mail-wm1-f71.google.com with SMTP id k128so43158wme.7
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 09:33:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:references:from:subject:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G0JktIhnfCMtzxuorbhhCkI99M5iZWuJ4uUeyUO/nho=;
 b=lni97+9OBgW0+2R/WPcWMy6v1YpMZwLf6wtSgrX5m2I7djhV9fpn32Q8yPghTfdBpy
 efxbbscXk2PiNcd7uYRFMZU7HmEk9yYeIUk7zdAIq47et7reBWeFM6MIxjTVnVAhY/fN
 +p7K5NjCorx/nwPQscbCRSNJRfzvtIXMyAkKNX3M6So/mcrNcQwgcdYqkizH5rjieG+Q
 spENumkbptZvqJ6iFO+xCuhFQintBtpiUssBLGtsiZqicyEihc2rDIHkOCnXhhNt1Yzy
 LAtea22sH1BHLzSfhRTbBloE0J4K7RRN3jOBFd9a5IaQbXnAs2pHVb590Fv91bDDyIFL
 eXew==
X-Gm-Message-State: AOAM532ZvJjiN5a60EbpD1brxJZXC1BTd3vwZ8CeAxSbWRVUfLZC38Hv
 jt47NTcjsB0DLme6R2DlJKRvXm8avOxMo6dYG6W8UaV6vovj4yxYd1uXYRYkOY2APGppGDPaw+H
 HHtMF5Jg4X/K39vs=
X-Received: by 2002:adf:f1ca:: with SMTP id z10mr16103231wro.265.1604943186624; 
 Mon, 09 Nov 2020 09:33:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRGOtWLc3fxPTBH0si+4WlQFRqnnrkjOLhN3aEhfH06OJR0RVTE1n+0vmoz6EOF0Sf2Mr4rQ==
X-Received: by 2002:adf:f1ca:: with SMTP id z10mr16103206wro.265.1604943186402; 
 Mon, 09 Nov 2020 09:33:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id q12sm96141wmc.45.2020.11.09.09.33.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 09:33:05 -0800 (PST)
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20201104160021.2342108-1-ehabkost@redhat.com>
 <20201106094511.GA23864@merkur.fritz.box> <20201106155013.GX5733@habkost.net>
 <20201106211034.GY5733@habkost.net>
 <ca99fc61-6cdd-117d-343e-8141e385522e@redhat.com>
 <20201109113404.GA24970@merkur.fritz.box>
 <3b711053-e67a-86fb-59e7-c06948dd8928@redhat.com>
 <20201109152125.GZ5733@habkost.net>
 <2300fd53-afa1-b957-b33b-cff2986fcb93@redhat.com>
 <20201109171618.GA5733@habkost.net>
From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/44] Make qdev static property API usable by any QOM
 type
Message-ID: <098ca211-3ad5-b194-e9f5-678291fe641e@redhat.com>
Date: Mon, 9 Nov 2020 18:33:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201109171618.GA5733@habkost.net>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 00:04:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/11/20 18:16, Eduardo Habkost wrote:
> On Mon, Nov 09, 2020 at 05:34:01PM +0100, Paolo Bonzini wrote:
>> On 09/11/20 16:21, Eduardo Habkost wrote:
>>> Nothing prevents us from describing those properties inside the
>>> same property array.
>>
>> Do you mean adding PropertyInfos for them?  Adding a once-only PropertyInfo
>> is worse than writing a custom getter/setter pair, because:
>>
>> - without (DEFINE_)PROP_* you lose the type safety.
>>
>> - with (DEFINE_)PROP_* you have much more boilerplate to write
> 
> I mean extending the API to let custom setters and getters appear
> on the Property array, not using the existing API.

That seems like conflicting goals.  The field property API is based on 
getters and setters hidden in PropertyInfo.  The "other" property API is 
based on getters and setters in plain sight in the declaration of the 
property.

>>>>> I think having different ways for different things (class vs. object) is
>>>>> better than having different ways for the same things (class in qdev vs.
>>>>> class in non-qdev).
>>>>
>>>> Right, but qdev's DEFINE_PROP_STRING would be easy to change to something
>>>> like
>>>>
>>>> - DEFINE_PROP_STRING("name", ...),
>>>> + device_class_add_field_property(dc, "name", PROP_STRING(...));
>>>
>>> I'm not worried about this direction of conversion (which is
>>> easy).  I'm worried about the function call => QAPI schema
>>> conversion.  Function calls are too flexible and requires parsing
>>> and executing C code.
>>
>> Converting DEFINE_PROP_STRING to a schema also requires parsing C code,
>> since you can have handwritten Property literals (especially for custom
>> PropertyInfo).  Converting DEFINE_PROP_STRING it also requires matching the
>> array against calls to object_class_add_field_properties (which could be
>> hidden behind helpers such as device_class_set_props).  (Plus matching
>> class_init functions against TypeInfo).
> 
> Parsing an array containing a handful of macros (a tiny subset of
> C) isn't even comparable to parsing and executing C code where
> object*_property_add*() calls can be buried deep in many levels
> of C function calls (which may or may not be conditional).

Finding the array would also require finding calls buried deep in C 
code, wouldn't they?

> (Also, I don't think we should allow handwritten Property literals.)

How would you do custom setters and getters then---without separate 
PropertyInfos, without Property literals, and without an exploding 
number of macros?

>> So, you don't save any parsing by using arrays.  (In fact I would probably
>> skip the parsing, and use your suggestion of *executing* C code: write the
>> QAPI schema generator in C, link into QEMU and run it just once to generate
>> the QOM schema).
> 
> If we do that with the existing code, we can't be sure the
> generated schema doesn't depend on configure flags or run time
> checks inside class_init.

We can use grep or Coccinelle or manual code review to identify 
problematic cases.

> Even locating the cases where this is
> happening is being a challenge because the API is too flexible.
> 
> However, if we require the property list to be always evaluated
> at compile time, we can be sure that this method will be
> reliable.
> 
>> QOM has been using function calls for many years, are there any cases of
>> misuse of that flexibility that you have in mind?  I can only think of two
>> *uses*, in fact.  One is eepro100_register_types is the only case I can
>> remember where types are registered dynamically.  The other is S390 CPU
>> features.  [...]
> 
> The list of tricky dynamic properties is large and I don't think
> we even found all cases yet.  John documented many of them here:
> 
> https://gitlab.com/jsnow/qemu/-/blob/cli_audit/docs/cli_audit.md
> 
> Look, for example, for the sections named "Features" for CPU
> options.

Yes, I'm only considering object_class_property calls.  Those are the 
ones that I claim aren't being misused enough for this to be a problem.

Making instance-level properties appear in the schema is a completely 
different kind of conversion, because there is plenty of manual work 
(and unsolved problems for e.g. subobject property aliases).

> You are also ignoring the complexity of the code path that leads
> to the object*_property_add*() calls, which is the main problem
> on most cases.

I would like an example of the complexity of those code paths.  I don't 
see much complexity, as long as the object exists at all, and I don't 
see how it would be simpler to find the code paths that lead to 
object_class_add_field_properties.

Paolo


