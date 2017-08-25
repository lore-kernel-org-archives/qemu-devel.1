Received: from eggs.gnu.org ([2001:4830:134:3::10]:59110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl8M0-00027z-0T
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dl8Lw-00043w-0y
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58764)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dl8Lv-00043j-QQ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 02:44:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A7415883CD
	for <qemu-devel@nongnu.org>; Fri, 25 Aug 2017 06:44:21 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170824103350.16400-1-marcandre.lureau@redhat.com>
	<20170824103350.16400-6-marcandre.lureau@redhat.com>
	<87r2w02lz9.fsf@dusky.pond.sub.org>
Date: Fri, 25 Aug 2017 08:44:18 +0200
In-Reply-To: <87r2w02lz9.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 25 Aug 2017 08:35:38 +0200")
Message-ID: <87fucg170d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 05/14] qlit: rename compare_litqobj_to_qobj
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org

Markus Armbruster <armbru@redhat.com> writes:

> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> Use qlit_ prefix.
>
> Let's spell it out:=20
>
>     qlit: rename compare_litqobj_to_qobj() to qlit_equal_qobject()
>
> By the way, not only is your name shorter, it's also more precise:
> "compare" suggests -1, 0, +1 for less than, equal and greater than,
> equal suggests non-zero for equal, zero for unequal.
>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  include/qapi/qmp/qlit.h |  2 +-
>>  qobject/qlit.c          |  6 +++---
>>  tests/check-qjson.c     | 14 +++++++-------
>>  3 files changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
>> index 1e9696988a..e299e8fab0 100644
>> --- a/include/qapi/qmp/qlit.h
>> +++ b/include/qapi/qmp/qlit.h
>> @@ -44,6 +44,6 @@ struct QLitDictEntry {
>>  #define QLIT_QLIST(val) \
>>      { .type =3D QTYPE_QLIST, .value.qlist =3D (val) }
>>=20=20
>> -int compare_litqobj_to_qobj(QLitObject *lhs, QObject *rhs);
>> +int qlit_equal_qobject(QLitObject *lhs, QObject *rhs);
>>=20=20
>>  #endif /* QLIT_H_ */
>
> Let's use this opportunity to change the return value to bool.

Maybe I should peek at the next patch once in a while.  Nevermind!

> With those changes:

Scratch "those changes", just touch up the commit message a bit:

    qlit: rename compare_litqobj_to_qobj() to qlit_equal_qobject()

    compare_litqobj_to_qobj() lacks a qlit_ prefix.  Moreover, "compare"
    suggests -1, 0, +1 for less than, equal and greater than.  The
    function actually returns non-zero for equal, zero for unequal.
    Rename to qlit_equal_qobject().

    Its return type will be cleaned up in the next patch.

Can do on commit.

> Reviewed-by: Markus Armbruster <armbru@redhat.com>
