Received: from eggs.gnu.org ([2001:4830:134:3::10]:41689)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1edgms-0005Q1-Uy
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:25:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1edgmn-0007gc-T1
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:25:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59810)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1edgmn-0007ey-FD
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 13:25:37 -0500
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <96f66b1f-2248-04ed-aabb-0cac1342b0cc@samsung.com>
Date: Mon, 22 Jan 2018 21:25:28 +0300
MIME-version: 1.0
In-reply-to: <CAFEAcA8wsQ7drfnyNbYHWcuNri4rn30BuE-4dXAnNFw_RZjxkw@mail.gmail.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <20180115115309.23982-1-quintela@redhat.com>
	<CAFEAcA-SxiJyKa84UwG8CESpkTXEM9AG5HqEgpPrzSFwrTPzYg@mail.gmail.com>
	<CGME20180119162746epcas1p2143cef3a97b076ce3fbc0b79d7d347b7@epcas1p2.samsung.com>
	<d746e2e8-3690-c27e-f816-9892b36d8a1c@amsat.org>
	<f399b096-6e75-c04f-bb02-80e327de45c4@samsung.com>
	<CAFEAcA-S5yB-3itnRJ41JriJYbsu2EKs9qjPjMC0488vsCZrRw@mail.gmail.com>
	<87h8rg2jdh.fsf@secure.laptop>
	<CAFEAcA-4HcQwWk2rEUuUc2PyGP8hnopbrL2zVOLiCayP3S7FrQ@mail.gmail.com>
	<016e04bd-3ee3-dffc-943f-394c8583c886@samsung.com>
	<CAFEAcA8wsQ7drfnyNbYHWcuNri4rn30BuE-4dXAnNFw_RZjxkw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/27] Migration pull
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 01/22/2018 07:26 PM, Peter Maydell wrote:
> On 22 January 2018 at 16:25, Alexey Perevalov <a.perevalov@samsung.com> wrote:
>> I want to keep 64bit atomic operations in migration.
> Sorry, you can't -- some 32 bit CPUs simply do not provide these
> operations. You need to rework your design to not require this.
I would like to ask David,
how do you think is it normal to use just one half of now_ms (int64_t), 
one half
of 64 bit value should represent 1200 hours and probably it's enough to 
keep time
difference.

>
> thanks
> -- PMM
>
>
>

-- 
Best regards,
Alexey Perevalov
