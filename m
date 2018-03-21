Received: from eggs.gnu.org ([2001:4830:134:3::10]:56479)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyeK8-0008G6-A8
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eyeK3-0006Wk-GI
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:02:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50458 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eyeK3-0006WU-CR
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 10:02:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E898CA1BEB
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 14:02:34 +0000 (UTC)
References: <20180321134005.8822-1-marcandre.lureau@redhat.com>
	<20180321134005.8822-3-marcandre.lureau@redhat.com>
	<989e4d84-15a9-8867-4616-31fc6c6151fa@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ce6ecc00-30de-f98f-b4b1-0dbed853dd7a@redhat.com>
Date: Wed, 21 Mar 2018 15:02:31 +0100
MIME-Version: 1.0
In-Reply-To: <989e4d84-15a9-8867-4616-31fc6c6151fa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] qobject: assume base of a qobject is
 at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com

On 21/03/2018 15:01, Eric Blake wrote:
>>
>=20
> Interesting.=C2=A0 If we do this, we should also simplify qobject_to() =
from
> its current:
>=20
> #define qobject_to(type, obj) ({ \
> =C2=A0=C2=A0=C2=A0 QObject *_tmp =3D qobject_check_type(obj, glue(QTYPE=
_CAST_TO_, type)); \
> =C2=A0=C2=A0=C2=A0 _tmp ? container_of(_tmp, type, base) : (type *)NULL=
; })
>=20
> to the simpler:
>=20
> #define qobject_to(type, obj) \
> =C2=A0=C2=A0=C2=A0 ((type *)qobject_check_type(obj, glue(QTYPE_CAST_TO_=
, type)))

Yes, indeed!

Paolo
