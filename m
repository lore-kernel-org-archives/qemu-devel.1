Received: from eggs.gnu.org ([208.118.235.92]:60008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuFxv-0001Ka-II
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fuFxr-0003cy-6j
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:45:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33410 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fuFxq-0003bf-Od
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:45:47 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180827111533.100ee062.cohuck@redhat.com> (Cornelia Huck's
	message of "Mon, 27 Aug 2018 11:15:33 +0200")
References: <20180822120050.12694-1-quintela@redhat.com>
	<CAFEAcA9xowHzaeN=N-EsUdP8rqMtGsJR2dNerQ_59Q+32ySWsw@mail.gmail.com>
	<20180827111533.100ee062.cohuck@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 27 Aug 2018 13:45:37 +0200
Message-ID: <87zhx8xcbi.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 00/20] Migration pull requset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Cornelia Huck <cohuck@redhat.com> wrote:
> On Fri, 24 Aug 2018 18:05:03 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
>> On 22 August 2018 at 13:00, Juan Quintela <quintela@redhat.com> wrote:
>> > The following changes since commit 13b7b188501d419a7d63c016e00065bcc693b7d4:
>> >
>> >   Merge remote-tracking branch
>> > 'remotes/kraxel/tags/vga-20180821-pull-request' into staging
>> > (2018-08-21 15:57:56 +0100)
>> >
>> > are available in the Git repository at:
>> >
>> >   git://github.com/juanquintela/qemu.git tags/migration/20180822-1
>> >
>> > for you to fetch changes up to ae526e32bd36cfb84045c8d2fd34e0b9e39a52f8:
>> >
>> >   migration: hold the lock only if it is really needed (2018-08-22
>> > 12:36:18 +0200)
>> >
>> > ----------------------------------------------------------------
>> > migration/next for 20180822
>> >
>> > All pending patches that are reviewed:
>> > - doc for pr_load (dave)
>> > - postcopy + rdma is nearer (lidong chen)
>> > - compression fixes (xiao)
>> > - silent warning for pcc tests (Thomas)
>> > - fix subsection without .needed function (pmaydell)
>> >
>> > Please apply, Juan.
>> >
>> > ----------------------------------------------------------------  
>> 
>> Applied, thanks.
>> 
>> -- PMM
>> 
>
> The rdma migration code in there seems to upset my clang (5.0.2, Fedora
> 27); gcc (7.3.1) does not complain.
>
> /home/cohuck/git/qemu/migration/rdma.c:4035:9: error: variable
>       'rdma_return_path' is used uninitialized whenever 'if' condition is true
>       [-Werror,-Wsometimes-uninitialized]
>     if (ret) {
>         ^~~
> /home/cohuck/git/qemu/migration/rdma.c:4059:12: note: uninitialized use occurs
>       here
>     g_free(rdma_return_path);
>            ^~~~~~~~~~~~~~~~
> /home/cohuck/git/qemu/migration/rdma.c:4035:5: note: remove the 'if' if its
>       condition is always false
>     if (ret) {
>     ^~~~~~~~~~
> /home/cohuck/git/qemu/migration/rdma.c:4027:9: error: variable
>       'rdma_return_path' is used uninitialized whenever 'if' condition is true
>       [-Werror,-Wsometimes-uninitialized]
>     if (ret) {
>         ^~~
> /home/cohuck/git/qemu/migration/rdma.c:4059:12: note: uninitialized use occurs
>       here
>     g_free(rdma_return_path);
>            ^~~~~~~~~~~~~~~~
> /home/cohuck/git/qemu/migration/rdma.c:4027:5: note: remove the 'if' if its
>       condition is always false
>     if (ret) {
>     ^~~~~~~~~~
> /home/cohuck/git/qemu/migration/rdma.c:4021:9: error: variable
>       'rdma_return_path' is used uninitialized whenever 'if' condition is true
>       [-Werror,-Wsometimes-uninitialized]
>     if (rdma == NULL) {
>         ^~~~~~~~~~~~
> /home/cohuck/git/qemu/migration/rdma.c:4059:12: note: uninitialized use occurs
>       here
>     g_free(rdma_return_path);
>            ^~~~~~~~~~~~~~~~
> /home/cohuck/git/qemu/migration/rdma.c:4021:5: note: remove the 'if' if its
>       condition is always false
>     if (rdma == NULL) {
>     ^~~~~~~~~~~~~~~~~~~
> /home/cohuck/git/qemu/migration/rdma.c:4015:41: note: initialize the variable
>       'rdma_return_path' to silence this warning
>     RDMAContext *rdma, *rdma_return_path;
>                                         ^
>                                          = NULL

Thanks, instaling clang and seing what is going on here.

Later, Juan.
