Received: from eggs.gnu.org ([2001:4830:134:3::10]:43261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPA6H-0001BT-31
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gPA6F-00045q-M9
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 12:46:12 -0500
References: <20181116155325.22428-1-berrange@redhat.com>
	<20181116155325.22428-7-berrange@redhat.com>
	<20181120172701.GC7513@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <60be62b6-86aa-f6fa-3b5f-c37f9d051d8c@redhat.com>
Date: Tue, 20 Nov 2018 11:45:54 -0600
MIME-Version: 1.0
In-Reply-To: <20181120172701.GC7513@localhost.localdomain>
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
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 11/20/18 11:27 AM, Kevin Wolf wrote:
> Am 16.11.2018 um 16:53 hat Daniel P. Berrang=C3=A9 geschrieben:
>> Add tests that validate it is possible to connect to an NBD server
>> running TLS mode. Also test mis-matched TLS vs non-TLS connections
>> correctly fail.
>=20
>> +echo
>> +echo "=3D=3D preparing TLS creds =3D=3D"
>> +
>> +tls_x509_create_root_ca "ca1"
>> +tls_x509_create_root_ca "ca2"
>> +tls_x509_create_server "ca1" "server1"
>> +tls_x509_create_client "ca1" "client1"
>> +tls_x509_create_client "ca2" "client2"
>=20
> Looks like we can't blindly assume that certtool exists. This test case
> fails for me, starting with the following diff:

Looks like we'll need a followup patch to skip the test if certtool is=20
not found. (I already did the same in common.nbd if 'ss' was not found;=20
so it should be easy to copy...)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
