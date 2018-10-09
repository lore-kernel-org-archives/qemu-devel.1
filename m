Received: from eggs.gnu.org ([2001:4830:134:3::10]:46737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9u4t-0004bV-Ie
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:37:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9u4k-0003aF-Ta
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:37:40 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:39347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1g9u4k-0003XJ-Gm
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:37:34 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181009125541.24455-7-berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-7-berrange@redhat.com>
Date: Tue, 09 Oct 2018 17:37:31 +0200
Message-ID: <w517eir872c.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 6/6] crypto: annotate xts_tweak_encdec as
 inlineable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue 09 Oct 2018 02:55:41 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> Encouraging the compiler to inline xts_tweak_encdec increases the
> performance for xts-aes-128 when built with gcrypt:
>
>   Encrypt: 460 MB/s -> 485 MB/s
>   Decrypt: 485 MB/s -> 505 MB/s

:-)

> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
