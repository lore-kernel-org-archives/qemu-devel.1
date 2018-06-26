Received: from eggs.gnu.org ([2001:4830:134:3::10]:39030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1fXe5e-0004be-Fv
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 22:52:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wangjie88@huawei.com>) id 1fXe5d-0006nj-L4
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 22:52:22 -0400
References: <1528759585-51780-1-git-send-email-wangjie88@huawei.com>
	<20180618155045.GB9785@stefanha-x1.localdomain>
From: "WangJie (Pluto)" <wangjie88@huawei.com>
Message-ID: <631d637f-d959-54fd-8d93-808ee937e885@huawei.com>
Date: Tue, 26 Jun 2018 10:51:50 +0800
MIME-Version: 1.0
In-Reply-To: <20180618155045.GB9785@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] util/async: avoid NULL pointer
 dereference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, famz@redhat.com

Thanks Stefan, will you push it to master branch?

On 2018/6/18 23:50, Stefan Hajnoczi wrote:
> On Tue, Jun 12, 2018 at 07:26:25AM +0800, Jie Wang wrote:
>> if laio_init create linux_aio failed and return NULL, NULL pointer
>> dereference will occur when laio_attach_aio_context dereference
>> linux_aio in aio_get_linux_aio. Let's avoid it and report error.
>>
>> Signed-off-by: Jie Wang <wangjie88@huawei.com>
>> ---
>>  block/file-posix.c | 19 +++++++++++++++++--
>>  util/async.c       |  5 ++++-
>>  2 files changed, 21 insertions(+), 3 deletions(-)
> 
> If someone wants to split aio_get_linux_aio() into an initialization
> function and a "get" function which doesn't return NULL if init
> succeeded, then we can make this a bit cleaner.  But it doesn't matter
> at the moment since there are few callers and duplicating the NULL check
> isn't too bad.
> 
> Thanks, applied to my block tree:
> https://github.com/stefanha/qemu/commits/block
> 
> Stefan
> 
