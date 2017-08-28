Received: from eggs.gnu.org ([2001:4830:134:3::10]:59026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmIG6-0000dn-NP
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:31:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dmIG3-0006OT-Ct
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:31:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dmIG3-0006OD-6q
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 07:31:07 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<1503602048-12268-16-git-send-email-armbru@redhat.com>
	<CAJ+F1CL0S-wngP5Oj=zX5FUUA311iLXZ477nVxpWgZFoX=FnnA@mail.gmail.com>
Date: Mon, 28 Aug 2017 13:31:04 +0200
In-Reply-To: <CAJ+F1CL0S-wngP5Oj=zX5FUUA311iLXZ477nVxpWgZFoX=FnnA@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Fri, 25 Aug 2017
	11:27:07 +0000")
Message-ID: <87bmn02akn.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 15/16] qapi-schema: Move queries from
 common.json to qapi-schema.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Aug 24, 2017 at 9:20 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> query-version and query-commands are in common.json for no good
>> reason.  Several similar queries are in qapi-schema.json.  Move them
>> there.
>
> I suppose it was initially meant to be shared with all QMP users, qga etc?

Possibly.

> That didn't happen, and is not planned either

Correct.

>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
