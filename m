Received: from eggs.gnu.org ([2001:4830:134:3::10]:60892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6EMI-0001dP-DW
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d6EME-0000Eo-Fv
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:51:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44044)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d6EME-0000DY-A3
	for qemu-devel@nongnu.org; Thu, 04 May 2017 06:51:38 -0400
Date: Thu, 4 May 2017 11:51:32 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170504105132.GA13354@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1493894491-26130-1-git-send-email-vip-ak47@yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1493894491-26130-1-git-send-email-vip-ak47@yandex.ru>
Subject: Re: [Qemu-devel] [PATCH] Video and sound capture to a videofile
 through ffmpeg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex K <vip-ak47@yandex.ru>
Cc: qemu-devel@nongnu.org, kraxel@redhat.com, aliguori@amazon.com

On Thu, May 04, 2017 at 01:41:31PM +0300, Alex K wrote:
> Hello everyone,
> 
> I've made a patch that adds ability to record video of what's going on
> inside qemu. It uses ffmpeg libraries. Basically, the patch adds
> 2 new commands to the console:
> capture_start path framerate
> capture_stop
> 
> path is required
> framerate could be 24, 25, 30 or 60. Default is 60
> video codec is always h264
> 
> The patch uses ffmpeg so you will need to install these packages:
> ffmpeg libavformat-dev libavcodec-dev libavutil-dev libswscale-dev

I wonder if this is not something that is better handled outside of
QEMU. eg there are quite a few programs already that can record
videos from a VNC stream, and there are libraries that can be used
to build custom solutions for either SPICE or VNC too. These would
give much more configurability in terms of encoding options than
this proposal does.

Including h264 support in QEMU also raises some potential legal issues
since organizations claim royalties on anyone using h264 encoders, so
IMHO it is preferrable to avoid this in QEMU entirely.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
