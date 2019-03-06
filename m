Received: from eggs.gnu.org ([209.51.188.92]:35548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Sjt-00047w-Vz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:21:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1Sjs-0003po-W8
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:21:25 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54966)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1Sjs-0003o8-Oy
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:21:24 -0500
Received: by mail-wm1-f65.google.com with SMTP id f3so5182984wmj.4
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 01:21:24 -0800 (PST)
References: <20190305162829.20079-1-philmd@redhat.com>
	<CAL1e-=gTsjAt1O63xuDwm7NfV6nKt3gMHk46Yjfg_PKp0a1m+w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <11d78ce4-4646-ca1d-82a6-3db98298996b@redhat.com>
Date: Wed, 6 Mar 2019 10:21:21 +0100
MIME-Version: 1.0
In-Reply-To: <CAL1e-=gTsjAt1O63xuDwm7NfV6nKt3gMHk46Yjfg_PKp0a1m+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/5] mips_malta: Clean up definition of
 flash memory size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

Hi Aleksandar,

On 3/6/19 7:38 AM, Aleksandar Markovic wrote:
> On Tuesday, March 5, 2019, Philippe Mathieu-Daudé <philmd@redhat.com
> <mailto:philmd@redhat.com>> wrote:
> 
>     Hi Markus,
> 
>     this is a rework of your 'mips_malta: Clean up definition of flash
>     memory size somewhat' patch:
>     https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07177.html
>     <https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07177.html>
> 
>     Regards,
> 
>     Phil.
> 
> 
> Philippe,
> 
> Could you summarize end-user-visible changes resulting from this series?

Good maintainer reflex :)

There is an end-user visible change, if he provides a file that is not
exactly 4MiB he will now get a "Malta CoreLV card expects a bios of 4MB"
error message and QEMU will exit to his shell. This change is introduced
by patch 4/5.

Now I rather expect this series to get integrated in Markus current
work, because his subsequent patches change the PFlash API and it is
easier he takes this (to avoid merge conflicts).

Note: Markus series is expected to include the following patch from Alex
Bennée: "hw/block: better reporting on pflash backing file mismatch"
https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg07341.html
which is a more important user visible change. I think the the changelog
can be updated once, by Markus :)

Meanwhile, if this series is taken by Markus can I have your Ack-by?

Thanks,

Phil.
