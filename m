Received: from eggs.gnu.org ([2001:4830:134:3::10]:58346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eswDh-00074l-BF
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:56:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eswDg-0007YR-H6
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 14:56:25 -0500
References: <20180305180433.106408-1-vsementsov@virtuozzo.com>
	<b8324efe-7fd4-3c44-faac-a7a9e9e1ad3e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9c4b48b2-e4ad-b8ec-0886-e30d06a950e3@redhat.com>
Date: Mon, 5 Mar 2018 13:56:18 -0600
MIME-Version: 1.0
In-Reply-To: <b8324efe-7fd4-3c44-faac-a7a9e9e1ad3e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nbd/server: fix space read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

On 03/05/2018 01:47 PM, Eric Blake wrote:
> On 03/05/2018 12:04 PM, Vladimir Sementsov-Ogievskiy wrote:

In the subject line: s/space/sparse/

>> In case of io error in nbd_co_send_sparse_read we should not
>> "goto reply:", as it is fatal error and common behavior is
>> disconnect in this case. We should not try to send client an
>> error reply, representing channel-io error on previous try to
>> send a reply.
>=20
> Good catch.
>=20
>>
>> Fix this by handle block-status error in nbd_co_send_sparse_read,
>> so nbd_co_send_sparse_read fails only on io error. Then just skip
>> common "reply:" code path in nbd_trip.
>>
>> Note: nbd_co_send_structured_error is moved without changes to be
>> called from nbd_co_send_sparse_read.
>=20
> Might be easier to read as two patches, one for the code motion, the=20
> other for using the new code.=C2=A0 But I'm not going to insist on a sp=
lit.
>=20
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
