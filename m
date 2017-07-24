Received: from eggs.gnu.org ([2001:4830:134:3::10]:54302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZbDb-0003I2-RA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZbDY-0001Ya-ML
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:08:07 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:38799)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZbDY-0001Xj-Au
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:08:04 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
	<87a83xlo1a.fsf@frigg.lan>
	<d5797b5e-d7d7-8751-21a9-f6ce5775b128@virtuozzo.com>
Date: Mon, 24 Jul 2017 14:07:54 +0300
In-Reply-To: <d5797b5e-d7d7-8751-21a9-f6ce5775b128@virtuozzo.com> (Vladimir
	Sementsov-Ogievskiy's message of "Mon, 24 Jul 2017 11:55:06 +0300")
Message-ID: <871sp6rt2t.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] improve tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@openvz.org, dgilbert@redhat.com, stefanha@redhat.com, armbru@redhat.com

Vladimir Sementsov-Ogievskiy writes:

> 21.07.2017 20:04, Llu=C3=ADs Vilanova wrote:
>> Vladimir Sementsov-Ogievskiy writes:
>>=20
>>> Current trace system have a drawback: parameters of trace functions
>>> are calculated even if corresponding tracepoint is disabled. Also, it
>>> looks like trace function are not actually inlined by compiler (at
>>> least for me).
>>> Here is a fix proposal: move from function call to macros. Patch 02
>>> is an example, of how to reduce extra calculations with help of
>>> patch 01.
>> The tracing functions *were* inlined last time I checked, although things
>> changed quite a lot since then. Not sure that will make a lot of differe=
nce in
>> terms of overall performance (needs measuring).
>>=20
>> As for arguments, each trace event has a define TRACE_{NAME}_ENABLED tha=
t you
>> can use for that purpose. If this is not explained in tracing.txt, that =
is a
>> documentation bug.

> These macroses are about enable/disable traces statically. I'm saying abo=
ut
> dynamic disable/enable.

Aha, I see. I think most events get passed already-calculated variables (us=
ually
for other purposes), so I don't think it will have much of a performance
impact. Did you measure it?


Thanks,
  Lluis
