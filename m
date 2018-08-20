Received: from eggs.gnu.org ([2001:4830:134:3::10]:58909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1frq9A-0005xR-Vz
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:47:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1frq90-0007tN-Vq
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 15:47:24 -0400
From: Stefan Weil <sw@weilnetz.de>
References: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
	<c350ae62-2712-79cc-e7e6-b88ae3fbc044@weilnetz.de>
	<008c57ea-0050-b5f0-4d68-db660cba269e@weilnetz.de>
Message-ID: <f4367121-e7fd-505b-7627-5ebee146dc5b@weilnetz.de>
Date: Mon, 20 Aug 2018 21:47:03 +0200
MIME-Version: 1.0
In-Reply-To: <008c57ea-0050-b5f0-4d68-db660cba269e@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Bugs when cross-compiling qemu for Windows with
 mingw 8.1, executable doesn't run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Ben Pye <ben@curlybracket.co.uk>

Am 20.08.2018 um 21:41 schrieb Stefan Weil:
> That's a problem triggered by gcc 8 for Mingw-w64 with compiler options
> -fstack-protector-all and -fstack-protector-strong. With any of those
> options this simple test program also fails with SIGSEGV:
> 
> #include <windows.h>
> int main(void) {
>   SYSTEM_INFO system_info;
>   GetSystemInfo(&system_info);
>   return system_info.dwPageSize;
> }
> 
> With configure option --disable-stack-protector, the resulting binary
> should work.


I could confirm that now. The following build works for me:

./configure --cross-prefix=x86_64-w64-mingw32- --enable-debug \
  --disable-stack-protector --target-list=ppc-softmmu && make

Stefan
