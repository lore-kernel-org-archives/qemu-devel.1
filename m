Received: from eggs.gnu.org ([2001:4830:134:3::10]:53923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkAod-0007bE-Jd
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:10:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dkAoY-0003fK-Hm
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:10:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52016)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dkAoY-0003em-BI
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 11:09:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 67BEF5BECD
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 15:09:57 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170822132255.23945-1-marcandre.lureau@redhat.com>
	<20170822132255.23945-3-marcandre.lureau@redhat.com>
Date: Tue, 22 Aug 2017 17:09:47 +0200
In-Reply-To: <20170822132255.23945-3-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Tue, 22 Aug 2017 15:22:03 +0200")
Message-ID: <87bmn78wqs.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/54] qdict: add qdict_put_null() helper
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/qapi/qmp/qdict.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
> index 363e431106..a35bed9f16 100644
> --- a/include/qapi/qmp/qdict.h
> +++ b/include/qapi/qmp/qdict.h
> @@ -60,6 +60,8 @@ void qdict_destroy_obj(QObject *obj);
   /* Helpers for int, bool, and string */
   #define qdict_put_int(qdict, key, value) \
           qdict_put(qdict, key, qnum_from_int(value))
   #define qdict_put_bool(qdict, key, value) \
>          qdict_put(qdict, key, qbool_from_bool(value))
>  #define qdict_put_str(qdict, key, value) \
>          qdict_put(qdict, key, qstring_from_str(value))
> +#define qdict_put_null(qdict, key) \
> +        qdict_put(qdict, key, qnull())
>=20=20
>  /* High level helpers */
>  double qdict_get_double(const QDict *qdict, const char *key);

Marginal.  I can accept it for completeness's sake, or rather a step
towards completeness.  But please update the "Helpers for ..." comment,
and convert existing qdict_put(QD, K, qnull()) to use qdict_put_null().
A quick grep finds some in target/i386/cpu.c.  There might be more.
