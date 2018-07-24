Received: from eggs.gnu.org ([2001:4830:134:3::10]:46753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhzGR-0000Ve-HE
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fhzGN-0006WD-In
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:30:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46736 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fhzGN-0006Vl-Da
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 11:30:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 08686402243B
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 15:30:11 +0000 (UTC)
References: <20180718093815.8104-1-berrange@redhat.com>
	<20180718093815.8104-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6561fc48-7164-8243-aa42-85596091ffe4@redhat.com>
Date: Tue, 24 Jul 2018 10:30:09 -0500
MIME-Version: 1.0
In-Reply-To: <20180718093815.8104-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for 3.0 4/4] tests: fix TLS handshake
 failure with TLS 1.3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 07/18/2018 04:38 AM, Daniel P. Berrang=C3=A9 wrote:
> When gnutls negotiates TLS 1.3 instead of 1.2, the order of messages
> sent by the handshake changes. This exposed a logic bug in the test
> suite which caused us to wait for the server to see handshake
> completion, but not wait for the client to see completion. The result
> was the client didn't receive the certificate for verification and the
> test failed.
>=20
> This is exposed in Fedora 29 rawhide which has just enabled TLS 1.3 in
> its GNUTLS builds.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tests/test-crypto-tlssession.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
