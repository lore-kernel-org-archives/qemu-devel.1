Received: from eggs.gnu.org ([2001:4830:134:3::10]:59105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gFDgc-0005lq-Ub
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:34:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gFDgb-0004KU-Ep
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:34:38 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40086)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gFDgY-0004Cn-Ty
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 03:34:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id b203-v6so4270205wme.5
	for <qemu-devel@nongnu.org>; Wed, 24 Oct 2018 00:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180903043900.28592-1-zhangckid@gmail.com>
	<20180903043900.28592-6-zhangckid@gmail.com>
	<497c0e00-d98e-5cdc-f62d-9edeec6458b7@redhat.com>
In-Reply-To: <497c0e00-d98e-5cdc-f62d-9edeec6458b7@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Wed, 24 Oct 2018 15:34:16 +0800
Message-ID: <CAK3tnvLbb22Lcv9F+SH0U767FkwAHp=k+4rfQeaB6v8BSs6wyQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V12 05/19] COLO: Add block replication into
 colo process
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: thuth@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, jasowang@redhat.com, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Zhang Chen <chen.zhang@intel.com>, zhang.zhanghailiang@huawei.com, lizhijian@cn.fujitsu.com, Peter Maydell <peter.maydell@linaro.org>

On Wed, Oct 24, 2018 at 3:21 PM Thomas Huth <thuth@redhat.com> wrote:

> On 2018-09-03 05:38, Zhang Chen wrote:
> > Make sure master start block replication after slave's block
> > replication started.
> >
> > Besides, we need to activate VM's blocks before goes into
> > COLO state.
> >
> > Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> > Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > Signed-off-by: Zhang Chen <chen.zhang@intel.com>
>
>  Hi,
>
> one of the recent merged PULL-requests broke compilation with
>  --disable-replication:
>
>  https://gitlab.com/huth/qemu/-/jobs/111968709
>
> Seems like it happened due to this patch here. Could you please have a
> look?
>

Sure, I will send a patch to fix this issue.

Thanks
Zhang Chen


>
>  Thanks,
>   Thomas
>
