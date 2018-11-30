Received: from eggs.gnu.org ([2001:4830:134:3::10]:40748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSisQ-0000j0-2Q
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:30:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gSisJ-0006ty-5K
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:30:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56038)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gSisI-0006t0-81
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 08:30:30 -0500
Date: Fri, 30 Nov 2018 13:29:59 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181130132959.GC9162@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181129121449.4322-1-jasowang@redhat.com>
	<44516b60-dafd-70e3-1638-ea38a804c8a4@redhat.com>
	<nycvar.YSQ.7.76.1811301446050.9903@xnncv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1811301446050.9903@xnncv>
Subject: Re: [Qemu-devel] [PATCH V2 for 3.1 0/4] Fix possible OOB during
 queuing packets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, peter.maydell@linaro.org, mst@redhat.com, Jason Wang <jasowang@redhat.com>, liq3ea@gmail.com, qemu-devel@nongnu.org, pbonzini@redhat.com

On Fri, Nov 30, 2018 at 02:48:19PM +0530, P J P wrote:
> +-- On Thu, 29 Nov 2018, Eric Blake wrote --+
> | How important is this for 3.1?  We've missed -rc3.  Is this CVE quality 
> | because of a guest being able to cause mayhem by intentionally getting into 
> | this condition (in which case, we need it, as well as a CVE assigned)? Is it 
> | pre-existing in 3.0 at which point waiting for 4.0 is no worse off than what 
> | we already are?
> 
> It is a revised patch to fix 'CVE-2018-17963' issue. Earlier patch was 
> included in -rc0.
> 
> $ git tag --contains 1592a9947036d60dde5404204a5d45975133caf5
> v3.1.0-rc0
> v3.1.0-rc1
> v3.1.0-rc2
> v3.1.0-rc3

If we've already tried to fix CVE-2018-17963 in 3.1.0 and failed to address
some edge cases, then it would be really desirable to get this into 3.1.0
too.  If we waited until 4.0.0, then we'd need to consider it to be a new
CVE on the grounds that 3.1.0 released a flawed fix.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
