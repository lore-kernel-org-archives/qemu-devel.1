Received: from eggs.gnu.org ([2001:4830:134:3::10]:42660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f1xOP-0001iv-Ec
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1f1xOK-0005qt-K0
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:00:45 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:36641)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1f1xOK-0005qD-AG
	for qemu-devel@nongnu.org; Fri, 30 Mar 2018 13:00:40 -0400
References: <20180320090813.852-1-laurent@vivier.eu>
	<d409453e-21c4-c989-c40c-442dcb8f2636@landley.net>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <7cac14a3-c097-572e-4b61-8960209f6bd9@vivier.eu>
Date: Fri, 30 Mar 2018 19:00:35 +0200
MIME-Version: 1.0
In-Reply-To: <d409453e-21c4-c989-c40c-442dcb8f2636@landley.net>
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
To: Rob Landley <rob@landley.net>, qemu-devel@nongnu.org

Le 30/03/2018 à 18:54, Rob Landley a écrit :
> On 03/20/2018 04:08 AM, Laurent Vivier wrote:> This series of patches is needed
> to fix a problem
>> in the m68k translator that can crash QEMU when translation
>> cache has too many instructions:
>>
>>   qemu-m68k: tcg/tcg.c:883: tcg_temp_alloc: Assertion `n < 512' failed.
>>   qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>>
>> I have reproduced it in linux user mode, with "ghc", and in
>> system mode with the debian-installer for unstable distro
>> from debian-ports.
> 
> If someone wanted to follow along with your "boot linux on qemu-system-m68k"
> work on https://github.com/vivier/qemu-m68k, which of the 51 branches should
> qemu-system-m68k with like -M q800 or whatever you had working be built from?

The branch to use is q800-dev

> 
> Also, "git pull" of the last tree I had from there exploded into a fireball of
> automerge conflicts. Is there something I should know?

As I rebase the branch regularly, a simple "git pull" will not work.

If the branch already exist locally

  git checkout q800-dev
  git reset --hard vivier/q800-dev

  [I guess the remote name is "vivier"]

otherwise, a simple "git checkout q800-dev" should create the branch
from scrash.

Thanks,
Laurent
