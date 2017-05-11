Received: from eggs.gnu.org ([2001:4830:134:3::10]:39536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8i9h-0007d4-LB
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d8i9d-00053I-MR
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:04:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37086)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d8i9d-00052R-Gc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 03:04:53 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170505201128.12099-1-ehabkost@redhat.com>
	<20170505201128.12099-2-ehabkost@redhat.com>
	<87efvw26nr.fsf@dusky.pond.sub.org>
	<20170510211028.GF3482@thinpad.lan.raisama.net>
Date: Thu, 11 May 2017 09:04:50 +0200
In-Reply-To: <20170510211028.GF3482@thinpad.lan.raisama.net> (Eduardo
	Habkost's message of "Wed, 10 May 2017 18:10:28 -0300")
Message-ID: <87tw4rlvql.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] visitor: Add 'supported_qtypes'
 parameter to visit_start_alternate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>, qemu-devel@nongnu.org, Michael Roth <mdroth@linux.vnet.ibm.com>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Wed, May 10, 2017 at 03:16:56PM +0200, Markus Armbruster wrote:
>> Eduardo Habkost <ehabkost@redhat.com> writes:
>>=20
>> > This will allow visitors to make decisions based on the supported qtyp=
es
>> > of a given alternate type. The new parameter can replace the old
>> > 'promote_int' argument, as qobject-input-visitor can simply check if
>> > QTYPE_QINT is set in supported_qtypes.
>> >
>> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>=20
>> Might conflict with Marc-Andr=C3=A9's work, which I haven't reviewed, ye=
t.
>> Should be easy enough to resolve, though.
>
> This series is now low-priority for me, as I'm not sure about the
> need for "feature=3Dforce" in x86. I won't mind having to rebase
> this later.

Okay.  I rather like PATCH 1, and may pick it into my own (unpublished)
rework of the alternate visiting code.
