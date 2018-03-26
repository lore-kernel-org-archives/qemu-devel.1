Received: from eggs.gnu.org ([2001:4830:134:3::10]:44368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0a7H-0006Cn-57
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0a7E-00024F-4I
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:57:23 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48300 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0a7E-00023z-0B
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 17:57:20 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E94940704B6
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 21:57:15 +0000 (UTC)
References: <20180326172041.21009-1-marcandre.lureau@redhat.com>
	<887d47b3-9243-4088-4449-f92f1f3c2302@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <33c617bd-88ee-3778-7059-0ef4a5f2a679@redhat.com>
Date: Mon, 26 Mar 2018 16:57:10 -0500
MIME-Version: 1.0
In-Reply-To: <887d47b3-9243-4088-4449-f92f1f3c2302@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qmp-test: fix response leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com

On 03/26/2018 01:33 PM, Eric Blake wrote:
> On 03/26/2018 12:20 PM, Marc-Andr=C3=A9 Lureau wrote:
>> Apparently introduced in commit a4f90923b520f1dc0a768634877eb412e5052c=
26.
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>> =C2=A0 tests/qmp-test.c | 1 +
>> =C2=A0 1 file changed, 1 insertion(+)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> I'll queue this through my qapi tree, unless applying Peter's for-2.12=20
> patches fixes it differently.

Okay, it's needed, and I'm queuing it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
