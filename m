Received: from eggs.gnu.org ([2001:4830:134:3::10]:52844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db1EP-0005sy-FV
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db1EM-0005K7-V4
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1db1EM-0005Jq-OL
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 05:06:46 -0400
Date: Fri, 28 Jul 2017 10:06:37 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170728090637.GI31495@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170728085547.13947-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170728085547.13947-1-vsementsov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] trace-events: print 0x before hex numbers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com, jsnow@redhat.com

On Fri, Jul 28, 2017 at 11:55:47AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> To make logs more readable prefix all hex values with '0x' mark.
> This is needed for consistency too, as a lot of hex values are already
> prefixed with '0x'. Also, bring all hex outputs to the common form -
> use '%#', not '0x%'.
> 
> This patch is done by two commands:
> find . -name trace-events | \
>  xargs sed -i 's/%\([-+ *.0-9]*\([hljztL]\|ll\|hh\)\?\(x\|X\|"\s*PRIx\)\)/%#\1/g'
> find . -name trace-events | xargs sed -i 's/0x%#/%#/g'

I fear that despite your cleanup, these mistakes will be frequently
re-introduced.  IOW, I think you should add to scripts/checkpatch.pl
to re-validate any patch which touches a trace-events file, to
prevent further regressions.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
> 
> Hi all!
> 
> It is hard to read logs, when there are hex and dec numbers in one line, when
> hex number doesn't contain any letters and don't have '0x' prefix. Hope I'm
> not alone who is not comfortable with it, so, what about a patch like this?
> May be regexp's should be improved but, I think, the common idea is clear.

Yeah, I agree - mixing decimal & hex values with no 0x prefix is horribly
misleading at best.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
