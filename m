Received: from eggs.gnu.org ([2001:4830:134:3::10]:55834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eiigt-0007j0-Bq
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:28:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eiign-0006fl-Pn
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:28:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eiign-0006c0-KS
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 10:28:13 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20180202130336.24719-1-armbru@redhat.com>
	<20180202130336.24719-3-armbru@redhat.com>
	<CAMxuvaw1-UtqTSYX1nD8Sh7ypaVv0kXcF3X0K0aw-_ci0d58nA@mail.gmail.com>
Date: Mon, 05 Feb 2018 16:28:06 +0100
In-Reply-To: <CAMxuvaw1-UtqTSYX1nD8Sh7ypaVv0kXcF3X0K0aw-_ci0d58nA@mail.gmail.com>
	(Marc-Andre Lureau's message of "Mon, 5 Feb 2018 14:44:43 +0100")
Message-ID: <87d11jjw1l.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 02/21] qapi: Generate up-to-date
 copyright notice
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

> Hi
>
> On Fri, Feb 2, 2018 at 2:03 PM, Markus Armbruster <armbru@redhat.com> wro=
te:
>> Each generator carries a copyright notice for the generator itself,
>> and another one for the files it generates.  Only the former have been
>> updated along the way, the latter have not, and are all out of date.
>>
>> Fix by copying the generator's copyright notice to the generated files
>> instead.
>
> That makes sense, but we loose the Author lines in the generated
> files. Not a big deal I guess, but worth to point out, no?

We do.  They've become just as outdated as the copyright notices.
Giving them the same treatment doesn't seem to be worth the trouble.
I'm happy to explain this in the commit message.

>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>
> Other than that,
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Thanks!
