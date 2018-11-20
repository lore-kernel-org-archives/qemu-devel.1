Received: from eggs.gnu.org ([2001:4830:134:3::10]:50972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPFMK-0003f7-7f
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 18:23:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gPFMJ-0000uU-8k
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 18:23:08 -0500
References: <20181120225241.2371769-1-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <5ce9a65a-4d82-c001-2fff-b6158e159d2f@redhat.com>
Date: Tue, 20 Nov 2018 18:22:56 -0500
MIME-Version: 1.0
In-Reply-To: <20181120225241.2371769-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] iotests: Skip 233 if certtool
 not installed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, berrange@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>



On 11/20/18 5:52 PM, Eric Blake wrote:
> The use of TLS while building qemu is optional. While the
> 'certtool' binary should be available on every platform that
> supports building against TLS, that does not imply that the
> developer has installed it.  Make the test gracefully skip
> in that case.
> 
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
> 
> On Fedora, libvirt requires libtls-utils to be present, but not qemu.
> 
> I'm fine if Kevin wants to pick this up in a pull request related
> to iotests in general; if not, I'll do a pull request through my
> NBD tree in time for -rc3.
> 
>  tests/qemu-iotests/common.tls | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/qemu-iotests/common.tls b/tests/qemu-iotests/common.tls
> index 39f17c1b999..eae81789bbc 100644
> --- a/tests/qemu-iotests/common.tls
> +++ b/tests/qemu-iotests/common.tls
> @@ -31,6 +31,9 @@ tls_x509_cleanup()
> 
>  tls_x509_init()
>  {
> +    (certtool --help) >/dev/null 2>&1 || \
> +	_notrun "certtool utility not found, skipping test"
> +

Or something wickedly foul has happened :)

>      mkdir -p "${tls_dir}"
> 
>      # use a fixed key so we don't waste system entropy on
> 
