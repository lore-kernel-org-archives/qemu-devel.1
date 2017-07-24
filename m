Received: from eggs.gnu.org ([2001:4830:134:3::10]:55378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dZbM1-0005UI-NR
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:16:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1dZbLy-00054Y-HW
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:16:49 -0400
Received: from mail-db5eur01on0111.outbound.protection.outlook.com
	([104.47.2.111]:55744
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@virtuozzo.com>) id 1dZbLx-00051s-Nu
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:16:46 -0400
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
	<87a83xlo1a.fsf@frigg.lan>
	<d5797b5e-d7d7-8751-21a9-f6ce5775b128@virtuozzo.com>
	<871sp6rt2t.fsf@frigg.lan>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <669eff78-f575-e534-8cbf-75b7ed47f82f@openvz.org>
Date: Mon, 24 Jul 2017 14:16:36 +0300
MIME-Version: 1.0
In-Reply-To: <871sp6rt2t.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/2] improve tracing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, stefanha@redhat.com, armbru@redhat.com

On 07/24/2017 02:07 PM, Llu=C3=ADs Vilanova wrote:
> Vladimir Sementsov-Ogievskiy writes:
>
>> 21.07.2017 20:04, Llu=C3=ADs Vilanova wrote:
>>> Vladimir Sementsov-Ogievskiy writes:
>>>
>>>> Current trace system have a drawback: parameters of trace functions
>>>> are calculated even if corresponding tracepoint is disabled. Also, it
>>>> looks like trace function are not actually inlined by compiler (at
>>>> least for me).
>>>> Here is a fix proposal: move from function call to macros. Patch 02
>>>> is an example, of how to reduce extra calculations with help of
>>>> patch 01.
>>> The tracing functions *were* inlined last time I checked, although thin=
gs
>>> changed quite a lot since then. Not sure that will make a lot of differ=
ence in
>>> terms of overall performance (needs measuring).
>>>
>>> As for arguments, each trace event has a define TRACE_{NAME}_ENABLED th=
at you
>>> can use for that purpose. If this is not explained in tracing.txt, that=
 is a
>>> documentation bug.
>> These macroses are about enable/disable traces statically. I'm saying ab=
out
>> dynamic disable/enable.
> Aha, I see. I think most events get passed already-calculated variables (=
usually
> for other purposes), so I don't think it will have much of a performance
> impact. Did you measure it?
>
>
> Thanks,
>   Lluis
The idea is that we can add more complex stuff after the patch.
QMP command log is a very good example of that.

Actually at our opinion macro will be safe but much better
from the point of side-effects - arguments will never be evaluated
until the trace happened.

Den
