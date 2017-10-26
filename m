Received: from eggs.gnu.org ([2001:4830:134:3::10]:47877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7f1Q-0005ac-Hf
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7f1K-0004Ab-Om
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:04:20 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:45773)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7f1K-0004AO-Hq
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 06:04:14 -0400
Received: by mail-wm0-x230.google.com with SMTP id q124so6858014wmb.0
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 03:04:14 -0700 (PDT)
References: <20171025123056.3165-1-richard.henderson@linaro.org>
	<CAFEAcA99zpvcgk2EuXkrcOY+8rHeRkJhH4GqViJkEgQV3bdWFg@mail.gmail.com>
	<CAFEAcA9XdoV0YVw+q7op_vafe9X0JTiQdYmGcmPgqRR3qhUYrQ@mail.gmail.com>
	<20171026070608.GC5847@redhat.com>
	<CAFEAcA8f7jJsM3=4bZG8fE_kTm6jueC-rF6ga0mdUvzMDSpLwQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b0a282ab-1f30-3e57-72e4-9f91c5dce69b@linaro.org>
Date: Thu, 26 Oct 2017 12:04:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8f7jJsM3=4bZG8fE_kTm6jueC-rF6ga0mdUvzMDSpLwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 00/11] Disassembler patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10/26/2017 09:21 AM, Peter Maydell wrote:
> On 26 October 2017 at 08:06, Daniel P. Berrange <berrange@redhat.com> wrote:
>> I'm not sure what's giving you the 'pathspec' message though ? I would
>> expect anything to ignore the capstone dir - its just like any other
>> untracked file once you go back in time before it was committed.
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

Looks like we need to make git-submodule-update depend on config-host.mak, so
that we have already re-run configure, so that vanishing modules will have been
de-selected.

Forcing a configure re-run by hand would have masked this problem.  I think all
of the testing that I have been doing has been builds from empty build directories.


r~
