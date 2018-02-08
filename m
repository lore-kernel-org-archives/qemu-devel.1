Received: from eggs.gnu.org ([2001:4830:134:3::10]:33758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejmwK-0004j4-95
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejmwJ-0001Ms-2e
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:12:40 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ejmwI-0001Me-Oa
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:12:38 -0500
References: <20180205102659.60552-1-marcel@redhat.com>
	<CAFEAcA8OO7jEeAe5UWKBqSb_+tap7OVM2YxEsqWDVZV8jN7cmA@mail.gmail.com>
	<51f8addc-8c6c-4532-1a59-b4c0098f6c68@redhat.com>
	<f7b61733-f25a-31b5-7b55-d9a41b6d3f10@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <c685b567-ad73-feff-08db-c952ac1f4c6f@redhat.com>
Date: Thu, 8 Feb 2018 16:12:17 +0200
MIME-Version: 1.0
In-Reply-To: <f7b61733-f25a-31b5-7b55-d9a41b6d3f10@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/4] RDMA patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: dotanb@mellanox.com, QEMU Developers <qemu-devel@nongnu.org>, yuval.shaia@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>

On 08/02/2018 16:01, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Marcel,
>=20
> On 02/08/2018 10:38 AM, Marcel Apfelbaum wrote:
>> On 08/02/2018 14:59, Peter Maydell wrote:
>>> On 5 February 2018 at 10:26, Marcel Apfelbaum <marcel@redhat.com> wro=
te:
>>>> The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57=
ea3d8fe:
>>>
>>> Hi. The technical details of this pullreq are all fine (pgp
>>> key, format, etc), and it passes my build tests. But I gave
>>> this pullreq a bit of a closer inspection than I normally
>>> would, since it's your first, and there are a few things I
>>> thought worth bringing up:
>>
>> Thanks for doing it!
>>
>>>
>>> (1) I notice that some of the new files in this pullreq are licensed
>>> as "GPL, version 2", rather than "version 2 or any later version".
>>> Did you really mean that? Per 'LICENSE', we have a strong preference
>>> for 2-or-later for new code.
>>>
>>
>> No real preference, I will modify the license.
>>
>>> (2) Some new files have no copyright or license comment at the
>>> top of them. Can you fix that, please?
>>>
>>
>> Sure.
>>
>>> (3) Some of the new headers use kernel-internals __u32 etc types.
>>> This isn't portable. ('HACKING' has some suggestions for types you
>>> might want instead.)
>>>
>>
>> We do not "use" the __u32 types, we just copied a kernel file
>> for structures used for communication between the guest driver
>> and the QEMU code. We had a look on how it is done and
>> we use the model that adds macros __u32 -> uint32_t,
>> so the "__types" do not really create such problems.
>>
>>> (4) One of your patches doesn't have any reviewed-by tags.
>>> We don't always manage to review everything, but it is
>>> nicer if we can get review, especially for patches from
>>> new submaintainers.
>>>
>>
>> The patch did receive several questions/comments and all
>> of them were addressed, but indeed no RB tag was given.
>> Since the patch was in the mailing list for over a month
>> and *was* reviewed, I thought is enough.
>> I will ping Eduardo, he had the latest comments for it.
>>
>>
>>> (5) This is an absolutely enormous diffstat for a single commit:
>>>  26 files changed, 5149 insertions(+), 4 deletions(-)
>>>
>>
>> On the github where the project was developed we have thousands of com=
mits,
>> so it can't be used.
>> It was reviewed closely by one reviewer and got a lot
>> of comments from others.
>> That being said, we will try to split it in a few patches
>> and send a new version.
>=20
> I spent some time to review this but got lost when it became too
> specific (this is not really my area).
> I was hoping some of the VMware folks could review this.
>=20

The code was reviewed by someone from Mellanox and
we have an RDMA developer from Oracle looking into it to.
For V10 we will have a second RB for the device, it should be enough.

> KVM related stuffs are hard to test, but we have some qtests (migration
> mostly). Adding some tests for this huge code addition would be really
> great.
>=20

It is in our plans, yes.
We saw the avocado guys are returning to QEMU, I will ask their help in s=
etting
up an avocado test. It should take some time and we are developing the de=
vice
over an year offline making it had to maintain/review, so
we will work on the tests in parallel with the device submission.

Thanks,
Marcel

> Regards,
>=20
> Phil.
>=20
