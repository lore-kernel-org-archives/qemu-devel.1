Received: from eggs.gnu.org ([2001:4830:134:3::10]:55845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1fRK7E-00045k-Ox
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <afaerber@suse.de>) id 1fRK7B-0001aj-J3
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:19:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:43629)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <afaerber@suse.de>) id 1fRK7B-0001YV-8i
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:19:49 -0400
References: <20180601153922.11590-1-ricardo.perez_blanco@nokia.com>
	<a51fbf8b-9839-ebc1-cde5-5ae95656f918@suse.de>
	<20180608094101.GG2671@work-vm>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Message-ID: <0cc71e01-7015-8f8b-6988-d3b411d3b28c@suse.de>
Date: Fri, 8 Jun 2018 18:19:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180608094101.GG2671@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] Show values and description when using
 "qom-list"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Ricardo Perez Blanco <ricardo.perez_blanco@nokia.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Am 08.06.2018 um 11:41 schrieb Dr. David Alan Gilbert:
> * Andreas F=C3=A4rber (afaerber@suse.de) wrote:
>> Am 01.06.2018 um 17:39 schrieb Ricardo Perez Blanco:
>>> For debugging purposes it is very useful to:
>>>  - See the description of the field. This information is already fill=
ed
>>>    in but not shown in "qom-list" command.
>>
>> No objection on this part.
>>
>>>  - Display value of the field.
>>
>> That is by definition the qom-get operation, not qom-list. Just like t=
he
>> ls command does not show file contents, there's cat etc. for that. For
>> debugging purposes we had a qom-tree (?) command that would combine
>> both.
>=20
> I'm not too bothered about distinguishing between the two commands;
> but it would be nice - one reason I'm not too bothered is because we've
> failed to get a qom-get in multiple years of trying.
>=20
>=20
>>       There might be unmerged patches on qemu-devel related to display
>> of certain data types.
>=20
> Which ones?

My original qom-info series needed StringOutputVisitor changes for enums
(test case: rtc) that did not get accepted immediately and thus some
part of HMP qom-info/qom-get got stuck due to risking assertions for
qom-info / otherwise; QMP was not affected IIRC.

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N=C3=BCrnberg)
