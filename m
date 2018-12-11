Received: from eggs.gnu.org ([2001:4830:134:3::10]:34003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWk48-0008K9-0W
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gWk45-0007Bt-RM
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:35:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gWk45-00079c-KD
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:35:17 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20181208111606.8505-1-marcandre.lureau@redhat.com>
	<20181208111606.8505-14-marcandre.lureau@redhat.com>
	<87a7lde1lg.fsf@dusky.pond.sub.org>
	<CAJ+F1CKFipFDJcO=cFwAUO+7Y_dx7-DbJgfaBwyk9zJj=XR3dw@mail.gmail.com>
Date: Tue, 11 Dec 2018 16:35:13 +0100
In-Reply-To: <CAJ+F1CKFipFDJcO=cFwAUO+7Y_dx7-DbJgfaBwyk9zJj=XR3dw@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 11 Dec 2018
	16:11:00 +0400")
Message-ID: <87efaooz4e.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v7 13/27] qapi: add a dictionary
 form for TYPE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Dec 10, 2018 at 9:26 PM Markus Armbruster <armbru@redhat.com> wro=
te:
[...]
>> Looks good, but I'd like to investigate whether my suggested placement
>> of the normalization would simplify things before I give my R-by.
>>
>
> I am not sure I follow, you suggest to have normalization before
> check? Then how can we produce an error that reflects the input
> accurately? Should we carry additional information (original form etc)
> on the source during normalization?

Let me play with it.  If my idea works out, showing it to you will be
easier than explaining it.  If it doesn't, ditching it quietly will also
be easier than explaining it :)
