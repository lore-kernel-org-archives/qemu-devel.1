Received: from eggs.gnu.org ([2001:4830:134:3::10]:47544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS4zS-0002rT-Qo
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:46:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cS4zO-0000KP-Ut
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:46:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cS4zO-0000KF-Os
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:46:06 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DEC5F4A543
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 16:46:06 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
	<20170113144135.5150-13-marcandre.lureau@redhat.com>
	<87pojrhr7d.fsf@dusky.pond.sub.org>
	<871234022.2428064.1484324797286.JavaMail.zimbra@redhat.com>
Date: Fri, 13 Jan 2017 17:46:04 +0100
In-Reply-To: <871234022.2428064.1484324797286.JavaMail.zimbra@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 13 Jan 2017
	11:26:37 -0500 (EST)")
Message-ID: <87fukmgb77.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 12/21] qapi.py: fix line break before
 binary operator pep8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <mlureau@redhat.com> writes:

> Hi
>
> ----- Original Message -----
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>>=20
>> > Python code style accepts both form, but pep8 complains. Better to cle=
an
>> > up the single warning for now, so new errors stand out more easily.
>> >
>> > Fix scripts/qapi.py:1539:21: W503 line break before binary operator
>> >
>> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>=20
>> I'm dropping this patch, as per review of v7.
>
> Sorry, I thought I dropped it. I think I screwed up with my two branches =
(maintaining both split/squash series was quite a pain, I am relieved we ar=
e nearing the end)

Don't worry, you did all the non-trivial changes correctly, so I'm happy
to do a few trivial ones :)
