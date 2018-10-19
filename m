Received: from eggs.gnu.org ([2001:4830:134:3::10]:45988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gDU7O-00045k-Bz
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:43:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gDU7K-0004ih-KY
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:43:06 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:54276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gDU7I-0004Vu-Pf
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:43:01 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181019110856.18893-5-berrange@redhat.com>
References: <20181019110856.18893-1-berrange@redhat.com>
	<20181019110856.18893-5-berrange@redhat.com>
Date: Fri, 19 Oct 2018 14:42:57 +0200
Message-ID: <w51lg6uw1im.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/8] crypto: convert xts_tweak_encdec to
 use xts_uint128 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Fri 19 Oct 2018 01:08:52 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> Using 64-bit arithmetic increases the performance for xts-aes-128
> when built with gcrypt:
>
>   Encrypt: 272 MB/s -> 355 MB/s
>   Decrypt: 275 MB/s -> 362 MB/s
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
