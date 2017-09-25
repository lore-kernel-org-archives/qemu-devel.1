Received: from eggs.gnu.org ([2001:4830:134:3::10]:55256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dwPFR-0001D6-1e
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:00:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dwPFO-0003kX-FK
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:00:17 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:43092)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dwPFO-0003jg-8k
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 05:00:14 -0400
Received: from player771.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 9F68C15F07E
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 11:00:12 +0200 (CEST)
References: <20170925083348.17126-1-clg@kaod.org>
	<30287e8a-e697-b33e-bcf0-94bf7fe291de@redhat.com>
	<20170925105256.6b8b57ff@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b726df92-21e6-d4d7-2347-34973a16d65b@kaod.org>
Date: Mon, 25 Sep 2017 11:00:08 +0200
MIME-Version: 1.0
In-Reply-To: <20170925105256.6b8b57ff@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/pnv: check for firmware
 file presence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 09/25/2017 10:52 AM, Greg Kurz wrote:
> On Mon, 25 Sep 2017 10:46:13 +0200
> Thomas Huth <thuth@redhat.com> wrote:
>=20
>> On 25.09.2017 10:33, C=C3=A9dric Le Goater wrote:
>>> and exit before uslessly trying to load it if the file does =20
>>
>> s/uslessly/uselessly/
>>
>>> not exists.
>>>
>>> Issue dicovered by Coverity Scan. =20
>>
>> /dicovered/discovered/
>>
>=20
> Mentioning the Coverity Id (ie, CID 1381410) is also a usual practice.


ah. too late :/

C.=20

>>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>>> ---
>>>  hw/ppc/pnv.c | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
>>> index 47221158d415..7728eece2eec 100644
>>> --- a/hw/ppc/pnv.c
>>> +++ b/hw/ppc/pnv.c
>>> @@ -570,6 +570,10 @@ static void ppc_powernv_init(MachineState *machi=
ne)
>>>      }
>>> =20
>>>      fw_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
>>> +    if (!fw_filename) {
>>> +        error_report("Could not find OPAL '%s'", bios_name); =20
>>
>> I'd suggest to say "OPAL firmware" instead of just "OPAL". Not every
>> user knows what OPAL is.
>>
>=20
> With all the suggested changes:
>=20
> Reviewed-by: Greg Kurz <groug@kaod.org>
>=20
>>> +        exit(1);
>>> +    }
>>> =20
>>>      fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MA=
X_SIZE);
>>>      if (fw_size < 0) {
>>>  =20
>>
>>  Thomas
>=20
>=20
>=20
