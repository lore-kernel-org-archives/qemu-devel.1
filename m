Received: from eggs.gnu.org ([2001:4830:134:3::10]:57153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnPTX-0007V6-8G
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dnPTR-0004Xc-2T
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50002)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dnPTQ-0004WO-RV
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 09:25:32 -0400
Date: Thu, 31 Aug 2017 14:25:26 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170831132526.GM17315@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <87r2w6eq5n.fsf@gmail.com> <87h8x1yox3.fsf@dusky.pond.sub.org>
	<20170830170941.GB24565@stefanha-x1.localdomain>
	<87bmmwi6r6.fsf@dusky.pond.sub.org>
	<CAFEAcA8r-EqOjZDvP=0mYG7QQ83MU-54RL9Bu8Eb_wPzQo1M7Q@mail.gmail.com>
	<87r2vrlwr3.fsf@dusky.pond.sub.org>
	<20170831131412.GK17315@redhat.com>
	<CAFEAcA_OHsZJd4hMtbMuaVD2QDT7H2XEPD03w8NKJ901Cj0Hcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_OHsZJd4hMtbMuaVD2QDT7H2XEPD03w8NKJ901Cj0Hcw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH] scripts: Support building with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, David Michael <fedora.dm0@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Aug 31, 2017 at 02:19:05PM +0100, Peter Maydell wrote:
> On 31 August 2017 at 14:14, Daniel P. Berrange <berrange@redhat.com> wrote:
> > NB, some distros have already changed /usr/bin/python to point to py3
> > so all the files with #!/usr/bin/python in QEMU are already broken on
> > those distros.
> 
> This is a bug in those distros and they should fix it. Python 3
> is not Python 2 and making /usr/bin/python point to the wrong
> interpreter will have predictably bad results for their users...

Having /usr/bin/python point to py3 is what upstream Python will
eventually recommend. Some distros jumped a bit early, but the
others will eventually follow, and I don't see those early distros
moving back. 

https://www.python.org/dev/peps/pep-0394/


   "* python2 will refer to some version of Python 2.x.
    * python3 will refer to some version of Python 3.x.
    * for the time being, all distributions should ensure
      that python refers to the same target as python2.
    * however, end users should be aware that python refers
      to python3 on at least Arch Linux (that change is what
      prompted the creation of this PEP), so python should 
      be used in the shebang line only for scripts that are
      source compatible with both Python 2 and 3.
    * in preparation for an eventual change in the default
      version of Python, Python 2 only scripts should either
      be updated to be source compatible with Python 3 or 
      else to use python2 in the shebang line."

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
