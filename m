Received: from eggs.gnu.org ([2001:4830:134:3::10]:42073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ds8mb-0001GB-MH
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:36:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ds8mX-00080l-5n
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:36:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ds8mX-00080O-03
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 10:36:49 -0400
Date: Wed, 13 Sep 2017 15:36:43 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170913143643.GB15565@stefanha-x1.localdomain>
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506192215.225.7218869490056612779@6d89bd104fc3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150506192215.225.7218869490056612779@6d89bd104fc3>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] trace: Add guest code events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: famz@redhat.com, qemu-devel@nongnu.org

On Sun, Sep 10, 2017 at 09:45:22AM -0700, no-reply@patchew.org wrote:
> In file included from /tmp/qemu-test/src/tcg/tcg-common.c:29:
> /tmp/qemu-test/src/tcg/tcg.h:411: error: redefinition of typedef =E2=80=
=98TCGInlineLabel=E2=80=99
> /tmp/qemu-test/src/include/qemu/typedefs.h:99: note: previous declarati=
on of =E2=80=98TCGInlineLabel=E2=80=99 was here
>   GEN     x86_64-softmmu/hmp-commands-info.h
> make[1]: *** [tcg/tcg-common.o] Error 1

Please take a look at this failure, Llu=C3=ADs.

Once Richard Henderson has reviewed this series I'd be happy to apply
it.

Stefan
