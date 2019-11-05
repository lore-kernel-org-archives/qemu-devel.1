Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29316C49EAB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 10:06:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5712190F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 10:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5712190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvjT-0007IK-4S
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 05:06:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlureau@redhat.com>) id 1iRvip-0006lE-3I
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 05:06:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1iRvin-0004AS-40
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 05:05:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51332)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1iRvim-00049u-Q5
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 05:05:57 -0500
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E21B2626
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2019 10:05:54 +0000 (UTC)
Received: by mail-ot1-f72.google.com with SMTP id n5so11818076otq.12
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 02:05:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0F/pA1Hg1YWmzBkDVQqi6SdbeosJrZ+JKxpVvH/qZu4=;
 b=ooL/a5ECZ0HeVR8RfKniFLjv002sUolXWENYY0aea/w3Zww6w/+HNuVBHXblD/1/5M
 Aahfkz2lCbfYe+eiXvW/V8d1bOIpYY/YwYEI3fgG2XEFwBbMjiCjv7HjjfQYvy6tm/XV
 DHs8WKkNHUVXTgeZaa+2+9JZBhVLXEQlffoxrEagG2InOzZAl8OjkQZXKc1ULvpKIhWK
 a9GJ26DIcUBDpBHPZajR/tI7JY204WNV85+EIGlweWvrgmuaEYRw+YjaHfpy81HD/vT2
 BpFZMM3PfcSa/nYuvoHfxVdXkBNlthoxxzmefLTF/f2UIe3+qn13621ZfZlYEhQ7y0fJ
 wzVg==
X-Gm-Message-State: APjAAAUA1VOmunPcJ0dWBm1s8AIekDRsdIhdYVcfMZfVUtzVgr0ZnKz7
 qK5owNa7oMI6zMkg/uXEYNxHemM7ytWXNowjlpzJXrKpgIPzBrMuMJSTcbVxl0AzYkeRIkaAx1D
 5rP7t5ZrdV0/ZBRyGI5jqASqJLw47t3c=
X-Received: by 2002:a9d:5382:: with SMTP id w2mr21028896otg.368.1572948354165; 
 Tue, 05 Nov 2019 02:05:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUXcIpPawhZs6T5lCBfkS6oa7nD4K4lwnuWZ6zZL5gFZ9AskR5Lefbr+4kXZ/V2PwN/uYSSPWupdxkmyMMqt4=
X-Received: by 2002:a9d:5382:: with SMTP id w2mr21028868otg.368.1572948353746; 
 Tue, 05 Nov 2019 02:05:53 -0800 (PST)
MIME-Version: 1.0
References: <c83fe0e7157562c3c17598917977eb4d@hostfission.com>
 <20191030185248.GC3114@work-vm>
 <88f1c3701740665b0ebe2f24c8ce7ade@hostfission.com>
 <20191031132443.GB3128@work-vm>
 <b36330ecd38ce872982df4d41d3d4695@hostfission.com>
 <CAFEAcA8uWCQY8GwtH4oHU8ybXsvmYaB4Qa5hnxyd+344WFjJ_Q@mail.gmail.com>
 <b87d5b2fb84ac0a3c98a62dcc0c19077@hostfission.com>
 <20191031155204.GD3128@work-vm>
 <cd00c2ba412361d707ab02575d74aacd@hostfission.com>
 <e23eb129dddc5d18bb9f9b15d116f957@hostfission.com>
 <20191104115546.GB3420@work-vm>
 <9b49de1379825ac1445766f4a8d198dc@hostfission.com>
In-Reply-To: <9b49de1379825ac1445766f4a8d198dc@hostfission.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 5 Nov 2019 14:05:40 +0400
Message-ID: <CAMxuvaxa820krw5gdRbbY-bbqf9zaE01GkC6mRVbrEaN9Fp56w@mail.gmail.com>
Subject: Re: RFC: New device for zero-copy VM memory access
To: geoff@hostfission.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Peter Maydell <peter.maydell@linaro.org>, "Coquelin,
 Maxime" <maxime.coquelin@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Mon, Nov 4, 2019 at 4:05 PM <geoff@hostfission.com> wrote:
