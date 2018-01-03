Received: from eggs.gnu.org ([2001:4830:134:3::10]:44456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWrS9-0005xR-Ii
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWrS8-0002ty-Qn
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:24:05 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:38040)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eWrS8-0002sh-Ju
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:24:04 -0500
Received: by mail-wr0-x242.google.com with SMTP id y9so3285193wrb.5
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 14:24:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_1+CWSb6Jc41n6UqvSqOLytgGi1idArXKe37iKyiv7mw@mail.gmail.com>
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
	<CAFEAcA_1+CWSb6Jc41n6UqvSqOLytgGi1idArXKe37iKyiv7mw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jan 2018 14:23:32 -0800
Message-ID: <CAKmqyKN+bz99zh008SHrZ+T+xxnaJ-PhUzGTuJOa+x7zOYAn=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MTTCG External Halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>

On Wed, Jan 3, 2018 at 2:14 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 3 January 2018 at 22:10, Alistair Francis <alistair23@gmail.com> wrote:
>> Any chance any one has some insight into a way to externally set a
>> vCPU as halted/un-halted?
>
> PSCI (where one vCPU can power off another) does this by
> calling arm_set_cpu_off(). Does that (or some variation
> on it) work?

It seems to help with the assert(), but I still see CPU stalls.

I also forgot to mention that we have a sev implementation, which also
might be contributing.

Alistair

>
> thanks
> -- PMM
