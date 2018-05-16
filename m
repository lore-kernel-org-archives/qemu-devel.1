Received: from eggs.gnu.org ([2001:4830:134:3::10]:45447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fItsS-0005Uk-Jn
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:41:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fItsR-0003DI-J1
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:41:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45430 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fItsR-0003D2-E2
	for qemu-devel@nongnu.org; Wed, 16 May 2018 06:41:47 -0400
References: <64050966FCE0B948BCE2B28DB6E0B7D541340A17@CBSEX1.cloudbase.local>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <af1bfcca-322d-094b-0997-7b9c635e8683@redhat.com>
Date: Wed, 16 May 2018 12:41:43 +0200
MIME-Version: 1.0
In-Reply-To: <64050966FCE0B948BCE2B28DB6E0B7D541340A17@CBSEX1.cloudbase.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] WHPX: fix some compiler warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lucian Petrut <lpetrut@cloudbasesolutions.com>, "petrutlucian94@gmail.com" <petrutlucian94@gmail.com>
Cc: Alessandro Pilotti <apilotti@cloudbasesolutions.com>, Justin Terry <juterry@microsoft.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 16/05/2018 12:21, Lucian Petrut wrote:
> Hi,
>=20
> Thanks for reviewing those changes.
>=20
> /=E2=80=9Ccan you send a patch with the bugfix only=E2=80=9D/
>=20
> By =E2=80=9Cthe bugfix only=E2=80=9D you mean the previous commit, the =
one that
> dynamically loads the DLLs?
>=20
> FWIW, without this patch, i386 targets won=E2=80=99t compile, so I=E2=80=
=99d consider
> that an improvement. Probably I should=E2=80=99ve explicitly mentioned =
this in
> the commit message.

I mean this patch, but without the switch from {0} initializers to memset=
.

I've already queued patch 2 independently, so you are set with that one!

Thanks,

Paolo
