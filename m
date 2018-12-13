Received: from eggs.gnu.org ([2001:4830:134:3::10]:50606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXNyW-0002M1-2w
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:12:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXNyP-0000hN-Kh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 05:12:11 -0500
Date: Thu, 13 Dec 2018 10:11:54 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181213101154.GA5171@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181212220410.569069-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181212220410.569069-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-io: Prefer stderr for error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, rjones@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, Dec 12, 2018 at 04:04:10PM -0600, Eric Blake wrote:
> When a qemu-io command fails, it's best if the failure message
> goes to stderr rather than stdout.
> 
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
> 
> RFC because at least iotest 60 (found by -qcow2 -g quick) breaks due
> to reordering of output lines, and I'd rather know if we like this
> idea before bothering to revisit all affected iotests (including
> discovering if other slower ones have similar problems).

I think the change is correct. Error messages should never go to stdout.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
