Received: from eggs.gnu.org ([2001:4830:134:3::10]:39185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erjz4-00031h-0w
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 07:40:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1erjz2-0003wr-Tb
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 07:40:21 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-2-git-send-email-vsementsov@virtuozzo.com>
	<b4c52fa6-67a3-da9d-b4e1-bfdc21ee9a88@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <73c70336-ad2e-8889-b668-930170cf5209@virtuozzo.com>
Date: Fri, 2 Mar 2018 15:40:09 +0300
MIME-Version: 1.0
In-Reply-To: <b4c52fa6-67a3-da9d-b4e1-bfdc21ee9a88@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 1/9] nbd/server: add nbd_opt_invalid helper
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

16.02.2018 01:01, Eric Blake wrote:
> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> NBD_REP_ERR_INVALID is often parameter to nbd_opt_drop and it would
>> be used more in following patches. So, let's add a helper.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 nbd/server.c | 50 ++++++++++++++++++++++++++++++++++++-----------=
---
>> =C2=A0 1 file changed, 36 insertions(+), 14 deletions(-)
>
> More than twice the lines added compared to what was removed, so it's=20
> a tough call whether this refactoring makes a common pattern easier or=20
> just adds burden in tracing what gets executed, just to remove a=20
> parameter.=C2=A0 I'm not opposed to the patch, but want to see how it hel=
ps=20
> the rest of the series.
>
> At any rate, the conversion itself is done correctly, so if we keep=20
> the patch, it has earned:
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
>
>> =C2=A0 +static int GCC_FMT_ATTR(4, 5)
>> +nbd_opt_drop(NBDClient *client, uint32_t type, Error **errp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const char *fmt, ...)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 va_list va;
>> +
>> +=C2=A0=C2=A0=C2=A0 va_start(va, fmt);
>> +=C2=A0=C2=A0=C2=A0 ret =3D nbd_opt_vdrop(client, type, errp, fmt, va);
>> +=C2=A0=C2=A0=C2=A0 va_end(va);
>> +
>> +=C2=A0=C2=A0=C2=A0 return ret;
>> +}
>> +
>> +static int GCC_FMT_ATTR(3, 4)
>> +nbd_opt_invalid(NBDClient *client, Error **errp, const char *fmt, ...)
>
> No documentation comments?
>
the function is obvious and is near to nbd_opt_vdrop.. do we really want=20
a comment? And, then, what about seprate comment for nbd_opt_drop?

--=20
Best regards,
Vladimir
