Received: from eggs.gnu.org ([2001:4830:134:3::10]:57259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ewsjS-0006JA-7r
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:01:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1ewsjO-0006Gg-M6
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:01:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33918 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1ewsjO-0006GB-ID
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 13:01:26 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 76714406E8D1
	for <qemu-devel@nongnu.org>; Fri, 16 Mar 2018 17:01:25 +0000 (UTC)
Date: Fri, 16 Mar 2018 18:01:22 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180316170122.fmo2nghyxpeaq7hp@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] qemu master build failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

Hi Thomas,

QEMU master is failing to build on an AArch64 machine with GCC 4.8. I get

  ...
  CC      qemu-nbd.o
/home/drjones/code/qemu/qemu-nbd.c: In function =E2=80=98version=E2=80=99=
:
/home/drjones/code/qemu/qemu-nbd.c:133:7: error: expected =E2=80=98)=E2=80=
=99 before =E2=80=98QEMU_FULL_VERSION=E2=80=99
 "%s " QEMU_FULL_VERSION "\n"
       ^
/home/drjones/code/qemu/qemu-nbd.c:139:5: error: format =E2=80=98%s=E2=80=
=99 expects a matching =E2=80=98char *=E2=80=99 argument [-Werror=3Dforma=
t=3D]
     , name);
     ^
cc1: all warnings being treated as errors
make: *** [qemu-nbd.o] Error 1


Reverting 7e563bfb8 fixes the build. I figured I'd report it now,
but I won't have time to look closer until Monday.

Thanks,
drew
