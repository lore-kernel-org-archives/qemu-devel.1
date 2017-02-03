Received: from eggs.gnu.org ([2001:4830:134:3::10]:52105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZapV-0005Zs-TH
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZapS-0002ze-Kl
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:10:57 -0500
Received: from smtp3.mundo-r.com ([212.51.32.191]:40659 helo=smtp4.mundo-r.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1cZapS-0002yo-8u
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 05:10:54 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <1486116298-25046-2-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1486116298-25046-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1486116298-25046-2-git-send-email-pradeep.jagadeesh@huawei.com>
Date: Fri, 03 Feb 2017 11:10:52 +0100
Message-ID: <w51r33fwpn7.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2 v15] fsdev: add IO throttle support to
 fsdev devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, qemu-devel@nongnu.org

On Fri 03 Feb 2017 11:04:57 AM CET, Pradeep Jagadeesh wrote:
> This patchset adds the io throttle support for the 9p-local driver.
> For now this functionality can be used only through qemu cli options.
> QMP interface and support to other 9p drivers need further extensions.
> To make it simple for other 9p drivers, the throttle code has been put in
> separate files.
>
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>

I don't see any difference between this patch and the one in v14...

> +
> +    s->ctx.fst = &fse->fst;
> +    fsdev_throttle_init(s->ctx.fst);
> +
>      v9fs_path_free(&path);
>  
>      rc = 0;
> @@ -3528,6 +3532,7 @@ out:
>          if (s->ops && s->ops->cleanup && s->ctx.private) {
>              s->ops->cleanup(&s->ctx);
>          }
> +        fsdev_throttle_cleanup(s->ctx.fst);
>          g_free(s->tag);
>          g_free(s->ctx.fs_root);
>          v9fs_path_free(&path);

Berto
