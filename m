Received: from eggs.gnu.org ([2001:4830:134:3::10]:53164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cqz05-0006Af-Ng
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cqz00-0007zP-QH
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:25:45 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:38612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cqz00-0007yP-Jk
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 05:25:40 -0400
Received: by mail-wm0-x22e.google.com with SMTP id t189so57455761wmt.1
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 02:25:40 -0700 (PDT)
References: <CAFEAcA9pqDoCWrPAJ+KVxLC_eRy-xRg36oYuARYg2YP8VpGpBg@mail.gmail.com>
	<c46ff864-fc8b-aeba-30f4-4c773f879786@redhat.com>
	<CAFEAcA_YdidZBNT79bC+NjPj1CvZBLKmCu4jF_28FipOzJuoxA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_YdidZBNT79bC+NjPj1CvZBLKmCu4jF_28FipOzJuoxA@mail.gmail.com>
Date: Thu, 23 Mar 2017 09:25:37 +0000
Message-ID: <87fui4xs32.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] rawhide gcc failures [was: Proposal for
 deprecating unsupported host OSes & architecutures]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Eric Blake <eblake@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 22 March 2017 at 19:07, Eric Blake <eblake@redhat.com> wrote:
>> Tangentially-related: do we officially support bleeding-edge OS builds?
>> For example, current rawhide has a new-enough gcc that gives some
>> (possibly-useful) new warnings (-Werror=format-truncation)
>
> Depends what you mean by "support". Are we testing them
> in our build/CI loop? Apparently not :-)

We test some. The Travis loop currently installs the toolchain PPAs for
two of its runs to use:

        - COMPILER_NAME=clang CXX=clang++-3.9 CC=clang-3.9
        - COMPILER_NAME=gcc CXX=g++-5 CC=gcc-5

That said it probably makes more sense to add a rawhide docker image for
testing. Whether it is worth running it on every patch series remains to
be seen as while it might give some advanced warning could it also be
because the bleeding edge distro is broken in some other way?

> Do we fix them?
> Yep, certainly, because bleeding-edge libraries and
> compilers will eventually be standard ones. Do we fix
> them during the release process? Yes, but maybe if
> the fix is very invasive somehow we might prefer to
> postpone to the next release. Do we consider them
> a release-critical bug that we'd spin an extra rc
> for? I don't think so, because (a) for released tarballs
> -Werror is not on by default (b) even for building from
> git you can work around this with -disable-werror
> (c) it's just an accident of timing if a new gcc drops
> 3 weeks before release rather than 3 weeks after, so
> it's always possible that releases will end up being
> built on compilers that warn about things in them.
>
> More generally, I'm not going to go so far as to insist
> that we have a build machine for every flavour of every
> distro -- that would not usefully improve coverage I think.
> Also I'm happy to be ad-hoc about exactly what we test
> (my x86 Linux builds are just "the Ubuntu flavour my
> desktop box happens to be running right now") because
> being less ad-hoc feels like it would be work that
> we don't really need to engage in.
>
> thanks
> -- PMM


--
Alex Bennée
