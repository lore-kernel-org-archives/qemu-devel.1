Received: from eggs.gnu.org ([2001:4830:134:3::10]:52068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e07pG-0005MI-2f
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:12:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e07pC-0001il-5m
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:12:38 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:46876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e07pB-0001iH-U5
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 11:12:34 -0400
Received: by mail-wm0-x22c.google.com with SMTP id m72so2783817wmc.1
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 08:12:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171005100106.30118-1-kraxel@redhat.com>
References: <20171005100106.30118-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Oct 2017 16:12:12 +0100
Message-ID: <CAFEAcA-9F++KngXrHGE=t7qZhdU2gCGKKSwHXYdLR6EhEfO4Qg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/6] Ui 20171005 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Daniel P. Berrange" <berrange@redhat.com>

On 5 October 2017 at 11:01, Gerd Hoffmann <kraxel@redhat.com> wrote:
> The following changes since commit d147f7e815f97cb477e223586bcb80c316ae10ea:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-10-03 16:27:24 +0100)
>
> are available in the git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20171005-pull-request
>
> for you to fetch changes up to 47247520ac44592cc7343138380bd6099f83262f:
>
>   ui: don't export qemu_input_event_new_key (2017-10-05 11:21:51 +0200)
>
> ----------------------------------------------------------------
> ui: use keycodemapdb for key code mappings, part one
>
> ----------------------------------------------------------------

Fails to build, all platforms:

make: Entering directory `/home/pm215/qemu/build/all'
config-host.mak is out-of-date, running configure
make: *** No rule to make target `ui/input-keymap-linux-to-qcode.c',
needed by `Makefile'. Stop.
make: *** Waiting for unfinished jobs....
Install prefix    /usr/local
BIOS directory    /usr/local/share/qemu
firmware path     /usr/local/share/qemu-firmware
binary directory  /usr/local/bin
library directory /usr/local/lib
module directory  /usr/local/lib/qemu
[etc]
replication support yes
VxHS block device no
make: Leaving directory `/home/pm215/qemu/build/all'

That make complains about the missing .c file before it has
finished running configure looks suspicious. I think there's
a race here with parallel make.

thanks
-- PMM
