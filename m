Received: from eggs.gnu.org ([2001:4830:134:3::10]:50580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f71Kj-0003dy-7j
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 12:13:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f71Kd-0007Qf-Fd
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 12:13:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40230 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f71Kd-0007Po-9q
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 12:13:47 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 199C6407246E
	for <qemu-devel@nongnu.org>; Fri, 13 Apr 2018 16:13:43 +0000 (UTC)
References: <20180329154833.566-1-marcandre.lureau@redhat.com>
	<20180329154833.566-4-marcandre.lureau@redhat.com>
	<b041bde4-b926-2ede-d8a5-4721dafe6736@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79dc3c32-32fe-316c-1874-779caf9a0e39@redhat.com>
Date: Fri, 13 Apr 2018 18:13:32 +0200
MIME-Version: 1.0
In-Reply-To: <b041bde4-b926-2ede-d8a5-4721dafe6736@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/4] qobject: replace
 qobject_incref/QINCREF qobject_decref/QDECREF
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

On 29/03/2018 18:23, Eric Blake wrote:
>>
>> =C2=A0 +/**
>> + * qobject_ref(): Increment QObject's reference count
>> + */
>> +#define qobject_ref(obj)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 \
>> +=C2=A0=C2=A0=C2=A0 qobject_ref(QOBJECT(obj))
>=20
> ...below the functions of the same name.=C2=A0 C preprocessor rules gua=
rantee
> that you don't get infinite expansion, although I did a double-take the
> first time I read through the patch (especially since your v2 used the
> name qobject_ref_impl() for the function, distinct from the macro name)=
.
> =C2=A0Worth a comment?

I prefer qobject_ref_impl, FWIW.  There are already a few examples in
include/qemu/thread.h and include/qemu/coroutine.h.

Thanks,

Paolo
