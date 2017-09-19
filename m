Received: from eggs.gnu.org ([2001:4830:134:3::10]:33657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duKs4-0002QA-Fz
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duKs3-0001Dq-K3
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:55:36 -0400
Date: Tue, 19 Sep 2017 16:55:23 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170919155523.GU9536@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <a6ad8398-fcef-2d7f-548a-024c54ad2379@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a6ad8398-fcef-2d7f-548a-024c54ad2379@virtuozzo.com>
Subject: Re: [Qemu-devel] image locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Tue, Sep 19, 2017 at 06:46:19PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Hi Fam!
> 
> I have a question about your image locking series:
> 
> Can you please explain, why OFD locking is enabled by default and posix
> locking is not? What is wrong with posix locking, what are the problems?

POSIX locking suffers from a horribly broken design making it practically
impossible to use it reliably, particularly in a threaded program. If
there are two file descriptors open to the same file, closing one FD
will release locks held by the other FD. See more details here:

  http://0pointer.de/blog/projects/locking.html

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
