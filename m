Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C88DBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:51:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9184C20724
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5y8CPzB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9184C20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnGA-0002q9-QD
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrn8X-0002zM-Va
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:43:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42904
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrn8V-0003yk-KK
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593888218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0PJpX4jH/bGy20P0EXe9TKnieR941CAQOK9+CesVaJI=;
 b=h5y8CPzBpqQpsV1HSJldLP8Y6jaUO36KqfEgeEHVF0J2IbA8OUoTU9MnroZoT9Me63X5Ad
 vrOaKUphNfOo614+8kPrpEf2Uap198ze+hOWprL6VOEoB0h0C/VX1YU6xAHrvTAYj0aO0F
 lBUs+yLnf5wyHFGfHtWSvxi14LeLooY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-ybZKD55HMEqw_ItlWmTI1A-1; Sat, 04 Jul 2020 14:43:37 -0400
X-MC-Unique: ybZKD55HMEqw_ItlWmTI1A-1
Received: by mail-wm1-f72.google.com with SMTP id v24so40263701wmh.3
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0PJpX4jH/bGy20P0EXe9TKnieR941CAQOK9+CesVaJI=;
 b=qd82y0DvQwGN5UPjzbCpcZRaXrM9rG7l6d9vQ2L+oMXQqSvFrL0EPpt4IsXq6LrU4h
 R9OIg2JmMPXayOo0xK3XjqhMCN+HDAoP4hR1Lox8URWASL+iD9GVpZZnKuonWdK3JzPT
 8XRQ86zlJRcGmb1khIgS8WJ9J47PwlvU+BxJ+CmKh4pLIPrS2t7nhLb3QjHYK7LwQIVX
 T9R5wtZuulMgY7MrjBRrcpnvBgC9r4HT29oCKtTMJ6/bp1K2QTGh7W8TOGi389xZlJ0S
 PWmvp5oM5Ve2waE0sRXVxjHicGOP7BqmOT6v0g34Bw+fTjFlYrM677r1EcIfhCN8Um81
 O/BQ==
X-Gm-Message-State: AOAM530ZhmrCxQKW/lQ8Ct1GmU1DV66gqY47kzXRjY2VIOgLUZmsz81W
 Mzbi9A7mb3EtB7EA8/5P81EWh6v7Qgj5ep8FOWg0FCi9MrdxLVWggkjscH5F+GmeICL5pNDf2KL
 vGfNSuysIoumtV+U=
X-Received: by 2002:adf:ed02:: with SMTP id a2mr41172922wro.110.1593888216081; 
 Sat, 04 Jul 2020 11:43:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz2slL7S/h3ZGpf/wt+mPN0ZE2v4S0v8e3BlBgiliKgWtFIMaKr5EJuVqZcz+z5C3THCAkzCA==
X-Received: by 2002:adf:ed02:: with SMTP id a2mr41172907wro.110.1593888215885; 
 Sat, 04 Jul 2020 11:43:35 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 k185sm17320859wmk.47.2020.07.04.11.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:43:35 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:43:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] virt/acpi: set PSCI flag even when psci_conduit is disabled
Message-ID: <20200704144228-mutt-send-email-mst@kernel.org>
References: <1593769409-13534-1-git-send-email-guoheyi@linux.alibaba.com>
 <CAFEAcA8RU6fS8PX7LMhn4U33nKoRvcO_mnyBFcmW3iOpA40sCQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8RU6fS8PX7LMhn4U33nKoRvcO_mnyBFcmW3iOpA40sCQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: yitian.ly@alibaba-inc.com, QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Heyi Guo <guoheyi@linux.alibaba.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 11:37:02AM +0100, Peter Maydell wrote:
> On Fri, 3 Jul 2020 at 10:44, Heyi Guo <guoheyi@linux.alibaba.com> wrote:
> >
> > vms->psci_conduit being disabled only means PSCI is not implemented by
> > qemu; it doesn't mean PSCI is not supported on this virtual machine.
> > Actually vms->psci_conduit is set to disabled when vms->secure and
> > firmware_loaded are both set, which means we will run ARM trusted
> > firmware, which will definitely provide PSCI.
> >
> > The issue can be reproduced when running qemu in TCG mode with secure
> > enabled, while using ARM trusted firmware + qemu virt UEFI as firmware
> > binaries, and we can see secondary cores will not be waken up.
> 
> If you're using a real EL3 guest firmware then it's the job of
> the guest firmware to provide a DTB to the guest EL2/EL1 that says
> "and I support PSCI" if it supports PSCI, surely? QEMU can't tell
> whether the EL3 code does or doesn't do that...
> 
> thanks
> -- PMM

I guess this means qemu needs to find this out from firmware?
Perhaps through fwcfg ...
Don't really know about PSCI specifically, just a general
comment from ACPI POV.

-- 
MST


