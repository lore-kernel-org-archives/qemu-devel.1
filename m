Received: from eggs.gnu.org ([2001:4830:134:3::10]:55361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fKpZ3-0006Zl-9e
	for qemu-devel@nongnu.org; Mon, 21 May 2018 14:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fKpZ2-00063t-FU
	for qemu-devel@nongnu.org; Mon, 21 May 2018 14:29:45 -0400
References: <20180521163203.26590-1-ross.zwisler@linux.intel.com>
	<20180521163203.26590-3-ross.zwisler@linux.intel.com>
	<6332df7d-3588-9ecc-6220-2f40c1581fe6@redhat.com>
	<be62d517-9b3e-6fe2-7333-b8315e830b4b@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cf2f3544-fe8f-4649-6056-f37246009307@redhat.com>
Date: Mon, 21 May 2018 13:29:31 -0500
MIME-Version: 1.0
In-Reply-To: <be62d517-9b3e-6fe2-7333-b8315e830b4b@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu PATCH v4 2/4] tests/.gitignore: add entry
 for generated file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Ross Zwisler <ross.zwisler@linux.intel.com>, Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu block <qemu-block@nongnu.org>, "Michael S . Tsirkin" <mst@redhat.com>, linux-nvdimm <linux-nvdimm@lists.01.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>

On 05/21/2018 12:32 PM, Philippe Mathieu-Daud=C3=A9 wrote:

>>>
>>>  =C2=A0=C2=A0=C2=A0=C2=A0tests/test-block-backend
>>>

>>> +test-block-backend
>>>  =C2=A0 test-blockjob
>>>  =C2=A0 test-blockjob-txn
>>>  =C2=A0 test-bufferiszero
>=20
> What about using gitignore negated pattern in tests/?

Or, what we've threatened to do in the past: rename all unit tests to=20
the pattern *-test instead of test-*, as a suffix is a lot easier to=20
exclude via glob than a prefix.  And while we're renaming things, sort=20
tests into separate subdirectories according to whether they are run as=20
part of 'make check-unit' or 'make check-qtest'.  But until someone does=20
that work, tweaking the .gitignore for individual tests as they keep=20
getting added is no worse than what we've been doing.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
