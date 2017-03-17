Received: from eggs.gnu.org ([2001:4830:134:3::10]:44860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cow35-0003mn-JM
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 13:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cow31-00049x-M9
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 13:52:23 -0400
References: <20170317160811.28370-1-pbonzini@redhat.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <86a22787-b3d0-dd32-9925-61f94de4ad33@weilnetz.de>
Date: Fri, 17 Mar 2017 18:52:15 +0100
MIME-Version: 1.0
In-Reply-To: <20170317160811.28370-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 2.9 v2] configure: remove Cygwin
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, thuth@redhat.com, QEMU Trivial <qemu-trivial@nongnu.org>

Am 17.03.2017 um 17:08 schrieb Paolo Bonzini:
> The Cygwin target is really compiling for native Win32 with -mno-cygwin.
> Except, GCC 4.7.0 has finally removed the long deprecated -mno-cygwin
> option, and that happened about five years ago.
>
> Let it rest in peace.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Stefan Weil <sw@weilnetz.de>

CC'ing qemu-trivial for the pull request.

I only wonder whether we should raise an error if people
try building QEMU with native Cygwin (not Cygwin / Mingw-w64).

Stefan


>  bsd-user/mmap.c | 5 -----
>  configure       | 6 ------
>  2 files changed, 11 deletions(-)
>
> diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
> index ee59073..1ad018a 100644
> --- a/bsd-user/mmap.c
> +++ b/bsd-user/mmap.c
> @@ -199,12 +199,7 @@ static int mmap_frag(abi_ulong real_start,
>      return 0;
>  }
>
> -#if defined(__CYGWIN__)
> -/* Cygwin doesn't have a whole lot of address space.  */
> -static abi_ulong mmap_next_start = 0x18000000;
> -#else
>  static abi_ulong mmap_next_start = 0x40000000;
> -#endif
>
>  unsigned long last_brk;
>
> diff --git a/configure b/configure
> index 99d8bec..b9a30cf 100755
> --- a/configure
> +++ b/configure
> @@ -553,12 +553,6 @@ fi
>  HOST_VARIANT_DIR=""
>
>  case $targetos in
> -CYGWIN*)
> -  mingw32="yes"
> -  QEMU_CFLAGS="-mno-cygwin $QEMU_CFLAGS"
> -  audio_possible_drivers="sdl"
> -  audio_drv_list="sdl"
> -;;
>  MINGW32*)
>    mingw32="yes"
>    hax="yes"
>
