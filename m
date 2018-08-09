Received: from eggs.gnu.org ([2001:4830:134:3::10]:47662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnsqz-0002hl-0B
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fnsqx-0005Df-V8
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:52:21 -0400
From: Leonid Bloch <lbloch@janustech.com>
References: <20180808221138.5770-1-lbloch@janustech.com>
	<20180808221138.5770-3-lbloch@janustech.com>
	<w51r2j7butk.fsf@maestria.local.igalia.com>
	<4e5aaa3e-0ad5-74b1-2569-7d3cbec279eb@janustech.com>
	<w51k1ozblpd.fsf@maestria.local.igalia.com>
	<93a5da55-b5d8-05fc-6643-98e71c423237@janustech.com>
	<246853e7-2873-974b-fa0f-d0daeb5fcc4a@redhat.com>
Message-ID: <c0bc41e8-6cb7-b772-b85d-548a8728f062@janustech.com>
Date: Fri, 10 Aug 2018 00:51:53 +0300
MIME-Version: 1.0
In-Reply-To: <246853e7-2873-974b-fa0f-d0daeb5fcc4a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qcow2: Assign the L2 cache
 relatively to image size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 8/9/18 8:37 PM, Eric Blake wrote:
> On 08/09/2018 11:46 AM, Leonid Bloch wrote:
>>>>> There are no functional changes, why do you need to change the
>>>>> indentation here?
>>>>
>>>> It's in the "immediate area (few lines) of the lines [I'm] changing".
>>>
>>> But there's no need to change those lines unless there's an obvious
>>> mistake. In this case it's just a matter of style so they just add nois=
e
>>> to the patch.
>>
>> Again, it just looks nicer, more readable, compliant to the generally=20
>> accepted style, and right next to the functional changes. It's a style=20
>> improvement which is in the immediate vicinity of the functional=20
>> improvements. I made another one, you must have seen it already, in v5.
>>
>> Look, it just looks better. It's possible to make another patch for=20
>> these cosmetic changes, but is it worth it when they are right next to=20
>> the functional changes? It's a bit of noise in the patch, versus noise=20
>> in the Git history.
>=20
> Patch splitting is an art form. But it IS easier to review two patches=20
> (one that fixes style but has no semantic change, and one that does=20
> semantic change in as few lines as possible) than to review one (that=20
> mixes both steps at once).=C2=A0 The more things you do in a single patch=
,=20
> the more likely you were to be better off by having split it into=20
> independent patches.
>=20
> A longer git history is not a problem. Our bottleneck is reviewer time,=20
> and everything you can do to make life easier for reviewers is a net win=
=20
> in overall time spent on the project. And splitting two distinct changes=
=20
>  =C2=A0IS worthwhile, especially when a reviewer has requested that split=
.
>=20
> Along those lines, I'll also comment that I've seen Berto request that=20
> you consider splitting even the functional part of this patch into two=20
> pieces - one raising the default value, and the other fixing things to=20
> use only what is needed rather than the full specified length when the=20
> specified/default length is larger than necessary.=C2=A0 It's not a hard=
=20
> split, and while you've continued to argue against the split, I tend to=20
> agree that doing the two parts separately makes the series a bit easier=20
> to backport to other stable branches (for example, if a distro wants to=20
> change to yet a different default value, but still use your patch that=20
> changes to not overallocate when the specified/default is larger than=20
> needed).
>=20

Hi Eric,

I agree with your arguments here, splitting the cosmetic fixes being the=20
reviewer's request, and splitting the size setting for the reason that=20
you have mentioned above.

Thanks! Sending v6.

Leonid.
