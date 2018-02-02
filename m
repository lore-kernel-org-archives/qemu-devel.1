Received: from eggs.gnu.org ([2001:4830:134:3::10]:37917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ehcYX-0008LH-7H
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgard.kaziakhmedov@virtuozzo.com>)
	id 1ehcYS-0001mT-VZ
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 09:43:09 -0500
References: <20180118115158.17219-1-edgar.kaziakhmedov@virtuozzo.com>
	<1b55edad-f820-6898-1630-ccc76e6c4845@redhat.com>
	<5858df64-9495-1332-3c53-fab0204f79a9@virtuozzo.com>
	<8b87f82d-2a90-d6cf-0fc4-aee0d704a403@redhat.com>
	<4919379e-ee86-5032-ec1e-fea39912783b@virtuozzo.com>
	<5f76135f-6a96-6446-7f48-0683e7674c32@redhat.com>
From: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Message-ID: <87738083-597b-5dcb-2c0e-a6c7aa639ec1@virtuozzo.com>
Date: Fri, 2 Feb 2018 17:23:37 +0300
MIME-Version: 1.0
In-Reply-To: <5f76135f-6a96-6446-7f48-0683e7674c32@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/1] nbd: implement bdrv_get_info callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, den@openvz.org, vsementsov@virtuozzo.com



On 02/02/2018 05:15 PM, Eric Blake wrote:
> On 02/02/2018 08:06 AM, Edgar Kaziakhmedov wrote:
>
>>>>> However, it would be nice to remove can_write_zeroes_with_unmap from
>>>>> BlockDriverInfo, and make bdrv_can_write_zeroes_with_unmap just retur=
n
>>>>> !!(bs->supported_zero_flags & BDRV_REQ_MAY_UNMAP).=C2=A0 Kevin, what =
do you
>>>>> think?
>>> Actually, I may even just give a shot at writing this alternative patch=
,
>>> to make Kevin's decision easier.
>> But actually qcow2 performs some checks for version inside get_info
>> callback before setting can_write_zeroes_with_unmap flag,
>> so we can't take into account such checks in
>> bdrv_can_write_zeroes_with_unmap subroutine. Therefore, I don't think it
>> is possible to do it like that.
> Here's the patch I proposed (it looks like I forgot to CC you):
>
> https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06471.html
>
Yes, it was possible to move check to open, ok, get it.
