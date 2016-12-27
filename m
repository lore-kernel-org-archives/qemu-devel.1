Received: from eggs.gnu.org ([2001:4830:134:3::10]:51420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLx5q-0007i8-7F
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLx5n-0003Pr-2t
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:07:26 -0500
Received: from roura.ac.upc.edu ([147.83.33.10]:35876 helo=roura.ac.upc.es)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1cLx5m-0003Pf-MI
	for qemu-devel@nongnu.org; Tue, 27 Dec 2016 14:07:23 -0500
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <148285303159.12721.5833400768046299304.stgit@fimbulvetr.bsc.es>
	<148285304262.12721.17599380934779528989.stgit@fimbulvetr.bsc.es>
	<CAFEAcA9QHXR2obCYytP0RD9e=Tgzq_MaEhKK1nBfO0FveS+J6g@mail.gmail.com>
Date: Tue, 27 Dec 2016 20:07:17 +0100
In-Reply-To: <CAFEAcA9QHXR2obCYytP0RD9e=Tgzq_MaEhKK1nBfO0FveS+J6g@mail.gmail.com>
	(Peter Maydell's message of "Tue, 27 Dec 2016 15:53:05 +0000")
Message-ID: <87zijhry1m.fsf@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/6] queue: Add macro for incremental
 traversal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Peter Maydell writes:

> On 27 December 2016 at 15:37, Llu=C3=ADs Vilanova <vilanova@ac.upc.edu> w=
rote:
>> Adds macro QTAILQ_FOREACH_CONTINUE to support incremental list
>> traversal.
>>=20
>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>> ---
>> include/qemu/queue.h |    5 +++++
>> 1 file changed, 5 insertions(+)
>>=20
>> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
>> index 342073fb4d..0d709016f4 100644
>> --- a/include/qemu/queue.h
>> +++ b/include/qemu/queue.h
>> @@ -415,6 +415,11 @@ struct {                                           =
                     \
>> (var);                                                  \
>> (var) =3D ((var)->field.tqe_next))
>>=20
>> +#define QTAILQ_FOREACH_CONTINUE(var, field)                            =
 \
>> +        for ((var) =3D ((var)->field.tqe_next);                        =
   \
>> +                (var);                                                 =
 \
>> +                (var) =3D ((var)->field.tqe_next))
>> +
>> #define QTAILQ_FOREACH_SAFE(var, head, field, next_var)                 \
>> for ((var) =3D ((head)->tqh_first);                               \
>> (var) && ((next_var) =3D ((var)->field.tqe_next), 1);     \

> Could we have some documentation for the new macro, please?

Sure thing.

Lluis
