Received: from eggs.gnu.org ([2001:4830:134:3::10]:42694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejpPF-00014T-1L
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:50:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejpPE-0004rh-Ei
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:50:41 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ERQQadvAdqhWbK+6hbLtvFMrA=X8R7UBcQpAKifDpOA@mail.gmail.com>
References: <20180207042438.15422-1-andrew.smirnov@gmail.com>
	<CAFEAcA8ERQQadvAdqhWbK+6hbLtvFMrA=X8R7UBcQpAKifDpOA@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 8 Feb 2018 08:50:36 -0800
Message-ID: <CAHQ1cqETa2Osx0Tc1EJJ4TiGfg1tMf3fG2AUyGKr6cj25N7F_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 00/14] Initial i.MX7 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, "Michael S . Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Thu, Feb 8, 2018 at 5:49 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 7 February 2018 at 04:24, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> Hi everyone,
>>
>> This v5 of the patch series containing the work that I've done in
>> order to enable support for i.MX7 emulation in QEMU.
>
> Thanks; I'm applying this to target-arm.next. There are a few minor
> tweaks I'm going to make in the process, but I think that's better
> than making you do yet another respin. Those changes are:
>  * dropped stray blank-line-at-end-of-file from a few patches
>  * fixed a couple of over-80-columnns lines
>  * added a ESDHC_UNDOCUMENTED_REG27 define as suggested by Philippe
>    (I didn't reorder the switches to put 'default' last though, as
>    that didn't seem necessary to me)
>
> If you get back to me today about the GPL-2-vs-2-or-later question
> for patch 13 I'll make that change too. Otherwise I'll drop 13
> and 14 for the moment.
>

Awesome, thanks!

Andrey Smirnov
