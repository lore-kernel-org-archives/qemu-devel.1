Received: from eggs.gnu.org ([2001:4830:134:3::10]:39972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cp7Xv-00035e-KT
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 02:09:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cp7Xr-0000UG-Qk
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 02:08:59 -0400
Received: from [45.249.212.189] (port=2862 helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cp7Xr-0000TI-1v
	for qemu-devel@nongnu.org; Sat, 18 Mar 2017 02:08:55 -0400
References: <201703181343527551855@zte.com.cn>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58CCCECD.5010401@huawei.com>
Date: Sat, 18 Mar 2017 14:08:13 +0800
MIME-Version: 1.0
In-Reply-To: <201703181343527551855@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel]
 =?utf-8?b?wqAgW1BBVENIVjJdIENPTE86wqBDT0xPLUZULnR4?=
 =?utf-8?q?t_err?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.guang55@zte.com.cn
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com

Hi,

Thanks for reporting this.

This patch has wrong format and it seems that you pasted the content
to this email directly, please follow the introduction bellow to submit a patch:
http://wiki.qemu-project.org/Contribute/SubmitAPatch

Thanks,
Hailiang


On 2017/3/18 13:43, wang.guang55@zte.com.cn wrote:
> This is an error in COLO-FT.txt.
>
>
> secondeary-disk0 should be secondary-disk0.
>
>
>
>
>
>
> Signed-off-by: Guang Wang＜wang.guang55@zte.com.cn＞
>
> diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
>
> index e289be2..754efda 100644
>
> --- a/docs/COLO-FT.txt
>
> +++ b/docs/COLO-FT.txt
>
> @@ -139,7 +139,7 @@ Secondary:
>
>   { 'execute': 'nbd-server-start',
>
>     'arguments': {'addr': {'type': 'inet', 'data': {'host': 'xx.xx.xx.xx', 'port': '8889'} } }
>
>   }
>
> -{'execute': 'nbd-server-add', 'arguments': {'device': 'secondeary-disk0', 'writable': true } }
>
> +{'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0', 'writable': true } }
>
>
>
>   Note:
>
>     a. The qmp command nbd-server-start and nbd-server-add must be run
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
> 原始邮件
>
>
>
> 发件人：王广10165992
> 收件人： ＜zhang.zhanghailiang@huawei.com＞
> 抄送人： ＜qemu-devel@nongnu.org＞ ＜zhangchen.fnst@cn.fujitsu.com＞
> 日 期 ：2017年03月18日 13:38
> 主 题 ：[Qemu-devel] [PATCH] COLO: COLO-FT.txt err
>
>
>
>
>
>
> This is an error in COLO-FT.txt.
>
> secondeary-disk0 should be secondary-disk0.
>
>
>
>
> Signed-off-by: Guang Wang＜wang.guang55@zte.com.cn＞
>
> diff --git a/docs/COLO-FT.txt b/docs/COLO-FT.txt
>
> index e289be2..754efda 100644
>
> --- a/docs/COLO-FT.txt
>
> +++ b/docs/COLO-FT.txt
>
> @@ -139,7 +139,7 @@ Secondary:
>
>   { 'execute': 'nbd-server-start',
>
>     'arguments': {'addr': {'type': 'inet', 'data': {'host': 'xx.xx.xx.xx', 'port': '8889'} } }
>
>   }
>
> -{'execute': 'nbd-server-add', 'arguments': {'device': 'secondeary-disk0', 'writable': true } }
>
> +{'execute': 'nbd-server-add', 'arguments': {'device': 'secondary-disk0', 'writable': true } }
>
