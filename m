Received: from eggs.gnu.org ([2001:4830:134:3::10]:51256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f6y95-0005ow-8x
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:49:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f6y91-0000Qm-AI
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:49:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48076 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f6y91-0000Q6-5g
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:49:35 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
	<20180211093607.27351-8-armbru@redhat.com>
	<addfee56-eb31-49b0-5321-d898ad1ed0a2@redhat.com>
	<20180227160124.GU18258@redhat.com>
Date: Fri, 13 Apr 2018 14:49:25 +0200
In-Reply-To: <20180227160124.GU18258@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Tue, 27 Feb 2018 16:01:24 +0000")
Message-ID: <87tvsfz2y2.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/29] qapi: Turn generators into modules
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, qemu-devel@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Feb 27, 2018 at 09:53:22AM -0600, Eric Blake wrote:
>> On 02/11/2018 03:35 AM, Markus Armbruster wrote:
>> > The next commit will introduce a common driver program for all
>> > generators.  The generators need to be modules for that.  qapi2texi.py
>> > already is.  Make the other generators follow suit.
>> >=20
>> > The changes are actually trivial.  Obvious in the diffs once you view
>> > them with whitespace changes ignored.
>> >=20
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > Reviewed-by: Eric Blake <eblake@redhat.com>
>> > Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> > ---
>> >   scripts/qapi-commands.py   | 43 ++++++++++++++++++--------------
>> >   scripts/qapi-event.py      | 43 ++++++++++++++++++--------------
>> >   scripts/qapi-introspect.py | 54 ++++++++++++++++++++++--------------=
----
>> >   scripts/qapi-types.py      | 56 ++++++++++++++++++++++--------------=
-----
>> >   scripts/qapi-visit.py      | 62 +++++++++++++++++++++++++-----------=
----------
>> >   5 files changed, 143 insertions(+), 115 deletions(-)
>>=20
>> Urgh. One annoyance of this patch is that if you switch to another branch
>> without the patch, leftover .pyc files in the source tree can cause weird
>> errors until you 'rm -f scripts/qapi/*.pyc':
>
> Pehaps make our build system set  PYTHONDONTWRITEBYTECODE=3D1  env variab=
le
>
>   https://docs.python.org/3/using/cmdline.html#envvar-PYTHONDONTWRITEBYTE=
CODE

We already have configure put PYTHON=3Dpython -B into config-host.mak.

I still manage to litter my tree with .pyc files...
