Received: from eggs.gnu.org ([2001:4830:134:3::10]:51736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejmQ8-0004Hi-T3
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:39:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ejmQ4-0003KG-VI
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:39:24 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39722 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1ejmQ4-0003Jn-Ph
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 08:39:20 -0500
References: <20180205102659.60552-1-marcel@redhat.com>
	<CAFEAcA8OO7jEeAe5UWKBqSb_+tap7OVM2YxEsqWDVZV8jN7cmA@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <51f8addc-8c6c-4532-1a59-b4c0098f6c68@redhat.com>
Date: Thu, 8 Feb 2018 15:38:59 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OO7jEeAe5UWKBqSb_+tap7OVM2YxEsqWDVZV8jN7cmA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 0/4] RDMA patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, yuval.shaia@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, dotanb@mellanox.com

Hi Peter,

On 08/02/2018 14:59, Peter Maydell wrote:
> On 5 February 2018 at 10:26, Marcel Apfelbaum <marcel@redhat.com> wrote:
>> The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57ea3d8fe:
>>
>>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180202-pull-request' into staging (2018-02-02 18:54:11 +0000)
>>
>> are available in the git repository at:
>>
>>   https://github.com/marcel-apf/qemu tags/rdma-pull-request
>>
>> for you to fetch changes up to f172ba1b02724fb66dabd69cd553cfa625b413e5:
>>
>>   MAINTAINERS: add entry for hw/rdma (2018-02-05 11:53:00 +0200)
>>
>> ----------------------------------------------------------------
>> PVRDMA implementation
>>
>> ----------------------------------------------------------------
>> Marcel Apfelbaum (3):
>>       mem: add share parameter to memory-backend-ram
>>       docs: add pvrdma device documentation.
>>       MAINTAINERS: add entry for hw/rdma
>>
>> Yuval Shaia (1):
>>       pvrdma: initial implementation
> 
> Hi. The technical details of this pullreq are all fine (pgp
> key, format, etc), and it passes my build tests. But I gave
> this pullreq a bit of a closer inspection than I normally
> would, since it's your first, and there are a few things I
> thought worth bringing up:

Thanks for doing it!

> 
> (1) I notice that some of the new files in this pullreq are licensed
> as "GPL, version 2", rather than "version 2 or any later version".
> Did you really mean that? Per 'LICENSE', we have a strong preference
> for 2-or-later for new code.
> 

No real preference, I will modify the license.

> (2) Some new files have no copyright or license comment at the
> top of them. Can you fix that, please?
> 

Sure.

> (3) Some of the new headers use kernel-internals __u32 etc types.
> This isn't portable. ('HACKING' has some suggestions for types you
> might want instead.)
> 

We do not "use" the __u32 types, we just copied a kernel file
for structures used for communication between the guest driver
and the QEMU code. We had a look on how it is done and
we use the model that adds macros __u32 -> uint32_t,
so the "__types" do not really create such problems.

> (4) One of your patches doesn't have any reviewed-by tags.
> We don't always manage to review everything, but it is
> nicer if we can get review, especially for patches from
> new submaintainers.
> 

The patch did receive several questions/comments and all
of them were addressed, but indeed no RB tag was given.
Since the patch was in the mailing list for over a month
and *was* reviewed, I thought is enough.
I will ping Eduardo, he had the latest comments for it.


> (5) This is an absolutely enormous diffstat for a single commit:
>  26 files changed, 5149 insertions(+), 4 deletions(-)
> 

On the github where the project was developed we have thousands of commits,
so it can't be used.
It was reviewed closely by one reviewer and got a lot
of comments from others.
That being said, we will try to split it in a few patches
and send a new version.

Thanks for the comments,
Marcel

> thanks
> -- PMM
> 
