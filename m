Received: from eggs.gnu.org ([209.51.188.92]:52683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goap3-0006cI-BG
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:21:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1goaor-0005Af-EF
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 16:21:25 -0500
References: <20190123144610.8842-1-mreitz@redhat.com>
	<20190123144610.8842-6-mreitz@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <4c417f84-3c3e-1fa4-7d69-987e5f6a17fe@redhat.com>
Date: Tue, 29 Jan 2019 16:21:14 -0500
MIME-Version: 1.0
In-Reply-To: <20190123144610.8842-6-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/9] iotests: Fix 237 for Python 2.x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


On 1/23/19 9:46 AM, Max Reitz wrote:
> It is not quite clear whether we want to support Python 2.x for any
> prolonged time, but this may as well be fixed along with the other
> issues some iotests have right now.
> 

I'd have shuffled this above patch 01 (or immediately below) with a note
in either commit saying that the test is still broken without both patches.

I'd also say what you're actually fixing in the commit
(range wants ints, not floats.)

> Signed-off-by: Max Reitz <mreitz@redhat.com>

But, like, that's just my opinion, man,,

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  tests/qemu-iotests/237 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qemu-iotests/237 b/tests/qemu-iotests/237
> index fe0dd0f461..06897f8c87 100755
> --- a/tests/qemu-iotests/237
> +++ b/tests/qemu-iotests/237
> @@ -224,7 +224,7 @@ with iotests.FilePath('t.vmdk') as disk_path, \
>              iotests.log("= %s %d =" % (subfmt, size))
>              iotests.log("")
>  
> -            num_extents = math.ceil(size / 2.0**31)
> +            num_extents = int(math.ceil(size / 2.0**31))
>              extents = [ "ext%d" % (i) for i in range(1, num_extents + 1) ]
>  
>              vm.launch()
> 
