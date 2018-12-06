Received: from eggs.gnu.org ([2001:4830:134:3::10]:55610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUx8I-0000O3-DZ
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:08:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUx8E-00032s-F3
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:08:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gUx8E-0002xs-8K
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 12:08:10 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0DD1158E46
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 17:08:03 +0000 (UTC)
References: <20181130140615.19937-1-berrange@redhat.com>
	<20181130140615.19937-10-berrange@redhat.com>
	<868aa668-c882-3392-ee10-2afc28a51f7e@redhat.com>
	<5d9b6cdf-3d6b-a424-daa1-e5a498920f59@redhat.com>
	<d7e633c1-2216-fd2b-dd36-41df5c264f0a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5a0b8acd-2906-2ee7-1ef2-0035af9af811@redhat.com>
Date: Thu, 6 Dec 2018 11:07:53 -0600
MIME-Version: 1.0
In-Reply-To: <d7e633c1-2216-fd2b-dd36-41df5c264f0a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 09/11] authz: add QAuthZListFile object
 type for a file access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 12/6/18 9:58 AM, Philippe Mathieu-Daud=C3=A9 wrote:

>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "refresh": "yes"
>>>
>>> I had to use "refresh": yes (value unquoted) to avoid:
>>
>> Do you mean "refresh":true?=C2=A0 (bare yes is not valid JSON, but bar=
e true
>> is the correct way for a JSON bool).
>=20
> I first tried 'true' then was curious and tried 'yes' and it worked too=
...

Ah, so you're using a python wrapper rather than direct QMP, and=20
benefitting from a rather-forgiving parser that turns yes into the=20
correct QMP true over the wire to the actual monitor.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
