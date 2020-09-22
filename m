Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D404C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:22:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D183823A1B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZwsDC8KA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D183823A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKk7T-0001wA-LJ
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 11:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34384)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKk4W-0000W5-7v
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:19:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1kKk4S-0006RI-4W
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 11:19:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600787947;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zXtscukOwOmjPH4Xy7QZd71M2/sjsRa1tGsrrcriAsU=;
 b=ZwsDC8KAe1Tsgb/DZa4WI9dRhBNw0qqE13KEhL/dhhRR6BXtJF4hX34MZcqvpNiZSiFYMS
 jlkLZsIwACRtpfEN55Sfm6VGPjMNKYL5YOoVxM/IGl4CNrHpqF+In5mAEcWtivZzSlZoMw
 dcwLEyl33v2atQhFGh08/lDEwo0+Spg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-phA1qHkHMSiJf4gRbewWBg-1; Tue, 22 Sep 2020 11:19:05 -0400
X-MC-Unique: phA1qHkHMSiJf4gRbewWBg-1
Received: by mail-wr1-f70.google.com with SMTP id a12so7549836wrg.13
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 08:19:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=zXtscukOwOmjPH4Xy7QZd71M2/sjsRa1tGsrrcriAsU=;
 b=iEVlpAI1uCGcHqkwR3NosF5bNdusgEbgpxjwtaXOepsb6xGOGXPKw8sSNo0Oz4ZAL2
 gq4UtYUBBb+3XOs8pn/nLNDM/teKk5MsBShwdpHUrWuO+zSbF9UhPRP8VsSKnwPyVWGT
 QVXQzrqWvcbHoRbUbFUvO6Yl0PNS7HF2/4AbZtxj6ZOgUXnZzSMBig/f2NxjV0oHMiw+
 b36vj8Qzela5e5AyOkzagrFV/vEvia7fxpzhm1pZ2o2mFQ673OFJqZe0n89hUygAPs9r
 llrfKJvq+7HI2UoFEF6Nq791BuAffdS4q+itiu6GQWrieO2HeV/Ew/ruFVxqpZAaIhqg
 9iRQ==
X-Gm-Message-State: AOAM533+fKiEmLjSdBQY1x1PUYdFdI7gQB7C8txiUwSxBk3nSQgAYpOq
 wJKJgOmoRhrgFqQZe0b2dC8/B69t1sRR0DPmkrt/j3ytk31EVkUTkvBAiQGe2MTRVGUKYKK5SOR
 BEvig2tQirOvjPFM=
X-Received: by 2002:a05:6000:109:: with SMTP id
 o9mr5442927wrx.364.1600787944573; 
 Tue, 22 Sep 2020 08:19:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0f1dlcgHKa+LQZTQtendx5FNO8z+s5uzsNIWh442mN5q+GPW/oWlgC1En0f098CuhxShr4Q==
X-Received: by 2002:a05:6000:109:: with SMTP id
 o9mr5442910wrx.364.1600787944369; 
 Tue, 22 Sep 2020 08:19:04 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id n10sm5389452wmk.7.2020.09.22.08.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 08:19:03 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Antoine Damhet <antoine.damhet@blade-group.com>
Subject: Re: [PATCH] target/i386: always create kvmclock device
In-Reply-To: <20200918152656.GN2816@work-vm>
References: <20200917111306.819263-1-vkuznets@redhat.com>
 <20200917122559.e7i5o64k7rw7urdh@tartarus>
 <87ft7gh6gy.fsf@vitty.brq.redhat.com> <20200917144237.GK2793@work-vm>
 <875z8ch2m6.fsf@vitty.brq.redhat.com> <20200917174410.GU2793@work-vm>
 <20200918151213.x2dntgytybh7dkmx@tartarus> <20200918152656.GN2816@work-vm>
Date: Tue, 22 Sep 2020 17:19:02 +0200
Message-ID: <87y2l1et5l.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert" <dgilbert@redhat.com> writes:

> * Antoine Damhet (antoine.damhet@blade-group.com) wrote:
>> On Thu, Sep 17, 2020 at 06:44:10PM +0100, Dr. David Alan Gilbert wrote:
>> 
>> [...]
>> 
>> > > >> >
>> > > >> > Shouldn't the old check used when machine type <= 5.1 in order to avoid
>> > > >> > migration incompatibility ?
>> > > >> 
>> > > >> Hm, when the check fails we just don't create the device and no error is
>> > > >> reported, so even if we have kvmclock data in the migration stream but
>> > > >> fail to create it migration will still succeed, right? (not a migration
>> > > >> expert here :-)
>> > > >
>> > > > When the migration stream is parsed, it'll try and find a "kvmclock"
>> > > > device to pass the data it's reading to; if one doesn't exist it'll
>> > > > fail.
>> > > 
>> > > This may happen with an older machine type when the destination is
>> > > running an unfixed QEMU and the source has the fix, right?
>> > 
>> > Yes I think so.
>> > 
>> > > The solution
>> > > would be to introduce a flag for older machine types (or for new ones)
>> > > like 'kvmclock_always'.
>> > 
>> > Yep sounds the normal answer.
>> > (You might want to try it first to trigger the bug)
>> 
>> So, I tried the patch and:
>> 
>> # patched -> patched
>> 
>> Everything working as expected
>> 
>> # patched -> unpatched
>> 
>> Migration failure with:
>> 
>> ```
>> Unknown savevm section or instance 'kvmclock' 0. Make sure that your current VM setup matches your saved VM setup, including any hotplugged devices
>> load of migration failed: Invalid argument
>> ```
>
> Right, that's what I expected and said we need to wire this fix to the
> machine type.
>

v2 with the idea implemented is coming. As I'm not a regular contributor
to machine types, please review thoroughly :-)

-- 
Vitaly


