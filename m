Received: from eggs.gnu.org ([209.51.188.92]:60242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gpZlM-0002qe-0X
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lucienmp_antispam@yahoo.com>) id 1gpZlK-0001BV-Q4
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:25:47 -0500
Received: from sonic307-11.consmr.mail.ne1.yahoo.com ([66.163.190.34]:37951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lucienmp_antispam@yahoo.com>)
	id 1gpZlK-0001Ac-BC
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:25:46 -0500
Date: Fri, 1 Feb 2019 14:25:39 +0000 (UTC)
From: Lucien Anti-Spam <lucienmp_antispam@yahoo.com>
Message-ID: <1994195934.1510428.1549031139233@mail.yahoo.com>
In-Reply-To: <622bb639-5ab5-d427-e84f-bc3ef85c83da@greensocs.com>
References: <20190131044837.9542-1-lucienmp_antispam@yahoo.com>
	<622bb639-5ab5-d427-e84f-bc3ef85c83da@greensocs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] Fix for RSP vCont packet
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Luc Michel <luc.michel@greensocs.com>

 Hi Luc,
Great feedback from both you and Eric - im blown away, I dont thinktheres a=
 single 1byte ascii character left unturned there :)My coding style snuck i=
n erywhere, as did my Scottish English!
    On Friday, February 1, 2019, 10:33:18 PM GMT+9, Luc Michel <luc.michel@=
greensocs.com> wrote: > > +=C2=A0 =C2=A0 GDBThreadIdKind vcontThreadType ;
> The coding style ...=C2=A0CODING_STYLE ...
Ah I didnt pick up on this whilst reading the Wiki for coding style, thank =
you!
> > +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vcontThreadType =3D GDB_ALL_=
THREAD ;> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pid =3D 1 ;
> The spec is not clear but I would opt for GDB_ALL_PROCESSES instead of
> GDB_ALL_THREAD here. pid =3D 1; is clearly wrong since you don't know if
> this PID exists or is currently attached.
I was in a quandary here, and I did see your previous email too.However, I =
looked at how the call to=C2=A0read_thread_id()=C2=A0behaved and=C2=A0copie=
d over the same behavior as if the command was vCont;c:-1which I understand=
 to mean continue all threads?
So maybe we should look at altering=C2=A0read_thread_id() which sets pid=3D=
1 when thereis no "ppid." part to the thread-id description, and if you set=
 "tid=3D-1" then it performs a GDB_ALL_THREAD
>From the vCont spec I also got;"p-1 ... means all processes""An action with=
 no thread-id matches all threads."
"tid=3D-1 ... matches all threads"
But it is not very clear what happens if you omit ppid and supply tid as -1=
.
What do you think?
Cheers,

Luc

 =20
