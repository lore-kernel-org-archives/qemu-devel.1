Received: from eggs.gnu.org ([2001:4830:134:3::10]:48452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqxv3-0004zk-Rc
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:21:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eqxv0-0002X3-Nt
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:21:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eqxv0-0002Wx-J6
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 04:20:58 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 130FA402290A
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 09:20:58 +0000 (UTC)
Date: Wed, 28 Feb 2018 09:20:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180228092047.GE31550@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-12-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228050633.7410-12-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 11/14] qio/chardev: return QIOTask when
 connect async
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 28, 2018 at 01:06:30PM +0800, Peter Xu wrote:
> Let qio_channel_socket_connect_async() return the created QIOTask object
> for the async connection.  In tcp chardev, cache that in SocketChardev
> for further use.  With the QIOTask refcount, this is pretty safe.

Why do you want to return QIOTask ? This is going against the intended
design pattern for QIOTask (that was based on that in GLib). The task
supposed to be an internal use only helper that callers should never
be touching until the completion callback is invoked.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
