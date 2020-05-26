Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFAC8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:55:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78EB720787
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W/ugcPB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78EB720787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUQc-0002Dr-OH
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:55:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44824)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdUQ1-0001oe-Bw
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:54:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27562
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jdUQ0-0002IU-IL
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590479675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P+7j/bsYLRsXcurjUbxakgQbRwUQ4G6U+efg1QBAnvs=;
 b=W/ugcPB4uiU5Vgh28+EheP5T7lIvUvIvytEHtSelTHokIdb0c0i44WFAMrdyEpYe0OvbVW
 D2lWE0QvnR+CE6cW2Hq1QUdialmQMaw0toI6FvKvs/QVhrPvqxBOlaSnMsAIbQHfYajm0O
 /Zm0Rzsl/ymYk9V3q4J82ps6sTnZB/E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-2majIVAwMrCUtyzQgAuiVA-1; Tue, 26 May 2020 03:54:33 -0400
X-MC-Unique: 2majIVAwMrCUtyzQgAuiVA-1
Received: by mail-ed1-f72.google.com with SMTP id i93so4524368edi.4
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 00:54:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P+7j/bsYLRsXcurjUbxakgQbRwUQ4G6U+efg1QBAnvs=;
 b=is5mYUTDv2c9CWDmSR88ADZgDN+Tmy48Ii777HM8Gbfz0yvkQ+/ladwofO9STU22xo
 T2J0NcjGZjduohtmG/kHL07HZXl9lT2kyO2n2O/IIOH+8NpR9hBWiRX7anX47pN7WjeQ
 YuOwsLS/DdL5yx//O4GetFHVq4Xk1nEigjsgV8kEALmtUKqIWATEpld0vVq/NLwb0Wcp
 odRdaWWTaITVWknwHAB4sHmYzQ7vl6/+miIAWgMxiL5SawomrusEXnGtrB2ArLHbvUrP
 8S03ZwHGJjdVMcxE7FXGeC14g70UFvqA9XHSTwEi9MHIX2etOaj1loB8TcyxKPAchaQa
 vIKQ==
X-Gm-Message-State: AOAM531M7MxGweaiWys/uLgDiIq5DkVODJfjjgjKXcaGNk9HTsMg/B0z
 poCMBjFscr9v26cUbKt9EwR+E+2wn19v5WQ69Q9HaVdi0/Os0yHwOAzhu3tliXxnqaqSyoBcKiE
 4zrFGHFrM57/y+Zo=
X-Received: by 2002:a17:906:350c:: with SMTP id
 r12mr45352eja.516.1590479672045; 
 Tue, 26 May 2020 00:54:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfZYChgjWAxu7ju4enEBhACB05huLgrOSsuOoARLlaPl8smF+GEp4ZoCnii84WV4KRmHHocA==
X-Received: by 2002:a17:906:350c:: with SMTP id
 r12mr45338eja.516.1590479671823; 
 Tue, 26 May 2020 00:54:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8?
 ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
 by smtp.gmail.com with ESMTPSA id q16sm16789021eju.73.2020.05.26.00.54.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 00:54:31 -0700 (PDT)
Subject: Re: [PATCH 51/55] qdev: Make qdev_realize() support bus-less devices
To: Markus Armbruster <armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
 <20200519145551.22836-52-armbru@redhat.com>
 <b0188311-e138-cf55-c0e9-52313b5aa906@redhat.com>
 <87lflmps2w.fsf@dusky.pond.sub.org>
 <1b43c6cb-ac47-1fcb-72b4-e96ae00141b1@redhat.com>
 <87mu5wfrj8.fsf@dusky.pond.sub.org>
 <a3b09578-c164-22a0-8a52-3a4bd5513ef2@redhat.com>
 <87y2pf9t19.fsf@dusky.pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <11771963-13dc-704b-d412-9853c81d7555@redhat.com>
Date: Tue, 26 May 2020 09:54:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87y2pf9t19.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:19:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/05/20 07:14, Markus Armbruster wrote:
>>> The contract must specify exactly what happens to the reference count,
>>> case by case.
>>
>> For both qdev_realize and qdev_realize_and_unref, on return the caller
>> need not care about keeping alive the device in the long-term.
>>
>> For qdev_realize_and_unref, the caller must _also_ have a "private"
>> reference to the object, which will be dropped on return.
>>
>> For qdev_realize, the caller _can_ have a private reference that it has
>> to later drop at a convenient time, but it could also ensure that the
>> device has a long-term reference via object->parent instead.
> 
> I need a contract.  The difficulty of writing a clear contract, caused
> by a case that doesn't actually occur, is what made me limit null bus to
> qdev_realize().  I admittedly didn't try hard.  Next try:
> 
>     /*
>      * Realize @dev and drop a reference.
>      * This is like qdev_realize(), except the caller must hold a
>      * (private) reference, which is dropped on return regardless of
>      * success or failure.  Intended use:
>      *     dev = qdev_new();
>      *     [...]
>      *     qdev_realize_and_unref(dev, bus, errp);
>      * Now @dev can go away without further ado.
>      */

Works for me!

>> Perhaps this tells us that the /machine/unattached automation actually
>> shouldn't be moved to qdev_realize, but rather to
>> qdev_realize_and_unref, and qdev_realize could assert that there is a
>> parent already at the time of the call.  However it is probably too
>> early to make a decision on that.
> 
> The common pairings are qdev_new() with qdev_realize_and_unref(), and
> object_initialize_child() with qdev_realize().  Your idea obviously
> works for these.  Whether there are other uses where it might not work,
> I can't say offhand.

Yes, let's look at it after this is committed.  But I think it is at
least sensible, in the long term, for the *_new variants or their
callers to all take care of adding the child, and then
qdev_realize_and_unref() can go away.

Paolo

Paolo


