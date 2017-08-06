Received: from eggs.gnu.org ([2001:4830:134:3::10]:40099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1deJzS-0003Pf-AJ
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 07:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1deJzN-00027b-BD
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 07:45:02 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:52558
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1deJzN-00026p-3e
	for qemu-devel@nongnu.org; Sun, 06 Aug 2017 07:44:57 -0400
References: <CADsqsq+TieaYKCUDLetQR7QVkubTV4w+82ByAQGzrrM6ebcGYg@mail.gmail.com>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <5c835b9a-cf6e-6c00-119c-c6082f288bf5@weilnetz.de>
Date: Sun, 6 Aug 2017 13:44:52 +0200
MIME-Version: 1.0
In-Reply-To: <CADsqsq+TieaYKCUDLetQR7QVkubTV4w+82ByAQGzrrM6ebcGYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Editing qemu source code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shantanu Agarwal <shantanu16111994@gmail.com>, qemu-devel@nongnu.org

Am 06.08.2017 um 13:25 schrieb Shantanu Agarwal:
> Hello all,
> I was reading about qemu, trying to understand the source code. I found
> that vl.c is considered the main file of qemu source code from where all
> the execution starts. So I flipped some values, i even put a exit(0) just
> after the int main starts, but nothing is changed. Qemu is fully
> functional. Also i put many printf's in between but no output at all. Am I
> missing something or vl.c is not the main file.
> 

Hi,

the main function in vl.c is the correct entry point.
If you don't see an effect of your changes, then you
are probably calling an executable which is not the
changed one.

What about using gdb to see what happens?

Regards
Stefan
