Received: from eggs.gnu.org ([2001:4830:134:3::10]:57740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejmlh-0002NY-2F
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejmle-0002fq-0j
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:01:41 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ejmld-0002fc-S2
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 09:01:37 -0500
Received: by mail-qt0-x242.google.com with SMTP id m11so6237923qtn.10
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 06:01:37 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180205102659.60552-1-marcel@redhat.com>
	<CAFEAcA8OO7jEeAe5UWKBqSb_+tap7OVM2YxEsqWDVZV8jN7cmA@mail.gmail.com>
	<51f8addc-8c6c-4532-1a59-b4c0098f6c68@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f7b61733-f25a-31b5-7b55-d9a41b6d3f10@amsat.org>
Date: Thu, 8 Feb 2018 11:01:31 -0300
MIME-Version: 1.0
In-Reply-To: <51f8addc-8c6c-4532-1a59-b4c0098f6c68@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/4] RDMA patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: dotanb@mellanox.com, QEMU Developers <qemu-devel@nongnu.org>, yuval.shaia@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>

Hi Marcel,

On 02/08/2018 10:38 AM, Marcel Apfelbaum wrote:
> On 08/02/2018 14:59, Peter Maydell wrote:
>> On 5 February 2018 at 10:26, Marcel Apfelbaum <marcel@redhat.com> wrote:
>>> The following changes since commit f24ee107a07f093bd7ed475dd48d7ba57ea3d8fe:
>>
>> Hi. The technical details of this pullreq are all fine (pgp
>> key, format, etc), and it passes my build tests. But I gave
>> this pullreq a bit of a closer inspection than I normally
>> would, since it's your first, and there are a few things I
>> thought worth bringing up:
> 
> Thanks for doing it!
> 
>>
>> (1) I notice that some of the new files in this pullreq are licensed
>> as "GPL, version 2", rather than "version 2 or any later version".
>> Did you really mean that? Per 'LICENSE', we have a strong preference
>> for 2-or-later for new code.
>>
> 
> No real preference, I will modify the license.
> 
>> (2) Some new files have no copyright or license comment at the
>> top of them. Can you fix that, please?
>>
> 
> Sure.
> 
>> (3) Some of the new headers use kernel-internals __u32 etc types.
>> This isn't portable. ('HACKING' has some suggestions for types you
>> might want instead.)
>>
> 
> We do not "use" the __u32 types, we just copied a kernel file
> for structures used for communication between the guest driver
> and the QEMU code. We had a look on how it is done and
> we use the model that adds macros __u32 -> uint32_t,
> so the "__types" do not really create such problems.
> 
>> (4) One of your patches doesn't have any reviewed-by tags.
>> We don't always manage to review everything, but it is
>> nicer if we can get review, especially for patches from
>> new submaintainers.
>>
> 
> The patch did receive several questions/comments and all
> of them were addressed, but indeed no RB tag was given.
> Since the patch was in the mailing list for over a month
> and *was* reviewed, I thought is enough.
> I will ping Eduardo, he had the latest comments for it.
> 
> 
>> (5) This is an absolutely enormous diffstat for a single commit:
>>  26 files changed, 5149 insertions(+), 4 deletions(-)
>>
> 
> On the github where the project was developed we have thousands of commits,
> so it can't be used.
> It was reviewed closely by one reviewer and got a lot
> of comments from others.
> That being said, we will try to split it in a few patches
> and send a new version.

I spent some time to review this but got lost when it became too
specific (this is not really my area).
I was hoping some of the VMware folks could review this.

KVM related stuffs are hard to test, but we have some qtests (migration
mostly). Adding some tests for this huge code addition would be really
great.

Regards,

Phil.
