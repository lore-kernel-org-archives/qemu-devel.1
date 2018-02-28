Received: from eggs.gnu.org ([2001:4830:134:3::10]:55698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er6rS-0006ZC-9a
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:53:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1er6rP-0000VD-7V
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:53:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46336 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1er6rP-0000UW-35
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 13:53:51 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C5554026764
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 18:53:50 +0000 (UTC)
References: <20180228184947.12317-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e00d8ba0-3fbc-8c44-ca73-60114dc8e9fe@redhat.com>
Date: Wed, 28 Feb 2018 12:53:48 -0600
MIME-Version: 1.0
In-Reply-To: <20180228184947.12317-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] crypto: ensure we use a predictable TLS
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

On 02/28/2018 12:49 PM, Daniel P. Berrang=C3=A9 wrote:
> The TLS test cert generation relies on a fixed set of algorithms that a=
re
> only usable under GNUTLS' default priority setting. When building QEMU
> with a custom distro specific priority setting, this can cause the TLS
> tests to fail. By forcing the tests to always use "NORMAL" priority we
> can make them more robust.
>=20
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>=20
> Changed in v2:
>=20
>   - Fix both test cases which use TLS creds !

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
