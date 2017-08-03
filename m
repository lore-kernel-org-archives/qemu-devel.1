Received: from eggs.gnu.org ([2001:4830:134:3::10]:47026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddJhX-0001g1-42
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:14:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ddJhS-0001J3-Um
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:14:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ddJhS-0001IQ-ON
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 13:14:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A2FD181236
	for <qemu-devel@nongnu.org>; Thu,  3 Aug 2017 17:14:17 +0000 (UTC)
References: <20170728121040.631-1-otubo@redhat.com>
	<20170728121040.631-7-otubo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <6ec4e5e8-0eb2-b29e-0b4b-87029af835ab@redhat.com>
Date: Thu, 3 Aug 2017 19:14:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170728121040.631-7-otubo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/6] seccomp: adding documentation to
 new seccomp model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, pbonzini@redhat.com

On 28.07.2017 14:10, Eduardo Otubo wrote:
> Adding new documention under docs/ to describe every one and each new

s/documention/documentation/

> option added by the seccomp refactoring patchset.
>=20
> Signed-off-by: Eduardo Otubo <otubo@redhat.com>
> ---
>  docs/seccomp.txt | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 docs/seccomp.txt
>=20
> diff --git a/docs/seccomp.txt b/docs/seccomp.txt
> new file mode 100644
> index 0000000000..4b7edba312
> --- /dev/null
> +++ b/docs/seccomp.txt
> @@ -0,0 +1,31 @@
> +QEMU Seccomp system call filter
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +Starting from Qemu version 2.10, the seccomp filter does not work as a

s/Qemu/QEMU/

s/2.10/2.11/

> +whitelist but as a blacklist instead. This method allows safer deploys=
 since
> +only the strictly forbidden system calls will be black-listed and the
> +possibility of breaking any workload is close to zero.
> +
> +The default option (-sandbox on) has a slightly looser security though=
 and the
> +reason is that it shouldn't break any backwards compatibility with pre=
vious
> +deploys and command lines already running. But if the intent is to hav=
e a
> +better security from this version on, one should make use of the follo=
wing
> +additional options properly:
> +
> +* [,obsolete=3Dallow]: It allows Qemu to run safely on old system that=
 still
> +  relies on old system calls.
> +
> +* [,elevateprivileges=3Ddeny|allow|children]: It allows or denies Qemu=
 process
> +  to elevate its privileges by blacklisting all set*uid|gid system cal=
ls. The
> +  'children' option sets the PR_SET_NO_NEW_PRIVS to 1 which allows hel=
pers
> +  (forls and execs) to run unprivileged.

s/forls/forks/

> +* [,spawn=3Ddeny]: It blacklists fork and execve syste calls, avoiding=
 Qemu to
> +  spawn new threads or processes.
> +
> +* [,resourcecontrol=3Ddeny]: It blacklists all process affinity and sc=
heduler
> +  priority system calls to avoid any bigger of the process.

"to avoid any bigger" sounds strange to me. Maybe rather something like:
"to avoid that the process can increase its amount of allowed resource
consumption" or something similar?

 Thomas
