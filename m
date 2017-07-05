Received: from eggs.gnu.org ([2001:4830:134:3::10]:47626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSl1M-0004SB-Vl
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1dSl1J-0003tO-1q
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:11:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1dSl1I-0003st-Qm
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 10:11:08 -0400
Date: Wed, 5 Jul 2017 10:11:00 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Message-ID: <931578284.47177982.1499263860608.JavaMail.zimbra@redhat.com>
In-Reply-To: <a3557c70-c63d-efc6-7c8f-2956c15edad9@redhat.com>
References: <20170704220346.29244-1-marcandre.lureau@redhat.com>
	<20170704220346.29244-2-marcandre.lureau@redhat.com>
	<a3557c70-c63d-efc6-7c8f-2956c15edad9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/35] WIP: coroutine: annotate coroutine
 with clang thread safety attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Weil <sw@weilnetz.de>

Hi

----- Original Message -----
> On 05/07/2017 00:03, Marc-Andr=C3=A9 Lureau wrote:
> > +typedef int TAA_ROLE coroutine_role;
> > +extern coroutine_role _coroutine_fn;
> > +
> > +static inline void co_role_acquire(coroutine_role R) TAA_ACQUIRE(R)
> > TAA_NO_ANALYSYS {}
> > +static inline void co_role_release(coroutine_role R) TAA_RELEASE(R)
> > TAA_NO_ANALYSYS {}
>=20
> Is the argument necessary, or could it be simply TAA_ACQUIRE(_coroutine_f=
n)?

Yes, it can be simplified.

thanks for the suggestion
