Received: from eggs.gnu.org ([2001:4830:134:3::10]:35925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Xu4-0003n6-AU
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f0Xu1-0002sC-5z
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:35:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38850 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f0Xu1-0002ro-28
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 15:35:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4F01FA201D
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 19:35:32 +0000 (UTC)
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-2-peterx@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <13e2d514-26cf-d824-79e9-e48eaa5511cb@redhat.com>
Date: Mon, 26 Mar 2018 14:35:24 -0500
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-2-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 1/8] qmp: fix qmp_capabilities
 error regression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 03/26/2018 01:38 AM, Peter Xu wrote:
> When someone sents a command before QMP handshake, error was like this:

s/sents/sends/
s/error was/the error used to be/

>=20
>   {"execute": "query-cpus"}
>   {"error": {"class": "CommandNotFound", "desc":
>              "Expecting capabilities negotiation with 'qmp_capabilities=
'"}}
>=20
> While after cf869d5317 it becomes:
>=20
>   {"execute": "query-cpus"}
>   {"error": {"class": "CommandNotFound", "desc":
>              "The command query-cpus has not been found"}}
>=20
> Fix it back to the nicer one.
>=20
> Fixes: cf869d5317 ("qmp: support out-of-band (oob) execution", 2018-03-=
19)
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   monitor.c | 23 ++++++++---------------
>   1 file changed, 8 insertions(+), 15 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
