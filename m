Received: from eggs.gnu.org ([2001:4830:134:3::10]:58469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLa65-0000kr-29
	for qemu-devel@nongnu.org; Wed, 23 May 2018 16:10:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fLa64-0008Ha-58
	for qemu-devel@nongnu.org; Wed, 23 May 2018 16:10:57 -0400
References: <20180425183223.580566-1-eblake@redhat.com>
	<20180425183223.580566-2-eblake@redhat.com>
	<3e7ce246-1af0-c246-ceeb-bba8d0cc28b3@redhat.com>
	<6291af36-93ec-9bfe-8365-cb3f8c55c30d@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <132b0f96-b1aa-4af5-ee34-d168f76d2a29@redhat.com>
Date: Wed, 23 May 2018 16:10:46 -0400
MIME-Version: 1.0
In-Reply-To: <6291af36-93ec-9bfe-8365-cb3f8c55c30d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/8] parallels: Switch to
 byte-based calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V. Lunev" <den@openvz.org>, "open list:parallels" <qemu-block@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>



On 05/23/2018 04:09 PM, Eric Blake wrote:
> On 05/23/2018 02:19 PM, John Snow wrote:
>>
>>
>> On 04/25/2018 02:32 PM, Eric Blake wrote:
>>> We are gradually moving away from sector-based interfaces, towards
>>> byte-based.=C2=A0 Make the change for the last few sector-based calls
>>> into the block layer from the parallels driver.
>>>
>>> Ideally, the parallels driver should switch to doing everything
>>> byte-based, but that's a more invasive change that requires a
>>> bit more auditing.
>>>
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>
>> Older than a month, so I'm assuming this is dropped for now.
>=20
> No, it's still awaiting a review; and still applies without any context
> changes.

Oh, OK! then I'll count this as my naive ping-by-proxy.

--js
