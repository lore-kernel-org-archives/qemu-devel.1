Received: from eggs.gnu.org ([2001:4830:134:3::10]:50899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYYDo-0005DZ-QS
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:48:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYYDk-0008DU-3Y
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:48:32 -0400
References: <20180628132211.8795-1-rjones@redhat.com>
	<20180628132211.8795-2-rjones@redhat.com>
	<cf457707-eaab-16f9-d1c9-3a3f6423958e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <feac5d6e-9f5c-ee83-1a8d-3f628d29d620@redhat.com>
Date: Thu, 28 Jun 2018 09:48:22 -0500
MIME-Version: 1.0
In-Reply-To: <cf457707-eaab-16f9-d1c9-3a3f6423958e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] crypto: Implement TLS Pre-Shared Keys
 (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org

On 06/28/2018 09:42 AM, Eric Blake wrote:
> On 06/28/2018 08:22 AM, Richard W.M. Jones wrote:
>=20
> In the subject line: most commit summaries don't have a trailing '.'.
>=20
>> Pre-Shared Keys (PSK) is a simpler mechanism for enabling TLS
>> connections than using certificates.=C2=A0 It requires only a simple s=
ecret
>> key:
>>
>> =C2=A0=C2=A0 $ mkdir -m 0700 /tmp/keys
>> =C2=A0=C2=A0 $ psktool -u rjones -p /tmp/keys/keys.psk
>> =C2=A0=C2=A0 $ cat /tmp/keys/keys.psk
>>   =20
>> rjones:d543770c15ad93d76443fb56f501a31969235f47e999720ae8d2336f6a13fcb=
c
>>
>> The key can be secretly shared between clients and servers.=C2=A0 Clie=
nts
>> must specify the directory containing the "keys.psk" file and a
>> username (defaults to "qemu").=C2=A0 Servers must specify only the
>> directory.
>>
>> Example NBD client:
>>
>> =C2=A0=C2=A0 $ qemu-img info \
>> =C2=A0=C2=A0=C2=A0=C2=A0 --object=20
>> tls-creds-psk,id=3Dtls0,dir=3D/tmp/keys,username=3Drjones,endpoint=3Dc=
lient \
>> =C2=A0=C2=A0=C2=A0=C2=A0 --image-opts \
>>     =20
>> file.driver=3Dnbd,file.host=3Dlocalhost,file.port=3D10809,file.tls-cre=
ds=3Dtls0,file.export=3D/=20


>=20
> Otherwise, I'm not spotting problems, but as it touches crypto, I'd als=
o=20
> get Dan's review.
>=20

Because of the immediate use for NBD, I'm willing to take this through=20
the NBD tree if Dan gives a review or ack.  Or, if Dan wants it through=20
the crypto tree (and my minor nits are addressed),

Acked-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
