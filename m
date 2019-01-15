Received: from eggs.gnu.org ([209.51.188.92]:58502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjSfh-0006yk-19
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjSfd-0002ua-NQ
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:38:39 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjSfN-0002oS-Bd
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 12:38:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id g67so4111361wmd.2
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 09:38:18 -0800 (PST)
References: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a7edc75f-4d59-29ab-463f-44e0aacb0d84@redhat.com>
Date: Tue, 15 Jan 2019 18:38:10 +0100
MIME-Version: 1.0
In-Reply-To: <20181220012441.13694-1-viktor.prutyanov@phystech.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/6] contrib/elf2dmp: elf2dmp for
 Windows hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>, rkagan@virtuozzo.com
Cc: qemu-devel@nongnu.org

On 20/12/18 02:24, Viktor Prutyanov wrote:
> In most cases, it is more convenient to convert a dump on the same machine
> on which the analysis is performed. Because of WinDbg, the analysis of guest
> Windows problems needs Windows host anyway, so it is useful to have dump
> convertion tool near the debugger.
> After these patches elf2dmp can be built both for Linux and Windows (x86
> and x86_64) hosts.
> 
> Viktor Prutyanov (6):
>   contrib/elf2dmp: fix elf.h including
>   contrib/elf2dmp: use GLib in ELF processing
>   contrib/elf2dmp: use GLib in PDB processing
>   contrib/elf2dmp: fix structures definitions
>   contrib/elf2dmp: fix printf format
>   configure: enable elf2dmp build for Windows hosts
> 
>  Makefile                   |  4 ++--
>  configure                  |  4 ++--
>  contrib/elf2dmp/kdbg.h     | 12 ++++++++----
>  contrib/elf2dmp/main.c     | 27 +++++++++++++++------------
>  contrib/elf2dmp/pdb.c      | 33 +++++++++++----------------------
>  contrib/elf2dmp/pdb.h      |  4 +++-
>  contrib/elf2dmp/pe.h       |  6 ++++--
>  contrib/elf2dmp/qemu_elf.c | 27 ++++++++-------------------
>  contrib/elf2dmp/qemu_elf.h | 10 +++++-----
>  9 files changed, 58 insertions(+), 69 deletions(-)
> 

Queued, thanks.

Paolo
