Received: from eggs.gnu.org ([2001:4830:134:3::10]:58509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f930n-0003V8-IA
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:25:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f930i-0002ZC-Lc
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:25:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54868 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f930i-0002Yr-Ht
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 02:25:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BC117D83F
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 06:25:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180417133602.23832-1-marcandre.lureau@redhat.com>
	<20180417133602.23832-5-marcandre.lureau@redhat.com>
	<a33a9fcb-f6a5-d211-c5f8-0607a65729ab@redhat.com>
Date: Thu, 19 Apr 2018 08:25:25 +0200
In-Reply-To: <a33a9fcb-f6a5-d211-c5f8-0607a65729ab@redhat.com> (Eric Blake's
	message of "Tue, 17 Apr 2018 13:50:28 -0500")
Message-ID: <87y3hjww4q.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 4/5] qobject: modify qobject_ref() to
 return obj
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 04/17/2018 08:36 AM, Marc-Andr=C3=A9 Lureau wrote:
>> For convenience and clarity, make it possible to call qobject_ref() at
>> the time when the reference is associated with a variable, or
>> argument, by making qobject_ref() return the same pointer as given.
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>
>> +++ b/monitor.c
>
>> @@ -4049,8 +4046,7 @@ static void monitor_qmp_respond(Monitor *mon, QObj=
ect *rsp,
>>      if (rsp) {
>>          if (id) {
>>              /* This is for the qdict below. */
>> -            qobject_ref(id);
>> -            qdict_put_obj(qobject_to(QDict, rsp), "id", id);
>> +            qdict_put_obj(qobject_to(QDict, rsp), "id", qobject_ref(id)=
);
>
> Is the comment still needed?  It made more sense when there were two
> statements, and now I think you can just delete it.

In my opinion, it didn't make much sense before, and less now.  Let's
drop it.

> Reviewed-by: Eric Blake <eblake@redhat.com>
