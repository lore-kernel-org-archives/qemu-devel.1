Received: from eggs.gnu.org ([2001:4830:134:3::10]:51537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cm0UE-0000Cj-Tn
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cm0U7-000093-3l
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:00:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55406)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1cm0U6-00008V-UQ
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 11:00:11 -0500
Date: Thu, 9 Mar 2017 17:00:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170309160007.GC4910@noname.redhat.com>
References: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d1c16a1-ec05-0367-e569-64a63b34f2e3@redhat.com>
Subject: Re: [Qemu-devel] What's the next QEMU version after 2.9 ? (or: when
 is a good point in time to get rid of old interfaces)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Am 08.03.2017 um 09:26 hat Thomas Huth geschrieben:
> what will be the next version of QEMU after 2.9? Will we go for a 2.10
> (as I've seen it mentioned a couple of times on the mailing list
> already), or do we dare to switch to 3.0 instead?
> 
> I personally dislike two-digit minor version numbers like 2.10 since the
> non-experienced users sometimes mix it up with 2.1 ... and there have
> been a couple of new cool features in the past releases that would
> justify a 3.0 now, too, I think.

We never really defined what major version numbers meant (except
"Anthony felt like using a new one"), so it's kind of arbitrary and we
could decide either way.

I don't think double digit minor version numbers make the switch
necessary, though. We went up to 0.15 before without any problems.

When this was discussed in IRC a while ago, the consensus seemed to be
2.10, so that's what I've been talking about since then - and from what
I read, it seems most other people are still expecting the same.

> But anyway, the more important thing that keeps me concerned is: Someone
>  once told me that we should get rid of old parameters and interfaces
> (like HMP commands) primarily only when we're changing to a new major
> version number. As you all know, QEMU has a lot of legacy options, which
> are likely rather confusing than helpful for the new users nowadays,
> e.g. things like the "-net channel" option (which is fortunately even
> hardly documented), but maybe also even the whole vlan/hub concept in
> the net code, or legacy parameters like "-usbdevice". If we switch to
> version 3.0, could we agree to remove at least some of them?

If we want to go this way, maybe this would actually be an argument for
doing a 2.10 first to give people enough time to think about any
incompatible changes they would like to make and then do 3.0 one release
later.

Kevin
