Received: from eggs.gnu.org ([2001:4830:134:3::10]:48318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Bnt-0000D3-Pq
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Bno-0002V0-Se
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:08:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6Bno-0002Tj-Mj
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:07:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BA8B5C04B941
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 08:07:55 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
	<20170503223846.6559-2-marcandre.lureau@redhat.com>
	<a0bf4ab7-0265-96cc-f856-4e2502f265e8@redhat.com>
Date: Thu, 04 May 2017 10:07:52 +0200
In-Reply-To: <a0bf4ab7-0265-96cc-f856-4e2502f265e8@redhat.com> (Eric Blake's
	message of "Wed, 3 May 2017 20:06:03 -0500")
Message-ID: <87r305m4dj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/5] test-keyval: fix leaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Eric Blake <eblake@redhat.com> writes:

> On 05/03/2017 05:38 PM, Marc-Andr=C3=A9 Lureau wrote:
>> Spotted by ASAN.
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  tests/test-keyval.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>
> Reviewed-by: Eric blake <eblake@redhat.com>

This is in qapi-next already.  I'm adding the R-by now.
