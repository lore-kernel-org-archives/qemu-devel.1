Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E9FC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 836512054F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 15:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6gtv4em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 836512054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYWc0-0000Xr-Im
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 11:14:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34672)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jYWPS-0003ZN-RG
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:01:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jYWPQ-0000wS-1m
 for qemu-devel@nongnu.org; Tue, 12 May 2020 11:01:30 -0400
Received: by mail-wr1-x443.google.com with SMTP id l11so9925444wru.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 08:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=p77Kw6QPNjd4l2su+e66QlsudY4rA5fiCsKH3y4FKuQ=;
 b=l6gtv4em12gLB53J6AyNKtIFUGYufEJcLbXGMBms7Pp9uBZ5Bj0wLNVZ1QouHODnQz
 AHd9cUyRXBYd95Q0wtwOjcoJrsUM+EA4D0Egw2GRz0LAFI7FBfHCx4rJVYGcgjYzEO6l
 TEvgBWvKFLSEv2Ql0tGtduTFVyzNrQG/fEvFnrpSmZ574mBcGNe8Ukj0dj9451xuPwcL
 RauR4tDgNXHMIKPzf33l1E3T2YUBrB97rWOxoCqTqQEwQfWVSD6iBLNQJaiHXDH/z0Kc
 Kju5HrJ2oYMqunuGZIFVEusArou9OWTpDsgFS79oNMvVsmnuSlBZHve6cC228Bn4MmyA
 lKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=p77Kw6QPNjd4l2su+e66QlsudY4rA5fiCsKH3y4FKuQ=;
 b=DUCcdftnG/DT4r+8847W1RUpWakoVsKGw7ZWg77tTk065aVxSDNhUj4BEAsd7I0sOs
 qztwyiysBBlfwvBe2SSDN1BMviDzET/CpdJP6PAbWjjkBBIvvOm2/qAOj/hfUDEQZRkC
 MwJkPfJ56eigoZ6E0DpQMFAr5zTZn9w+WIJdZvnc0jygZFxC3yZcmEZbQDPty0IPRNbf
 wV405HpHfv4QBCaFMnuEPUDF3llCOuGkGqRwLyDonzOsOpY52LFpbt3XpksvqUMNX3XP
 v+F/f9QiGGSqLW+YWcSv99CyFp4Q1vP+AdbzSLavvkdwk6Fj0ZvjGacsiCQXLHEz46JG
 +ctg==
X-Gm-Message-State: AGi0Puaiq9hPzHPur+7OGxNtLH3R3+6StBwd78ySp1swc3wSV4k3WD9I
 0qPjTI51urEjw6HPrWM38KA=
X-Google-Smtp-Source: APiQypLNzbdZQdw7mXAzOWseqxc0BZZ1fekG/XrwBqPlbUac4ojNWjfMdxETIh8y86LIbyvguug4Sg==
X-Received: by 2002:adf:e9d2:: with SMTP id l18mr25536257wrn.34.1589295685972; 
 Tue, 12 May 2020 08:01:25 -0700 (PDT)
Received: from jondnuc (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id 32sm23552189wrg.19.2020.05.12.08.01.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2020 08:01:25 -0700 (PDT)
Date: Tue, 12 May 2020 18:01:23 +0300
From: Jon Doron <arilou@gmail.com>
To: Roman Kagan <rvkagan@yandex-team.ru>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 QEMU <qemu-devel@nongnu.org>,
 Evgeny Yakovlev <eyakovlev@virtuozzo.com>, ehabkost@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Liran Alon <liran.alon@oracle.com>
Subject: Re: [PATCH v1 5/5] i386: Hyper-V VMBus ACPI DSDT entry
Message-ID: <20200512150123.GI2862@jondnuc>
References: <9b9c42d3-af9e-25e9-210e-c58ee5975941@maciej.szmigiero.name>
 <472544e7-498a-4e28-06e9-83c102d6436b@maciej.szmigiero.name>
 <20200406073246.GA7707@rvkaganb>
 <CAP7QCojPsOYjw94k3rkH0A3rLFADLeVhgy502N=8X5wrUnoC6Q@mail.gmail.com>
 <20200407185608.GA178651@rvkaganb>
 <8c278ea8-81c5-7458-8979-c319470440d7@maciej.szmigiero.name>
 <20200408041639.GA7606@jondnuc> <20200408204742.GA709224@rvkaganb>
 <20200409033518.GC7606@jondnuc>
 <20200512140542.GA9944@rvkaganb.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200512140542.GA9944@rvkaganb.lan>
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=arilou@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/05/2020, Roman Kagan wrote:
>On Thu, Apr 09, 2020 at 06:35:18AM +0300, Jon Doron wrote:
>> On 08/04/2020, Roman Kagan wrote:
>> > On Wed, Apr 08, 2020 at 07:16:39AM +0300, Jon Doron wrote:
>> > > Well I have implemented the hyperv synthetic kernel debugger interface, but
>> > > on Windows 10 it requires to have a working VMBus (it's not really using it,
>> > > but without a function vmbus that will answer to the initiate contact then
>> > > the kdnet will simply be stuck in a loop.
>
>I tried to google for this interface but the only thing I managed to
>find was this
>
>https://withinrafael.com/2015/02/01/how-to-set-up-synthetic-kernel-debugging-for-hyper-v-virtual-machines/
>
>Is this what you're trying to implement?  Are there any more
>authoritative descriptions of the feature?
>
>The document doesn't quite explain the inner workings of the feature,
>but it looks like the regular network debugging interface, except that
>IP is forwarded by the hypervisor app, so that the debugger has to
>connect to the host and avoid setting up full-fledged network
>connectivity to the guest.  That would be essentially hv-net + slirp.
>OTOH you say it doesn't use VMBus so I'm confused...
>
>Thanks,
>Roman.
>
>> > > In addition to that Michael Kelley from Microsoft has informed us that
>> > > Microsoft might be dropped the synthetic kernel debugger interface sometime
>> > > in the future, and it seems like the new mode is simply to use hvnet device
>> > > for the communication (which is again much faster).

Yes that's indeed the interface I have implemented this part of the 
patch it not full ready for commit, but I think we can keep going with 
the VMBUS.

Based on your previous reply it sounds like there is not a real issue 
with the current patch of ACPI DSDT entry, right?

Thanks,
-- Jon.

