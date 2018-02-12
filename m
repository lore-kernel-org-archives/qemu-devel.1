Received: from eggs.gnu.org ([2001:4830:134:3::10]:57975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elAwv-00087s-9Y
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 05:03:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1elAwr-00020T-7x
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 05:03:01 -0500
Date: Mon, 12 Feb 2018 10:02:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180212100247.GG4071@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180207162920.28386-1-pbonzini@redhat.com>
	<84467de4-5563-8293-9838-a5d48878597f@redhat.com>
	<b1278b08-0881-1dec-05c7-22da222cab93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1278b08-0881-1dec-05c7-22da222cab93@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: early check for blockers on
 drive-mirror
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, Feb 12, 2018 at 10:58:31AM +0100, Paolo Bonzini wrote:
> On 10/02/2018 00:07, John Snow wrote:
> >> +    /* Early check to avoid creating target */
> >> +    if (bdrv_op_is_blocked(bs, BLOCK_OP_TYPE_MIRROR_SOURCE, errp)) {
> >> +        return;
> >> +    }
> >> +
> >>      aio_context = bdrv_get_aio_context(bs);
> >>      aio_context_acquire(aio_context);
> >>  
> >>
> > What's the implication of the temporarily-extant target node that it
> > needs to be avoided so strictly?
> > 
> 
> Creating a file on disk, that no one will ever remvoe. :)

Fortunately libvirt's SELinux policy will probably prevent QEMU creating
it in the first place :-)

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
