Received: from eggs.gnu.org ([2001:4830:134:3::10]:38908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erjxf-0002Ag-Ma
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 07:38:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erjxe-00021K-AW
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 07:38:55 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:42444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erjxe-0001zO-5I
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 07:38:54 -0500
Received: by mail-ot0-x22f.google.com with SMTP id l5so8559246otf.9
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 04:38:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180302013007.11827-1-eblake@redhat.com>
References: <20180302013007.11827-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Mar 2018 12:38:32 +0000
Message-ID: <CAFEAcA94aLXy8Zy5hjLMH5=x3LG5Z5icpzYJ+tHazFw3YQ_d4Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/30] QAPI patches for 2018-03-01
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 2 March 2018 at 01:29, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit 0dc8ae5e8e693737dfe65ba02d0c6eccb58a9c67:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20180301-v2' into staging (2018-03-01 17:08:16 +0000)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-01-v2
>
> for you to fetch changes up to 76b2baeed38089c19f69c7117b8eaa64b0e7d227:
>
>   qapi: Don't create useless directory qapi-generated (2018-03-01 19:16:40 -0600)
>
> v2: fix rebase on top of s390x work so that build is successful
> (if I do it right, I'm sending just the changed patches)
>
> Again, this series will be a conflict magnet due to content motion
> from qapi-schema.json to qapi/misc.json; hopefully, the level of
> rebasing required is not too painful
>
> ----------------------------------------------------------------
> qapi patches for 2018-03-01
>
> - Markus Armbruster: Modularize generated QAPI code
>

This produces a huge pile of warnings from my OSX toolchain.

When running ar on libqemuutil.a:
  AR      libqemuutil.a
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libqemuutil.a(qapi-types.o) has no symbols
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libqemuutil.a(qapi-visit.o) has no symbols
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libqemuutil.a(qapi-events.o) has no symbols
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libqemuutil.a(qapi-events-common.o) has no symbols
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libqemuutil.a(qapi-events-crypto.o) has no symbols
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libqemuutil.a(qapi-events-introspect.o) has no symbols
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libqemuutil.a(qapi-events-rocker.o) has no symbols
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libqemuutil.a(qapi-events-sockets.o) has no symbols
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libqemuutil.a(qapi-events-tpm.o) has no symbols
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libqemuutil.a(qapi-events-trace.o) has no symbols
/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/ranlib:
file: libqemuutil.a(qapi-events-transaction.o) has no symbols

On every link of a binary:
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm:
no name list
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm:
no name list
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm:
no name list
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm:
no name list
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm:
no name list
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm:
no name list
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm:
no name list
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm:
no name list
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm:
no name list
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm:
no name list
warning: /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/nm:
no name list

I think these are related -- nm complains once for every .o file in the archive
that doesn't have any symbols in it.

I had a look at the autogenerated .c files on my Linux build, and they
seem to consist only of a bunch of #includes. Why are we not generating
any code here?

thanks
-- PMM
