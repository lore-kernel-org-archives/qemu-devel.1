Received: from eggs.gnu.org ([209.51.188.92]:33774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guel6-0005G7-Kf
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:46:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1guel0-0003mZ-Ca
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:46:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1guekv-0003bL-CC
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 09:46:24 -0500
Date: Fri, 15 Feb 2019 14:46:05 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190215144605.GF14454@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190124132020.13571-1-kraxel@redhat.com>
	<20190124132020.13571-8-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190124132020.13571-8-kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PULL 7/7] audio: probe audio drivers by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Brad Smith <brad@comstyle.com>

On Thu, Jan 24, 2019 at 02:20:20PM +0100, Gerd Hoffmann wrote:
> Add the drivers listed in audio_possible_drivers to audio_drv_list,
> using the try-* variants.  That way the probable drivers are compiled by
> default if possible.
> 
> Additioal tweaks:
>   linux: reorder to: pa alsa sdl oss.

Unfortunately this breaks QEMU on hosts which lack a physical  sound
card. The alsa driver activates itself, despite the fact it is incapable
of working, and thus causes QEMU startup to fail when AUD_open_out is
tried

https://bugs.launchpad.net/qemu/+bug/1816052


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
