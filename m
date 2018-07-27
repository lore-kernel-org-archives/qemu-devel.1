Received: from eggs.gnu.org ([2001:4830:134:3::10]:49720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4sY-0005uT-6k
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4sT-0001VP-UF
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:42:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj4sT-0001UK-PT
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:42:01 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-13-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ec42fb4-8fa3-c864-6c83-65b4a865cc44@redhat.com>
Date: Fri, 27 Jul 2018 10:42:00 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-13-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 12/23] cpu-plug-test: Don't pass
 integers as strings to device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, f4bug@amsat.org

On 07/27/2018 10:13 AM, Markus Armbruster wrote:
> test_plug_with_device_add_x86() plugs Haswell-i386-cpu and
> Haswell-x86_64-cpu with device_add.  It passes socket-id, core-id,
> thread-id as JSON strings.  The properties are actually integers.
>=20
> test_plug_with_device_add_coreid() plugs power8_v2.0-spapr-cpu-core
> and qemu-s390x-cpu with device_add.  It passes core-id as JSON string.
> The properties are actually integers.
>=20
> Passing JSON string values to integer properties works only due to
> device_add implementation accidents.  Fix the test to pass JSON
> numbers.  While there, use %u rather than %i with unsigned int.
>=20
> Cc: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/cpu-plug-test.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
