Received: from eggs.gnu.org ([209.51.188.92]:58192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grPFw-0006NN-1c
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:36:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1grPFu-0000KD-Cy
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:36:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42256)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1grPFl-0000ES-MN
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:36:47 -0500
Date: Wed, 6 Feb 2019 15:36:31 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190206153631.GS12331@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1548509635-15776-1-git-send-email-ptsneves@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1548509635-15776-1-git-send-email-ptsneves@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] chardev: Allow for pty path passing.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paulo Neves <ptsneves@gmail.com>
Cc: qemu-devel@nongnu.org

On Sat, Jan 26, 2019 at 02:33:55PM +0100, Paulo Neves wrote:
> If a user requires a virtual serial device like provided
> by the pty char device, the user needs to accept the
> returned device name. This makes the program need to
> have smarts to parse or communicate with qemu to get the
> pty device.
> With this patch the program can pass the path where
> a symlink to the pty device will be, removing the
> need for 2 way communication or smarts.
> 
> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
> ---
>  chardev/char-pty.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  chardev/char.c     |  6 +++++-
>  qapi/char.json     |  4 ++--
>  3 files changed, 47 insertions(+), 4 deletions(-)

qemu-options.hx needs updating to document the new syntax too


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
