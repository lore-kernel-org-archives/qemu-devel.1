Received: from eggs.gnu.org ([2001:4830:134:3::10]:34290)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVYa3-0000eB-9Z
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fVYa0-00012C-0v
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:35:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59498 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fVYZz-000124-T0
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 04:35:03 -0400
Date: Wed, 20 Jun 2018 09:34:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180620083459.GB3441@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180619132200.12320-1-sameeh@daynix.com>
	<20180619134933.GY20929@redhat.com>
	<CAKPgXcHrZY1=65jOg3Y3bDdwNnik7x-Ti-3PAryYsRuvRWk=iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKPgXcHrZY1=65jOg3Y3bDdwNnik7x-Ti-3PAryYsRuvRWk=iA@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 0/1] Add BPF suuport to Qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sameeh Jubran <sameeh@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>, Yan Vugenfirer <yan@daynix.com>, Amnon Ilan <ailan@redhat.com>

On Tue, Jun 19, 2018 at 05:37:10PM +0300, Sameeh Jubran wrote:
> This patch is actually a preparation for an upcoming patch set that I want
> to integrate into virtio-net which implements the RSS feature. (
> https://lists.oasis-open.org/archives/virtio-dev/201805/msg00024.html)
> So there is a use case. The rationale behind this is to distinguish the
> infrastructure preparation needed for the BPF from the actual RSS feature
> implementation.

Ah, so IIUC, that is not actually doing network filtering, rather it is
some performance related feature than happens to make of use of BPF.

I think it is be important to submit code changes for the virtio driver
at the same time, so we can properly understand the interface and usage
model exposed to the user CLI (if any).


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
