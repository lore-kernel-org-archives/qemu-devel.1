Received: from eggs.gnu.org ([2001:4830:134:3::10]:55035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <minwoo.im.dev@gmail.com>) id 1e8TEx-0003ZN-O4
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 11:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <minwoo.im.dev@gmail.com>) id 1e8TEw-0002Xe-V9
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 11:41:39 -0400
MIME-Version: 1.0
In-Reply-To: <20171023143001.GC30713@localhost.localdomain>
References: <1508568856-17545-1-git-send-email-minwoo.im.dev@gmail.com>
	<20171023143001.GC30713@localhost.localdomain>
From: Minwoo Im <minwoo.im.dev@gmail.com>
Date: Sun, 29 Oct 2017 00:41:33 +0900
Message-ID: <CAA7jztczxweuAv_t9sN5LRDQen+9N-MjovWY_EmD5u8gJ=P5WQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block][PATCH] qemu-block: add support HMB
 with feature commands.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Keith Busch <keith.busch@intel.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

I'll send a patch only when there is a clear real use case.
Thanks for your reply.

On Mon, Oct 23, 2017 at 11:30 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Sat, Oct 21, 2017 at 03:54:16PM +0900, Minwoo Im wrote:
>> Add support HMB(Host Memory Block) with feature commands(Get Feature, Set Feature).
>> nvme-4.14 tree supports HMB features.
>> This patch will make nvme controller to return 32MiB preferred size of HMB to host via identify command.
>> Set Feature, Get Feature implemented for HMB.
>>
>> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
>
> Nak; this patch doesn't have a use for host memory. It's just advertising
> the need without ever accessing it.
