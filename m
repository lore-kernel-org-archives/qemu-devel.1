Received: from eggs.gnu.org ([2001:4830:134:3::10]:59027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBfj5-00041x-Bk
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fBfj0-00086D-Q2
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 08:10:15 -0400
Date: Thu, 26 Apr 2018 13:10:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180426121002.GG26812@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180418123838.3511-1-olaf@aepfle.de>
	<20180418124753.GM27579@redhat.com>
	<CAFEAcA_TtC-p4JJFRPaBFwim1a8J9G+z79KAK8vqrTx7ZKjOKg@mail.gmail.com>
	<20180418144433.GV27579@redhat.com>
	<CAFEAcA8jXwo35B7KVdVZEiqZTtMRvVXCP87iHKECjWPkHiTJ_A@mail.gmail.com>
	<c9b7c417-e714-658b-20da-7150c9ec8ab9@redhat.com>
	<20180426140807.4a4a577b.olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180426140807.4a4a577b.olaf@aepfle.de>
Subject: Re: [Qemu-devel] [PATCH v1] configure: require glib-2.24
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>

On Thu, Apr 26, 2018 at 02:08:07PM +0200, Olaf Hering wrote:
> Am Thu, 26 Apr 2018 13:52:04 +0200
> schrieb Paolo Bonzini <pbonzini@redhat.com>:
> 
> > min-glib Dockerfile is using glib 2.22
> 
> Why did it not prevent the bad commit from entering 2.12?

Presumably the min-glib docker job didn't enable the vfio feature, which
is what contained the bad code.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
