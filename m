Received: from eggs.gnu.org ([2001:4830:134:3::10]:46089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwt3H-0004Dl-4J
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:49:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwt3E-00072x-0v
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:49:43 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:38270)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dwt3D-000720-M0
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 12:49:39 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
	<150529666493.10902.14830445134051381968.stgit@frigg.lan>
	<CAFEAcA9p9B8AFaaSaSOOSsFsEhHW=XPLBFs5MrozWq=7p4_9Zg@mail.gmail.com>
	<87poasgjyh.fsf@frigg.lan>
	<CAFEAcA8XP+8Jz9Dn-mEQ3CCrVj00t3HA0praQ-OSggtQGAmQ5Q@mail.gmail.com>
	<87d16o53xr.fsf@frigg.lan>
	<CAFEAcA9FhXKVKe1E_pVDWX3u0W7WuKQmO54Z1Jgj-iL980yPew@mail.gmail.com>
	<87o9pywt8k.fsf@frigg.lan> <20170925194202.GA19618@flamenco>
Date: Tue, 26 Sep 2017 19:49:26 +0300
In-Reply-To: <20170925194202.GA19618@flamenco> (Emilio G. Cota's message of
	"Mon, 25 Sep 2017 15:42:02 -0400")
Message-ID: <87bmlxtnft.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 01/22] instrument: Add documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>

Emilio G Cota writes:

> On Mon, Sep 25, 2017 at 21:03:39 +0300, Llu=C3=ADs Vilanova wrote:
>> I know it's not exactly the same we're discussing, but the plot in [1] c=
ompares
>> a few different ways to trace memory accesses on SPEC benchmarks:
>>=20
>> * First bar is using a Intel's tool called PIN [2].
>> * Second is calling into an instrumentation function on every executed m=
emory
>> access in QEMU.
>> * Third is embedding the hot path of writing the memory access info to a=
n array
>> into the TCG opcode stream (more or less equivalent to supporting filter=
ing;
>> when the array is full, a user's callback is called - cold path -)
>> * Fourth bar can be ignored.
>>=20
>> This was working on a much older version of instrumentation for QEMU, bu=
t I can
>> implement something that does the first use-case point above and some fi=
ltering
>> example (second use-case point) to see what's the performance difference.
>>=20
>> [1] https://filetea.me/n3wy9WwyCCZR72E9OWXHArHDw

> Interesting! Unfortunately, this URL gives me a 404.

Ok, I've uploade it somewhere else:

  https://people.gso.ac.upc.edu/vilanova/mtrace.pdf

There's also another one that simply counts the number of memory accesses, =
using
the same three approaches:

  https://people.gso.ac.upc.edu/vilanova/mcount.pdf

Cheers,
  Lluis
