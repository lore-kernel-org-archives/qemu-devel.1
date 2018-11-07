Received: from eggs.gnu.org ([2001:4830:134:3::10]:47717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gKWTF-0000b2-KF
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 17:38:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gKWTA-0002eD-F3
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 17:38:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40230)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gKWT5-0002Ce-Qo
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 17:38:38 -0500
References: <20181019133835.16494-1-berrange@redhat.com>
	<20181019133835.16494-9-berrange@redhat.com>
	<CAJ+F1C+Wcp5jueeP-smg88sbc5KssULKKG7gF6kEXYGtqdANKw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a23f41f3-096f-c8e4-0d29-f14217316c4e@redhat.com>
Date: Wed, 7 Nov 2018 16:38:18 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+Wcp5jueeP-smg88sbc5KssULKKG7gF6kEXYGtqdANKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 08/11] authz: add QAuthZList object type
 for an access control list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>
Cc: philmd@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 11/7/18 4:23 PM, Marc-Andr=C3=A9 Lureau wrote:

>> +##
>> +# @QAuthZListRuleListHack:
>> +#
>> +# Not exposed via QMP; hack to generate QAuthZListRuleList
>> +# for use internally by the code.
>=20
> Well, this will probably end in the documentation (it's already in the
> .json, which is one source of documentation ;).
>=20
> What about adding a 'gen-list' field, or a 'pragma' listing the
> structs that should have list code generated?

We've used this hack several times in the past, but indeed there might=20
be nicer design approaches to consider now that we have pragma listings.=20
  But I don't see that as holding up this series.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
