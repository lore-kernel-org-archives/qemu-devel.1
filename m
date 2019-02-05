Received: from eggs.gnu.org ([209.51.188.92]:37633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqwdA-00075s-CF
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:03:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gqwd9-0008SH-HC
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:03:00 -0500
Date: Tue, 5 Feb 2019 10:02:48 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190205100248.54f5d1cd.cohuck@redhat.com>
In-Reply-To: <9a93a2a0-f352-1fb6-eb27-49f607cd0b97@redhat.com>
References: <20190204225542.5597-1-eblake@redhat.com>
	<9a93a2a0-f352-1fb6-eb27-49f607cd0b97@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] checkpatch: Flag suspicious attribution
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, peter.maydell@linaro.org

On Tue, 5 Feb 2019 00:29:14 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 2/4/19 11:55 PM, Eric Blake wrote:
> > Flag commit attribution tags that are unusual (often because they
> > were a typo), but only as a warning (because sometimes a humorous
> > or otherwise useful tag is intentionally supplied).
> >=20
> > This picks the 6-most popular tags, each with 700 or more uses (well,
> > S-o-b was already checked for case-sensitivity and typos, leaving
> > only 5 new tags being checked), as determined by:
> > $ git log | sed -n 's/^ *\([A-Za-z-]*-by:\).*/\1/p' | \
> >   sort | uniq -c | sort -k1,1n | tail
> >=20
> > Most of the rejected lines were obvious typos (among others, we've
> > had 4 cases of someone being burnt, based on Singed-off-by; and 2
> > cases of list-reading via an e-reader, based on eviewed-by; there
> > are also lines forgetting a space after the ':') or otherwise
> > tongue-in-check (3 Approximately-suggested-by). A few lines not
> > whitelisted here may be legitimate, but as they are orders of
> > magnitude rarer, it is therefore not worth worrying about
> > (7 Requested-by, 3 Co-authored-by, 1 Inspired-by, etc.). =20

Hm, wasn't Co-authored-by: actually intended to cover the cases where
someone else did write significant parts of the patch? (I cannot point
to the source without searching, though...)

>=20
> 'Inspired-by' is kinda Zen :) And is from Peter!

I also like that one :)
