Received: from eggs.gnu.org ([2001:4830:134:3::10]:47802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwXnS-0006uU-K0
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwXnP-0004Be-Dx
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:07:58 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:50372)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwXnP-0004An-26
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 14:07:55 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<20170922224855.GA6905@flamenco>
Date: Mon, 25 Sep 2017 21:07:45 +0300
In-Reply-To: <20170922224855.GA6905@flamenco> (Emilio G. Cota's message of
	"Fri, 22 Sep 2017 18:48:55 -0400")
Message-ID: <87fubawt1q.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 00/22] instrument: Add basic event
 instrumentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

Emilio G Cota writes:

> On Wed, Sep 13, 2017 at 12:53:43 +0300, Llu=C3=ADs Vilanova wrote:
>> The instrumentation code is dynamically loaded as a library into QEMU ei=
ther
>> when it starts or later using its remote control interfaces. The loaded =
code
>> only has access to function explicitly exported through the QI_VPUBLIC m=
acro.
>>=20
>> This series is branch 'devel-instrument' in
>> https://code.gso.ac.upc.edu/git/qemu-dbi.

> Is this up to date? That tree doesn't build for me with --enable-instrume=
nt; I
> get the same error I got in v4:

>   CC      x86_64-linux-user/instrument/state.o
> /data/src/qemu2/instrument/trace.c:13:30: fatal error: qemu-instr/trace.h=
: No such file or directory
> compilation terminated.
> /data/src/qemu2/rules.mak:66: recipe for target 'instrument/trace.o' fail=
ed

> Or maybe I'm doing something wrong?
> I'm configuring with `configure --target-list=3Dx86_64-linux-user --enabl=
e-instrument'.

You're doing it right, and I've checked that the branch is properly pushed.=
 Can
you compile with V=3D1 to show me the failing cmdline?

Thanks,
  Lluis
