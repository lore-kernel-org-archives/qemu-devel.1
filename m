Received: from eggs.gnu.org ([2001:4830:134:3::10]:38136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRz6l-0001Fo-Ao
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRz6i-0002d1-LM
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:29:19 -0500
Received: from mail.avalus.com ([89.16.176.221]:42731)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cRz6i-0002Yd-Ea
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 05:29:16 -0500
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <c0608208-de6c-fd41-95d7-e73877f8cdba@virtuozzo.com>
Date: Fri, 13 Jan 2017 10:29:06 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <D72ADFAF-BCC6-4CF6-AD42-FECFABA9C575@alex.org.uk>
References: <20161214150840.10899-1-alex@alex.org.uk>
	<e3c30f7c-8d5b-5cfc-1cc0-5e673a30cd8a@virtuozzo.com>
	<6986E12E-AE0A-4502-BB43-77C4E83C9DC4@alex.org.uk>
	<dcaf043a-9e76-3be2-1740-e90085928f6a@virtuozzo.com>
	<5CBA6C86-A5CD-4F88-B8B2-29224BF1223D@alex.org.uk>
	<c0608208-de6c-fd41-95d7-e73877f8cdba@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V . Lunev" <den@openvz.org>


> On 13 Jan 2017, at 09:48, Vladimir Sementsov-Ogievskiy =
<vsementsov@virtuozzo.com> wrote:
>=20
> 12.01.2017 16:11, Alex Bligh wrote:
>>> On 12 Jan 2017, at 07:05, Vladimir Sementsov-Ogievskiy =
<vsementsov@virtuozzo.com> wrote:
>>>=20
>>> Yes this is better. But is it actually needed to force contexts have =
some safe default? If context wants it may define such default without =
this requirement.. So, should it be requirement at all?
>> I've changed this to:
>>=20
>>     of the file), a server MAY reply with a single block status
>>     descriptor with *length* matching the requested length, rather =
than
>>     reporting the error; in this case the context MAY mandate the
>>     status returned.
>>=20
>>=20
>=20
> Hmm, I don't understand. So, it MAY mandate and therefore MAY NOT do =
it? And what client should think, if server replies with one chunk =
matching the request length and not mandate the status?

Some contexts may mandate a particular value (so for instance the =
allocation context might mandate 0).

Some contexts may not mandate a particular value, in which case the =
interpretation is dependent upon the context (just like any other status =
value). EG a context which returned an status of 7 if the range =
contained a prime number, and else 3, could carry on doing that.

As it doesn't make sense to interpret status returns without an =
understanding of the particular context, we might as well simply extend =
this to 'beyond the range' returns - as I think you pointed out!

--=20
Alex Bligh
