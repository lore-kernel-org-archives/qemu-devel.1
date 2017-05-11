Received: from eggs.gnu.org ([2001:4830:134:3::10]:55649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8nIq-0003bk-B3
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8nIp-0006H4-Ef
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:34:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8nIp-0006Ft-90
	for qemu-devel@nongnu.org; Thu, 11 May 2017 08:34:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E00F4E4C6
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 12:34:42 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-4-marcandre.lureau@redhat.com>
	<99e29bb5-2f6f-68a6-4ec8-4e9c445a72bd@redhat.com>
Date: Thu, 11 May 2017 14:34:37 +0200
In-Reply-To: <99e29bb5-2f6f-68a6-4ec8-4e9c445a72bd@redhat.com> (Eric Blake's
	message of "Tue, 9 May 2017 13:51:18 -0500")
Message-ID: <87fugbwp0i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/17] tests: remove alt num-int cases
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

> On 05/09/2017 12:35 PM, Marc-Andr=C3=A9 Lureau wrote:
>> There are no real users of this case, and it's going to be invalid after
>> merging of QFloat and QInt use the same QNum type in the following patch.
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  tests/test-keyval.c                     |  3 ---
>>  tests/test-qobject-input-visitor.c      | 26 --------------------------
>>  tests/qapi-schema/qapi-schema-test.json |  2 --
>>  tests/qapi-schema/qapi-schema-test.out  |  8 --------
>>  4 files changed, 39 deletions(-)
>
> Is it worth adding tests/qapi-schema/alternate-num-int.json that
> attempts to create an alternate on 'int' and 'number' to (eventually)
> show that we give a decent error message at QAPI generation time that
> such a type is invalid?  Such a test would (eventually be) a negative
> replacement test for the (currently positive) test that you are deleting
> here, and make it easier to see the point in the series where we flip
> the concept from supported to rejected.
>
> That said, it doesn't have to necessarily be done at this point in the
> series (since I haven't even yet seen how QNum will look), so it doesn't
> hold up review of this particular patch.
>
> Also, this may interact with Eduardo's current attempt (or at least
> start of an attempt) to tighten the QAPI parser to reject alternates
> that would otherwise be ambiguous when passed through the string input
> visitor (for example, forbidding the combination of an enum starting
> with a digit in an alternate that also accepts integers).  So be aware
> that we may have some integration things to think about down the road.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Eduardo's work made me think about alternates, and I've come to the
conclusion that restricting alternates now would be prudent.  I'll work
on a patch.  It'll probably replace this one.
