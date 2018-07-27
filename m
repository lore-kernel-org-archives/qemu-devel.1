Received: from eggs.gnu.org ([2001:4830:134:3::10]:44860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4bz-0007kJ-Sf
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4bw-0001ri-OE
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:24:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34794 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj4bw-0001qu-JU
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:24:56 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce71cd21-ed5f-ee51-b6c5-65441b9a6664@redhat.com>
Date: Fri, 27 Jul 2018 10:24:55 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/23] libqtest: Clean up how we read
 device_del messages
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
> qtest_qmp_device_del() still uses the qmp("") hack to receive a
> message, even though we have qmp_receive() since commit 66e0c7b187e.
> Put it to use.
>=20
> Bonus: gets rid of empty format strings.  A step towards compile-time
> format string checking without triggering -Wformat-zero-length.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/libqtest.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
