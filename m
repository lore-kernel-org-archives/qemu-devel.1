Received: from eggs.gnu.org ([209.51.188.92]:34434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gvnIs-0004no-C3
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:06:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <crosa@redhat.com>) id 1gvnIr-0005f9-7w
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:06:06 -0500
References: <20190209040132.25573-1-crosa@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Message-ID: <35c3b6d2-01fb-dd01-0c10-7de15e774499@redhat.com>
Date: Mon, 18 Feb 2019 13:05:41 -0500
MIME-Version: 1.0
In-Reply-To: <20190209040132.25573-1-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-iotests: add a Travis job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>



On 2/8/19 11:01 PM, Cleber Rosa wrote:
> Besides the obvious reasons of testing more, and somewhat for free,
> running the qemu-iotests along the other tests on Travis also makes
> sure that changes to shared code such as "scripts/qemu.py" and the
> like won't break other users of the same code.
> 
> Cleber Rosa (2):
>   qemu-iotests: only enable kvm if the host seems to support it
>   qemu-iotests: add "make check-block" job to Travis
> 
>  .travis.yml            | 8 ++++++++
>  tests/qemu-iotests/235 | 5 +++--
>  tests/qemu-iotests/238 | 5 +++--
>  3 files changed, 14 insertions(+), 4 deletions(-)
> 

Just a follow up showing the results for the added Travis job:

https://travis-ci.org/clebergnu/qemu/jobs/490806941#L2321

Cheers,
- Cleber.
