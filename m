Received: from eggs.gnu.org ([2001:4830:134:3::10]:58109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5S6-0002wf-RK
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:18:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj5S3-0000LX-LB
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:18:50 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51156 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj5S3-0000KU-FZ
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 12:18:47 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-21-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <dbad8c4a-8793-cad1-8198-3ff94efa6426@redhat.com>
Date: Fri, 27 Jul 2018 11:18:45 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-21-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 20/23] libqtest: Enable compile-time
 format string checking
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
> qtest_qmp() & friends pass their format string and variable arguments
> to qobject_from_vjsonf_nofail().  Unlike qobject_from_jsonv(), they
> aren't decorated with GCC_FMT_ATTR().  Fix that to get compile-time
> format string checking.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>   tests/libqtest.h | 32 +++++++++++++++++++-------------
>   1 file changed, 19 insertions(+), 13 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
