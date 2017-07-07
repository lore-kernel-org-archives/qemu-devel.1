Received: from eggs.gnu.org ([2001:4830:134:3::10]:40768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTOV9-0003gU-Ep
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTOV4-00081h-GH
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:20:35 -0400
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:34848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTOV4-00080x-BQ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 04:20:30 -0400
Received: by mail-qk0-x241.google.com with SMTP id 16so3429101qkg.2
	for <qemu-devel@nongnu.org>; Fri, 07 Jul 2017 01:20:30 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
	<9645bafa-2c7e-96e8-5f3c-9cf7a9415285@physik.fu-berlin.de>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <51a3a21f-6145-d721-170f-b8cf20cbc2d9@twiddle.net>
Date: Thu, 6 Jul 2017 22:20:24 -1000
MIME-Version: 1.0
In-Reply-To: <9645bafa-2c7e-96e8-5f3c-9cf7a9415285@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/27] linux-user/sh4: Notice gUSA
 regions during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 07/06/2017 09:25 PM, John Paul Adrian Glaubitz wrote:
> On 07/07/2017 04:20 AM, Richard Henderson wrote:
>> We translate gUSA regions atomically in a parallel context.
>> But in a serial context a gUSA region may be interrupted.
>> In that case, restart the region as the kernel would.
> 
> This patch is still causing random segfaults, unfortunately:
> 
> Setting up dpkg (1.18.24+b1) ...
> Setting up perl-base (5.24.1-5) ...
> Setting up grep (2.27-2) ...
> Setting up debconf (1.5.62) ...
> Setting up tzdata (2017b-2) ...
> 
> Current default time zone: 'Etc/UTC'
> Local time is now:      Fri Jul  7 07:17:20 UTC 2017.
> Universal Time is now:  Fri Jul  7 07:17:20 UTC 2017.
> Run 'dpkg-reconfigure tzdata' if you wish to change it.
> 
> qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> dpkg: error processing package tzdata (--configure):
>   subprocess installed post-installation script was killed by signal (Segmentation fault)
> Setting up gzip (1.6-5) ...
> Setting up dash (0.5.8-2.4) ...
> Setting up init-system-helpers (1.48) ...
> Setting up libpam0g:sh4 (1.1.8-3.6) ...
> Setting up libpam-modules-bin (1.1.8-3.6) ...
> Setting up bash (4.4-5) ...

How do I reproduce this from the filesystem image you linked earlier?


r~
