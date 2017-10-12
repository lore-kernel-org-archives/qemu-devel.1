Received: from eggs.gnu.org ([2001:4830:134:3::10]:41593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2ZLx-0004z7-KU
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e2ZLs-0002f9-09
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:00:29 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:43865)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e2ZLr-0002e0-H0
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 05:00:23 -0400
Received: by mail-wm0-x22d.google.com with SMTP id m72so23042681wmc.0
	for <qemu-devel@nongnu.org>; Thu, 12 Oct 2017 02:00:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171012082456.GB16125@redhat.com>
References: <20171011083604.11820-1-kraxel@redhat.com>
	<CAFEAcA9uXw7XYOBu9cKY+B=OWNbS=cRp7BKcXacLTaRLx9RWdA@mail.gmail.com>
	<20171011154951.GA6163@redhat.com>
	<CAFEAcA8OZALycKmsrC=MrftfF0YytXzRxGrzbetmSvddfTVf1g@mail.gmail.com>
	<20171012082456.GB16125@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Oct 2017 10:00:01 +0100
Message-ID: <CAFEAcA_Nxw4totmmuJK814SBy8=1vxpXKQpA3GNtafpHXSAAtg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/10] Ui 20171011 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 12 October 2017 at 09:24, Daniel P. Berrange <berrange@redhat.com> wrote:
> On Wed, Oct 11, 2017 at 05:45:04PM +0100, Peter Maydell wrote:
>> $ ./scripts/git-submodule.sh update ui/keycodemapdb dtc
>> Cloning into 'ui/keycodemapdb'...
>> fatal: unable to access
>> 'https://gitlab.com/keycodemap/keycodemapdb.git/': Problem with the
>> SSL CA cert (path? access rights?)
>> fatal: clone of 'https://gitlab.com/keycodemap/keycodemapdb.git' into
>> submodule path 'ui/keycodemapdb' failed
>
> I'm not sure what I can do about this one - if GIT can't checkout
> a normal git repo, this looks like a OS distro / setup bug on the
> build host.

Build system (which is a chroot) didn't have openssl or ca-certificates
packages installed. That hasn't been a problem so far because we
haven't used https:// for git previously.

I've updated the packages on the build system, but it would be nice
if we had a clearer error message when the problem is "we now
depend on some packages that we didn't previously and so you
should install them".

thanks
-- PMM
