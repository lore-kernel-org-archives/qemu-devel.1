Received: from eggs.gnu.org ([2001:4830:134:3::10]:51577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUf96-0007Do-CW
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gUf91-0004ly-K5
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:55:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gUf91-0004kh-ER
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 16:55:47 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7DD130D0303
	for <qemu-devel@nongnu.org>; Wed,  5 Dec 2018 21:55:46 +0000 (UTC)
References: <20181130140615.19937-1-berrange@redhat.com>
	<20181130140615.19937-10-berrange@redhat.com>
	<868aa668-c882-3392-ee10-2afc28a51f7e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5d9b6cdf-3d6b-a424-daa1-e5a498920f59@redhat.com>
Date: Wed, 5 Dec 2018 15:55:28 -0600
MIME-Version: 1.0
In-Reply-To: <868aa668-c882-3392-ee10-2afc28a51f7e@redhat.com>
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

On 12/5/18 11:23 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/30/18 3:06 PM, Daniel P. Berrang=C3=A9 wrote:
>> Add a QAuthZListFile object type that implements the QAuthZ interface.=
 This
>> built-in implementation is a proxy around the QAuthZList object type,
>> initializing it from an external file, and optionally, automatically
>> reloading it whenever it changes.
>>
>> To create an instance of this object via the QMP monitor, the syntax
>> used would be:
>>
>>        {
>>          "execute": "object-add",
>>          "arguments": {
>>            "qom-type": "authz-list-file",
>>            "id": "authz0",
>>            "parameters": {
>=20
> "parameters" -> "props"
>=20
>>              "filename": "/etc/qemu/vnc.acl",
>> 	    "refresh": "yes"
>=20
> I had to use "refresh": yes (value unquoted) to avoid:

Do you mean "refresh":true?  (bare yes is not valid JSON, but bare true=20
is the correct way for a JSON bool).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
