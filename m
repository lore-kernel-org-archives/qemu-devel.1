Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1FC9C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC31022201
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQv3u8TO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC31022201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kShal-000686-Av
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:17:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kShZi-0005SU-97; Wed, 14 Oct 2020 10:16:18 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:44589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eafanasova@gmail.com>)
 id 1kShZg-0003fs-LF; Wed, 14 Oct 2020 10:16:18 -0400
Received: by mail-lf1-x141.google.com with SMTP id b1so3843296lfp.11;
 Wed, 14 Oct 2020 07:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=4rulUlLsOSz2rOq4EcyDa/eVfnIpoV3tqv12AO/FRDc=;
 b=DQv3u8TOi488lqXd0WHpYsrP9zxd9chVqP533oX3M2IOdZuxlE4EwwkVtSN9XTwDIv
 gnk21nAL9yNfHlOH7sseOssi3kBXYBZ1RN8CdYW5qV5rWpNhBxaJX+kqP1y4v4MaE6Ha
 VRnEPUInOI6XlAeeRZtUWj10qpg0X4oq2ivMh7Y0zlv9BFrWahFMmLuHAjiDi+UW7L7T
 YutvlDTMeDaBdG4cuIYtBGxtjLdR6PED19XZs/taw7/x0H6s3ixJiLIshYezY1UnpvkX
 4SvD5LrvoA2F+d28o4u1ZN+5FzcqqYHPbOi5UjJwCOp9gknYLus1zhKvA0TiKpQg8X4S
 SNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=4rulUlLsOSz2rOq4EcyDa/eVfnIpoV3tqv12AO/FRDc=;
 b=Ahks95Mxt1yA/cGLuKN8lASTyN65iDVJ37DVpNB3ZW6OmdADeHIyFVmgCi5aMIYRle
 2Yz6dGD8xr0y9+R/kAbmkTFFaIcWVpLz9/FKyoD2dAGZ7l5/nF9FVhkMbhjmWakMB4e2
 5vuiAsIuQtb+iyRtHcUNZSyRmKFxEroSDm1nURXSGnipt9p0m2WSI1UFw+NtYplaLtCv
 xCz8s+ctL5uBcwryyFWpAVBTQI3wLMIZTFf/KxxWBuUhWtDLgrGzz22nXpo89XTm7tWq
 tt8mRBX/MnOxUF3+iEU719FeTPnJYeDKzh9/ku3vQq+4BMgnhj1FCH1foNitju7cFXeg
 pXBg==
X-Gm-Message-State: AOAM531Z9PGSG0Xcqnj+ye/X5oWCbFs/uPXEuf8JP08zspLkTUR5UWk7
 4QbG80CXbC6qkWpNBKz059g=
X-Google-Smtp-Source: ABdhPJzLzJy3Y347nwBsIwELBLhY5PkWIY0cfq825D3VfQJ0LE5lusVObOJx24kpZgIXyfKk0mRKVw==
X-Received: by 2002:a19:8546:: with SMTP id h67mr1429921lfd.26.1602684973433; 
 Wed, 14 Oct 2020 07:16:13 -0700 (PDT)
Received: from [192.168.167.128] (37-145-186-126.broadband.corbina.ru.
 [37.145.186.126])
 by smtp.gmail.com with ESMTPSA id q8sm1259613ljg.105.2020.10.14.07.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 07:16:12 -0700 (PDT)
Message-ID: <96fa5d23ca57363e063b9b5006ad8f71e6b1b307.camel@gmail.com>
Subject: Re: [PATCH] hw/net: move allocation to the heap due to very large
 stack frame
From: Elena Afanasova <eafanasova@gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini
 <pbonzini@redhat.com>
Date: Wed, 14 Oct 2020 07:15:47 -0700
In-Reply-To: <20201013053250.GV71119@yekko.fritz.box>
References: <8f07132478469b35fb50a4706691e2b56b10a67b.camel@gmail.com>
 <20201010060745.GK1025389@yekko.fritz.box>
 <f505c80b88ee665a62883a69bed9d614f6ba2a66.camel@gmail.com>
 <20201012053001.GD4787@yekko.fritz.box>
 <38d5993e-8a10-0fb1-5263-6531a356fefd@redhat.com>
 <ca54ec71-11b4-70c5-6d48-4e58fb90a545@redhat.com>
 <20201013053250.GV71119@yekko.fritz.box>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=eafanasova@gmail.com; helo=mail-lf1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, jasowang@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2020-10-13 at 16:32 +1100, David Gibson wrote:
> On Mon, Oct 12, 2020 at 03:45:02PM +0200, Paolo Bonzini wrote:
> > On 12/10/20 12:44, Thomas Huth wrote:
> > > I think this is one of the tasks from:
> > > 
> > >  
> > > https://wiki.qemu.org/Contribute/BiteSizedTasks#Compiler-driven_cleanups
> > > 
> > > It has been added by Paolo in 2016:
> > > 
> > >  
> > > https://wiki.qemu.org/index.php?title=Contribute/BiteSizedTasks&diff=5368&oldid=5367
> > > 
> > > ... so maybe Paolo can comment on the size that has been chosen
> > > here...?
> > 
> > I used 16K, mostly because it is a nice round number.  8k is too
> > small
> > due to PATH_MAX-sized variables.  16k seemed to be plenty and
> > triggered
> > in few-enough places that the cleanup is viable.
> 
> Ok.  Why are large stack frames bad in qemu?
> 

I think that the main issue here is alloca() because it can lead to UB.


