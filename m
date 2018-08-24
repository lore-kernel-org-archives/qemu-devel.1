Received: from eggs.gnu.org ([2001:4830:134:3::10]:53811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftBSt-0002rR-Iv
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 08:45:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ftBSs-0008Tl-QK
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 08:45:23 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:42676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ftBSs-0008Ru-DX
	for qemu-devel@nongnu.org; Fri, 24 Aug 2018 08:45:22 -0400
Received: by mail-oi0-x244.google.com with SMTP id q204-v6so15045843oig.9
	for <qemu-devel@nongnu.org>; Fri, 24 Aug 2018 05:45:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8okRmYDDAW2D_dq_VfQLowM1Uzhfm6KafeJFzLXBvt9A@mail.gmail.com>
References: <20180823112153.15279-1-peter.maydell@linaro.org>
	<20180823141155.GD6960@lemon.usersys.redhat.com>
	<CAFEAcA8okRmYDDAW2D_dq_VfQLowM1Uzhfm6KafeJFzLXBvt9A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Aug 2018 13:45:01 +0100
Message-ID: <CAFEAcA82wxTeHiPkMKnO9XCDGYbtP1B9_HgZxJu+d6=XKdx+iw@mail.gmail.com>
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

On 24 August 2018 at 13:02, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 23 August 2018 at 15:11, Fam Zheng <famz@redhat.com> wrote:
>> On Thu, 08/23 12:21, Peter Maydell wrote:
>>> The VM tests currently have a timeout of 2 minutes for trying
>>> to connect to ssh. Since the guest VM has to boot from cold
>>> to the point of accepting inbound ssh during this time, if the
>>> host machine is heavily loaded it can spuriously time out.
>>> Increase the timeout from 2 to 5 minutes.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>
>> Acked-by: Fam Zheng <famz@redhat.com>
>>
>> Again, please apply this yourself. :)
>
> Applied, thanks.

I'm still seeing the ssh login for a netbsd VM sometimes
sit there apparently indefinitely. Is there some way to
debug what the guest VM is actually doing when the
log just sits there doing
DEBUG:root:ssh_cmd: ssh -q -o StrictHostKeyChecking=no -o
UserKnownHostsFile=/dev/null -o ConnectTimeout=1 -p 36947 -i
/home/peter.maydell/qemu-netbsd/build/vm-test-g0SkVX.tmp/id_rsa
qemu@127.0.0.1 exit 0
DEBUG:root:ssh_cmd: ssh -q -o StrictHostKeyChecking=no -o
UserKnownHostsFile=/dev/null -o ConnectTimeout=1 -p 36947 -i
/home/peter.maydell/qemu-netbsd/build/vm-test-g0SkVX.tmp/id_rsa
qemu@127.0.0.1 exit 0

(eg a capture of its terminal output) ?

thanks
-- PMM
