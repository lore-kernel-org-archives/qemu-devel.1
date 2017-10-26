Received: from eggs.gnu.org ([2001:4830:134:3::10]:48272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7f3v-0006aZ-C3
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:06:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7f3r-0005wZ-GY
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:06:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e7f3r-0005wO-7F
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:06:51 -0400
Date: Thu, 26 Oct 2017 11:06:45 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171026100645.GA24581@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
	<CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
	<CAFEAcA9XdoV0YVw+q7op_vafe9X0JTiQdYmGcmPgqRR3qhUYrQ@mail.gmail.com>
	<20171026070608.GC5847@redhat.com>
	<CAFEAcA8f7jJsM3=4bZG8fE_kTm6jueC-rF6ga0mdUvzMDSpLwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8f7jJsM3=4bZG8fE_kTm6jueC-rF6ga0mdUvzMDSpLwQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/11] Disassembler patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Thu, Oct 26, 2017 at 08:21:48AM +0100, Peter Maydell wrote:
> On 26 October 2017 at 08:06, Daniel P. Berrange <berrange@redhat.com> wrote:
> > I'm not sure what's giving you the 'pathspec' message though ? I would
> > expect anything to ignore the capstone dir - its just like any other
> > untracked file once you go back in time before it was committed.
> 
> Sorry, just realized that was the output of my filtering of the
> log. Here's what I should have quoted:
> 
> From git://git.linaro.org/people/pmaydell/qemu-arm
>  + a872ea5...6315472 staging    -> pmaydell/staging  (forced update)
> warning: unable to rmdir capstone: Directory not empty
> error: pathspec 'capstone' did not match any file(s) known to git.
> Did you forget to 'git add'?
> make: Entering directory `/home/pm215/qemu/build/all'
> config-host.mak is out-of-date, running configure
>   GIT     ui/keycodemapdb dtc capstone
> make[1]: *** No rule to make target `all'.  Stop.
> error: pathspec 'capstone' did not match any file(s) known to git.
> Did you forget to 'git add'?
> make: *** [git-submodule-update] Error 1
> make: *** Waiting for unfinished jobs....
> make: *** [subdir-capstone] Error 2
> Install prefix    /usr/local
> BIOS directory    /usr/local/share/qemu
> firmware path     /usr/local/share/qemu-firmware
> binary directory  /usr/local/bin
> [rest of configure output skipped]
> replication support yes
> VxHS block device no
> make: Leaving directory `/home/pm215/qemu/build/all'
> 
> It looks like the git update script thinks that there ought to
> be a 'capstone' submodule, which of course there isn't any more,
> so it barfs trying to update it.

Yeah, ok that makes more sense.  The 'config-host.mak' rules have the
list of desired submodules and those correspond to the state when you
ran configure with the patches applied.

Do we really expect make/configure todo the right thing when going
backwards in time ?  I've always assumed that if you go back in time
when you need to do a 'git clean -f -x d' and re-run configure from
scratch. Certainly in the past various makefile changes in QEMU would
break, or silently not correctly recompile stuff when going backwards
in time.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
