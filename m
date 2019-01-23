Received: from eggs.gnu.org ([209.51.188.92]:47825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmF3p-0002Im-By
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:43:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gmEy4-0005Ee-GS
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:37:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gmEy4-0005Al-Aj
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 04:37:08 -0500
Date: Wed, 23 Jan 2019 09:36:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190123093657.GC27270@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190123080005.31078-1-kraxel@redhat.com>
	<20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>

On Wed, Jan 23, 2019 at 09:27:48AM +0100, Thomas Huth wrote:
> On 2019-01-23 09:00, Gerd Hoffmann wrote:
> > 
> > This is RfC because we might look at the ordering.  On linux we probably
> > want prefer alsa over oss.
> Yes, please! I've run into the trap a couple of times already: OSS
> headers were available, but these days the OSS compatibility kernel
> modules are not loaded anymore by default. So you compile QEMU with OSS
> support and then wonder why you do not get any audio output at all...
> 
> IMHO we should put OSS as last item in the list on Linux nowadays.

Given our targetted platform list[1], are there even any platforms
where we would *not* have alsa, but still have OSS ?  If not, then
we could just drop the OSS driver entirely on the ground that it is
obsolete.

Regards,
Daniel

[1] https://qemu.weilnetz.de/doc/qemu-doc.html#Supported-build-platforms
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
