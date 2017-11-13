Received: from eggs.gnu.org ([2001:4830:134:3::10]:52586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEH6r-0003et-HA
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:57:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eEH6n-0007JS-Mp
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 10:57:17 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20171113154948.GE27765@stefanha-x1.localdomain>
References: <cover.1510339534.git.berto@igalia.com>
	<071eb397118ed207c5a7f01d58766e415ee18d6a.1510339534.git.berto@igalia.com>
	<20171113154948.GE27765@stefanha-x1.localdomain>
Date: Mon, 13 Nov 2017 16:57:10 +0100
Message-ID: <w51r2t25fzd.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/3] qemu-iotests: Test I/O limits with
 removable media
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, sochin jiang <sochin.jiang@huawei.com>

On Mon 13 Nov 2017 04:49:48 PM CET, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Fri, Nov 10, 2017 at 08:54:48PM +0200, Alberto Garcia wrote:
>> +        result = self.vm.qmp("blockdev-add", driver = "null-aio",
>> +                             node_name = "cd0")
>
> PEP8 says:
>
> "Don't use spaces around the = sign when used to indicate a keyword
> argument or a default parameter value."
>
> https://www.python.org/dev/peps/pep-0008/#whitespace-in-expressions-and-statements
>
> I fixed this while merging the patch.

Ok, thanks!

Berto
