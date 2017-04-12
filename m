Received: from eggs.gnu.org ([2001:4830:134:3::10]:47178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cyMUi-0000It-MT
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:55:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cyMUf-0001HL-KN
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:55:52 -0400
Received: from mail.weilnetz.de ([37.120.169.71]:56518
	helo=v2201612906741603.powersrv.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cyMUf-0001Gg-E6
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 13:55:49 -0400
References: <8a7bf9dbac4c6db5b7e8dd5c968cacae@ispras.ru>
	<20170412163055.GB4915@rkaganb.sw.ru>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <ec726281-486f-5448-4c3c-c28375c182cb@weilnetz.de>
Date: Wed, 12 Apr 2017 19:55:45 +0200
MIME-Version: 1.0
In-Reply-To: <20170412163055.GB4915@rkaganb.sw.ru>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] WinDbg module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, Mihail Abakumov <mikhail.abakumov@ispras.ru>, qemu-devel@nongnu.org, Pavel Dovgalyuk <dovgaluk@ispras.ru>, pbonzini@redhat.com

Am 12.04.2017 um 18:30 schrieb Roman Kagan:
> On Wed, Apr 12, 2017 at 05:05:45PM +0300, Mihail Abakumov wrote:
>> Hello.
>>
>> We made the debugger module WinDbg (like GDB) for QEMU. This is the
>> replacement of the remote stub in Windows kernel. Used for remote Windows
>> kernel debugging without debugging mode.
>>
>> The latest build and instructions for the launch can be found here:
>> https://github.com/ispras/qemu/releases/tag/v2.7.50-windbg
>>
>> Currently only one ways to create a remote debugging connection is
>> supported: using COM port with named pipe.
>>
>> Should I prepare patches for inclusion in the master branch? Or is it too
>> specific module and it is not needed?
>
> Please do!
>
> Every once in a while dealing with a Windows guest problem I wished I
> had this.  We at Virtuozzo looked into doing something like this but
> never got around to.
>
> Thanks,
> Roman.
>

Hello Mihail,

from the previous answers you can see that there is a
need for WinDbg support.

If you want to prepare patches for the official QEMU,
you need signed commits from all developers who contributed
(Dmitry Koltunov and you?).

Make also sure that no licensed code (for example extracts
from MS header files) gets added.

See http://wiki.qemu-project.org/Contribute/SubmitAPatch for
more hints.

As far as I saw, WinDbg support adds several thousand lines
of code. Do you want to support that code after it has been
included in QEMU?

Cheers
Stefan
