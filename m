Received: from eggs.gnu.org ([209.51.188.92]:60237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gl6RH-0004kG-BQ
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 01:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gl6RE-0002En-KZ
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 01:18:34 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33462)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gl6RC-0002Ce-Iv
	for qemu-devel@nongnu.org; Sun, 20 Jan 2019 01:18:32 -0500
Received: by mail-wr1-x443.google.com with SMTP id c14so19721507wrr.0
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 22:18:28 -0800 (PST)
References: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
	<4627c86e.406c.16869dbf8f9.Coremail.liq3ea@163.com>
	<f4d555ee-d524-a7ed-ae53-77377d147e2f@gmail.com>
	<7c5fdf65.41c2.16869e6f924.Coremail.liq3ea@163.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <0d91276f-e9d4-4ac1-43ba-210c6e154fb1@gmail.com>
Date: Sun, 20 Jan 2019 08:18:42 +0200
MIME-Version: 1.0
In-Reply-To: <7c5fdf65.41c2.16869e6f924.Coremail.liq3ea@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH PULL 00/10] RDMA queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?5p2O5by6?= <liq3ea@163.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, yuval.shaia@oracle.com, kamalheib1@gmail.com, cohuck@redhat.com, philmd@redhat.com



On 1/20/19 8:16 AM, 李强 wrote:
> At 2019-01-20 14:08:57, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com> wrote:
> >Hi,
> >
> >On 1/20/19 8:04 AM, 李强 wrote:
> >>
> >> Hi Marcel,
> >> Seems you lost another:
> >>
> >
> >No,  I did not, please see below.
> Yes, I just read the patch.
> >> hw: pvrdma: fix memory leak in error path
> >> -->http://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01217.html
> >>
> >
> >Please see this mail thread, you were cc--ed:
> >https://www.mail-archive.com/qemu-devel@nongnu.org/msg588766.html   <https://www.mail-archive.com/qemu-devel@nongnu.org/msg588766.html
> >>
> > <https://www.mail-archive.com/qemu-devel@nongnu.org/msg588766.html >>
> I think you're right my patch "hw: pvrdma: fix memory leak in error path"
> is redundant.
> Sorry for the late reply.

No problem, thanks for the contribution!
Marcel

> Thanks,
> Li Qiang
> >Basically the following patch makes the the mentioned one obsolete.
> >https://patchew.org/QEMU/20190109201559.3906-1-yuval.shaia@oracle.com/
> >
> >Thanks,
> >Marcel
> >
> >> At 2019-01-19 18:03:05, "Marcel Apfelbaum" <marcel.apfelbaum@gmail.com> wrote:
> >> >The following changes since commit a8d2b0685681e2f291faaa501efbbd76875f8ec8:
> >> >
> >> >  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190118' into staging (2019-01-18 16:56:15 +0000)
> >> >
> >> >are available in the Git repository at:
> >> >
> >> >  https://github.com/marcel-apf/qemu tags/rdma-pull-request
> >> >
> >> >for you to fetch changes up to 0f645ba16c6b76ccf2076d38460aa998198893bc:
> >> >
> >> >  contrib/rdmacm-mux: fix clang compilation (2019-01-19 11:01:57 +0200)
> >> >
> >> >----------------------------------------------------------------
> >> >RDMA queue
> >> > * Clang compilation fix
> >> > * Coverity fix
> >> > * Various fixes for the pvrdma device
> >> >
> >> >----------------------------------------------------------------
> >> >Kamal Heib (1):
> >> >      docs/pvrdma: Update rdmacm-mux documentation
> >> >
> >> >Li Qiang (1):
> >> >      hw: rdma: fix an off-by-one issue
> >> >
> >> >Marcel Apfelbaum (3):
> >> >      contrib/rdmacm-mux: remove Wno-format-truncation flag
> >> >      hw/rdma: modify struct initialization
> >> >      contrib/rdmacm-mux: fix clang compilation
> >> >
> >> >Yuval Shaia (5):
> >> >      hw/pvrdma: Remove max-sge command-line param
> >> >      hw/rdma: Delete unused struct member
> >> >      hw/pvrdma: Post CQE when receive invalid gid index
> >> >      hw/pvrdma: Make function pvrdma_qp_send/recv return void.
> >> >      hw/rdma: Verify that ptr is not NULL before freeing
> >> >
> >> > Makefile                         |  2 ++
> >> > contrib/rdmacm-mux/Makefile.objs |  1 -
> >> > contrib/rdmacm-mux/main.c        | 12 ++++----
> >> > docs/pvrdma.txt                  |  4 ++-
> >> > hw/rdma/rdma_backend.c           | 63 +++++++++++++++-------------------------
> >> > hw/rdma/rdma_backend.h           | 12 ++++++++
> >> > hw/rdma/rdma_backend_defs.h      |  1 -
> >> > hw/rdma/rdma_rm.c                |  9 ++++--
> >> > hw/rdma/vmw/pvrdma_main.c        | 10 +++----
> >> > hw/rdma/vmw/pvrdma_qp_ops.c      | 44 +++++++++++++++++++++-------
> >> > hw/rdma/vmw/pvrdma_qp_ops.h      |  4 +--
> >> > 11 files changed, 96 insertions(+), 66 deletions(-)
> >> >-- 
> >> >2.17.1
> >>
> >>
>
>
