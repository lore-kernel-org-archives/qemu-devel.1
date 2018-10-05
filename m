Received: from eggs.gnu.org ([2001:4830:134:3::10]:45091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g8Umj-0005Uz-By
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g8Uhw-0002Gf-08
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 14:20:49 -0400
References: <20181004161852.11673-1-crosa@redhat.com>
	<20181004161852.11673-4-crosa@redhat.com>
	<4ebd6e33-e1e7-962f-3ca8-4bae7b7ce425@redhat.com>
	<c33abf23-46c6-3939-f781-61662714acc5@redhat.com>
	<2b62d615-615b-a128-9c22-7d37df052abb@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b40dca25-2a3c-2e4b-53ad-8f2f1d13143b@redhat.com>
Date: Fri, 5 Oct 2018 13:19:53 -0500
MIME-Version: 1.0
In-Reply-To: <2b62d615-615b-a128-9c22-7d37df052abb@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/10] qemu-iotests: make 218 executable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>

On 10/5/18 1:02 PM, Eric Blake wrote:
> On 10/5/18 12:49 PM, Cleber Rosa wrote:
>=20
>>>
>>> We could add a git pre-commit hook grep'ing for "^#!\
>>> *(/usr/bin/env|/bin/(b?a)?sh)" in the 1st line and then checking the
>>> file perms.
>>>
>>
>> Good idea.=C2=A0 Probably better to send that as a different patch, ri=
ght?
>=20
> Yes, separate patch. For that matter, "^#!/" is probably a sufficient=20
> pattern to catch any file that intends to be run via an interpreter, an=
d=20
> therefore wants to be executable, rather than limiting to just env and=20
> specific shells.

Also, many maintainers already have scripts/checkpatch.pl as a git=20
pre-commit hook, and putting the check in checkpatch.pl means that=20
patchew would also flag the issue.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
