Received: from eggs.gnu.org ([209.51.188.92]:60581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWGa-00022v-VV
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWGZ-0004wZ-VP
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:22:12 -0400
References: <20190503111832.30316-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <c2a39c3c-c9df-12d1-7dac-5ffe14a64ad7@vivier.eu>
Date: Fri, 3 May 2019 13:21:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190503111832.30316-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL v2 00/12] Trivial branch patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, qemu-trivial@nongnu.org, Richard Henderson <rth@twiddle.net>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>, Michael Tokarev <mjt@tls.msk.ru>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 03/05/2019 13:18, Laurent Vivier wrote:
> The following changes since commit 8482ff2eb3bb95020eb2f370a9b3ea26511e41df:
> 
>   Merge remote-tracking branch 'remotes/jnsnow/tags/bitmaps-pull-request' into staging (2019-05-02 12:04:51 +0100)
> 
> are available in the Git repository at:
> 
>   git://github.com/vivier/qemu.git tags/trivial-branch-pull-request
> 
> for you to fetch changes up to 2d2023c3b99edb33ad4bb9791f70456ea1a1c049:
> 
>   sockets: avoid string truncation warnings when copying UNIX path (2019-05-03 13:03:04 +0200)
> 
> ----------------------------------------------------------------
> Pull request trivial branch 2019-05-03
> 
> ----------------------------------------------------------------
> 
> Aruna Jayasena (1):
>   Header cleanups
> 
> Daniel P. Berrangé (1):
>   sockets: avoid string truncation warnings when copying UNIX path
> 
> Dr. David Alan Gilbert (1):
>   configure: fix pam test warning
> 
> Marc-André Lureau (1):
>   doc: fix the configuration path
> 
> Philippe Mathieu-Daudé (3):
>   hw/net/pcnet: Use qemu_log_mask(GUEST_ERROR) instead of printf
>   Makefile: Let the 'clean' rule remove qemu-ga.exe on Windows hosts
>   hw/sparc/leon3: Allow load of uImage firmwares
> 
> Stefan Weil (1):
>   Update configure
> 
> Thomas Huth (1):
>   net: Print output of "-net nic, model=help" to stdout instead of
>     stderr
> 
> Wei Yang (3):
>   CODING_STYLE: specify the indent rule for multiline code
>   CODING_STYLE: indent example code as all others
>   qom: use object_new_with_type in object_new_with_propv
> 
>  qemu-ga.texi              |  4 ++--
>  configure                 |  5 ++---
>  Makefile                  | 11 +++++----
>  include/exec/cpu-common.h |  3 ---
>  hw/net/pcnet.c            |  4 +++-
>  hw/sparc/leon3.c          |  4 ++++
>  net/net.c                 |  7 +++---
>  qom/object.c              |  2 +-
>  util/qemu-sockets.c       | 12 ++++++----
>  CODING_STYLE              | 47 +++++++++++++++++++++++++++++++++++----
>  10 files changed, 74 insertions(+), 25 deletions(-)
> 

Forget this series, the send has been aborted for an unknown reason.

Thanks,
Laurent
