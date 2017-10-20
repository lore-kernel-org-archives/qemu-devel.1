Received: from eggs.gnu.org ([2001:4830:134:3::10]:49631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5Wd4-0004rS-FR
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e5Wd3-0005NY-LI
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:42:22 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:48082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e5Wd3-0005Mx-Ee
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 08:42:21 -0400
Received: by mail-wr0-x235.google.com with SMTP id y39so11255518wrd.4
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 05:42:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1B925CC0CD9F3341B32D442251E7E1DC391048B2@shsmsx102.ccr.corp.intel.com>
References: <1B925CC0CD9F3341B32D442251E7E1DC391048B2@shsmsx102.ccr.corp.intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Oct 2017 13:41:59 +0100
Message-ID: <CAFEAcA81-ht6tTc-nwiios3pjnWjNC49gZp8RQAOdNntM3tkUw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] qemu compile error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Chen, Farrah" <farrah.chen@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Hu,
	Robert" <robert.hu@intel.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 20 October 2017 at 13:13, Chen, Farrah <farrah.chen@intel.com> wrote:
> Hi,
>
> When I build qemu with commit from aef45d51d1204f3335fb99de6658e0c5612c2b67 to the latest one, the following error occurred:
>
> tsocks git clone git://git.qemu.org/qemu.git
> cd qemu
>
> ./configure --target-list=x86_64-softmmu --enable-kvm --enable-vnc --disable-gtk --enable-libusb --enable-numa --disable-sdl
> make
>   GEN     config-host.h
>   GIT     dtc
>   GEN     trace/generated-tcg-tracers.h
>   GEN     trace/generated-helpers-wrappers.h
>   GEN     trace/generated-helpers.h
>   GEN     module_block.h
>   GEN     trace/generated-helpers.c
> make: *** [git-submodule-update] Error 1

Dan -- I thought we were going to not have the git-submodule.sh
script throw away the errors from git, but the version in
master still seems to do that...

Fan: this happens because we tried to run a 'git submodule'
command and it failed. If you edit scripts/git-submodule.sh
to remove the "1>/dev/null 2>&1" part of the 'git submodule
update' command line then rerun make it should print the
error messages from git which will tell you what the
problem is.

(The fact you needed to say 'tsocks git clone...' on your
original command suggests to me that the problem is that
plain 'git submodule update' can't access the git repo.)

thanks
-- PMM
