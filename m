Received: from eggs.gnu.org ([2001:4830:134:3::10]:53165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1f33x5-0004wJ-8e
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 14:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1f33x2-0007bN-0M
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 14:13:07 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:36746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1f33x1-0007b9-Rd
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 14:13:03 -0400
Received: by mail-io0-x241.google.com with SMTP id o4so18873772iod.3
	for <qemu-devel@nongnu.org>; Mon, 02 Apr 2018 11:13:03 -0700 (PDT)
References: <20180320090813.852-1-laurent@vivier.eu>
	<d409453e-21c4-c989-c40c-442dcb8f2636@landley.net>
	<7cac14a3-c097-572e-4b61-8960209f6bd9@vivier.eu>
From: Rob Landley <rob@landley.net>
Message-ID: <67f4fb22-9ad5-7f41-371a-001d1346fc4f@landley.net>
Date: Mon, 2 Apr 2018 13:13:00 -0500
MIME-Version: 1.0
In-Reply-To: <7cac14a3-c097-572e-4b61-8960209f6bd9@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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

On 03/30/2018 12:00 PM, Laurent Vivier wrote:
> Le 30/03/2018 à 18:54, Rob Landley a écrit :
>> On 03/20/2018 04:08 AM, Laurent Vivier wrote:> This series of patches is needed
>> to fix a problem
>>> in the m68k translator that can crash QEMU when translation
>>> cache has too many instructions:
>>>
>>>   qemu-m68k: tcg/tcg.c:883: tcg_temp_alloc: Assertion `n < 512' failed.
>>>   qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>>>
>>> I have reproduced it in linux user mode, with "ghc", and in
>>> system mode with the debian-installer for unstable distro
>>> from debian-ports.
>>
>> If someone wanted to follow along with your "boot linux on qemu-system-m68k"
>> work on https://github.com/vivier/qemu-m68k, which of the 51 branches should
>> qemu-system-m68k with like -M q800 or whatever you had working be built from?
> 
> The branch to use is q800-dev

There isn't any m68k support in musl-libc yet, so I grabbed my old
https://github.com/landley/aboriginal project, did a "./build.sh m68k", built
your q800-dev branch, added the m68k-softmmu from that to the start of the
$PATH, and ran "more/dev-environment-from-build.sh m68k".

It booted Linux to a shell prompt, I could wget a file from the internet, and
/home had the 2 gigabyte ext3 mount from the virtual block device.

I.E. it works for me. Why is it still out of tree?

Rob
