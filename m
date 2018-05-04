Received: from eggs.gnu.org ([2001:4830:134:3::10]:42186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEguu-0004FU-JK
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:02:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fEgur-0004q0-H0
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:02:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57836 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fEgur-0004pj-BU
	for qemu-devel@nongnu.org; Fri, 04 May 2018 16:02:53 -0400
References: <20180504160026.14017-1-berrange@redhat.com>
	<20180504160026.14017-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b7050902-496b-3196-a12c-a4069712e34f@redhat.com>
Date: Fri, 4 May 2018 15:02:41 -0500
MIME-Version: 1.0
In-Reply-To: <20180504160026.14017-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] glib: bump min required glib library
 version to 2.42
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Olaf Hering <olaf@aepfle.de>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

On 05/04/2018 11:00 AM, Daniel P. Berrang=C3=A9 wrote:
> Per supported platforms doc, the various min glib on relevant distros i=
s:
>=20
>    RHEL-7: 2.50.3
>    Debian (Stretch): 2.50.3
>    Debian (Jessie): 2.42.1
>    OpenBSD (Ports): 2.54.3
>    FreeBSD (Ports): 2.50.3
>    OpenSUSE Leap 15: 2.54.3
>    Ubuntu (Xenial): 2.48.0
>    macOS (Homebrew): 2.56.0
>=20

Worth listing mingw in this list (at least the cross-compile environment=20
that docker tests from Fedora)?

> This suggests that a minimum glib of 2.42 is a reasonable target
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

> +++ b/trace/simple.c
> @@ -36,9 +36,9 @@
>    * Trace records are written out by a dedicated thread.  The thread w=
aits for
>    * records to become available, writes them out, and then waits again=
.
>    */
> -static CompatGMutex trace_lock;
> -static CompatGCond trace_available_cond;
> -static CompatGCond trace_empty_cond;
> +static GMuttex trace_lock;

As pointed out by patchew, this is a typo.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
