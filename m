Received: from eggs.gnu.org ([2001:4830:134:3::10]:40996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1f1xIh-0005sl-WA
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 12:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1f1xId-0003IZ-QW
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 12:54:52 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:45708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1f1xId-0003IR-IJ
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 12:54:47 -0400
Received: by mail-io0-x243.google.com with SMTP id 141so11603328iou.12
	for <qemu-devel@nongnu.org>; Fri, 30 Mar 2018 09:54:46 -0700 (PDT)
References: <20180320090813.852-1-laurent@vivier.eu>
From: Rob Landley <rob@landley.net>
Message-ID: <d409453e-21c4-c989-c40c-442dcb8f2636@landley.net>
Date: Fri, 30 Mar 2018 11:54:43 -0500
MIME-Version: 1.0
In-Reply-To: <20180320090813.852-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/2] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org

On 03/20/2018 04:08 AM, Laurent Vivier wrote:> This series of patches is needed
to fix a problem
> in the m68k translator that can crash QEMU when translation
> cache has too many instructions:
> 
>   qemu-m68k: tcg/tcg.c:883: tcg_temp_alloc: Assertion `n < 512' failed.
>   qemu: uncaught target signal 11 (Segmentation fault) - core dumped
> 
> I have reproduced it in linux user mode, with "ghc", and in
> system mode with the debian-installer for unstable distro
> from debian-ports.

If someone wanted to follow along with your "boot linux on qemu-system-m68k"
work on https://github.com/vivier/qemu-m68k, which of the 51 branches should
qemu-system-m68k with like -M q800 or whatever you had working be built from?

Also, "git pull" of the last tree I had from there exploded into a fireball of
automerge conflicts. Is there something I should know?

Rob
