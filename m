Received: from eggs.gnu.org ([2001:4830:134:3::10]:36199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddVSd-0006cC-C3
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddVSZ-000480-W4
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:47:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:37008 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ddVSZ-00044V-Pq
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 01:47:43 -0400
References: <1501766821-76419-1-git-send-email-hare@suse.de>
	<8ad6ed91-b793-fab1-ea72-1e30e5b59266@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <41045776-f4c2-20f5-1000-c826e314cfe2@suse.de>
Date: Fri, 4 Aug 2017 07:47:41 +0200
MIME-Version: 1.0
In-Reply-To: <8ad6ed91-b793-fab1-ea72-1e30e5b59266@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/2] scsi: enclosure support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On 08/03/2017 05:10 PM, Paolo Bonzini wrote:
> On 03/08/2017 15:26, Hannes Reinecke wrote:
>> Hi all,
>>
>> due to a customer issue I've added simple subenclosure support
>> to the SCSI emulation. The patch simply converts the current invisible
>> LUN0 into an enclosure device; existing setups using LUN0 as disks or
>> CD-ROMs will not be affected.
>=20
> What is the issue exactly?  That is, for what is it necessary to have a
> dummy enclosure?
>=20
Well, stock linux displays some very interesting error messages for
these types of enclosures.
Which was the prime mover for doing this.

> I agree with Dan that this need machine type compatibility gunk.  For
> example, could the new device affect /dev/sgN numbering?
>=20
Yes, indeed it would.

What about a new option to the scsi driver?
With that each user could selectively enable it, and we wouldn't need to
worry with machine type compability...

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=C3=BCrnberg)
