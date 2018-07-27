Received: from eggs.gnu.org ([2001:4830:134:3::10]:47090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4lF-0007mx-2j
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4lB-0002Ls-VN
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:34:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47718 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj4lB-0002LL-RH
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:34:29 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-10-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <87b5da45-269a-aa25-d880-ebbbd394b5d0@redhat.com>
Date: Fri, 27 Jul 2018 10:34:28 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-10-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 09/23] qobject: qobject_from_jsonv() is
 dangerous, hide it away
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
> qobject_from_jsonv() takes ownership of %p arguments.  On failure, we
> can't generally know whether we failed before or after %p, so
> ownership becomes indeterminate.  To avoid leaks, callers passing %p
> must terminate on error, e.g. by passing &error_abort.  Trap for the
> unwary; document and give the function internal linkage.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   include/qapi/qmp/qjson.h |  2 --
>   qobject/qjson.c          | 13 ++++++++++++-
>   2 files changed, 12 insertions(+), 3 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
