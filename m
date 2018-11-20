Received: from eggs.gnu.org ([2001:4830:134:3::10]:45773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPAkV-000852-Uj
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPAkQ-0001kw-NG
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 13:27:45 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
	<20181120172701.GC7513@localhost.localdomain>
	<60be62b6-86aa-f6fa-3b5f-c37f9d051d8c@redhat.com>
	<20181120175333.GB25047@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a56dbf66-14f1-5a57-0f0f-28877072d176@redhat.com>
Date: Tue, 20 Nov 2018 12:22:39 -0600
MIME-Version: 1.0
In-Reply-To: <20181120175333.GB25047@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] tests: exercise NBD server in TLS mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 11/20/18 11:53 AM, Daniel P. Berrang=C3=A9 wrote:

>>>> +echo
>>>> +echo "=3D=3D preparing TLS creds =3D=3D"
>>>> +
>>>> +tls_x509_create_root_ca "ca1"
>>>> +tls_x509_create_root_ca "ca2"
>>>> +tls_x509_create_server "ca1" "server1"
>>>> +tls_x509_create_client "ca1" "client1"
>>>> +tls_x509_create_client "ca2" "client2"
>>>
>>> Looks like we can't blindly assume that certtool exists. This test ca=
se
>>> fails for me, starting with the following diff:
>>
>> Looks like we'll need a followup patch to skip the test if certtool is=
 not
>> found. (I already did the same in common.nbd if 'ss' was not found; so=
 it
>> should be easy to copy...)
>=20
> FWIW certtool is part of gnutls-utils and is available on every platfor=
m
> that QEMU officially supports as a build target.

Ported to the build target !=3D installed on the build machine. The=20
failure is happening on machines that do not have all the build=20
prerequisites (since it should still be possible to configure qemu to=20
build without TLS, right?)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
