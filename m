Received: from eggs.gnu.org ([2001:4830:134:3::10]:53785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyHMJ-00072d-K8
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 10:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fyHMC-0003EF-Sg
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 10:03:39 -0400
References: <20180907121319.8607-1-marcandre.lureau@redhat.com>
	<20180907121319.8607-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0ac178fc-b237-2263-b32f-cd5bf91cea2b@redhat.com>
Date: Fri, 7 Sep 2018 09:03:04 -0500
MIME-Version: 1.0
In-Reply-To: <20180907121319.8607-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] util: add qemu_write_pidfile()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Stefan Weil <sw@weilnetz.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

On 09/07/2018 07:13 AM, Marc-Andr=C3=A9 Lureau wrote:
> There are variants of qemu_create_pidfile() in qemu-pr-helper and
> qemu-ga. Let's have a common implementation in libqemuutil.
>=20

Unrelated to this patch, but a question that this raises: should=20
'qemu-nbd' also have a mode for creating a pid file, since it has --fork=20
for daemonizing the server process?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
