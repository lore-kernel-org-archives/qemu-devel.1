Received: from eggs.gnu.org ([2001:4830:134:3::10]:60018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9sJ7-0003tu-EY
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1g9sIx-0003bk-0r
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:44:12 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:49809)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1g9sIk-0003B7-O3
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 09:44:05 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20181009125541.24455-3-berrange@redhat.com>
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-3-berrange@redhat.com>
Date: Tue, 09 Oct 2018 15:43:51 +0200
Message-ID: <w51va6b8cbs.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/6] crypto: remove code duplication in
 tweak encrypt/decrypt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue 09 Oct 2018 02:55:37 PM CEST, Daniel P. Berrang=C3=A9 wrote:
> The tweak encrypt/decrypt functions are identical except for the
> comments, so can be merged. Profiling data shows that the compiler is
> in fact already merging the two merges in the object files.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
