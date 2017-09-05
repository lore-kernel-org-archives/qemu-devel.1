Received: from eggs.gnu.org ([2001:4830:134:3::10]:39080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpAiN-0001Ev-MT
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpAiG-00028b-4A
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 06:04:15 -0400
Date: Tue, 5 Sep 2017 11:04:04 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170905100404.GH17449@stefanha-x1.localdomain>
References: <20170901105434.3288-1-berrange@redhat.com>
	<20170901105434.3288-3-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901105434.3288-3-berrange@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] iotests: blacklist 194
 with the luks driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

On Fri, Sep 01, 2017 at 11:54:34AM +0100, Daniel P. Berrange wrote:
> The 194 test has alot of code that assumes a simple image file. Rewriting
> this to work with luks is possible, but non-trivial, so blacklist the
> luks format for now.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/194        | 1 +
>  tests/qemu-iotests/iotests.py | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
