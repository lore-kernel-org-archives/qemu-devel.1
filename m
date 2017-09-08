Received: from eggs.gnu.org ([2001:4830:134:3::10]:53631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqLd7-0007k0-Hb
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dqLd6-00050V-Mq
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 11:55:41 -0400
References: <20170905151614.31303-1-cohuck@redhat.com>
	<20170905151614.31303-3-cohuck@redhat.com>
	<20170908110425.GC3283@localhost.localdomain>
	<20170908132439.3ab53d7d.cohuck@redhat.com>
	<20170908115414.GF3283@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4374d570-cee8-5f82-7187-dcb7bf57bf55@redhat.com>
Date: Fri, 8 Sep 2017 17:55:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170908115414.GF3283@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: use -ccw on s390x for 051
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: haoqf@linux.vnet.ibm.com, qemu-block@nongnu.org, david@redhat.com, agraf@suse.de, qemu-devel@nongnu.org, borntraeger@de.ibm.com, mreitz@redhat.com, =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>

On 08.09.2017 13:54, Kevin Wolf wrote:
> Am 08.09.2017 um 13:24 hat Cornelia Huck geschrieben:
>> On Fri, 8 Sep 2017 13:04:25 +0200
>> Kevin Wolf <kwolf@redhat.com> wrote:
>>
>>> Am 05.09.2017 um 17:16 hat Cornelia Huck geschrieben:
>>>> The default cpu model on s390x does not provide zPCI, which is
>>>> not yet wired up on tcg. Moreover, virtio-ccw is the standard
>>>> on s390x, so use the -ccw instead of the -pci versions of virtio
>>>> devices on s390x.
>>>>
>>>> Provide an output file for s390x.
>>>>
>>>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>>>> ---
>>>>  tests/qemu-iotests/051                     |   9 +-
>>>>  tests/qemu-iotests/051.s390-ccw-virtio.out | 434 ++++++++++++++++++=
+++++++++++
>>>>  2 files changed, 442 insertions(+), 1 deletion(-)
>>>>  create mode 100644 tests/qemu-iotests/051.s390-ccw-virtio.out =20
>>>
>>> It's already a pain to have two separate output files for 051, let's =
try
>>> to avoid adding a third one. Even more so since I think that the spli=
t
>>> between 051.out and 051.pc.out was already made for s390, so I'm not
>>> sure if anyone would actually still make use of the plain 051.out
>>> output if s390 got it's own one.
>>
>> Are there no non-pc and non-s390 machines for which this is run?
>=20
> Who knows? But I'm not aware of anyone who is interested in something
> else and has contributed to the test cases until now.

FWIW, as far as I know, Luk=C3=A1=C5=A1 is running this test also on ppc6=
4 in our
weekly regression run. So it would be good to keep that working, please :=
-)

>> Another approach would be to drop the -pci postfix, but I don't want t=
o
>> introduce more usage of aliases.
>=20
> Maybe that would indeed be the easiest way. As long as we don't intend
> to remove the alias from qemu, there's no reason not to use it in tests=
.

Maybe we should even use it in a couple of places on purpose - so we get
some test coverage for them?

 Thomas
