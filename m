Received: from eggs.gnu.org ([2001:4830:134:3::10]:49559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dspRW-0001zw-0H
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:09:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dspRS-0007fW-0c
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:09:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dspRR-0007ew-R1
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 08:09:53 -0400
Date: Fri, 15 Sep 2017 13:09:46 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170915120946.GH13610@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170915090253.12201-1-famz@redhat.com>
	<CAFEAcA_b71j3v5Ag7uSTPBgUT2_Qej+KJxH57cKV+6QdRgCw9A@mail.gmail.com>
	<20170915114001.GG13610@redhat.com>
	<CAFEAcA9Vf8pvQ07+HNnRHiTv=N7m6LZRKUQdqziDiPX6=uEy_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Vf8pvQ07+HNnRHiTv=N7m6LZRKUQdqziDiPX6=uEy_Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v4 00/38] Test and build patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Sep 15, 2017 at 01:03:54PM +0100, Peter Maydell wrote:
> On 15 September 2017 at 12:40, Daniel P. Berrange <berrange@redhat.com> wrote:
> > IIUC, the public part of the key gets exposed to the guest images via
> > cloud-init metadata. During boot the guest read this metadata and add
> > the public key to authorized_keys. The private key is used by the test
> > suite on the host so that it can now login to the guests.
> >
> > So the risk here is that if these guests were exposed to the LAN in any
> > way, someone could grab our private key and login to these guests.
> >
> > What saves us is that the VMs are run with user mode slirp networking
> > so AFAICT, aren't exposed to the LAN.
> 
> If I'm reading the right bit of the script we run QEMU with a
> hostfwd specification using 0.0.0.0 as the host part -- doesn't
> that listen on all interfaces including the LAN ones?

Actually yes, you are right, my bad.

That needs to be fixed to use 127.0.0.1 for sure.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
