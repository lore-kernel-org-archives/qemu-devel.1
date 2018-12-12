Received: from eggs.gnu.org ([2001:4830:134:3::10]:49269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gX1VL-0001Rp-J5
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:12:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gX1VG-0004AU-W5
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:12:35 -0500
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:37151)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gX1VG-00048P-On
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 05:12:30 -0500
Received: from player711.ha.ovh.net (unknown [10.109.146.168])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 18820E609F
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 11:12:29 +0100 (CET)
Received: from kaod.org (lfbn-1-10605-110.w90-89.abo.wanadoo.fr
	[90.89.196.110]) (Authenticated sender: postmaster@kaod.org)
	by player711.ha.ovh.net (Postfix) with ESMTPSA id D9D1EB1BCE3
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 10:12:28 +0000 (UTC)
References: <20181211174253.10947-1-alex.bennee@linaro.org>
	<81aec30a-c599-9521-9571-c32de4087db4@redhat.com>
	<87pnu712sv.fsf@linaro.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <ffa4daf8-2dc6-c9c3-2dac-a8bbda83a24e@kaod.org>
Date: Wed, 12 Dec 2018 11:12:27 +0100
MIME-Version: 1.0
In-Reply-To: <87pnu712sv.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] contrib: add a basic gitdm config
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 12/12/18 11:01 AM, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
>> On 2018-12-11 18:42, Alex Benn=C3=A9e wrote:
>>> This is a QEMU specific version of a gitdm config for generating
>>> reports on the contributor base of the project. I've added enough
>>> group maps and domain aliases to ensure the current top ten is as
>>> reflective as it can be. As of this commit running:
>>>
>>>   git log --numstat --since "Last Year" | gitdm -n -l 16
>>>
>>> Reports:
>>>
>>>   Top changeset contributors by employer
>>>   RedHat                    3116 (43.8%)
>>>   Linaro                    1166 (16.4%)
>>>   f4bug@amsat.org            384 (5.4%)
>>>   IBM                        170 (2.4%)
>>>   Virtuozzo                  168 (2.4%)
>>>   mark.cave-ayland@ilande.co.uk  161 (2.3%)
>>>   cota@braap.org             134 (1.9%)
>>>   Xilinx                     102 (1.4%)
>>>   clg@kaod.org               100 (1.4%)
>>>   Igalia                      93 (1.3%)
>>>   Cadence Design Systems      88 (1.2%)
>>>   groug@kaod.org              78 (1.1%)
>>
>> You might also want to add a group-map-ibm file for groug and
>> clg@kaod.org ?
>=20
> Yes I finally tracked that down via what I presume are their github ids=
.
> The domain itself has a rather enigmatic but sparse homepage ;-)

"Mihi Placet", it's what you like !=20

C.

>=20
>>
>>  Thomas
>=20
>=20
> --
> Alex Benn=C3=A9e
>=20
