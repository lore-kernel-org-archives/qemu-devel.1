Received: from eggs.gnu.org ([2001:4830:134:3::10]:46180)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceXLc-00020V-4S
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 20:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nirsof@gmail.com>) id 1ceXLa-0000ZF-UW
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 20:28:32 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:34212)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nirsof@gmail.com>) id 1ceXLa-0000Z0-Py
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 20:28:30 -0500
Received: by mail-ot0-x243.google.com with SMTP id 45so430553otd.1
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 17:28:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170217005431.4016-2-bobby.prani@gmail.com>
References: <20170217005431.4016-1-bobby.prani@gmail.com>
	<20170217005431.4016-2-bobby.prani@gmail.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Fri, 17 Feb 2017 03:28:29 +0200
Message-ID: <CAMr-obvtzqgFT1XZp5pg-b8PaDq4BT+a_WsKuhnjTLOp-py4tQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/2] Update README to accomodate markdown
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: alex.bennee@linaro.org, peter.maydell@linaro.org, qemu-devel@nongnu.org, stefanha@redhat.com

On Fri, Feb 17, 2017 at 2:54 AM, Pranith Kumar <bobby.prani@gmail.com> wrote:
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  README | 44 +++++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 23 deletions(-)
>
> diff --git a/README b/README
> index cb60d05bee..225afd6be7 100644
> --- a/README
> +++ b/README
> @@ -1,5 +1,5 @@
> -         QEMU README
> -         ===========
> +QEMU
> +====
>
>  QEMU is a generic and open source machine & userspace emulator and
>  virtualizer.
> @@ -31,22 +31,22 @@ version 2. For full licensing details, consult the LICENSE file.
>
>
>  Building
> -========
> +--------
>
>  QEMU is multi-platform software intended to be buildable on all modern
>  Linux platforms, OS-X, Win32 (via the Mingw64 toolchain) and a variety
>  of other UNIX targets. The simple steps to build QEMU are:
>
> -  mkdir build
> -  cd build
> -  ../configure
> -  make
> +    mkdir build
> +    cd build
> +    ../configure
> +    make
>
>  Additional information can also be found online via the QEMU website:
>
> -  http://qemu-project.org/Hosts/Linux
> -  http://qemu-project.org/Hosts/Mac
> -  http://qemu-project.org/Hosts/W32
> +  - http://qemu-project.org/Hosts/Linux
> +  - http://qemu-project.org/Hosts/Mac
> +  - http://qemu-project.org/Hosts/W32
>
>
>  Submitting patches

You missed this title

> @@ -54,7 +54,7 @@ Submitting patches
>
>  The QEMU source code is maintained under the GIT version control system.
>
> -   git clone git://git.qemu-project.org/qemu.git
> +    git clone git://git.qemu-project.org/qemu.git
>
>  When submitting patches, the preferred approach is to use 'git
>  format-patch' and/or 'git send-email' to format & send the mail to the
> @@ -65,18 +65,18 @@ guidelines set out in the HACKING and CODING_STYLE files.
>  Additional information on submitting patches can be found online via
>  the QEMU website
>
> -  http://qemu-project.org/Contribute/SubmitAPatch
> -  http://qemu-project.org/Contribute/TrivialPatches
> +  - http://qemu-project.org/Contribute/SubmitAPatch
> +  - http://qemu-project.org/Contribute/TrivialPatches
>
>
>  Bug reporting
> -=============
> +-------------
>
>  The QEMU project uses Launchpad as its primary upstream bug tracker. Bugs
>  found when running code built from QEMU git or upstream released sources
>  should be reported via:
>
> -  https://bugs.launchpad.net/qemu/
> +  - https://bugs.launchpad.net/qemu/
>
>  If using QEMU via an operating system vendor pre-built binary package, it
>  is preferable to report bugs to the vendor's own bug tracker first. If
> @@ -85,22 +85,20 @@ reported via launchpad.
>
>  For additional information on bug reporting consult:
>
> -  http://qemu-project.org/Contribute/ReportABug
> +  - http://qemu-project.org/Contribute/ReportABug
>
>
>  Contact
> -=======
> +-------
>
>  The QEMU community can be contacted in a number of ways, with the two
>  main methods being email and IRC
>
> - - qemu-devel@nongnu.org
> -   http://lists.nongnu.org/mailman/listinfo/qemu-devel
> - - #qemu on irc.oftc.net
> + - Mailing List: qemu-devel@nongnu.org
> + - Archives: http://lists.nongnu.org/mailman/listinfo/qemu-devel
> + - IRC: #qemu on irc.oftc.net
>
>  Information on additional methods of contacting the community can be
>  found online via the QEMU website:
>
> -  http://qemu-project.org/Contribute/StartHere
> -
> --- End
> +  - http://qemu-project.org/Contribute/StartHere

Much nicer now!

Nir
