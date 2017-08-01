Received: from eggs.gnu.org ([2001:4830:134:3::10]:46467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dcfSg-000155-1J
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 18:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dcfSf-0006f7-9E
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 18:16:22 -0400
References: <20170801213127.15036-1-crosa@redhat.com>
	<20170801213127.15036-2-crosa@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <7b193a9e-112b-f7a3-f472-09e72ce53d49@redhat.com>
Date: Tue, 1 Aug 2017 18:16:02 -0400
MIME-Version: 1.0
In-Reply-To: <20170801213127.15036-2-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] qemu-iotests/109: Fix lock race
 condition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org



On 08/01/2017 05:31 PM, Cleber Rosa wrote:
> A race condition is currently present between the clean up attempt of
> the QEMU process and the execution of qemu-img.  The actual (bad)
> output is:
> 
>  -Warning: Image size mismatch!
>  -Images are identical.
>  +qemu-img: Could not open '<build_dir>/tests/qemu-iotests/scratch/t.raw': Failed to get "consistent read" lock
>  +Is another process using the image?
> 
> A KILL signal is sent to the QEMU process, but qemu-img may begin to
> run before the QEMU process is really gone.  qemu-img will then
> attempt to open the TEST_IMG file before it can secure a lock on it.
> 
> This attempts a more graceful shutdown, and waits for the QEMU process
> to exit.
> 
> Signed-off-by: Cleber Rosa <crosa@redhat.com>

Reviewed-by: John Snow <jsnow@redhat.com>

Thanks for this, it was driving me batty.
