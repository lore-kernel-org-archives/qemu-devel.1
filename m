Received: from eggs.gnu.org ([2001:4830:134:3::10]:45250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eii9y-0003dw-KT
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:54:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eii9v-0001BB-Ep
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:54:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58012)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eii9v-000192-9H
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:54:15 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-21-armbru@redhat.com>
	<CAMxuvaw9_oBL=DJPekHffUNvL70ih7LJm+E3EJa5e35gUBmngQ@mail.gmail.com>
Date: Mon, 05 Feb 2018 15:53:47 +0100
In-Reply-To: <CAMxuvaw9_oBL=DJPekHffUNvL70ih7LJm+E3EJa5e35gUBmngQ@mail.gmail.com>
	(Marc-Andre Lureau's message of "Mon, 5 Feb 2018 14:46:05 +0100")
Message-ID: <87inbbv66c.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 20/21] Include less of qapi-types.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc-Andre Lureau <mlureau@redhat.com>
Cc: marcandre <marcandre.lureau@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, mdroth@linux.vnet.ibm.com

Marc-Andre Lureau <mlureau@redhat.com> writes:

> On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> In my "build everything" tree, a change to the types in
>> qapi-schema.json triggers a recompile of about 4500 out of 4800
>> objects.
>>
>> The previous commit split up the generated qapi-types.h.  Replace
>> includes of qapi-types.h (i.e. all types) by includes of parts where
>> possible.
>>
>> To illustrate the benefits: adding a type to qapi/migration.json now
>> recompiles some 2300 instead of 4500 objects.  The next commit will
>> improve it further.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> for the record, what was your methodology?

I counted compiles like this:

    $ make 2>&1 | awk '/^  [A-Z]/ { h[$1]++ } END { n =3D asorti(h, x); for=
 (i =3D 1; i <=3Dn; i++) print x[i], h[x[i]] }'

> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
