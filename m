Received: from eggs.gnu.org ([2001:4830:134:3::10]:59599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds584-0001bb-Gb
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:42:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ds580-0005mW-IB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:42:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41664)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ds580-0005lq-CB
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 06:42:44 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C23D461E0
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 10:42:43 +0000 (UTC)
Date: Wed, 13 Sep 2017 18:42:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170913104235.GG3617@pxdev.xzpeter.org>
References: <1505295366-25295-1-git-send-email-peterx@redhat.com>
	<f7707221-5365-8074-7a83-ac108059aecc@redhat.com>
	<20170913102842.GE3617@pxdev.xzpeter.org>
	<3652b029-7a6d-af98-47e0-2e894f471b46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3652b029-7a6d-af98-47e0-2e894f471b46@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] qtest: fix "device_del" out-of-order
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed, Sep 13, 2017 at 12:35:17PM +0200, Thomas Huth wrote:

[...]

> >> As far as I know, some test currently use QMP in a bad way, for example
> >> usb_test_hotplug() only checks for the DEVICE_DELETED at the end, but
> >> forgets to read back the final return value. That return value is then
> >> presented to the next part of the code that uses QMP instead ... it
> >> currently only works more or less by accident, but as soon as you try to
> >> add new code inbetween, it certainly will fail.
> >> ==> We really got to clean this up (either with my patch or your patch
> >> series).
> > 
> > Agree.
> > 
> > I think your patch is nicer on the interface (as you have mentioned in
> > the other reply), I can try to review it later.
> > 
> > However it seems that your patch didn't really solve the problem I
> > encountered (mis-ordered message arrivals).  It would be good if you
> > want to solve it together, or I can draft patch upon yours.
> 
> True, I'll try to respin my patch, including the ideas from your patch...

That would be great.  I've left some comments there already.  Thanks!

-- 
Peter Xu
