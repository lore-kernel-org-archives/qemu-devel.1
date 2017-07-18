Received: from eggs.gnu.org ([2001:4830:134:3::10]:46155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXU3e-0002yR-Ai
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:05:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXU3Y-0006Px-Iz
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:05:06 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXU3Y-0006Ph-EE
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 11:05:00 -0400
Received: by mail-qt0-x241.google.com with SMTP id 50so1609344qtz.0
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 08:05:00 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<20170717164641.GA31820@work-vm>
	<a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
	<CAFEAcA9Dc1_1t-N-gYiUsW+FY9-2ZNsKqBFY-WMF9Z-SeXsjiw@mail.gmail.com>
Message-ID: <f834b5c4-f16c-2099-3018-cd5a2f503ac4@amsat.org>
Date: Tue, 18 Jul 2017 12:04:51 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9Dc1_1t-N-gYiUsW+FY9-2ZNsKqBFY-WMF9Z-SeXsjiw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 07/17/2017 02:36 PM, Peter Maydell wrote:
> On 17 July 2017 at 18:29, Eric Blake <eblake@redhat.com> wrote:
>> On 07/17/2017 11:46 AM, Dr. David Alan Gilbert wrote:
[...]
>>> You may find this doesn't help in some windows builds;  the assert
>>> functions aren't always marked as noreturn (because they pop up a dialog
>>> that asks you whether you want to run into a debugger etc).
>>
>> How would it not help?  Are we using gcc 7 on windows builds?
> 
> At some point in the future we are likely to, because my
> w32/w64 test setups use the Ubuntu gcc-mingw-w64-x86-64
> packages, and so as I upgrade my desktop they will move
> forward to newer gcc versions. (More generally our users
> may do so before me ;-))

The MXE toolchain (mxe.cc) provides GCC version 5.4.0 and compiles fine:

win32:
https://app.shippable.com/github/philmd/qemu/runs/32/2/console

# file i386-softmmu/qemu-system-i386.exe
i386-softmmu/qemu-system-i386.exe: PE32 executable (console) Intel 
80386, for MS Windows

and win64:
https://app.shippable.com/github/philmd/qemu/runs/32/3/console

# file x86_64-softmmu/qemu-system-x86_64.exe
x86_64-softmmu/qemu-system-x86_64.exe: PE32+ executable (console) 
x86-64, for MS Windows

> We should be consistent -- if we can't trust assert() to
> be marked nonreturn, as it seems we can't, then we shouldn't
> write new code that assumes it always is, even if today
> it doesn't happen to bite us on the compiler/host combinations
> we're testing right now.

And there is also the problem when you compiles with CPPFLAGS+=-DNDEBUG 
some oldschool guys still have in their ~/.cshrc ;)

Phil.
