Received: from eggs.gnu.org ([209.51.188.92]:58437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmfFV-0005ho-B4
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:40:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmfCx-0003nm-6P
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:38:19 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:36033)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gmfCw-0003jx-Py
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 08:38:15 -0500
References: <251451940.431966.1548259107629.ref@mail.yahoo.com>
	<251451940.431966.1548259107629@mail.yahoo.com>
	<20190123180804.GA1040@flamenco>
	<70145779.391347.1548334794441@mail.yahoo.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <b74582b9-a1b0-a7cc-b478-a26a140ce055@vivier.eu>
Date: Thu, 24 Jan 2019 14:38:02 +0100
MIME-Version: 1.0
In-Reply-To: <70145779.391347.1548334794441@mail.yahoo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] m68k gdb has stopped single stepping correctly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>, "Emilio G. Cota" <cota@braap.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>

On 24/01/2019 13:59, Lucien Anti-Spam wrote:
> 
> 
>> On Thursday, January 24, 2019, 3:08:07 AM GMT+9, Emilio G. Cota
> <cota@braap.org> wrote:
>> > On Wed, Jan 23, 2019 at 15:58:27 +0000, Lucien Anti-Spam via
> Qemu-devel wrote:
>> > Hi folks,
>> > I noticed that with 3.x release that the GDB options (-S -s) for
> certain CPU results in very weird stepping.Usually stops afer a few
> steps, whilst the stub continues responding the PC doesnt update,
> however, I have only deeply looked at the m68k.
>> > In the case of the m68K the SR gets the trace bit set (T=10b), and
> the PC doesnt update.The m68k gdbstub, and main gdbstub seem mostly
> unchanged.But it seems the INSN handling has changed greatly for the m68k.
>> > Does anyone have any ideas what happened?
>>
>> Can you please bisect to find at which point things start misbehaving?
>> 
>> Thanks,
>>  Emilio
> 
> Understood, I was hoping my original post might jog someone's memory
> about the issue.  
> 
> Apparently not, so after some digging I found that it was introduced
> with the refactor to TranslatorOps, specifically two lines got dropped
> that update the PC if single-stepping is being performed ( commit
> 11ab74b01e0a8ea4973eed89c6b90fa6e4fb9fb6 )
> 
> Since its not valid to revert, shall I go ahead and submit a patch for
> these two lines?

It seems to me to be a good solution, but CC'ing Richard for that.

Thanks,
Laurent
