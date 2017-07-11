Received: from eggs.gnu.org ([2001:4830:134:3::10]:51204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dUvST-0007e3-6f
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:44:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dUvSS-0006Y4-CD
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 09:44:09 -0400
References: <1499755579-31262-1-git-send-email-gengdongjiu@huawei.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <366f019e-50e8-03f4-9b8f-946ef318ca79@redhat.com>
Date: Tue, 11 Jul 2017 15:43:51 +0200
MIME-Version: 1.0
In-Reply-To: <1499755579-31262-1-git-send-email-gengdongjiu@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH resend v4 0/3] Generate APEI GHES table and
 dynamically record CPER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: mst@redhat.com, imammedo@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, zhaoshenglong@huawei.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, zhengqiang10@huawei.com, huangshaoyu@huawei.com, wuquanming@huawei.com, zhihui.gao@huawei.com, Eric Blake <eblake@redhat.com>

Hi Dongjiu,

On 07/11/17 08:46, Dongjiu Geng wrote:
> [...]

So my followup is off-topic, but I'd like to point out that the patch /
email threading in this series is still incorrect.

These are the "sent" timestamps on the messages:

Date: Tue, 11 Jul 2017 14:46:19 +0800
Date: Tue, 11 Jul 2017 14:46:31 +0800 (+12 seconds)
Date: Tue, 11 Jul 2017 14:46:41 +0800 (+10 seconds)
Date: Tue, 11 Jul 2017 14:47:00 +0800 (+19 seconds)

This tells me that you are mailing out the patches one by one. That's
not how most people post their patches.

(Side remark: while git-send-email can still get the threading right
with individual posting, for that you would have to provide the first
email's Message-Id individually to all the subsequent commands, and the
emails show that this didn't happen.)

Instead, you should invoke git-send-email with all the messages *at
once*. Then git-send-email can set up the threading automatically. From
git-send-email(1):

> GIT-SEND-EMAIL(1)            Git Manual            GIT-SEND-EMAIL(1)
>
> NAME
>        git-send-email - Send a collection of patches as emails
>
> SYNOPSIS
>        git send-email [options] <file|directory|rev-list options>...
>        git send-email --dump-aliases
>
> DESCRIPTION
>        Takes the patches given on the command line and emails them
>        out. Patches can be specified as files, directories (which
>        will send all files in the directory), or directly as a
>        revision list. In the last case, any format accepted by git-
>        format-patch(1) can be passed to git send-email.

So send the patches with

  git send-email *.patch

or put all the patches into a temporary directory, and run

  git send-email patch-dir/

Thanks,
Laszlo
