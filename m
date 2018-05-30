Received: from eggs.gnu.org ([2001:4830:134:3::10]:40906)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNpLs-0003Vn-Kz
	for qemu-devel@nongnu.org; Tue, 29 May 2018 20:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNpLr-0003By-Sg
	for qemu-devel@nongnu.org; Tue, 29 May 2018 20:52:32 -0400
References: <20180503222626.1303410-1-eblake@redhat.com>
	<dd9b008a-0e2e-9a4f-5387-e66aecf6feb3@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <110f164d-16ea-090d-2aec-93d774116bf4@redhat.com>
Date: Tue, 29 May 2018 19:52:25 -0500
MIME-Version: 1.0
In-Reply-To: <dd9b008a-0e2e-9a4f-5387-e66aecf6feb3@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] nbd/client: Relax handling of large
 NBD_CMD_BLOCK_STATUS reply
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

On 05/29/2018 10:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> 04.05.2018 01:26, Eric Blake wrote:
>> The NBD spec is proposing a relaxation of NBD_CMD_BLOCK_STATUS
>> where a server may have the final extent per context give a
>> length beyond the original request, if it can easily prove that
>> subsequent bytes have the same status, on the grounds that a
>> client can take advantage of this information for fewer block
>> status requests.=C2=A0 Since qemu 2.12 as a client always sends
>> NBD_CMD_FLAG_REQ_ONE, and rejects a server that sends extra
>> length, the upstream NBD spec will probably limit this behavior
>> to clients that don't request REQ_ONE semantics; but it doesn't
>> hurt to relax qemu to always be permissive of this server
>> behavior, even if it continues to use REQ_ONE.
>=20
> Hi!
>=20
> Patch is applied, are you going to make a patch for NBD spec?

Yes, thanks for the reminder (lots going on lately).

https://lists.debian.org/nbd/2018/05/msg00042.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
