Received: from eggs.gnu.org ([209.51.188.92]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gwTxH-00035Y-56
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:38:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1gwTxD-0006xK-A4
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:38:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1gwTx9-0006sY-CY
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:38:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so7157531wml.2
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:38:15 -0800 (PST)
References: <251451940.431966.1548259107629.ref@mail.yahoo.com>
	<251451940.431966.1548259107629@mail.yahoo.com>
	<20190123180804.GA1040@flamenco>
	<70145779.391347.1548334794441@mail.yahoo.com>
	<87va2eyy38.fsf@linaro.org>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <15e19a9e-8cb4-e767-f5d3-6b268948844e@tuxfamily.org>
Date: Wed, 20 Feb 2019 16:38:11 +0100
MIME-Version: 1.0
In-Reply-To: <87va2eyy38.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Cc: "Emilio G. Cota" <cota@braap.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>

On 24/01/2019 14.38, Alex Bennée wrote:
> 
> Lucien Anti-Spam via Qemu-devel <qemu-devel@nongnu.org> writes:
> 
>>    > On Thursday, January 24, 2019, 3:08:07 AM GMT+9, Emilio G. Cota <cota@braap.org> wrote: > > On Wed, Jan 23, 2019 at 15:58:27 +0000, Lucien Anti-Spam via Qemu-devel wrote:> > Hi folks,
>>>> I noticed that with 3.x release that the GDB options (-S -s) for certain CPU results in very weird stepping.Usually stops afer a few steps, whilst the stub continues responding the PC doesnt update, however, I have only deeply looked at the m68k.
>>>> In the case of the m68K the SR gets the trace bit set (T=10b), and the PC doesnt update.The m68k gdbstub, and main gdbstub seem mostly unchanged.But it seems the INSN handling has changed greatly for the m68k.
>>>> Does anyone have any ideas what happened?>> Can you please bisect to find at which point things start misbehaving?
>>>
>>> Thanks,
>>>  Emilio
>> Understood, I was hoping my original post might jog someone's memory about the issue.
>> Apparently not, so after some digging I found that it was introduced with the refactor to TranslatorOps, specifically two lines got dropped that update the PC if single-stepping is being performed ( commit 11ab74b01e0a8ea4973eed89c6b90fa6e4fb9fb6 )
>> Since its not valid to revert, shall I go ahead and submit a patch for
>> these two lines?
> 
> Yes please!

 Hi Lucien,

did you ever sent the patch? I can't find it on the mailing list, and I
think this bug is still pending?

 Thomas
