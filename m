Received: from eggs.gnu.org ([2001:4830:134:3::10]:41012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7cUV-0008TL-RN
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e7cUU-0003k7-SQ
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:22:11 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:54483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e7cUU-0003jo-L9
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:22:10 -0400
Received: by mail-wm0-x22e.google.com with SMTP id r68so6162364wmr.3
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 00:22:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171026070608.GC5847@redhat.com>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
	<CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
	<CAFEAcA9XdoV0YVw+q7op_vafe9X0JTiQdYmGcmPgqRR3qhUYrQ@mail.gmail.com>
	<20171026070608.GC5847@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Oct 2017 08:21:48 +0100
Message-ID: <CAFEAcA8f7jJsM3=4bZG8fE_kTm6jueC-rF6ga0mdUvzMDSpLwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] Disassembler patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 26 October 2017 at 08:06, Daniel P. Berrange <berrange@redhat.com> wrote:
> I'm not sure what's giving you the 'pathspec' message though ? I would
> expect anything to ignore the capstone dir - its just like any other
> untracked file once you go back in time before it was committed.

Sorry, just realized that was the output of my filtering of the
log. Here's what I should have quoted:

>From git://git.linaro.org/people/pmaydell/qemu-arm
 + a872ea5...6315472 staging    -> pmaydell/staging  (forced update)
warning: unable to rmdir capstone: Directory not empty
error: pathspec 'capstone' did not match any file(s) known to git.
Did you forget to 'git add'?
make: Entering directory `/home/pm215/qemu/build/all'
config-host.mak is out-of-date, running configure
  GIT     ui/keycodemapdb dtc capstone
make[1]: *** No rule to make target `all'.  Stop.
error: pathspec 'capstone' did not match any file(s) known to git.
Did you forget to 'git add'?
make: *** [git-submodule-update] Error 1
make: *** Waiting for unfinished jobs....
make: *** [subdir-capstone] Error 2
Install prefix    /usr/local
BIOS directory    /usr/local/share/qemu
firmware path     /usr/local/share/qemu-firmware
binary directory  /usr/local/bin
[rest of configure output skipped]
replication support yes
VxHS block device no
make: Leaving directory `/home/pm215/qemu/build/all'

It looks like the git update script thinks that there ought to
be a 'capstone' submodule, which of course there isn't any more,
so it barfs trying to update it.

thanks
-- PMM
