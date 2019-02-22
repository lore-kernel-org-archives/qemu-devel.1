Received: from eggs.gnu.org ([209.51.188.92]:43863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gxA4j-0000Pf-9V
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:37:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gxA4i-0003re-Da
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:37:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gxA4g-0003kr-I9
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:37:08 -0500
References: <cover.1550836631.git.berto@igalia.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ae1b28d7-4a3e-27e3-457b-b0cdd7b7a00f@redhat.com>
Date: Fri, 22 Feb 2019 13:36:57 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1550836631.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/3] char-socket: Fix race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 22/02/19 12:59, Alberto Garcia wrote:
> This fixes a race condition in which the tcp_chr_read() ioc handler
> can close a connection that is being written to from another thread.
>=20
> This is essentially v1 rebased on top of the current master, after
> Daniel and Marc-Andr=C3=A9's chardev series have been merged.
>=20
> Note: vhost-user-test still fails if QTEST_VHOST_USER_FIXME is set.

Thanks.  I'll look into it next (this week most of the time I had set
aside was eaten debugging other chardev issues... it's a rathole :)).

Paolo
