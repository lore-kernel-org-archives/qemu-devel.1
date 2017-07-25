Received: from eggs.gnu.org ([2001:4830:134:3::10]:46550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZyNQ-0006os-AG
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:51:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZyNN-0002Df-Ah
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:51:48 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:49747)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dZyNM-0002Cm-Uc
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:51:45 -0400
From: =?utf-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>
References: <150091574424.30739.4131793221953168474.stgit@frigg.lan>
	<150091841019.30739.3661641061220051037.stgit@frigg.lan>
	<109e1849-1bf6-5875-b304-7cacbf45f068@redhat.com>
	<87wp6wgbzw.fsf@frigg.lan>
	<3a8accf6-2805-e2fa-1d58-1db85558c7a5@redhat.com>
Date: Tue, 25 Jul 2017 14:51:31 +0300
In-Reply-To: <3a8accf6-2805-e2fa-1d58-1db85558c7a5@redhat.com> (Eric Blake's
	message of "Tue, 25 Jul 2017 06:30:42 -0500")
Message-ID: <87o9s8enuk.fsf@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/13] instrument: [qapi] Add library loader
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Eric Blake writes:

> On 07/25/2017 03:24 AM, Llu=C3=ADs Vilanova wrote:
>> Eric Blake writes:
>>=20
>>> On 07/24/2017 12:46 PM, Llu=C3=ADs Vilanova wrote:
>>>> Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
>>>> ---
>>>> instrument/Makefile.objs |    1 +
>>>> instrument/qmp.c         |   71 ++++++++++++++++++++++++++++++++++++
>>>> qapi-schema.json         |    3 ++
>>>> qapi/instrument.json     |   92 ++++++++++++++++++++++++++++++++++++++=
++++++++
>>>> 4 files changed, 167 insertions(+)
>>>> create mode 100644 instrument/qmp.c
>>>> create mode 100644 qapi/instrument.json
>>=20
>>> Adding new files; but I don't see a patch to MAINTAINERS to cover
>>> instrument/*.
>>=20
>> Who should I put as a maintainer? Or does this go to the general maintai=
ner(s)?

> You can be the maintainer if you'd like; or see if Stefan is okay
> including it as part of the trace files, since it trace-related.

I can certainly do that. I was just wondering if the project prefers to have
someone on the "core team" as a maintainer. Stefan?


Thanks,
  Lluis
