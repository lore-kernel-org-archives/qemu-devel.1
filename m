Received: from eggs.gnu.org ([2001:4830:134:3::10]:38291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er30M-0000BT-3e
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er30J-0001ko-2r
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:46:50 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1er30I-0001kG-Tb
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:46:46 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE31540FB647
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 14:46:42 +0000 (UTC)
References: <20180228140652.31933-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a770c9fa-3a6b-c1be-2d5a-de1cb8d70292@redhat.com>
Date: Wed, 28 Feb 2018 08:46:38 -0600
MIME-Version: 1.0
In-Reply-To: <20180228140652.31933-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] crypto: ensure we use a predictable TLS
 priority setting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org

On 02/28/2018 08:06 AM, Daniel P. Berrang=C3=A9 wrote:
> The TLS test cert generation relies on a fixed set of algorithms that a=
re
> only usable under GNUTLS' default priority setting. When building QEMU
> with a custom distro specific priority setting, this can cause the TLS
> tests to fail. By forcing the tests to always use "NORMAL" priority we
> can make them more robust.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   tests/test-crypto-tlssession.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssess=
ion.c
> index 1a4a066d76..82f21c27f2 100644
> --- a/tests/test-crypto-tlssession.c
> +++ b/tests/test-crypto-tlssession.c
> @@ -75,6 +75,7 @@ static QCryptoTLSCreds *test_tls_creds_create(QCrypto=
TLSCredsEndpoint endpoint,
>                        "server" : "client"),
>           "dir", certdir,
>           "verify-peer", "yes",
> +        "priority", "NORMAL",
>           /* We skip initial sanity checks here because we
>            * want to make sure that problems are being
>            * detected at the TLS session validation stage,
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
