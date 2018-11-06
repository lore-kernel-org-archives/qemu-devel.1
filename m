Received: from eggs.gnu.org ([2001:4830:134:3::10]:41368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gJv8Z-00084f-AU
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangckid@gmail.com>) id 1gJv8Y-0002Ki-9E
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:46:55 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <zhangckid@gmail.com>) id 1gJv8X-0002GC-T1
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 01:46:54 -0500
Received: by mail-wm1-x341.google.com with SMTP id f19-v6so8050664wmb.0
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 22:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20181101021226.6353-1-zhangckid@gmail.com>
	<f1b5db6b-bd49-6b51-2bfa-be8c8d218cde@redhat.com>
In-Reply-To: <f1b5db6b-bd49-6b51-2bfa-be8c8d218cde@redhat.com>
From: Zhang Chen <zhangckid@gmail.com>
Date: Tue, 6 Nov 2018 14:44:35 +0800
Message-ID: <CAK3tnv+UYxvNTcKA+B2jARa4EFWoPWcYE28ji9HsCyxegCJ1zA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH V2] migration/colo.c: Fix compilation issue
 when disable replication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, "zhang.zhanghailiang@huawei.com" <zhang.zhanghailiang@huawei.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Mon, Nov 5, 2018 at 6:02 PM Thomas Huth <thuth@redhat.com> wrote:

> On 2018-11-01 03:12, Zhang Chen wrote:
> > This compilation issue will occur when user use --disable-replication
> > to config Qemu.
> >
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Zhang Chen <zhangckid@gmail.com>
> > ---
> >  migration/colo.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
>
> Thanks, this fixes the compilation problem with --disable-replication
> for me:
>
> Tested-by: Thomas Huth <thuth@redhat.com>
>
> BTW, if colo can't be used without CONFIG_REPLICATION, would it make
> sense to disable the related objects (for the "--object" parameter) in
> an additional patch, too? Something like this (untested):
>

Hi Thomas,

Yes, you are right. current COLO project need work with replication, but in
the future we will develop COLO shared disk mode,
In this mode COLO-compare maybe not depend on replication. So I think we
can keep the independence of the two modules.

Thanks
Zhang Chen


>
> diff --git a/net/Makefile.objs b/net/Makefile.objs
> --- a/net/Makefile.objs
> +++ b/net/Makefile.objs
> @@ -10,7 +10,7 @@ common-obj-$(CONFIG_NETMAP) += netmap.o
>  common-obj-y += filter.o
>  common-obj-y += filter-buffer.o
>  common-obj-y += filter-mirror.o
> -common-obj-y += colo-compare.o
> +common-obj-$(CONFIG_REPLICATION) += colo-compare.o
>  common-obj-y += colo.o
>  common-obj-y += filter-rewriter.o
>  common-obj-y += filter-replay.o
>
>   Thomas
>
