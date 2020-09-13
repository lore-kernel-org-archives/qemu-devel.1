Return-Path: <SRS0=H3r+=CW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8698AC433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:13:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9868221EB
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2020 16:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CAwXB4rN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9868221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHUdH-0007dn-5P
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 12:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHUcc-0006xl-Qf
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 12:12:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57529
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kHUcb-0002RS-9W
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 12:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600013576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DYm6r7ljYVK/BeVRP1BalJMUE7dU4r/YpbcazoGyhic=;
 b=CAwXB4rNFbZT2GfKJwZvAxJGnGwh9IGfMH4HlmCyi0Z3JXAIUDoaeGtrIBTLQTlm/n49V/
 Waly9gF3nTMB7gstTOljfkZE4CC1gRbLRNHwj42ZtQGNXl/t2/Pu3btAhrSMTKhdwJ0xJD
 0MSuIKH23fDsRjxnmx2C/I9PJly9Ch0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-QNgphXdnP3S0JM1nBAj3Ig-1; Sun, 13 Sep 2020 12:12:54 -0400
X-MC-Unique: QNgphXdnP3S0JM1nBAj3Ig-1
Received: by mail-ed1-f72.google.com with SMTP id n25so8408331edr.13
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 09:12:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DYm6r7ljYVK/BeVRP1BalJMUE7dU4r/YpbcazoGyhic=;
 b=ZiaYPx2k4agRdrVP5A74zRFBcxAEk7QY7GfmuhFlNgWTflb6jGlCypsdEuwhbafftg
 JMVKyTW3KHcxVJeqR2L2OHSskJVVr/j2NLrpd2Uumt+9EhZ9mNeGh45c2WIWyOpjmYj0
 6ZZgFkwUtOaZG3JQT3KLfNRZMwSs1+dCAuKjAp8KQgq/XTIFuuPzWiiEx2OnflN0FCQx
 Z2sHMaLq+nlLCZ7Hku6oLr4BalcKxPDeeUul2RPBNBpxQDx+yM8uIvLbsKtaxx3Oxm4J
 qID4qCY5f9ShDpKtHcxelZ7LiiASJATwP7GUCV+O9PJRWzj0Zva+HR4zoZJCzBgobUsl
 7TRw==
X-Gm-Message-State: AOAM532q9QrsFzs9N2Dvcgq6u7Jxrb9oPO9VpFhRiZ7RncZN1Kzf69Dl
 RRkyLI3yzAnz+buIVjZ3D7SXEol+OqhWDahlxHBFuqoaOZ6sn4vewcN+EBj+qKyZFxxu3C2J3Zv
 eeCPVEDfDv/O1GOE=
X-Received: by 2002:a05:6402:b68:: with SMTP id
 cb8mr13522480edb.350.1600013572771; 
 Sun, 13 Sep 2020 09:12:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypWK7+11eQ9SBBeEtDvaMCxDDH4+TN+OYOJX4255Nrdj5i3y3wvVCj+2b+9QAvZn5Hu2S7vg==
X-Received: by 2002:a05:6402:b68:: with SMTP id
 cb8mr13522463edb.350.1600013572605; 
 Sun, 13 Sep 2020 09:12:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d03c:628a:ca24:cea1?
 ([2001:b07:6468:f312:d03c:628a:ca24:cea1])
 by smtp.gmail.com with ESMTPSA id lz22sm5579826ejb.98.2020.09.13.09.12.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 09:12:51 -0700 (PDT)
Subject: Re: [PATCH v4 0/9] user-mode: Prune build dependencies (part 2)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
References: <20200910152225.524322-1-philmd@redhat.com>
 <f8c9c94c-9b27-6c16-bde1-1a0a91287563@redhat.com>
 <fb687ccc-919c-6c61-4dbc-9e76625c3743@redhat.com>
 <84799885-c40c-a8ae-915d-798fdae3e303@redhat.com>
 <e3ce5624-f67e-0877-4129-ac8cdcea48a7@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d5b1114a-b42b-7164-5284-dd548e74a48b@redhat.com>
Date: Sun, 13 Sep 2020 18:12:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <e3ce5624-f67e-0877-4129-ac8cdcea48a7@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/13 11:28:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Eduardo Habkost <ehabkost@redhat.com>, Ben Warren <ben@skyportsystems.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-block@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/09/20 17:51, Philippe Mathieu-Daudé wrote:
>>>
>> Yes, I'm not sure about the stub _in general_.  I would prefer to either
>> have the type available even on user-mode emulation, or remove the
>> property altogether... I don't know, anything but not a property that
>> aborts. :)
> I plan to eventually get user-mode cleaned, but this is out of the scope
> of this generic second part which is already big enough for Laurent to
> digest. Maybe part #4 will be x86 specific.
> 
> Let's wait for Markus view on this (personally I don't mind removing
> the abort, it was not there on v3).
> 

The abort is better than v3 which was buggy (like use-uninitialized-data
buggy).  But I'd prefer not needing the stub at all.

Paolo


