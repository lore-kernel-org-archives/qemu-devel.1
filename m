Received: from eggs.gnu.org ([209.51.188.92]:54880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gprz6-0006z8-6I
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 04:53:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gprtc-0008Ug-Qj
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 04:47:36 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:51375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gprtW-0008PX-20
	for qemu-devel@nongnu.org; Sat, 02 Feb 2019 04:47:29 -0500
Received: by mail-wm1-x32e.google.com with SMTP id b11so8451726wmj.1
	for <qemu-devel@nongnu.org>; Sat, 02 Feb 2019 01:47:21 -0800 (PST)
MIME-Version: 1.0
References: <20190123114220.16972-1-alex.bennee@linaro.org>
	<39aa1e09-ecb9-b795-9ec2-1835a40edd20@redhat.com>
In-Reply-To: <39aa1e09-ecb9-b795-9ec2-1835a40edd20@redhat.com>
From: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Date: Sat, 2 Feb 2019 09:47:09 +0000
Message-ID: <CAHDbmO0Vt8PUNNAsmd9V0_U-W+r+C9CRE0FfOK2dULyQj5VXVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/11] check-softfloat,
 fp-bench and clang compile fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

I'll add an ignore when I send the next fpu series.

Thanks.

On Fri, 1 Feb 2019, 18:44 Eric Blake <eblake@redhat.com wrote:

> On 1/23/19 5:42 AM, Alex Benn=C3=A9e wrote:
> > The following changes since commit
> 952bc8b3c2cbba78261923a1e8ca55cda261dee9:
> >
> >   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-01-21'
> into staging (2019-01-22 17:56:21 +0000)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/stsquad/qemu.git tags/pull-fpu-next-230119-2
> >
> > for you to fetch changes up to 7617010250822677348af2bd98f048be10e7f334=
:
> >
> >   tests/Makefile: add check-softfloat rule (2019-01-23 08:30:01 +0000)
> >
> > ----------------------------------------------------------------
> > Some more softfloat/fpu fixes
> >
> >    - make check-softfloat
> >    - fixes for fp-bench
> >    - workaround broken host fma
> >    - compile fix for s390x/clang
> >    - fixed for bigendian (v2)
> >    - minor makefile tweaks (v2)
>
> I think this series is the reason that an in-tree 'make && make check &&
> git status' is now showing a bunch of untracked files:
>
>         tests/fp/add.out
>         tests/fp/div.out
>         tests/fp/eq.out
> ...
>
> I suggest a followup patch to amend a .gitignore for tests/fp/*.out
>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>
>
