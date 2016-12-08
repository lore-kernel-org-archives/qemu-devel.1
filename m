Received: from eggs.gnu.org ([2001:4830:134:3::10]:49543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cEnuT-0007f6-24
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 20:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cEnuN-0007U4-Uw
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 20:54:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43172)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cEnuN-0007TX-Pq
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 20:54:03 -0500
References: <CAFEAcA9kODkdK96a=rdZS7+xSW0drj4vLMev-AVio-uewm6Cbw@mail.gmail.com>
	<20161207120419.GA1476@redhat.com>
	<CAFEAcA8UofRa9Yo93vsFYDqJaW5YuKKF68X+2ae=GKdp8w9HWg@mail.gmail.com>
	<20161207140715.GB1476@redhat.com>
	<CAFEAcA-8P3cv=ce_jjQRAa5Oh-1EDUByuJq-tX2sX29vVm-5mQ@mail.gmail.com>
	<20161207142449.GC1476@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0f77bab2-47c1-66ba-b89c-bd6d07c3e134@redhat.com>
Date: Thu, 8 Dec 2016 09:53:51 +0800
MIME-Version: 1.0
In-Reply-To: <20161207142449.GC1476@redhat.com>
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
To: "Daniel P. Berrange" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>



On 2016=E5=B9=B412=E6=9C=8807=E6=97=A5 22:24, Daniel P. Berrange wrote:
> On Wed, Dec 07, 2016 at 02:21:24PM +0000, Peter Maydell wrote:
>> On 7 December 2016 at 14:07, Daniel P. Berrange <berrange@redhat.com> =
wrote:
>>> On Wed, Dec 07, 2016 at 12:30:31PM +0000, Peter Maydell wrote:
>>>> On 7 December 2016 at 12:04, Daniel P. Berrange <berrange@redhat.com=
> wrote:
>>>>> On Wed, Dec 07, 2016 at 12:01:14PM +0000, Peter Maydell wrote:
>>>>>> The usual suggested workaround is to use the -netdev fd option, li=
ke
>>>>>>    fd=3D3 3<>/dev/tap$(< /sys/class/net/tap0/ifindex)
>>>>>> (which gets the shell to open the right /dev/tap device).
>>>>>> Unfortunately this isn't compatible with multi-queue support
>>>>>> because netdev complains
>>>>>> "ifname=3D, script=3D, downscript=3D, vnet_hdr=3D, helper=3D, queu=
es=3D, fds=3D,
>>>>>> and vhostfds=3D are invalid with fd=3D"
>>>>>> so you can't pass options like "queues=3D4"...
>>>>> FWIW you should be able to instead do
>>>>>
>>>>>     fds=3D3 3<>/dev/tap$(< /sys/class/net/tap0/ifindex)
>>>>>
>>>>> note 'fds' plural, instead of 'fd'
>>>> What's the difference between that and the "usual suggested workarou=
nd"
>>>> I described above that doesn't work with queues=3D... ?
>>> It just seems the 'queues' param always wants you to use 'fds' instea=
d
>>> of 'fd' - 'fds' takes a comma-separated list of FDs - one per queue
>>> and 'fd' only takes a single FD.
>> Oh, I see. That seems a bit obscure :-)
> And pointless, because QemuOpts would have allowed use of 'fd' multiple
> times instead of inventing a new arg.  fd=3D1,fd=3D3,fd=3D6 could have =
worked
> fine with multi-queue :-(
>
> Regards,
> Daniel

Yes, but not the time when multiqueue is introduced. I'm not sure how=20
much value we can gain from this, consider libvirt has already use fds=20
for years.

Thanks
