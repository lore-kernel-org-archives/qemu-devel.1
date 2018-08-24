Received: from eggs.gnu.org ([2001:4830:134:3::10]:45183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftAnL-0001XS-7N
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 08:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftAnK-00053z-Fv
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 08:02:27 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45556)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftAnK-000538-3A
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 08:02:26 -0400
Received: by mail-oi0-x243.google.com with SMTP id t68-v6so3652504oie.12
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 05:02:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180823141155.GD6960@lemon.usersys.redhat.com>
References: <20180823112153.15279-1-peter.maydell@linaro.org>
	<20180823141155.GD6960@lemon.usersys.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 13:02:04 +0100
Message-ID: <CAFEAcA8okRmYDDAW2D_dq_VfQLowM1Uzhfm6KafeJFzLXBvt9A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests/vm: Increase timeout waiting for VM
 to boot to 5 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 23 August 2018 at 15:11, Fam Zheng <famz@redhat.com> wrote:
> On Thu, 08/23 12:21, Peter Maydell wrote:
>> The VM tests currently have a timeout of 2 minutes for trying
>> to connect to ssh. Since the guest VM has to boot from cold
>> to the point of accepting inbound ssh during this time, if the
>> host machine is heavily loaded it can spuriously time out.
>> Increase the timeout from 2 to 5 minutes.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Acked-by: Fam Zheng <famz@redhat.com>
>
> Again, please apply this yourself. :)

Applied, thanks.

-- PMM
