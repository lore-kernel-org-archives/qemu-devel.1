Received: from eggs.gnu.org ([2001:4830:134:3::10]:47064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtmU-0006Ww-Ki
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:08:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ewtmQ-0001cp-9W
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:08:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ewtmQ-0001cg-5c
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 14:08:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D9072A1BE1
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 18:08:37 +0000 (UTC)
Date: Fri, 16 Mar 2018 18:08:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180316180833.GJ3066@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180316115403.4148-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316115403.4148-1-quintela@redhat.com>
Subject: Re: [Qemu-devel] [RFC v11 00/15] mutifd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

On Fri, Mar 16, 2018 at 12:53:48PM +0100, Juan Quintela wrote:
> Multifd
> 
> 
> Hi
> 
> [v11]
> 
> Changes on top of previous sumbimission:
> - Now on top of migration-tests/v6 that I sent on Wednesday
> - Rebased to latest upstream
> - Everything that is sent through the network should be converted correctly
>   (famous last words)
> - Still on RFC (sometimes it ends some packets at the end), just to
>   show how things are going on.  Problems are only on the last patch.
> 
> - Redo some locking (again) Now the problem is being able te send the
>   synchronization through the multifd channels.  I end the migration
>   _before_ all the channels have recevied all the packets.
> 
> - Trying to get a flags argument into each packet, to be able to synchronze
>   through the network, not from the "main" incoming corroutine.
> 
> - Related to the network-safe fields, now everything is in its own
>   routine, it should be easier to understand/review.  Once there, I
>   check that all values are inside range.
> 
> So, please comment.

Just a few very minor things I've noticed. No more comments from me,
i'll defer to someone else for understanding of the actual RAM page
handling patches


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
