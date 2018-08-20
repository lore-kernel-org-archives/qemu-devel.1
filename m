Received: from eggs.gnu.org ([2001:4830:134:3::10]:58557)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1frqxM-00045S-2Y
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hsp.cat7@gmail.com>) id 1frqxK-0003sp-V1
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 16:39:19 -0400
MIME-Version: 1.0
In-Reply-To: <f4367121-e7fd-505b-7627-5ebee146dc5b@weilnetz.de>
References: <CABLmASE2HTZPBVFM=grds+9RmPyh2naJ2KwNjb81LD0+E+yrtA@mail.gmail.com>
	<c350ae62-2712-79cc-e7e6-b88ae3fbc044@weilnetz.de>
	<008c57ea-0050-b5f0-4d68-db660cba269e@weilnetz.de>
	<f4367121-e7fd-505b-7627-5ebee146dc5b@weilnetz.de>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Mon, 20 Aug 2018 22:39:14 +0200
Message-ID: <CABLmASEoBy3xzx4VY+HDJ0RY57axngP1rnXc2JqQcg0DfaC+RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefan Weil <sw@weilnetz.de>
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Ben Pye <ben@curlybracket.co.uk>

On Mon, Aug 20, 2018 at 9:47 PM, Stefan Weil <sw@weilnetz.de> wrote:
> Am 20.08.2018 um 21:41 schrieb Stefan Weil:
>> That's a problem triggered by gcc 8 for Mingw-w64 with compiler options
>> -fstack-protector-all and -fstack-protector-strong. With any of those
>> options this simple test program also fails with SIGSEGV:
>>
>> #include <windows.h>
>> int main(void) {
>>   SYSTEM_INFO system_info;
>>   GetSystemInfo(&system_info);
>>   return system_info.dwPageSize;
>> }
>>
>> With configure option --disable-stack-protector, the resulting binary
>> should work.
>
>
> I could confirm that now. The following build works for me:
>
> ./configure --cross-prefix=x86_64-w64-mingw32- --enable-debug \
>   --disable-stack-protector --target-list=ppc-softmmu && make
>
> Stefan

Confirmed, adding --disable-stack-protector to configure results in a
working binary.

Great, thanks,
Howard
