Received: from eggs.gnu.org ([209.51.188.92]:41806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grTVB-0000He-U6
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grTVB-0004nu-6f
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:08:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40776)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grTVB-0004nS-12
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:08:57 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0EF6889AFF
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 20:08:56 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-16-armbru@redhat.com>
	<CAMxuvayWQawJ3we4bJF7npZgaUWqZvKAK3uik5EO7826DcrnYA@mail.gmail.com>
Date: Wed, 06 Feb 2019 21:08:54 +0100
In-Reply-To: <CAMxuvayWQawJ3we4bJF7npZgaUWqZvKAK3uik5EO7826DcrnYA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Wed, 6 Feb 2019
	19:30:23 +0100")
Message-ID: <87pns4llwp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 15/17] Revert "qapi-events: add 'if'
 condition to implicit event enum"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> Hi
>
> On Wed, Feb 6, 2019 at 7:17 PM Markus Armbruster <armbru@redhat.com> wrot=
e:
>>
>> This reverts commit 7bd263490590ee6fcf34ecb6203437e22f6e5a9c.
>>
>> The commit applied the events' conditions to the members of enum
>> QAPIEvent.  Awkward, because it renders QAPIEvent unusable in
>> target-independent code as soon as we make an event target-dependent.
>
> Well, my solution didn't have this problem iirc. You could mention
> that by having target-specific event enums, we could solve this.

What about appending:

    Another option would be to split target-dependent parts off enum
    QAPIEvent into a target-dependent enum.  Doesn't seem worthwhile right
    now.

> It might be worth a FIXME too.

Well, the only thing that's broken is query-events, and I propose to
delete it instead of fixing it.

>> Reverting this has the following effects:
>>
>> * ui/vnc.c can remain target independent.
>>
>> * monitor_qapi_event_conf[] doesn't have to muck around with #ifdef.
>>
>> * query-events again doesn't reflect conditionals.  I'm going to
>>   deprecate it in favor of query-qmp-schema.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> But that's ok for now:
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
