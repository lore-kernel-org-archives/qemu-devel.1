Received: from eggs.gnu.org ([209.51.188.92]:41965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grTW0-0000gb-Sv
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:09:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1grTVz-00052e-1j
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:09:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1grTVy-00050b-Er
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 15:09:46 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E838C8F507
	for <qemu-devel@nongnu.org>; Wed,  6 Feb 2019 20:09:36 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20190206181725.14337-1-armbru@redhat.com>
	<20190206181725.14337-18-armbru@redhat.com>
	<5ad19847-14c5-fdd4-8cf5-9cacd8a95005@redhat.com>
Date: Wed, 06 Feb 2019 21:09:31 +0100
In-Reply-To: <5ad19847-14c5-fdd4-8cf5-9cacd8a95005@redhat.com> (Eric Blake's
	message of "Wed, 6 Feb 2019 12:40:05 -0600")
Message-ID: <87lg2sllvo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 17/17] qapi: move RTC_CHANGE to the
 target schema
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com

Eric Blake <eblake@redhat.com> writes:

> On 2/6/19 12:17 PM, Markus Armbruster wrote:
>> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>=20
>> A few targets don't emit RTC_CHANGE, we could restrict the event to
>> the tagets that do emit it.
>
> s/tagets/targets/
>
>>=20
>> Note: There is a lot more of events & commands that we could restrict
>
> s/is a lot more of/are a lot more/
>
>> to capable targets, with the cost of some additional complexity, but
>> the benefit of added correctness and better introspection.
>>=20
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---

Will fix, thanks!
