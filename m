Received: from eggs.gnu.org ([2001:4830:134:3::10]:44478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1er1Sl-00069W-4t
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1er1Sk-0000IW-B7
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:08:03 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38038 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1er1Sk-0000Hy-6B
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:08:02 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D356A818B12A
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 13:08:01 +0000 (UTC)
Date: Wed, 28 Feb 2018 21:07:56 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180228130756.GL27381@xz-mi>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-12-peterx@redhat.com>
	<20180228092047.GE31550@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228092047.GE31550@redhat.com>
Content-Transfer-Encoding: quoted-printable
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
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Feb 28, 2018 at 09:20:47AM +0000, Daniel P. Berrang=C3=A9 wrote:
> On Wed, Feb 28, 2018 at 01:06:30PM +0800, Peter Xu wrote:
> > Let qio_channel_socket_connect_async() return the created QIOTask obj=
ect
> > for the async connection.  In tcp chardev, cache that in SocketCharde=
v
> > for further use.  With the QIOTask refcount, this is pretty safe.
>=20
> Why do you want to return QIOTask ? This is going against the intended
> design pattern for QIOTask (that was based on that in GLib). The task
> supposed to be an internal use only helper that callers should never
> be touching until the completion callback is invoked.

I proposed another solution in the other comment reply to split the
threaded QIO task into create() and run().  If you like that, I can
try.  Any other suggestion would be welcomed too.  Thanks,

--=20
Peter Xu
