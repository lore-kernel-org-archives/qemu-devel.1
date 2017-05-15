Received: from eggs.gnu.org ([2001:4830:134:3::10]:44748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAEYi-0003XG-U8
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAEYi-000899-Cd
	for qemu-devel@nongnu.org; Mon, 15 May 2017 07:53:04 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1494348286-10253-1-git-send-email-sundeep.lkml@gmail.com>
	<1494348286-10253-2-git-send-email-sundeep.lkml@gmail.com>
	<e87597ba-4759-76a5-7b0d-3297d2eb8f79@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d82b2e7c-e983-b227-b300-ceea0bd8b2cb@amsat.org>
Date: Mon, 15 May 2017 08:52:56 -0300
MIME-Version: 1.0
In-Reply-To: <e87597ba-4759-76a5-7b0d-3297d2eb8f79@amsat.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, alistair23@gmail.com

Hi Subbaraya,

>> +        if (value & TIMER_MODE) {
>> +            qemu_log_mask(LOG_UNIMP, "64-bit mode not supported\n");
>
> No need of trailing '\n', be more specific, something like:
>
>     qemu_log_mask(LOG_UNIMP, TYPE_MSF2_TIMER ": 64-bit mode not
> supported");

I mistaken with error_report(), qemu_log_mask() does use trailing 
newline, sorry!

Phil.
