Received: from eggs.gnu.org ([2001:4830:134:3::10]:59366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <f.gruenbichler@proxmox.com>) id 1cTolg-0005Tr-8N
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 06:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <f.gruenbichler@proxmox.com>) id 1cTold-0006JG-6z
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 06:51:08 -0500
Date: Wed, 18 Jan 2017 12:50:50 +0100
From: Fabian =?iso-8859-1?Q?Gr=FCnbichler?= <f.gruenbichler@proxmox.com>
Message-ID: <20170118115050.6o2ut7wtfkuzy5oh@nora.maurer-it.com>
References: <5878AF90.8020709@kamp.de>
	<260873230.6154791.1484638426777.JavaMail.zimbra@oxygem.tv>
	<20170117080326.dfjqzwstfxusuhgc@nora.maurer-it.com>
	<b7f5dc23-6d72-4897-e9ca-6482acfb4c72@redhat.com>
	<20170117112224.2st4wuivcbwuif2m@nora.maurer-it.com>
	<196ac8f5-2fd7-37e9-d577-8177802d0fb4@redhat.com>
	<40cbdb51-3dcc-35bc-bb99-6c85a47d20d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <40cbdb51-3dcc-35bc-bb99-6c85a47d20d0@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-stable] Data corruption in Qemu 2.7.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexandre DERUMIER <aderumier@odiso.com>, qemu-stable <qemu-stable@nongnu.org>

On 17/01/2017 16:03, Paolo Bonzini wrote:
> On 17/01/2017 12:22, Fabian Gr=FCnbichler wrote:
>> 6) repeat 3-5 until md5sum does not match, kernel spews error
>> messages, or you are convinced that everything is OK
>>
>> sample kernel message (for ext3):
>> Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 FAILED Result:=
 hostbyte=3DDID_OK driverbyte=3DDRIVER_SENSE
>> Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 Sense Key : Il=
legal Request [current]
>> Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 Add. Sense: In=
valid field in cdb
>> Jan 17 11:39:32 ubuntu kernel: sd 2:0:0:0: [sda] tag#32 CDB: Write(10)=
 2a 00 0f 3a 90 00 00 07 d8 00
>> Jan 17 11:39:32 ubuntu kernel: blk_update_request: critical target err=
or, dev sda, sector 255496192
>=20
> Can you reproduce it if QEMU runs under "strace -e ioctl -ff" in the=20
> host?  Or also using this systemtap script.
>=20
> The important bit would be the lines with a nonzero status, but the
> others can be useful to see what the surroundings look like.
>=20

OT: systemtap is not working with your script under Debian Jessie (or
maybe in general under Debian Jessie? not sure).

after some further testing it seems like this change in Qemu exposes
some subtle issue with our specific kernel (it works fine with the
upstream Ubuntu 4.4 one which ours is based on). I am currently
debugging further to narrow down potential causes - if I need further
input from your side or if I suspect Qemu to be at fault I'll resurrect
this thread (and include the strace output).

thanks for your quick reaction anyhow!
