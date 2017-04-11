Received: from eggs.gnu.org ([2001:4830:134:3::10]:52255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxtvw-0004cA-Uh
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cxtvt-0002wJ-0i
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:26:04 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:42575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1cxtvs-0002vX-Kh
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 07:26:00 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20170405151148.16363-9-stefanha@redhat.com>
References: <20170405151148.16363-1-stefanha@redhat.com>
	<20170405151148.16363-9-stefanha@redhat.com>
Date: Tue, 11 Apr 2017 13:25:56 +0200
Message-ID: <w51d1cjyym3.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 8/9] qemu-iotests: support per-format
 golden output files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Nir Soffer <nsoffer@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Maor Lipchuk <mlipchuk@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

On Wed 05 Apr 2017 05:11:47 PM CEST, Stefan Hajnoczi wrote:
> Some tests produce format-dependent output.  Either the difference is
> filtered out and ignored, or the test case is format-specific so we
> don't need to worry about per-format output differences.
>
> There is a third case: the test script is the same for all image formats
> and the format-dependent output is relevant.  An ugly workaround is to
> copy-paste the test into multiple per-format test cases.  This
> duplicates code and is not maintainable.
>
> This patch allows test cases to add per-format golden output files so a
> single test case can work correctly when format-dependent output must be
> checked:
>
>   123.out.qcow2
>   123.out.raw
>   123.out.vmdk
>   ...
>
> This naming scheme is not composable with 123.out.nocache or 123.pc.out,
> two other scenarios where output files are split.  I don't think it
> matters since few test cases need these features.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
