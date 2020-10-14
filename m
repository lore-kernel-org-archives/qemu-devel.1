Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC733C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8A4A206DC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 19:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOEZi25E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8A4A206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSmua-0002YF-Pe
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 15:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1kSmtV-000267-T1
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1kSmtT-0006BL-4h
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 15:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602705421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c/TUuxAAQNkPqrb2OI38OodGrG9rASRQRljANve5f8I=;
 b=GOEZi25EeJBwciYyB5R+ntiLGFp/7b/bSsVRmc4GgIcgRG1UGsuuf1b3tEqv8CbdmkmzXu
 F1TPaw04Be9s5ZhrlGLYTC+m9nOd8vU1G2EcGb7J9HqrDr3hUKTRpbmRjxY8WENZZdJHBR
 feeaYVVMVzm5WkK/q6HR9s3JmJfY2EE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-w8fLRnCMNNGRcLXv_4BFGA-1; Wed, 14 Oct 2020 15:55:40 -0400
X-MC-Unique: w8fLRnCMNNGRcLXv_4BFGA-1
Received: by mail-ej1-f71.google.com with SMTP id gh22so177553ejb.8
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 12:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c/TUuxAAQNkPqrb2OI38OodGrG9rASRQRljANve5f8I=;
 b=A/ftR8SkdKnHe6+8d8Tt6JwktQz4pdiT6LnvCZFJZ2ES4W0fiVZKWUxxjLbpWRZFCa
 kijk3cbIhB8IB9Zt1xHH38PWbDzDWwJ71l+ygnMdUl7xK3Jp6yaWKHtuBe/5I07xUi8x
 gp4hFN4rsRsrnlE/gHyVYBQDZdqEaWDYtcp3NqPOuoIiBQkj1Jfl4Q5o5AYVZXB7m2JQ
 /++gTIDCaZFfTc1a9yPJlFUPum/i/4j4h+MgDGEx7njUjKuK5g7Fuhi8ANqKXqsZGLrE
 7S74xwVFl3jIqJD+Iyt/tWDMruawyQKcdiQNuwrGpVvfzg3ydz1WQQXEeN980/1KK/yB
 w0sw==
X-Gm-Message-State: AOAM532K1k92N4bBf2hTp52i+pDDv6+xQVZvyGy+62+UkQ4nBP/Ry14G
 A+rhwSFE8uzg871jELamrYlmcOqg+5OEYR5oW1XSJpt4fXhGVF0p6d1WuMyvh3+deNnknWF/0dg
 etSPKvEBMIhCgqF73kOa+idzSQ+Xk6Wc=
X-Received: by 2002:a50:f389:: with SMTP id g9mr620497edm.367.1602705339501;
 Wed, 14 Oct 2020 12:55:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy/+/qoIpX2IdI+sJmR9jjBpagGBU5PdVO0x3EK9KzMazoBxF/K8BP2fNu8J80zXqn2NBw4R9aDUZGFdN0uTKw=
X-Received: by 2002:a50:f389:: with SMTP id g9mr620470edm.367.1602705339250;
 Wed, 14 Oct 2020 12:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <20201012150356.79670-1-mcascell@redhat.com>
 <CADBGO7-w7txnd6MHAY0ge3k3LRcn0FfGDU9znQU7qxQddJQT0A@mail.gmail.com>
 <20201013070423.ahsq7dvpwcsl6ouj@sirius.home.kraxel.org>
 <CADBGO7-BuSh04JctYpQkHoG02cANfet6Zy2fAHVx0gq0cL96jQ@mail.gmail.com>
 <20201013084123.6eihr74ckoburszw@sirius.home.kraxel.org>
In-Reply-To: <20201013084123.6eihr74ckoburszw@sirius.home.kraxel.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Wed, 14 Oct 2020 21:55:28 +0200
Message-ID: <CAA8xKjX_o5QmXbvjbYkBP8gmO4EOMbESSzWpeAwz9-e1eKmYEg@mail.gmail.com>
Subject: Re: [PATCH] hw/usb/hcd-dwc2: fix divide-by-zero in
 dwc2_handle_packet()
To: Gerd Hoffmann <kraxel@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mcascell@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: gaoning.pgn@antgroup.com, linyi.lxw@antfin.com,
 QEMU Developers <qemu-devel@nongnu.org>, Paul Zimmerman <pauldzim@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 13, 2020 at 10:41 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Tue, Oct 13, 2020 at 12:19:40AM -0700, Paul Zimmerman wrote:
> > I sent you a patch to fix up several assert()s, including that one, about a
> > month ago. Did you miss it?
> > https://lore.kernel.org/qemu-devel/20200920021449.830-1-pauldzim@gmail.com
>
> I'll check.  There is a bunch of pending stuff in my qemu-patches
> mailbox I'll try to process this week ...
>
> > > Also: What would be the effect of simply returning here? Would dwc2
> > > emulation simply stop processing queues? Should we maybe raise an
> > > error IRQ?
> >
> > Not entirely sure, I imagine the emulation will just stop working. I can
> > test it tomorrow. Also, can you give me a hint what an error IRQ is?
> > Is that a Qemu thing, or do you mean we should emulate what the
> > real core does in this case?
>
> Same real hardware does.  ehci for example has the USBSTS_ERRINT bit in
> the IRQ status register to signal errors.
>
> take care,
>   Gerd
>

I'll send a new version of the patch with the check moved earlier in
the function, as suggested by Paul. If raising an error turns out to
be the right thing to do, I think other checks may need to be updated
in addition to this one. Hence we can possibly address that in a later
patch. Thanks a lot for your comments.

-- 
Mauro Matteo Cascella, Red Hat Product Security
6F78 E20B 5935 928C F0A8  1A9D 4E55 23B8 BB34 10B0


