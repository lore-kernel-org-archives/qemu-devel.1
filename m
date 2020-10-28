Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A33C5C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1702A247C5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bin0fxpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1702A247C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXnN3-00051l-1w
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXnHk-0005Zm-OE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:22:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kXnHi-0006r0-Tn
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603898566;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qiFBBrsNzMxI5HGgs4EzUyQEFC+cIzLIJLUFTr9IIMw=;
 b=bin0fxpSw2WaFvkjUxMQ6GBgFAFRa6mi4C4qzgorRddnhinvHslXISlbmFqctfD82q2tGg
 RiBZDJpUva72t/V4AHCCOT0WPB3MP1N1ahnzBdGS/KkYDrvbbYm85D4PFKJPVu8O5k5QQ/
 2JuoC5N7h2Kjodtc0n8f3sZfMq8PMeo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-D9dRRloPPkOp3YS08yOymQ-1; Wed, 28 Oct 2020 11:22:43 -0400
X-MC-Unique: D9dRRloPPkOp3YS08yOymQ-1
Received: by mail-wm1-f70.google.com with SMTP id c204so1886389wmd.5
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 08:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qiFBBrsNzMxI5HGgs4EzUyQEFC+cIzLIJLUFTr9IIMw=;
 b=Lpdv3nZjFAb6EMBPTYBm9+s6HEmR6zFQ3nR/ayH9jFHuIwLdtvRtiBAGI8jcob4xZZ
 nWcrCJ5PW04rFhNGXruWqXzYhqk2JM3LLaDf6mf0nluA/LVnzFDl5bwPUHpidIMS653W
 kmCQHeWJ3+AuUlocO3c4iI6icdQuU+k1m6YbEWlZKpn704smWvlC23U+YMF/h+/rrJ1U
 pkEf2HtIf0i9VTDucTlXFKsFOkgShXGN8kCxsZR681xVat+n/xQWaY5cqV0TtqViPcZX
 HwgPkZ0GxwVCSSRe/8toE2zuvH/CEwdrL+afmogbaG6POGiddyfnZ+Ue+K5ogMGHF32n
 OCTw==
X-Gm-Message-State: AOAM533EtMMvKUAEj3v8ECLi6xcgGtLoRKtE/DnZgloGl+xU3QEl4uNi
 7W4QJq0Sz1ttLbeKWNmHjYaKQaE5ft9CM4H5ZmXYrRrSw/i/cbzSaPUNk1Xk4OiM5MxEmZ/MXNr
 k3Gne8thYs4Qyhlc=
X-Received: by 2002:adf:f381:: with SMTP id m1mr10588341wro.347.1603898562191; 
 Wed, 28 Oct 2020 08:22:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyc0jMPqOITIpgStHALePN3HIyATfb98GiM2IKoQoy8tuWCLELaFcVFts1Gu4li1nkRkj2C0g==
X-Received: by 2002:adf:f381:: with SMTP id m1mr10588315wro.347.1603898561912; 
 Wed, 28 Oct 2020 08:22:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a?
 ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
 by smtp.gmail.com with ESMTPSA id y2sm7552376wrh.0.2020.10.28.08.22.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 08:22:41 -0700 (PDT)
Subject: Re: [PATCH 03/12] qom: Make object_class_property_add_uint*_ptr() get
 offset
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
 <20201009160122.1662082-4-ehabkost@redhat.com>
 <20201021142408.72d2b92f@redhat.com> <20201021133041.GT5733@habkost.net>
 <20201023173314.6d46ada9@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6f5c3a13-6798-9d7d-e686-69d549366095@redhat.com>
Date: Wed, 28 Oct 2020 16:22:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201023173314.6d46ada9@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.921, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/20 17:33, Igor Mammedov wrote:
> On Wed, 21 Oct 2020 09:30:41 -0400
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
>> On Wed, Oct 21, 2020 at 02:24:08PM +0200, Igor Mammedov wrote:
>>> On Fri,  9 Oct 2020 12:01:13 -0400
>>> Eduardo Habkost <ehabkost@redhat.com> wrote:
>>>   
>>>> The existing object_class_property_add_uint*_ptr() functions are
>>>> not very useful, because they need a pointer to the property
>>>> value, which can't really be provided before the object is
>>>> created.
>>>>
>>>> Replace the pointer parameter in those functions with a
>>>> `ptrdiff_t offset` parameter.
>>>>
>>>> Include a uint8 class property in check-qom-proplist unit tests,
>>>> to ensure the feature is working.  
>>>
>>>
>>> Not sure I like approach, it's reinventing qdev pointer properties in QOM form.  
>>
>> Yes, and that's on purpose.  If we want to eventually merge the
>> two competing APIs into a single one, we need to make them
>> converge.
>>
>>> I had an impression that Paolo wanted qdev pointer properties be gone
>>> and replaced by something like link properties.  
>>
>> This is completely unrelated to qdev pointer properties and link
>> properties.  The properties that use object_property_add_uint*_ptr()
>> today are not qdev pointer properties and will never be link
>> properties.  They are just integer properties.

I think this series a step in the right direction, but please take more
"inspiration" from link properties, which are done right.  In
particular, properties should have an optional check function and be
read-only unless the check function is there.

You can make the check function take an uint64_t for simplicity, so that
all the check functions for uint properties have the same prototype.
For example a single "property_check_uint_allow" function can allow
setting the property (which is almost always wrong, but an easy cop out
for this series).

Paolo


