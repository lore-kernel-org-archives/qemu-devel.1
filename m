Received: from eggs.gnu.org ([2001:4830:134:3::10]:50308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6Bve-0002ls-Mj
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d6BvZ-0006is-Py
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:16:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d6BvZ-0006hw-Ie
	for qemu-devel@nongnu.org; Thu, 04 May 2017 04:15:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4511DC057FA5
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 08:15:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170503223846.6559-1-marcandre.lureau@redhat.com>
	<20170503223846.6559-2-marcandre.lureau@redhat.com>
	<a0bf4ab7-0265-96cc-f856-4e2502f265e8@redhat.com>
	<87r305m4dj.fsf@dusky.pond.sub.org>
Date: Thu, 04 May 2017 10:15:52 +0200
In-Reply-To: <87r305m4dj.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Thu, 04 May 2017 10:07:52 +0200")
Message-ID: <87inlhkpfr.fsf@dusky.pond.sub.org>
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

Markus Armbruster <armbru@redhat.com> writes:

> Eric Blake <eblake@redhat.com> writes:
>
>> On 05/03/2017 05:38 PM, Marc-Andr=C3=A9 Lureau wrote:
>>> Spotted by ASAN.
>>>=20
>>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>  tests/test-keyval.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>
>> Reviewed-by: Eric blake <eblake@redhat.com>
>
> This is in qapi-next already.  I'm adding the R-by now.

Actually, I'm replacing the commit in my tree by this one, because that
results in a simpler, cleaner commit message: I don't have to note the
tweaks I applied in my tree, and you in your v5.  Thanks!
