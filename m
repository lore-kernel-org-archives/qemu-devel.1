Received: from eggs.gnu.org ([2001:4830:134:3::10]:38404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYZCg-00047x-CU
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:51:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fYZCf-0002v1-Kc
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:51:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41884 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fYZCf-0002uN-EJ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:51:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DF9D2814F0A5
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 15:51:24 +0000 (UTC)
References: <20180607101019.14958-1-berrange@redhat.com>
	<20180628131722.GA13766@redhat.com>
	<8964dea3-042d-2eac-0198-d50c9c8947fc@redhat.com>
	<03c1e60e-6f5b-51cb-afe1-9f4e26a2c56b@redhat.com>
	<85bdb202-2211-8d06-105b-86efb307f961@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <df642a2c-b7af-40ef-9fdf-defd75b501f0@redhat.com>
Date: Thu, 28 Jun 2018 17:51:21 +0200
MIME-Version: 1.0
In-Reply-To: <85bdb202-2211-8d06-105b-86efb307f961@redhat.com>
Content-Type: text/plain; charset=utf-8
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
To: Eric Blake <eblake@redhat.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org

On 28/06/2018 16:46, Eric Blake wrote:
> On 06/28/2018 08:28 AM, Paolo Bonzini wrote:
>> On 28/06/2018 15:22, Eric Blake wrote:
>>>>>
>>>>> -qemu-system-i386 [...OPTIONS...] -vnc :1,tls,x509=3D/etc/pki/qemu
>>>>> -monitor stdio
>>>>> +qemu-system-i386 [...OPTIONS...] \
>>>>> +=C2=A0 -object
>>>>> tls-creds-x509,id=3Dtls0,dir=3D/etc/pki/qemu,endpoint=3Dserver,veri=
fy-peer=3Dno
>>>>>
>>>>> \
>>>
>>> I'd use --object here (especially since -object cannot be used on
>>> qemu-nbd, but --object tls-creds-x509 can).
>>
>> But that would be inconsistent with -vnc.
>>
>> I honestly don't understand the crusade against single-dashed options.
>=20
> Rather, it's a crusade FOR the use of --object, for consistency reasons=
:
>=20
> These work:
>=20
> qemu-system-i386 -object foo
> qemu-system-i386 --object foo
> qemu-nbd --object foo
>=20
> but this fails:
>=20
> qemu-nbd -object foo
>=20
> And since --object blurbs can a) be quite long, and b) be quite useful
> for pasting between apps, then it stands to reason that our
> documentation should prefer the form that is easiest to reuse everywher=
e.

It's also inconsistent with the rest of the command line, though, and it
may wrongly give the impression that single-character options can be
combined.

Paolo
