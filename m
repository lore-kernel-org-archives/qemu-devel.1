Received: from eggs.gnu.org ([2001:4830:134:3::10]:35054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fihI7-000489-Sb
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:30:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lbloch@janustech.com>) id 1fihI4-0003Rf-Sl
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 10:30:55 -0400
References: <20180725142758.9980-1-lbloch@janustech.com>
	<20180725142758.9980-3-lbloch@janustech.com>
	<20180726100242.GD4215@localhost.localdomain>
	<3373f5e8-e613-c5eb-81d3-77a2b9dc73fb@redhat.com>
From: Leonid Bloch <lbloch@janustech.com>
Message-ID: <55b6885d-b07c-5473-bab1-687cc7812af9@janustech.com>
Date: Thu, 26 Jul 2018 17:30:30 +0300
MIME-Version: 1.0
In-Reply-To: <3373f5e8-e613-c5eb-81d3-77a2b9dc73fb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 2/4 for-3.0] qcow2: Options'
 documentation fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 07/26/2018 05:20 PM, Eric Blake wrote:
> On 07/26/2018 05:02 AM, Kevin Wolf wrote:
>> Am 25.07.2018 um 16:27 hat Leonid Bloch geschrieben:
>>> Signed-off-by: Leonid Bloch <lbloch@janustech.com>
>>> ---
>>> =C2=A0 docs/qcow2-cache.txt |=C2=A0 3 +++
>>> =C2=A0 qemu-options.hx=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ++++++----
>>> =C2=A0 2 files changed, 9 insertions(+), 4 deletions(-)
>>>
>=20
>>> +++ b/qemu-options.hx
>>> @@ -752,15 +752,17 @@ image file)
>>> =C2=A0 @item cache-size
>>> =C2=A0 The maximum total size of the L2 table and refcount block caches=
 in=20
>>> bytes
>>> -(default: 1048576 bytes or 8 clusters, whichever is larger)
>>
>> I think it would be good to still say something about the default.
>> Maybe something like "default: the sum of l2-cache-size and
>> refcount-cache-size"?
>=20
> Except what happens if you specify only one of l2-cache-size or=20
> refcount-cache-size? Is the defaulted cache-size then just that one size=
=20
> you specified (and the other cache ignored), or is the total cache size=20
> still defaulted to the 1M/8-cluster size (assuming its larger than the=20
> other size specified)?

I think that the meaning here is the sum of the actual l2-cache-size and=20
refcount-cache-size. Not the specified options, but the actual caches.

Leonid.
