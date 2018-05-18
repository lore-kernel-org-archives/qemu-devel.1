Received: from eggs.gnu.org ([2001:4830:134:3::10]:44377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJeBH-00017a-A8
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:08:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fJeBE-0000kV-JE
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:08:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38882 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fJeBE-0000jq-ES
	for qemu-devel@nongnu.org; Fri, 18 May 2018 08:08:16 -0400
References: <20180515113348.10516-1-zyimin@linux.ibm.com>
	<20180515113348.10516-2-zyimin@linux.ibm.com>
	<20180517124109.GJ17734@vader> <20180518075212.GE3416@dnr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <168a82a8-9562-55b7-0fd2-05472a33fc78@redhat.com>
Date: Fri, 18 May 2018 07:08:13 -0500
MIME-Version: 1.0
In-Reply-To: <20180518075212.GE3416@dnr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/1] sandbox: disable -sandbox if
 CONFIG_SECCOMP undefined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?J=c3=a1n_Tomko?= <jtomko@redhat.com>, Eduardo Otubo <otubo@redhat.com>
Cc: borntraeger@de.ibm.com, fiuczy@linux.ibm.com, qemu-devel@nongnu.org, jferlan@redhat.com, Yi Min Zhao <zyimin@linux.ibm.com>

On 05/18/2018 02:52 AM, J=C3=A1n Tomko wrote:

> This patch fixes the usage of QEMU new enough for seccomp blacklist
> (where libvirt enables the sandbox by default),
> but breaks the usage of QEMU with compiled out sandbox and
> setting
>  =C2=A0seccomp_sandbox =3D 0
> in libvirt's qemu.conf:
>=20
> error: internal error: process exited while connecting to monitor:
> qemu-git: -sandbox off: There is no option group 'sandbox'
>=20
>=20
> But now libvirt requires QEMU >=3D 1.5.0 which already supports
> query-command-line-options, so if you want the option gone completely
> --without-seccomp, I can add the code that probes for it and
> make seccomp_sandbox =3D 0 a no-op if it's compiled out.

And that's acceptable - we document that libvirt must be at least as new=20
as qemu.  Mixing old qemu + new libvirt should always work, but mixing=20
new qemu + old libvirt may fail, and this is one of those cases.  The=20
solution for anyone hitting the failure is to upgrade libvirt to match=20
the fact that they upgraded qemu.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
