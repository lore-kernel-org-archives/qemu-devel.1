Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2ACC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 026B52395B
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 11:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bY2NxFit"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 026B52395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLPRi-0003zj-1a
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 07:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLPMf-0004ys-U2
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:24:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kLPMc-0004Zu-RQ
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 07:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600946656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxvYg4JBi3OvNwDG4G2He+yTF8ikdg0m4iwNK9jrAIA=;
 b=bY2NxFitq0cxhhYU/anVRLsLZ0vxck89Ty7q2MEkXDjSUrDcQ1WC0gVCo/3ScqBxCkwGfU
 LbQh4qS4qXfF3tQgYb7PohmASdFqbkRUVg6QNbYpgVdk9El8jxRn9zb5fEvgRrPcl9IUyS
 IOlV+j68brqLJ9sEnz5eqdSffOJRfG8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-FCzlbRz5PYOZtg2YULR6zw-1; Thu, 24 Sep 2020 07:24:14 -0400
X-MC-Unique: FCzlbRz5PYOZtg2YULR6zw-1
Received: by mail-wr1-f72.google.com with SMTP id a2so1104243wrp.8
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 04:24:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zxvYg4JBi3OvNwDG4G2He+yTF8ikdg0m4iwNK9jrAIA=;
 b=FPWiBTwxwoB5+dHuXXQ6gBKKCc28E8qLbNp3FIC2eytlujVhovmNbiiT2Cf4jpWwn9
 zVceo9hwx79pZRSPhyjQ9XOJjhorb4ZKd3gFayLKvVG2CF1Ku/lQ3O0Otlga5NtIYG/s
 EEnff5sc9bT/yDweAC1V3jTSsVQBBeiW9JN7nl7Q1/cGy5kGORvLsVEhdNZbIcv0BpHP
 EKqhw3wnaD1I0/CH6kRq4j58AF20UsYW4PGvJ5pFkoi4IMygKE5PJpDIQBtSK3TrrEsR
 92Fc5yNL20dPL9HfFAuRFQO59PP8Nuhh/Dgw1y31WkHQoicNLptyuajye47yxwuqYlIZ
 Pc1Q==
X-Gm-Message-State: AOAM530BNlDEMmO3NfLVXY2uGYRPEXofIQCZ/xXa8ScEQdAam/FQjZeL
 Mz8RQdSVKpqpw5mI2hCAw/NRDQj0q4flNH9+ehVgANA2Z0DGadxE1trr20NXOPVLGHQ2vOCdj/4
 16DdleNKVVoI5hVU=
X-Received: by 2002:a05:600c:2742:: with SMTP id
 2mr4131415wmw.136.1600946652944; 
 Thu, 24 Sep 2020 04:24:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvbFGCNGrYM9uggDZf0WJbATcA6tBQFuuFr6jssjygsxxOOhlCSiK843zhV/gTiu8tJWIy+g==
X-Received: by 2002:a05:600c:2742:: with SMTP id
 2mr4131401wmw.136.1600946652756; 
 Thu, 24 Sep 2020 04:24:12 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id d2sm3292097wro.34.2020.09.24.04.24.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2020 04:24:11 -0700 (PDT)
Date: Thu, 24 Sep 2020 07:24:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PULL v3 00/15] virtio,pc,acpi: fixes, tests
Message-ID: <20200924072329-mutt-send-email-mst@kernel.org>
References: <20200921112913.555392-1-mst@redhat.com>
 <CAKXe6SLYL0DDWTbPEwa7y47BOpagg8HkUf+nfgzz_3Or_ebUqQ@mail.gmail.com>
 <20200921083052-mutt-send-email-mst@kernel.org>
 <20200923164029-mutt-send-email-mst@kernel.org>
 <CAFEAcA8WSbvG9Cgp6J4fqp4AX-rCR2F3vjPsAVegv3axAFUiMA@mail.gmail.com>
 <CAFEAcA_EyDoO0nA39wrc9ERn=hQ08TWoMVHf1H1Lc2QMAfUjkw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_EyDoO0nA39wrc9ERn=hQ08TWoMVHf1H1Lc2QMAfUjkw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 24, 2020 at 11:51:47AM +0100, Peter Maydell wrote:
> On Thu, 24 Sep 2020 at 11:43, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Wed, 23 Sep 2020 at 21:41, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > Peter, you said you see issues on some systems.
> > > I pushed a tag:
> > >     git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream_test
> > > which drops some patches I suspect.
> > > If that helps, pls let me know.
> >
> > Yes, the original tag seems to just cause 'make check' to stall
> > out (the logfiles simply stop) for OSX, NetBSD, OpenBSD and
> > s390x. I'll try your test tag...
> 
> ...if the test tag works do you want me to merge it?
> 
> thanks
> -- PMM

I dropped the last patch which was mis-squashed from there and repushed.
Not a big deal so either merge that one or this one ...

-- 
MST


