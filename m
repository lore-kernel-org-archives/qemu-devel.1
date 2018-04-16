Received: from eggs.gnu.org ([2001:4830:134:3::10]:35279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f86pK-0007Av-W1
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f86pJ-00010e-I2
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:17:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49296 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f86pJ-00010L-DY
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:17:57 -0400
Date: Mon, 16 Apr 2018 17:17:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180416161753.GA12819@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1502467522-32237-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1502467522-32237-1-git-send-email-armbru@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] vl: Partial support for non-scalar
 properties with -object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, el13635@mail.ntua.gr, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com, f4bug@amsat.org

Just a ping to say I'd like us to restart work this patch and try to get
it mergable for the 2.13 cycle, so I can rely it on for the ACL support
I've had out of tree since 2.6 :-)

On Fri, Aug 11, 2017 at 06:05:20PM +0200, Markus Armbruster wrote:
> v2:
> * PATCH 1: Whitespace change dropped [Eric]
> * PATCH 2: Deallocation done differently [Paolo], R-by dropped
>            Commit message typo [Eric]
> 
> Markus Armbruster (2):
>   vl: Factor object_create() out of main()
>   vl: Partial support for non-scalar properties with -object
> 
>  qapi-schema.json | 14 ++++++++---
>  vl.c             | 71 ++++++++++++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 72 insertions(+), 13 deletions(-)
> 
> -- 
> 2.7.5
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
