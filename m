Received: from eggs.gnu.org ([2001:4830:134:3::10]:53821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGsZ2-0001Bs-Tj
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 14:16:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cGsYy-0004Om-0f
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 14:16:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cGsYx-0004NS-Rh
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 14:16:31 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <1480432054-12065-1-git-send-email-yuval.shaia@oracle.com>
	<c809cb3d-6e44-679b-f3b4-3c37bb0252b1@vivier.eu>
	<decdd3a8-518b-e618-f591-32b1db80c771@weilnetz.de>
Date: Tue, 13 Dec 2016 20:16:27 +0100
In-Reply-To: <decdd3a8-518b-e618-f591-32b1db80c771@weilnetz.de> (Stefan Weil's
	message of "Tue, 13 Dec 2016 13:57:30 +0100")
Message-ID: <87y3zjljw4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] slirp,
 disas: Replace min/max with MIN/MAX macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: Laurent Vivier <laurent@vivier.eu>, Yuval Shaia <yuval.shaia@oracle.com>, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com, qemu-devel@nongnu.org

Stefan Weil <sw@weilnetz.de> writes:

> Am 13.12.2016 um 13:33 schrieb Laurent Vivier:
>> Le 29/11/2016 =C3=A0 16:07, Yuval Shaia a =C3=A9crit :
>>> diff --git a/slirp/slirp.h b/slirp/slirp.h
>>> index a1f3139..3877f66 100644
>>> --- a/slirp/slirp.h
>>> +++ b/slirp/slirp.h
>>> @@ -292,9 +292,4 @@ int tcp_emu(struct socket *, struct mbuf *);
>>>  int tcp_ctl(struct socket *);
>>>  struct tcpcb *tcp_drop(struct tcpcb *tp, int err);
>>>=20=20
>>> -#ifndef _WIN32
>>> -#define min(x,y) ((x) < (y) ? (x) : (y))
>>> -#define max(x,y) ((x) > (y) ? (x) : (y))
>>> -#endif
>>> -
>> It seems the defines have been added because they are already defined
>> for Win32.
>>
>> If we remove them, do we know if MIN()/MAX() are defined for Win32?
>> [CC: host W32 maintainer]
>>
>> Thanks,
>> Laurent
>
> Neither MIN nor MAX are defined in the header files provided with Mingw-w=
64.

osdep.h provides them, and it's by convention included first by every
.c.
