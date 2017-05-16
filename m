Received: from eggs.gnu.org ([2001:4830:134:3::10]:37142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dAWB0-0001TP-A7
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1dAWAw-0005eJ-GU
	for qemu-devel@nongnu.org; Tue, 16 May 2017 02:41:46 -0400
MIME-Version: 1.0
In-Reply-To: <d82b2e7c-e983-b227-b300-ceea0bd8b2cb@amsat.org>
References: <1494348286-10253-1-git-send-email-sundeep.lkml@gmail.com>
	<1494348286-10253-2-git-send-email-sundeep.lkml@gmail.com>
	<e87597ba-4759-76a5-7b0d-3297d2eb8f79@amsat.org>
	<d82b2e7c-e983-b227-b300-ceea0bd8b2cb@amsat.org>
From: sundeep subbaraya <sundeep.lkml@gmail.com>
Date: Tue, 16 May 2017 12:11:41 +0530
Message-ID: <CALHRZurDU8fS3GSKproqP83Un2mVnJ75ptydf4QsRZvyzsZz1Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [Qemu-devel PATCH 1/5] msf2: Add
 Smartfusion2 System timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair23@gmail.com>

Hi Philippe,

On Mon, May 15, 2017 at 5:22 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg>
wrote:

> Hi Subbaraya,
>
> +        if (value & TIMER_MODE) {
>>> +            qemu_log_mask(LOG_UNIMP, "64-bit mode not supported\n");
>>>
>>
>> No need of trailing '\n', be more specific, something like:
>>
>>     qemu_log_mask(LOG_UNIMP, TYPE_MSF2_TIMER ": 64-bit mode not
>> supported");
>>
>
> I mistaken with error_report(), qemu_log_mask() does use trailing newline=
,
> sorry!
>

thats ok :)

Thanks,
Sundeep

>
> Phil.
>
