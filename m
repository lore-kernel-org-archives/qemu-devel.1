Received: from eggs.gnu.org ([2001:4830:134:3::10]:53649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXPU6-0003Vr-Am
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:48:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gXPU3-00058n-6W
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:48:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gXPU2-00057v-W5
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 06:48:51 -0500
Date: Thu, 13 Dec 2018 11:48:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181213114843.GE5171@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1544701071-2922-1-git-send-email-liq3ea@gmail.com>
	<CAFEAcA8tG-mXv63dDuJ-DFNDmxvv=AzK2rJXVFG5mnpPadGjGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8tG-mXv63dDuJ-DFNDmxvv=AzK2rJXVFG5mnpPadGjGQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] util: check the return value of fcntl
 in qemu_set_{block, nonblock}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Li Qiang <liq3ea@gmail.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Dec 13, 2018 at 11:45:22AM +0000, Peter Maydell wrote:
> On Thu, 13 Dec 2018 at 11:37, Li Qiang <liq3ea@gmail.com> wrote:
> >
> > Also add diagnostics info in 'qemu_set_cloexec' so that we can know
> > what happen when error occurs.
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> > Change since v1: add diagnostics info
> 
> We need to fix the assert in the test suite first...

Hopefully the improved diagnostics in this v2 will give us a better idea
of what the test suite failure is likely to be when patchew reports in....

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
