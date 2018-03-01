Received: from eggs.gnu.org ([2001:4830:134:3::10]:37551)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erMY4-0008K2-HD
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:38:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erMY3-0005UE-KJ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:38:56 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-6-git-send-email-vsementsov@virtuozzo.com>
	<6f4c0fa6-78f5-13a9-bdd7-d24da479fc72@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <2e169d7b-29fa-37a7-efe3-32772c966d8e@virtuozzo.com>
Date: Thu, 1 Mar 2018 14:38:40 +0300
MIME-Version: 1.0
In-Reply-To: <6f4c0fa6-78f5-13a9-bdd7-d24da479fc72@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 5/9] nbd/client: fix error messages in
 nbd_handle_reply_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

16.02.2018 20:38, Eric Blake wrote:
> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 1. NBD_REP_ERR_INVALID is not only about length, so, make message more
>> =C2=A0=C2=A0=C2=A0 general
>>
>> 2. hex format is not very good: it's hard to read something like
>> =C2=A0=C2=A0=C2=A0 "option a (set meta context)", so switch to dec.
>
> It would be okay as option 0xa; I also want to be sure we match the=20
> output in server traces with the output in client traces; for example,=20
> I found:
>
> nbd/server.c-=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Unsupported option 0x%"=20
> PRIx32 " (%s)",
> nbd/server.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 option, nbd_opt_lookup(option));
>
> So we want consistency through all the call sites, before this patch=20
> is ready to go, although I agree we need it.
>

I think, decimal format for NBD constants is better, as it used in the spec=
.

--=20
Best regards,
Vladimir
