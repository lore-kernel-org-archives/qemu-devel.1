Received: from eggs.gnu.org ([2001:4830:134:3::10]:50512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYYBT-0004MA-Cd
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:46:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fYYBQ-0003lj-9f
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:46:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42300 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fYYBQ-0003ky-50
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:46:04 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AB274401CE88
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 14:46:03 +0000 (UTC)
References: <20180607101019.14958-1-berrange@redhat.com>
	<20180628131722.GA13766@redhat.com>
	<8964dea3-042d-2eac-0198-d50c9c8947fc@redhat.com>
	<03c1e60e-6f5b-51cb-afe1-9f4e26a2c56b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <85bdb202-2211-8d06-105b-86efb307f961@redhat.com>
Date: Thu, 28 Jun 2018 09:46:02 -0500
MIME-Version: 1.0
In-Reply-To: <03c1e60e-6f5b-51cb-afe1-9f4e26a2c56b@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] doc: switch to modern syntx for VNC TLS
 setup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org

On 06/28/2018 08:28 AM, Paolo Bonzini wrote:
> On 28/06/2018 15:22, Eric Blake wrote:
>>>>
>>>> -qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509=3D/etc/pki/qemu
>>>> -monitor stdio
>>>> +qemu-system-i386 [...OPTIONS...] \
>>>> +=C2=A0 -object
>>>> tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver,verif=
y-peer=3Dno
>>>> \
>>
>> I'd use --object here (especially since -object cannot be used on
>> qemu-nbd, but --object tls-creds-x509 can).
>=20
> But that would be inconsistent with -vnc.
>=20
> I honestly don't understand the crusade against single-dashed options.

Rather, it's a crusade FOR the use of --object, for consistency reasons:

These work:

qemu-system-i386 -object foo
qemu-system-i386 --object foo
qemu-nbd --object foo

but this fails:

qemu-nbd -object foo

And since --object blurbs can a) be quite long, and b) be quite useful=20
for pasting between apps, then it stands to reason that our=20
documentation should prefer the form that is easiest to reuse everywhere.

Meanwhile, these both work:
qemu-system-i386 -vnc
qemu-system-i386 --vnc

but as no other qemu-* binaries (currently) take a --vnc argument, it's=20
a moot point as to which form the documentation should prefer for the=20
purpose of pasting into other binaries.  But at the same time,=20
consistency argues that if we're going to spell --object everywhere,=20
then we might as well spell --vnc everywhere too.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
