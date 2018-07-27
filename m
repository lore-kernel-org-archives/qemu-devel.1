Received: from eggs.gnu.org ([2001:4830:134:3::10]:44699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4bU-0006sY-Fj
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fj4bT-0001ce-Kb
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:24:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59178 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fj4bT-0001ba-EH
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:24:27 -0400
References: <20180727151359.29061-1-armbru@redhat.com>
	<20180727151359.29061-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3b9339b3-9a22-e6df-7a93-4e0f870d342f@redhat.com>
Date: Fri, 27 Jul 2018 10:24:25 -0500
MIME-Version: 1.0
In-Reply-To: <20180727151359.29061-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/23] libqtest: Rename functions to
 send QMP messages
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
> The functions to receive messages are called qtest_qmp_receive() and
> qmp_receive(), qmp_fd_receive().  The ones to send messages are called
> qtest_async_qmp(), qtest_async_qmpv(), qmp_async(), qmp_fd_send(),
> qmp_fd_sendv().  Inconsistent.  Rename the *_async* ones to
> qmp_send(), qtest_qmp_send(), qtest_qmp_vsend().  Rename
> qmp_fd_sendv() to qmp_fd_vsend().
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

> @@ -1592,8 +1592,8 @@ static void test_atapi_tray(void)
>       atapi_wait_tray(false);
>  =20
>       /* Remove media */
> -    qmp_async("{'execute': 'blockdev-open-tray', "
> -               "'arguments': {'id': 'cd0'}}");
> +    qmp_send("{'execute': 'blockdev-open-tray',"
> +             " 'arguments': {'id': 'cd0'}}");

Could perhaps fit in one line now, but I won't insist.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
