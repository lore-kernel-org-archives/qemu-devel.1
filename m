Received: from eggs.gnu.org ([2001:4830:134:3::10]:38959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1cuyb0-00047U-Td
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chouteau@adacore.com>) id 1cuyax-0002HN-6R
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 05:48:22 -0400
References: <20170331192724.14339-1-ehabkost@redhat.com>
	<58cc8898-70fc-6e35-4666-c2a023d3e66a@amsat.org>
From: Fabien Chouteau <chouteau@adacore.com>
Message-ID: <d9dc8fd5-fab3-6878-f027-d836baa71da8@adacore.com>
Date: Mon, 3 Apr 2017 11:48:16 +0200
MIME-Version: 1.0
In-Reply-To: <58cc8898-70fc-6e35-4666-c2a023d3e66a@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.10 0/2] etsec: (TYPE_)ETSEC_COMMON
 macro cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Scott Wood <scottwood@freescale.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

On 02/04/2017 14:42, Philippe Mathieu-Daud=E9 wrote:
> On 03/31/2017 04:27 PM, Eduardo Habkost wrote:
>> When working on other things, I got confused by the etsec code,
>> that didn't use the TYPE_ETSEC_COMMON macro in its type
>> declaration, and had no subclasses despite being named
>> ETSEC_COMMON.
>>
>> This is a very simple cleanup to remove the _COMMON suffix from
>> the macros, and to use the TYPE_ETSEC macro when registering and
>> creating devices instead of hardcoding the "eTSEC" name.
>>
>> Cc: Alexander Graf <agraf@suse.de>
>> Cc: Scott Wood <scottwood@freescale.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: Fabien Chouteau <chouteau@adacore.com>
>> Cc: qemu-ppc@nongnu.org
>>
>> Eduardo Habkost (2):
>>   etsec: Rename (TYPE_)ETSEC_COMMON to (TYPE_)ETSEC
>>   etsec: Use TYPE_ETSEC macro when registering/creating device
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
>=20

Reviewed-by: Fabien Chouteau <chouteau@adacore.com>


Thanks Eduardo,
