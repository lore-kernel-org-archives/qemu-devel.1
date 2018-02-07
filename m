Received: from eggs.gnu.org ([2001:4830:134:3::10]:55480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejMyL-0004CC-NV
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:29:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ejMyI-0002OZ-3C
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 05:29:01 -0500
Date: Wed, 7 Feb 2018 10:28:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180207102848.GE32061@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180206191515.25830-1-mdroth@linux.vnet.ibm.com>
	<dd122493-dd05-e5bd-abab-0955bc82b770@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dd122493-dd05-e5bd-abab-0955bc82b770@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 00/54] Patch Round-up for stable 2.11.1,
 freeze on 2018-02-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org, qemu-stable@nongnu.org, christian.ehrhardt@canonical.com, Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>

On Wed, Feb 07, 2018 at 07:47:54AM +0100, Thomas Huth wrote:
> On 06.02.2018 20:14, Michael Roth wrote:
> > Hi everyone,                                                                                              
> > 
> > The following new patches are queued for QEMU stable v2.11.1:
> > 
> >   https://github.com/mdroth/qemu/commits/stable-2.11-staging
> > 
> > The release is planned for 2017-02-14:
> > 
> >   https://wiki.qemu.org/Planning/2.11
> > 
> > Please respond here or CC qemu-stable@nongnu.org on any patches you
> > think should be included in the release.
> 
> Looking for "CVE" in the changelog, these look like good candidates for
> stable as well:
> 
>     191f59dc17396bb5a8da50f8c59b6e0a430711a4
>     vga: check the validation of memory addr when draw text
> 
>     f887cf165db20f405cb8805c716bd363aaadf815
>     ui: place a hard cap on VNC server output buffer size
>     (and the preceding patches)

FYI, to fix the VNC problem you'll need alot of patches. To get clean
cherry-pick's I think you'll probably need all of this:

627ebec208a8809818589e17f4fce55a59420ad2 ui: correctly advance output buffer when writing SASL data
4c956bd81e2e16afd19d38d1fdeba6d9faa8a1ae ui: avoid sign extension using client width/height
30b80fd5269257f55203b7072c505b4ebaab5115 ui: mix misleading comments & return types of VNC I/O helper methods
6aa22a29187e1908f5db738d27c64a9efc8d0bfa ui: add trace events related to VNC client throttling
f887cf165db20f405cb8805c716bd363aaadf815 ui: place a hard cap on VNC server output buffer size
ada8d2e4369ea49677d8672ac81bce73eefd5b54 ui: fix VNC client throttling when forced update is requested
e2b72cb6e0443d90d7ab037858cb6834b6cca852 ui: fix VNC client throttling when audio capture is active
0bad834228b9ee63e4239108d02dcb94568254d0 ui: refactor code for determining if an update should be sent to the client
728a7ac95484a7ba5e624ccbac4c1326571576b0 ui: correctly reset framebuffer update state after processing dirty regions
fef1bbadfb2c3027208eb3d14b43e1bdb51166ca ui: introduce enum to track VNC client framebuffer update request state
8f61f1c5a6bc06438a1172efa80bc7606594fa07 ui: track how much decoded data we consumed when doing SASL encoding
3541b08475d51bddf8aded36576a0ff5a547a978 ui: avoid pointless VNC updates if framebuffer isn't dirty
b939eb89b6f320544a9328fa908d881d0024c1ee ui: remove redundant indentation in vnc_client_update
c53df961617736f94731d94b62c2954c261d2bae ui: remove unreachable code in vnc_update_client
6af998db05aec9af95a06f84ad94f1b96785e667 ui: remove 'sync' parameter from vnc_update_client


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
