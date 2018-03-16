Received: from eggs.gnu.org ([2001:4830:134:3::10]:60251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewstm-0002ZE-Kv
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:12:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewsth-0007B3-N0
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:12:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43782 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewsth-0007AW-I5
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:12:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 60BEA40201A3
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:11:54 +0000 (UTC)
References: <20180316170122.fmo2nghyxpeaq7hp@kamzik.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a876446f-d4a4-4df2-c986-4e45a64b9436@redhat.com>
Date: Fri, 16 Mar 2018 18:11:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180316170122.fmo2nghyxpeaq7hp@kamzik.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] qemu master build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On 16/03/2018 18:01, Andrew Jones wrote:
> Hi Thomas,
>=20
> QEMU master is failing to build on an AArch64 machine with GCC 4.8. I g=
et
>=20
>   ...
>   CC      qemu-nbd.o
> /home/drjones/code/qemu/qemu-nbd.c: In function =E2=80=98version=E2=80=99=
:
> /home/drjones/code/qemu/qemu-nbd.c:133:7: error: expected =E2=80=98)=E2=
=80=99 before =E2=80=98QEMU_FULL_VERSION=E2=80=99
>  "%s " QEMU_FULL_VERSION "\n"
>        ^
> /home/drjones/code/qemu/qemu-nbd.c:139:5: error: format =E2=80=98%s=E2=80=
=99 expects a matching =E2=80=98char *=E2=80=99 argument [-Werror=3Dforma=
t=3D]
>      , name);
>      ^
> cc1: all warnings being treated as errors
> make: *** [qemu-nbd.o] Error 1
>=20
>=20
> Reverting 7e563bfb8 fixes the build. I figured I'd report it now,
> but I won't have time to look closer until Monday.

You probably have a stray qemu-version.h file somewhere.  No worries, I
was puzzled by the same thing after I applied Thomas's patch. :)

Paolo
