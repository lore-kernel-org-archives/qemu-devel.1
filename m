Received: from eggs.gnu.org ([2001:4830:134:3::10]:37862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7cF9-00020V-H9
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:06:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e7cF3-0002Sy-Fo
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:06:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e7cF3-0002SH-9a
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 03:06:13 -0400
Date: Thu, 26 Oct 2017 08:06:08 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171026070608.GC5847@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20171025123056.3165-1-richard.henderson@linaro.org>
	<CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
	<CAFEAcA9XdoV0YVw+q7op_vafe9X0JTiQdYmGcmPgqRR3qhUYrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA9XdoV0YVw+q7op_vafe9X0JTiQdYmGcmPgqRR3qhUYrQ@mail.gmail.com>
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

On Thu, Oct 26, 2017 at 07:16:45AM +0100, Peter Maydell wrote:
> On 26 October 2017 at 07:07, Peter Maydell <peter.maydell@linaro.org> wrote:
> > Hi. This failed to build for Windows:
> 
> Also, after it failed and I backed out the merge, the next thing I
> tried to build failed everywhere with:
> 
> warning: unable to rmdir capstone: Directory not empty
> error: pathspec 'capstone' did not match any file(s) known to git.
> error: pathspec 'capstone' did not match any file(s) known to git.
> 
> That's bad, because it suggests that bisection is going to break
> across this merge commit.
> 
> Dan, is this going to be a generic problem with the new submodule
> stuff, or is it specific to something with how the capstone
> submodule is being handled in this patchset?

If you make your checkout go back in time to before the submodule
existed, git won't delete your checked out submodule - in case you
have commits there you still care about. So it'll print that warning
about unable to 'rmdir'. This should be harmless to the build process
in general though.

I'm not sure what's giving you the 'pathspec' message though ? I would
expect anything to ignore the capstone dir - its just like any other
untracked file once you go back in time before it was committed.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
