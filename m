Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20082C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 15:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E172020FC3
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 15:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4Lat0HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E172020FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpCVp-0001MS-5I
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 11:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpCV4-0000us-Bl
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 11:12:14 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35846)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpCV1-0005Y5-A6
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 11:12:14 -0400
Received: by mail-ot1-x341.google.com with SMTP id 72so11416208otc.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 08:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BnJgSSvXqjRD52qqNdzP3gVIPFCs4p8DWsVlNqAwAgY=;
 b=u4Lat0HL6uanlv132h90NsXr5IeXtKV4ENSy/AmJgSquyNqxvZ2dItppaS0XHIQ1Ty
 SK1pKrhfrEW7EaCZKyIy7oJK0KJY90KmU8ppAkBFX83RXHE8076BRMiUkhgVMTN+EaWG
 /rN62M/6/HZs69t/RsTuVFLNs5VcuFmZHozqBtGZWdOGpLpWPoIcIwtsOmT9TMjHLs5I
 bdtvN3lQmOrJS6+6qtQGMTcStngr5i91d9M6fz10euf7ybtiDLXuQFBjLMzpc6Fcb01z
 op8kQOUEGzSbivviYGRxfWywkXqI5cOwkU9PaxcPKwIWAFSe4GVKzs/Lyp1y4Q/Jxk4H
 qrxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BnJgSSvXqjRD52qqNdzP3gVIPFCs4p8DWsVlNqAwAgY=;
 b=R/l1P8YBtkghv7rA+4w7TqI7oUEY1eUHv5kPboaP9PGFoH+tl2EFeCNKIbH4jfOnEf
 BzWHZW8M8oedNSwiKYKoJgWfHWvy6fRnz2rSKW23UJthXqrwQzqLJ21+8BxZK8jrLi9l
 egqqASZyuKvyohmjwM1OWa22HVNlCU+KF9SUsnfKaW7PBDcIdLZk10mUk3lihfequ+mZ
 tEr+i350UJV6k/NS3/dFIC6/Fxc11Ha0wKLVlzfguDiluIYc+My0JYIiSj4jHtzzzxFe
 c3gFzP0arKqCjEAm9cjuOb4f//fBHT9/6PVmmwQIw6f4yRVoBSDiRO8yO4PfQoITo5L3
 RSiQ==
X-Gm-Message-State: AOAM532bpfFbQHmWocKNGC4K2BAIBNp+OiWyxhKUWWxCA9wN7PilVj8G
 rej75jNSdX8RLGJxMZOe2dJFqdqGMM0o7V28m/tUmQ==
X-Google-Smtp-Source: ABdhPJxnATuUA0sUVZCxsKWt9Z884um9GDOsRY5g/rPqSAmszprL4Eu3HsEkal/X/g8FXZV7h5O8W/gVH59uMdFZprs=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr1368581otk.221.1593270729901; 
 Sat, 27 Jun 2020 08:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200615204008.3069956-1-armbru@redhat.com>
 <CAFEAcA_EnwYq4je-_OQz22zpxeqcSjaZnP7ieN-CyHC3pJp2Zw@mail.gmail.com>
 <87o8p4rahe.fsf@dusky.pond.sub.org>
In-Reply-To: <87o8p4rahe.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 27 Jun 2020 16:11:58 +0100
Message-ID: <CAFEAcA_fV4nf8paMXvfo-b+73oZTcEQHtyXV1u2gc9qbrEYc6g@mail.gmail.com>
Subject: Re: [PULL 00/84] QOM patches for 2020-06-15
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 27 Jun 2020 at 12:53, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
> > Hi. I've just noticed that this commit added new global-scope
> > functions to header files without documentation comments, eg
> >
> > bool qdev_realize_and_unref(DeviceState *dev, BusState *bus, Error **errp);
>
> They actually have doc comments: next to their definition, just like the
> functions they replace.

> > Please could you provide some follow-up patches that document them?
> > I don't think we have any hope of getting people to follow whatever
> > the correct new way to create/configure/realize devices is if we
> > don't document it :-(   [Concrete example: I now have no idea
> > how this is supposed to work after this patchset.]
>
> Please check out my function comments, and if they leave you confused,
> let's talk about improvements.

I will have a look at them, but we should move them (wholesale
with other documentation comments for qdev) to the header files.
(That we are having this discussion at all demonstrates why -- people
don't look in the C files for API documentation of functions.)
The headers are where the API that faces the rest of QEMU should
be documented; comments in the C files are for people who care
about the internals of the implementation. "New prototype in a header
file should have a doc comment" is a standard part of my code review
I apply to any code which I see going past. We absolutely have not
been good about documenting our facing-the-rest-of-QEMU functions
in the past but this is an area where I think we should be raising the bar.

> I'm content to use comment placement / formatting I dislike to make my
> code blend in, but I'm not willing to do conversion work from a style I
> like to style I dislike.  That's a job for someone who won't feel icky
> afterwards :)

Fair enough. I'm happy to write some patches to consistently put
all the qdev doc info into the headers.

thanks
-- PMM

