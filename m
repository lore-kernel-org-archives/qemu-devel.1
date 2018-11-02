Received: from eggs.gnu.org ([2001:4830:134:3::10]:36424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1gIend-0000jC-Ut
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 15:08:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Chris.Friesen@windriver.com>) id 1gIenX-000896-5a
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 15:08:03 -0400
Received: from mail.windriver.com ([147.11.1.11]:44827)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Chris.Friesen@windriver.com>)
	id 1gIenW-000800-Od
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 15:07:58 -0400
References: <d5d6e09a-78ed-41c4-bbb9-260263c05bf2@windriver.com>
	<87pnvn6hnq.fsf@linaro.org>
From: Chris Friesen <chris.friesen@windriver.com>
Message-ID: <b109fe05-1e88-a6e3-34cb-21a4b61e64b3@windriver.com>
Date: Fri, 2 Nov 2018 09:31:19 -0600
MIME-Version: 1.0
In-Reply-To: <87pnvn6hnq.fsf@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] strange situation,
 guest cpu thread spinning at ~100%, but display not yet initialized
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org

On 11/2/2018 1:51 AM, Alex Benn=C3=A9e wrote:
>=20
> Chris Friesen <chris.friesen@windriver.com> writes:
>=20
>> Hi all,
>>
>> I have an odd situation which occurs very infrequently and I'm hoping
>> to get some advice on how to debug.  Apologies for the length of this
>> message, I tried to include as much potentially useful information as
>> possible.
>>
>> In the context of an OpenStack compute node I have a qemu guest (with
>> kvm acceleration) that has started up.  The virtual console shows
>> "Guest has not initialized the display (yet)."   I'm trying to figure
>> out what's going on and how we got into this state.  I assume it's
>> some sort of deadlock/livelock, but I can't figure out what's causing
>> it.

>> At this point gdb appears to be stuck, though the task is still
>> chewing 99.9% of host cpu 43.
>=20
> That's because the vcpu_ioctl you just trace through is into the
> VCPU_RUN, basically when you enter the guest code (assuming the in
> kernel KVM code isn't spinning).

That's what I figured, thanks for the confirmation.

> If you want to get an idea why your guest is spinning you probably want
> to enable the gdb stub and look at what your guest kernel is doing.

Given the "not initialized" message on the console, I wasn't sure=20
whether the kernel had even started yet.

Chris
