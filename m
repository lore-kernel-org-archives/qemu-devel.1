Received: from eggs.gnu.org ([2001:4830:134:3::10]:56276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsqGq-0002LB-2N
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fsqGn-0006ek-3c
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:07:31 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51002 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fsqGm-0006dj-QH
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:07:28 -0400
References: <20180823102502.28122-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <684bc04e-0e25-cd9b-b773-1b5b140586d3@redhat.com>
Date: Thu, 23 Aug 2018 09:07:27 -0500
MIME-Version: 1.0
In-Reply-To: <20180823102502.28122-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: report on author emails that are
 mangled by the mailing list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 08/23/2018 05:25 AM, Daniel P. Berrang=C3=A9 wrote:
> In some cases the Author: email address in patches submitted to the
> list gets mangled such that it says
>=20
>      John Doe via Qemu-devel <qemu-devel@nongnu.org>
>=20
> This change is a result of workarounds for DMARC policies.
>=20
> Subsystem maintainers accepting patches need to catch these and fix
> them before sending pull requests, so a checkpatch.pl test is highly
> desirable.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   scripts/checkpatch.pl | 4 ++++
>   1 file changed, 4 insertions(+)
>=20

Adding it here will let patchew flag such message; the workaround is for=20
the submitter to resubmit with an explicit 'From: User Name=20
<address@example.com>' line in the body of the email.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
