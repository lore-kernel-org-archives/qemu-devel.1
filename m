Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E88DC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A3C20678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 09:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aYDBHRoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A3C20678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZtp2-0005Vc-84
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 04:41:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56747)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1iZto4-0004Av-Ng
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:40:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1iZto1-0000yh-Ih
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:40:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59296
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1iZto1-0000y3-Du
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 04:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574847616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HUXcjK5049AqCLODGo0pn6FMUEzhATEweCT+FK2pz/4=;
 b=aYDBHRoG111zJ8dHwHiiAmID6dkTs/3fAKAh1t2nXXKeYVvs+numn8eVAxMao+SwbVDm3t
 3gMUscaxGSu0FSCtwqWBperz+ZotgrNXseeFWetmNzWBmDdEec9pj1VSp+VM70QJn+nN7n
 KmryS+jUkFgE9t2fJFCLtquj6a8SMfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-GnQtnVppNG6myGuwetnJQQ-1; Wed, 27 Nov 2019 04:40:14 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73B5C107ACE3;
 Wed, 27 Nov 2019 09:40:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-67.ams2.redhat.com
 [10.36.116.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1558D5D9D6;
 Wed, 27 Nov 2019 09:40:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 45B1116E18; Wed, 27 Nov 2019 10:40:12 +0100 (CET)
Date: Wed, 27 Nov 2019 10:40:12 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Yuri Benditovich <yuri.benditovich@daynix.com>
Subject: Re: [PATCH] usbredir: remove 'remote wake' capability from
 configuration descriptor
Message-ID: <20191127094012.vgpckaztez77dsgz@sirius.home.kraxel.org>
References: <20191126212245.27735-1-yuri.benditovich@daynix.com>
 <87a78hltbq.fsf@dusky.pond.sub.org>
 <CAOEp5OdsYhxD4LE9Qu981uiB+33Xc81z8H=cuwTS6tbU9x_UkA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOEp5OdsYhxD4LE9Qu981uiB+33Xc81z8H=cuwTS6tbU9x_UkA@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: GnQtnVppNG6myGuwetnJQQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Yan Vugenfirer <yan@daynix.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 27, 2019 at 09:36:21AM +0200, Yuri Benditovich wrote:
> On Wed, Nov 27, 2019 at 8:36 AM Markus Armbruster <armbru@redhat.com> wro=
te:
> >
> > Yuri Benditovich <yuri.benditovich@daynix.com> writes:
> >
> > > If the redirected device has this capability, Windows guest may
> > > place the device into D2 and expect it to wake when the device
> > > becomes active, but this will never happen. For example, when
> > > internal Bluetooth adapter is redirected, keyboards and mice
> > > connected to it do not work. Setting global property
> > > 'usb-redir.nowake=3Doff' keeps 'remote wake' as is.
> >
> > "usb-redir.nowake=3Doff" is a double negation.  Gets weirder when duste=
d
> > with syntactic sugar: "usb-redir.nonowake".  Can we think of a better
> > name?  Naming is hard...  What about "usb-redir.wakeup=3Don"?
> '"wakeup" is good but "wakeup=3Don" makes an impression that we add the
> capability to the device even if it does not have one.
> disable_wake? suppress_wake? clear_wake? wake_allowed?

remote-wakeup=3Don,off ?

> > > +    DEFINE_PROP_BOOL("nowake", USBRedirDevice, suppress_remote_wake,=
 true),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> >
> > The default is .nowake=3Don.  Is that a guest-visible change?

Yes, usb descriptors change, which the guest can see.

> And, of course, we can keep existing behavior by default and advise to
> turn this property on to make these devices work.

In that case a compat property would not be needed.

But, after all the question is whenever that is the best way to solve
the problem.  Most likely there is just a usb_wakeup() call missing
somewhere ...

cheers,
  Gerd


