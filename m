Received: from eggs.gnu.org ([2001:4830:134:3::10]:47490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4m8-0000YB-Cl
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:35:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4m5-0003PF-7l
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:35:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33788 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj4m5-0003PB-3N
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:35:25 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-11-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f08c4d4c-f3db-24ff-a2ee-9f57dd0a79ba@redhat.com>
Date: Fri, 27 Jul 2018 10:35:23 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 10/23] tests: Pass literal format
 strings directly to qmp_FOO()
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
> The qmp_FOO() take a printf-like format string.  In a few places, we
> assign a string literal to a variable and pass that instead of simply
> passing the literal.  Clean that up.
>=20
> Bonus: gets rid of non-literal format strings.  A step towards
> compile-time format string checking without triggering
> -Wformat-nonliteral.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/ahci-test.c | 4 +---
>   tests/ide-test.c  | 4 +---
>   2 files changed, 2 insertions(+), 6 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
