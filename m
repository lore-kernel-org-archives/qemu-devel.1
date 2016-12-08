Received: from eggs.gnu.org ([2001:4830:134:3::10]:48877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cEnsh-0006rO-JM
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 20:52:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cEnsc-0006nK-PR
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 20:52:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cEnsc-0006md-J4
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 20:52:14 -0500
References: <CAFEAcA9kODkdK96a=rdZS7+xSW0drj4vLMev-AVio-uewm6Cbw@mail.gmail.com>
	<20161207120419.GA1476@redhat.com>
	<CAFEAcA8UofRa9Yo93vsFYDqJaW5YuKKF68X+2ae=GKdp8w9HWg@mail.gmail.com>
	<20161207140715.GB1476@redhat.com>
	<CAFEAcA-8P3cv=ce_jjQRAa5Oh-1EDUByuJq-tX2sX29vVm-5mQ@mail.gmail.com>
	<20161207142449.GC1476@redhat.com>
	<CAFEAcA-riLzPyfT+CSbEgLzRoJiGVRByk7Ft7EdDqhVcOH4vHg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c1475981-5d6f-a623-525c-fa72b101a96b@redhat.com>
Date: Thu, 8 Dec 2016 09:52:07 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-riLzPyfT+CSbEgLzRoJiGVRByk7Ft7EdDqhVcOH4vHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu -netdev tun/tap support can't handle macvtap
 type devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 2016=E5=B9=B412=E6=9C=8807=E6=97=A5 22:32, Peter Maydell wrote:
> On 7 December 2016 at 14:24, Daniel P. Berrange <berrange@redhat.com> w=
rote:
>> On Wed, Dec 07, 2016 at 02:21:24PM +0000, Peter Maydell wrote:
>>> On 7 December 2016 at 14:07, Daniel P. Berrange <berrange@redhat.com>=
 wrote:
>>>> On Wed, Dec 07, 2016 at 12:30:31PM +0000, Peter Maydell wrote:
>>>>> On 7 December 2016 at 12:04, Daniel P. Berrange <berrange@redhat.co=
m> wrote:
>>>>>> note 'fds' plural, instead of 'fd'
>>>>> What's the difference between that and the "usual suggested workaro=
und"
>>>>> I described above that doesn't work with queues=3D... ?
>>>> It just seems the 'queues' param always wants you to use 'fds' inste=
ad
>>>> of 'fd' - 'fds' takes a comma-separated list of FDs - one per queue
>>>> and 'fd' only takes a single FD.
>>> Oh, I see. That seems a bit obscure :-)
>> And pointless, because QemuOpts would have allowed use of 'fd' multipl=
e
>> times instead of inventing a new arg.  fd=3D1,fd=3D3,fd=3D6 could have=
 worked
>> fine with multi-queue :-(
> I guess the best we could do now would be to make fd=3D and fds=3D syno=
nyms
> with both supporting either comma-separated or being specified
> multiple times ?

When multiqueue were introduced, qemu does not support such kind of=20
parameters. This maybe useful (or use fd[0],fd[1]), but I'm not sure=20
this is really needed consider libvirt is in charge of doing such things=20
now.

>
> It's particularly confusing in this case that fd=3D doesn't work with
> queues=3D, because the user isn't trying to pass multiple fds, just
> the one is fine.

Since fd can only accept on file descriptor, so it implies 1 queue. For=20
"fds", specifying queues seems redundant, since qemu can count the #fds=20
by itself.

Thanks

>
> thanks
> -- PMM
>