>
>
>
> On 2019-11-04 22:55, Dr. David Alan Gilbert wrote:
> > * geoff@hostfission.com (geoff@hostfission.com) wrote:
> >>
> >>
> >> On 2019-11-03 21:10, geoff@hostfission.com wrote:
> >> > On 2019-11-01 02:52, Dr. David Alan Gilbert wrote:
> >> > > * geoff@hostfission.com (geoff@hostfission.com) wrote:
> >> > > >
> >> > > >
> >> > > > On 2019-11-01 01:52, Peter Maydell wrote:
> >> > > > > On Thu, 31 Oct 2019 at 14:26, <geoff@hostfission.com> wrote:
> >> > > > > > As the author of Looking Glass, I also have to consider the
> >> > > > > > maintenance
> >> > > > > > and the complexity of implementing the vhost protocol into the
> >> > > > > > project.
> >> > > > > > At this time a complete Porthole client can be implemented in 150
> >> > > > > > lines
> >> > > > > > of C without external dependencies, and most of that is boilerplate
> >> > > > > > socket code. This IMO is a major factor in deciding to avoid
> >> > > > > > vhost-user.
> >> > > > >
> >> > > > > This is essentially a proposal that we should make our project and
> >> > > > > code more complicated so that your project and code can be simpler.
> >> > > > > I hope you can see why this isn't necessarily an argument that will hold
> >> > > > > very much weight for us :-)
> >> > > >
> >> > > > Certainly, I do which is why I am still going to see about using
> >> > > > vhost,
> >> > > > however, a device that uses vhost is likely more complex then
> >> > > > the device
> >> > > > as it stands right now and as such more maintenance would be
> >> > > > involved on
> >> > > > your end also. Or have I missed something in that vhost-user can
> >> > > > be used
> >> > > > directly as a device?
> >> > >
> >> > > The basic vhost-user stuff isn't actually that hard;  if you aren't
> >> > > actually shuffling commands over the queues you should find it pretty
> >> > > simple - so I think your assumption about it being simpler if you
> >> > > avoid
> >> > > it might be wrong.  It might be easier if you use it!
> >> >
> >> > I have been looking into this and I am yet to find some decent
> >> > documentation or a simple device example I can use to understand how to
> >> > create such a device. Do you know of any reading or examples I can
> >> > obtain
> >> > on how to get an initial do nothing device up and running?
> >> >
> >> > -Geoff
> >>
> >> Scratch that, the design just solidified for me and I am now making
> >> progress, however it seems that vhost-user can't do what we need here:
> >>
> >> 1) I dont see any way to recieve notification of socket disconnection,
> >> in
> >> our use case the client app needs to be able to be (re)connected
> >> dynamically. It might be possible to get this event by registering it
> >> on
> >> the chardev manually but this seems like it would be a kludge.
> >
> > My understanding was that someone added support for reconnection of
> > vhost-user;  I'm not sure of the detail - cc'ing in Maxime and
> > Marc-Andre.
> >
> >> 2) I don't see any method of notifying the vhost-user client of the
> >> removal of a shared memory mapping. Again, these may not be
> >> persistently
> >> mapped in the guest as we have no control over the buffer allocation,
> >> and
> >> as such, we need a method to notify the client that the mapping has
> >> become
> >> invalid.
> >>
> >> 3) VHOST_USER_SET_MEM_TABLE is a one time request, again this breaks
> >> our
> >> usage as we need to change this dynamically at runtime.
> >
> > I've seen (3) being sent multiple times (It's messy but it happens); so
> > I think that fixes (2) as well for you.
>
> Yes, but it's ignored.
>
>      /*
>       * For non-vring specific requests, like VHOST_USER_SET_MEM_TABLE,
>       * we just need send it once in the first time. For later such
>       * request, we just ignore it.
>       */
>      if (vhost_user_one_time_request(msg->hdr.request) && dev->vq_index
> != 0) {
>           msg->hdr.flags &= ~VHOST_USER_NEED_REPLY_MASK;
>           return 0;
>      }

This code was added to avoid sending the same mapping for each queue:
https://github.com/qemu/qemu/commit/b931bfbf042983f311b3b09894d8030b2755a638
(arguably, the filtering could have been done earlier)

But if you reconnect, it should still send it again at least once (for vq #0).

vhost-user-bridge reconnect used to work quite reliably, I haven't
tested recently.


>
> >
> > Dave
> >
> >> Unless there are viable solutions to these problems there is no way
> >> that
> >> vhost-user can be used for this kind of a device.
> >>
> >> -Geoff
> >>
> >> >
> >> > >
> >> > > Dave
> >> > >
> >> > > > >
> >> > > > > thanks
> >> > > > > -- PMM
> >> > > --
> >> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

