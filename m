Received: from eggs.gnu.org ([209.51.188.92]:40583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1CMk-0008BN-0P
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1h1CMh-0007vs-Vm
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:52:25 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:36939)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1h1CMe-0007k9-C3
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 10:52:22 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <cover.1550842915.git.berto@igalia.com>
References: <cover.1550842915.git.berto@igalia.com>
Date: Tue, 05 Mar 2019 16:52:15 +0100
Message-ID: <w511s3lco9c.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v3 0/3] char-socket: Fix race condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Daniel_P=2E_Berrang?= =?utf-8?Q?=C3=A9?= <berrange@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

ping

On Fri 22 Feb 2019 02:46:23 PM CET, Alberto Garcia wrote:
> This fixes a race condition in which the tcp_chr_read() ioc handler
> can close a connection that is being written to from another thread.
>
> Note: vhost-user-test still fails if QTEST_VHOST_USER_FIXME is set.
>
> Berto
