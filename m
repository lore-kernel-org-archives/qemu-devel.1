Received: from eggs.gnu.org ([2001:4830:134:3::10]:53869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e9ppg-0003Cf-3Z
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:01:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e9ppY-0007jZ-9O
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:01:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e9ppY-0007j4-36
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 06:01:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1FC0D5AFC7
	for <qemu-devel@nongnu.org>; Wed,  1 Nov 2017 10:01:02 +0000 (UTC)
Date: Wed, 1 Nov 2017 11:00:56 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171101100056.GB9289@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171023091947.20771-1-kraxel@redhat.com>
	<20171023091947.20771-5-kraxel@redhat.com>
	<20171027072934.GA30999@redhat.com>
	<1509523112.3856.3.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1509523112.3856.3.camel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 4/9] ps2: fix scancodes sent for Alt-Print
 key combination (aka SysRq)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Nov 01, 2017 at 08:58:32AM +0100, Gerd Hoffmann wrote:
>   Hi,
> 
> > No one confirmed whether or not this new field needs to be added to
> > the
> > VMSTATE sections, and if so, how todo this in a back compatible
> > manner....
> 
> Good question.  Sky isn't falling if we don't send this over, worst
> case is a minor keyboard glitch, affecting only the SysRq key, right?
> 
> Annoying things like sticky modifier keys should not happen.  So I'd
> tend to simply leave things as-is.

Yeah, we would only gitch that key combo. It should be (practically) impossible
to hit, because from the user input POV its just a single key, that internally
we turn into a sequence of keys when injecting.

> 
> When sending it over we need a subsection for it.  Simplest way would
> be to only send over the section in the unlikely case that the field is
> non-zero.  But this might fail migration to older qemu versions in case
> someone hits a modifier key the wrong moment.  Alternatively send the
> sibsection only on new machine types using a compat property, but that
> needs a bit more boilerplate.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
