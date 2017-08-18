Received: from eggs.gnu.org ([2001:4830:134:3::10]:44603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1dicqx-0006hw-O8
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hahn@univention.de>) id 1dicqu-0004jV-Kz
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:42:03 -0400
Received: from mail.univention.de ([82.198.197.8]:12881)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hahn@univention.de>) id 1dicqu-0004ib-C1
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 04:42:00 -0400
References: <8b120ab5-5319-30d6-6971-411c7e5c4330@univention.de>
	<20170814183910.GA2469@work-vm>
	<35734e50-0fe7-1809-1826-f6f28856ff88@redhat.com>
From: Philipp Hahn <hahn@univention.de>
Message-ID: <410b3398-470f-4434-7488-890054b4921b@univention.de>
Date: Fri, 18 Aug 2017 10:41:47 +0200
MIME-Version: 1.0
In-Reply-To: <35734e50-0fe7-1809-1826-f6f28856ff88@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] RFH: difference in read-only mapped bios.bin -
 memory corruption?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org

Hello,

Am 15.08.2017 um 13:25 schrieb Laszlo Ersek:
> On 08/14/17 20:39, Dr. David Alan Gilbert wrote:
>> * Philipp Hahn (hahn@univention.de) wrote:
>>> I'm currently investigating a problem, were a Linux VM does not reboo=
t
>>> and gets stuck in the SeaBIOS reboot code:
>>>
>>> I'm using SeaBIOS-1.7 from Debian with a more modern qemu-2.8
...>>> If I dump both regions and compare them, I get a difference:
...>> You might want seabios commit c68aff5 and b837e6 that got fixed aft=
er
>> I tracked down some reboot hangs - although they were rare, not every
>> time.  c68aff5 did certainly cause a corruption, and the address of th=
at
>> corruption was determined at link time and could overlay random useful
>> bits of code if you were unlucky.

Thanks you for the commit IDs - to me this looks like they fixed the
problem. Testing with seabios-1.10 does not show any reboot problem so fa=
r.

>>> 1. How can it be, that the low-mem ROM mapping is modified?
>>
>> I can't remember all the details, but PC ROM is shadowed and mapped ov=
er
>> with RAM at various times,
>=20
> Right. I don't remember for sure, but I believe the state of the PAM
> registers doesn't only affect what the VCPUs see in that address range,
> but also what your monitor commands will dump. (This would be the
> logical choice -- make the monitor output what the VCPUs see anyway, at
> the moment, dependent on the PAM settings.)

That makes sense.
Do you know by change what change in Qemu triggered that bug, as I've
never seen any reboot problem with qemu-1.1.2, but only since switching
to qemu-2.8?

Thanks again for your excellent help.

Philipp
