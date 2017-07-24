Received: from eggs.gnu.org ([2001:4830:134:3::10]:59828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dZZ95-0004MD-0F
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dZZ91-0001V6-34
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:55:19 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:14873 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dZZ90-0001PA-NF
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 04:55:15 -0400
References: <20170721143149.43721-1-vsementsov@virtuozzo.com>
	<87a83xlo1a.fsf@frigg.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <d5797b5e-d7d7-8751-21a9-f6ce5775b128@virtuozzo.com>
Date: Mon, 24 Jul 2017 11:55:06 +0300
MIME-Version: 1.0
In-Reply-To: <87a83xlo1a.fsf@frigg.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
To: qemu-devel@nongnu.org, den@openvz.org, dgilbert@redhat.com, stefanha@redhat.com, armbru@redhat.com

21.07.2017 20:04, Llu=C3=ADs Vilanova wrote:
> Vladimir Sementsov-Ogievskiy writes:
>
>> Current trace system have a drawback: parameters of trace functions
>> are calculated even if corresponding tracepoint is disabled. Also, it
>> looks like trace function are not actually inlined by compiler (at
>> least for me).
>> Here is a fix proposal: move from function call to macros. Patch 02
>> is an example, of how to reduce extra calculations with help of
>> patch 01.
> The tracing functions *were* inlined last time I checked, although thin=
gs
> changed quite a lot since then. Not sure that will make a lot of differ=
ence in
> terms of overall performance (needs measuring).
>
> As for arguments, each trace event has a define TRACE_{NAME}_ENABLED th=
at you
> can use for that purpose. If this is not explained in tracing.txt, that=
 is a
> documentation bug.

These macroses are about enable/disable traces statically. I'm saying=20
about dynamic disable/enable.

>
>
> Thanks,
>    Lluis


--=20
Best regards,
Vladimir
