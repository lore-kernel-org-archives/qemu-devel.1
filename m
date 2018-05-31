Received: from eggs.gnu.org ([2001:4830:134:3::10]:33773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOPeo-0000kT-MS
	for qemu-devel@nongnu.org; Thu, 31 May 2018 11:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fOPen-0001GD-S3
	for qemu-devel@nongnu.org; Thu, 31 May 2018 11:38:30 -0400
References: <20180531004323.4611-1-jsnow@redhat.com>
	<20180531004323.4611-2-jsnow@redhat.com>
	<e394c9c5-e65e-5df5-71b3-5cdf87016be3@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <78d5dcf5-1694-08d3-c47c-4dbc85501a24@redhat.com>
Date: Thu, 31 May 2018 11:38:24 -0400
MIME-Version: 1.0
In-Reply-To: <e394c9c5-e65e-5df5-71b3-5cdf87016be3@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/3] ahci: trim signatures on raise/lower
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org



On 05/31/2018 10:56 AM, Eric Blake wrote:
> On 05/30/2018 07:43 PM, John Snow wrote:
>> These functions work on the AHCI device, not the individual
>=20
> s/device/state/ ?
>=20

It's confusing; the AHCI device itself (the HBA) is represented by the
struct AHCIState. the SATA devices are referred to by "AHCIDevice".

Not great names, admittedly.

--js

>> AHCI devices, so trim the AHCIDevice argument.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>> =C2=A0 hw/ide/ahci.c | 8 ++++----
>> =C2=A0 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>=20
