Received: from eggs.gnu.org ([2001:4830:134:3::10]:47442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cNK-0003IY-SR
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:43:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1g9cNH-0007lc-K6
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:43:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1g9cNH-0007UB-9W
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:43:31 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 34F3883F40
	for <qemu-devel@nongnu.org>; Mon,  8 Oct 2018 20:43:17 +0000 (UTC)
References: <20181008173125.19678-1-armbru@redhat.com>
	<20181008173125.19678-19-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d159f50b-2ff0-e6a2-3e0e-75d27aabf20b@redhat.com>
Date: Mon, 8 Oct 2018 15:43:15 -0500
MIME-Version: 1.0
In-Reply-To: <20181008173125.19678-19-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 18/31] qom: Clean up error reporting in
 user_creatable_add_opts_foreach()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On 10/8/18 12:31 PM, Markus Armbruster wrote:
> Calling error_report() in a function that takes an Error ** argument
> is suspicious.  user_creatable_add_opts_foreach() does that, and then
> fails without setting an error.  Its caller main(), via
> qemu_opts_foreach(), is fine with it, but clean it up anyway.
>=20
> Cc: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qemu-io.c               |  8 +++-----
>   qemu-nbd.c              |  8 +++-----
>   qom/object_interfaces.c |  4 +---
>   vl.c                    | 16 ++++++----------
>   4 files changed, 13 insertions(+), 23 deletions(-)

While I could take this through my NBD tree, I think it makes more sense=20
to go through your error tree with the rest of the series.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
