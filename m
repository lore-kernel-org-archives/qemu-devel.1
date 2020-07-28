Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6764BC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 17:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA762070B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 17:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9ClZgvs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA762070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0TZU-0005Qb-FN
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 13:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57428)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0TYi-00051Z-9A
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 13:38:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1k0TYf-0005LA-SR
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 13:38:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595957912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QRm4ttgr3/oaqscGdAih9t2jxR91ulD8qVJ2ZoJWUew=;
 b=h9ClZgvskhB4OqQa108Fleausdb7oJ5WDlnUsEBWxPKCOd+zlLhq4vkdCttyCsOXKp4m+A
 H/gj9Omu1ZXfo4EzCJAF5OCeYXoA/nikeussmM6scRKhYnhq86WFVE/QbP627KVKESYMaQ
 oMWs8LscPW80CB9Q1IrdG7EAUiCEdTQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-StB-jq3rP2Wg65ksUOMUIw-1; Tue, 28 Jul 2020 13:38:30 -0400
X-MC-Unique: StB-jq3rP2Wg65ksUOMUIw-1
Received: by mail-wr1-f69.google.com with SMTP id j2so2968313wrr.14
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 10:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QRm4ttgr3/oaqscGdAih9t2jxR91ulD8qVJ2ZoJWUew=;
 b=hA+++5MGFJUkGakh0ZzEKhZMGqU9hYJpWwRt+v6n8d93Ps32gkiyLgO3iMIpV/INaL
 izYAZhfI09Zbh4G58oNsKOVY5DCQdTUdxKklyRN/Ekz/Mm2jbdu7KXXp7icnGFvIAtSz
 tQ5MRam/EaszhDRneMx+3yMfWBdEifUeK9mx/aNHp2Ra6zAHBYrpJICMXvxRZFYBfqZY
 dY89qntfTp2xxdxo3gXqJgHRU30ePvJFnwzHIWOrgqRQivLMmYAgODJIzAKrFiwfUBsh
 kci6BioWuvVarDmcEq/r3bGgiKc3D5zm6ar3/EjF+UEaHuUSI4Io2iWJZKh/v5POMWsh
 Og8g==
X-Gm-Message-State: AOAM5318hBkAUCwwemUsik3AhWRdYxjeEb8ytFvUggz1sEQvH2BNJLTi
 Yv+490qOdoab9c5od+ThrrppM57KXE4WS6/GLtWeYdtMgMbm+fpS73SxbMvO+YBYo7GmM1/VkQ1
 5oUbVQoEEBag6G1I=
X-Received: by 2002:adf:c986:: with SMTP id f6mr26434701wrh.168.1595957909526; 
 Tue, 28 Jul 2020 10:38:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzSvQHTtdiuf/zc+9f7JrZtjl5FHttTRj/ChqU8+YUN44nXvdKli3iaVa5pPkDKcbjIY5zqw==
X-Received: by 2002:adf:c986:: with SMTP id f6mr26434689wrh.168.1595957909252; 
 Tue, 28 Jul 2020 10:38:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:80b0:f446:bb61:1dbb?
 ([2001:b07:6468:f312:80b0:f446:bb61:1dbb])
 by smtp.gmail.com with ESMTPSA id l81sm5501687wmf.4.2020.07.28.10.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jul 2020 10:38:28 -0700 (PDT)
Subject: Re: sysbus_create_simple Vs qdev_create
To: Markus Armbruster <armbru@redhat.com>
References: <CA+aXn+EkkyiXmKpNhbggy0pjKVpiHxa+TUqEnZLB4v_D=T+7tA@mail.gmail.com>
 <CA+aXn+HHXAmT6Ljj2tpovGAYSurHKSdtUL3y-89t31B0e7jpsA@mail.gmail.com>
 <adb25c78-2edc-115a-5264-ca9f97864ec7@redhat.com>
 <87365t18mp.fsf@dusky.pond.sub.org>
 <CA+aXn+Guvt34PDD=N3FsD5w1C-aDXZ7gS8H_AZN-JEM8j8wBiQ@mail.gmail.com>
 <87lfjkvo81.fsf@dusky.pond.sub.org> <20200716222130.GO1274972@habkost.net>
 <87tuy6k9pa.fsf@dusky.pond.sub.org> <20200717162312.GR1274972@habkost.net>
 <87r1t6hc0f.fsf@dusky.pond.sub.org> <20200720155955.GV1274972@habkost.net>
 <87v9ihbe6u.fsf@dusky.pond.sub.org>
 <50e31ece-215c-a632-e5a2-86ae7ab3abab@redhat.com>
 <87lfj4f6nz.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <759959d1-f320-734a-ac5e-a60db6b1bc23@redhat.com>
Date: Tue, 28 Jul 2020 19:38:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <87lfj4f6nz.fsf@dusky.pond.sub.org>
Content-Language: en-US
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 11:04:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Pratik Parvati <pratikp@vayavyalabs.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/07/20 09:19, Markus Armbruster wrote:
>> the composition tree generally mirrors things that are born and die
>> at the same time, and creating children is generally reserved to the
>> object itself.
>
> Yes.  Notable exceptions: containers /machine/peripheral,
> /machine/peripheral-anon, /machine/unattached.

And /objects too.  Apart from /machine/unattached, all these dynamic
objects are created by the monitor or the command line.

>>                 Children are usually embedded directly in a struct, for
>> example.
> 
> We sometimes use object_new() + object_property_add_child() instead.
> Extra indirection.  I guess we'd be better off without the extra
> indirection most of the time.  Implementation detail.
> 
> We sometimes use object_new() without object_property_add_child(), and
> have qdev_realize() put the device in the /machine/unattached orphanage.
> Meh.  I guess the orphanage feature exists to make conversion to QOM
> slightly easier.  Could we ban its use for new boards at least?

Banning perhaps is too strong, but yes /machine/unattached is an
anti-pattern.

>> 3) accessing the QOM graph is slow (it requires hash table lookups,
>> string comparisons and all that), so the pointers that cache the
>> parent-child links are needed for use in hot paths.
> 
> True, but only because QOM's design opts for generality, efficiency be
> damned :)

Remember that QOM's essential feature is the visitors: unlike GObject,
QOM is not targeted at programming languages but rather at CLI and RPC.

> I never quite understood why we need to build properties at run time.

I think it was (for once) Anthony reasoning that good is better than
perfect.  You do need run-time properties for /machine/unattached,
/machine/peripheral, etc., so he decided to only have run-time
properties.  Introspection wasn't considered a primary design goal.

Also, even though child properties are quite often the same for all
objects after initialization (and possibly realization) is complete,
this does not cover in two cases:

1) before the corresponding objects are created---so static child
properties would only be possible if creation of all children is moved
to instance_init, which is guaranteed not to fail.

2) there are cases in which a property (e.g. an int) governs how many of
those children exist, so you cannot create all children in instance_init.

Paolo

> It's makes reasoning about properties harder, and introspection brittle.


