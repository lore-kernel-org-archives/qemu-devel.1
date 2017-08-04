Received: from eggs.gnu.org ([2001:4830:134:3::10]:53909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddX88-0000Bc-8q
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1ddX85-0006e0-Hj
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:34:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:44864 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hare@suse.de>) id 1ddX85-0006br-BW
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 03:34:41 -0400
References: <1501766821-76419-1-git-send-email-hare@suse.de>
	<8ad6ed91-b793-fab1-ea72-1e30e5b59266@redhat.com>
	<41045776-f4c2-20f5-1000-c826e314cfe2@suse.de>
	<637661261.1409588.1501827011350.JavaMail.zimbra@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d748e35f-1ba5-0e32-478b-975bcca3f208@suse.de>
Date: Fri, 4 Aug 2017 09:34:38 +0200
MIME-Version: 1.0
In-Reply-To: <637661261.1409588.1501827011350.JavaMail.zimbra@redhat.com>
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

On 08/04/2017 08:10 AM, Paolo Bonzini wrote:
>=20
>> On 08/03/2017 05:10 PM, Paolo Bonzini wrote:
>>> On 03/08/2017 15:26, Hannes Reinecke wrote:
>>>> Hi all,
>>>>
>>>> due to a customer issue I've added simple subenclosure support
>>>> to the SCSI emulation. The patch simply converts the current invisib=
le
>>>> LUN0 into an enclosure device; existing setups using LUN0 as disks o=
r
>>>> CD-ROMs will not be affected.
>>>
>>> What is the issue exactly?  That is, for what is it necessary to have=
 a
>>> dummy enclosure?
>>>
>> Well, stock linux displays some very interesting error messages for
>> these types of enclosures. Which was the prime mover for doing this.
>=20
> --verbose?
>=20
[   12.958454] scsi 1:0:0:254: Wrong diagnostic page; asked for 2 got 0
[   12.958456] scsi 1:0:0:254: Failed to get diagnostic page 0xffffffea
[   12.958457] scsi 1:0:0:254: Failed to bind enclosure -19
[   12.959392] ses 1:0:0:254: Attached Enclosure device

>>> I agree with Dan that this need machine type compatibility gunk.  For
>>> example, could the new device affect /dev/sgN numbering?
>>
>> Yes, indeed it would.
>>
>> What about a new option to the scsi driver?
>=20
> If you do that, you've done 99% of the work to do compatibility so I
> won't complain and do the 1% myself. :)
>=20
Okay, will be doing so.

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=C3=BCrnberg)
