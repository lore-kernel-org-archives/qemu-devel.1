Received: from eggs.gnu.org ([2001:4830:134:3::10]:47673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9tBf-0005l8-H8
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:40:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9tBc-0003Yz-Av
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:40:39 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:58032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1g9tBb-0003RH-UA
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:40:36 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181009125541.24455-4-berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-4-berrange@redhat.com>
Date: Tue, 09 Oct 2018 16:40:33 +0200
Message-ID: <w51murn89pa.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/6] crypto: introduce a xts_uint128 data
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue 09 Oct 2018 02:55:38 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> The new type is designed to allow use of 64-bit arithmetic instead
> of operating 1-byte at a time. The following patches will use this to
> improve performance.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

I suppose that the fixes for the endianness problem may end up requiring
you to change this, but the patch itself is fine as it is now.

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
