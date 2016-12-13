Received: from eggs.gnu.org ([2001:4830:134:3::10]:59957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cGmeJ-0001oH-3S
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:57:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1cGmeF-0002Nd-5L
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:57:39 -0500
Received: from smtp.mail.uni-mannheim.de ([134.155.96.80]:53836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sw@weilnetz.de>) id 1cGmeE-0002N2-VE
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:57:35 -0500
References: <1480432054-12065-1-git-send-email-yuval.shaia@oracle.com>
	<c809cb3d-6e44-679b-f3b4-3c37bb0252b1@vivier.eu>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <decdd3a8-518b-e618-f591-32b1db80c771@weilnetz.de>
Date: Tue, 13 Dec 2016 13:57:30 +0100
MIME-Version: 1.0
In-Reply-To: <c809cb3d-6e44-679b-f3b4-3c37bb0252b1@vivier.eu>
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
To: Laurent Vivier <laurent@vivier.eu>, Yuval Shaia <yuval.shaia@oracle.com>, samuel.thibault@ens-lyon.org, jan.kiszka@siemens.com
Cc: qemu-devel@nongnu.org

Am 13.12.2016 um 13:33 schrieb Laurent Vivier:
> Le 29/11/2016 =C3=A0 16:07, Yuval Shaia a =C3=A9crit :
>> diff --git a/slirp/slirp.h b/slirp/slirp.h
>> index a1f3139..3877f66 100644
>> --- a/slirp/slirp.h
>> +++ b/slirp/slirp.h
>> @@ -292,9 +292,4 @@ int tcp_emu(struct socket *, struct mbuf *);
>>  int tcp_ctl(struct socket *);
>>  struct tcpcb *tcp_drop(struct tcpcb *tp, int err);
>> =20
>> -#ifndef _WIN32
>> -#define min(x,y) ((x) < (y) ? (x) : (y))
>> -#define max(x,y) ((x) > (y) ? (x) : (y))
>> -#endif
>> -
> It seems the defines have been added because they are already defined
> for Win32.
>
> If we remove them, do we know if MIN()/MAX() are defined for Win32?
> [CC: host W32 maintainer]
>
> Thanks,
> Laurent

Neither MIN nor MAX are defined in the header files provided with Mingw-w=
64.

Cheers,
Stefan
