Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AC4C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:44:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 960A72084A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:44:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 960A72084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47523 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY47U-00062K-F0
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 03:44:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hY46S-0005W4-GM
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hY46Q-00084W-UR
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:43:28 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:51937)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hY46Q-00073c-Ht; Tue, 04 Jun 2019 03:43:26 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
	(mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
	1MuUvS-1ggvZu0g0Q-00rYPC; Tue, 04 Jun 2019 09:43:00 +0200
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
References: <20190604071915.288045-1-borntraeger@de.ibm.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
	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
Message-ID: <08f9ca93-4db4-826a-bd60-1e6ac7c0dd90@vivier.eu>
Date: Tue, 4 Jun 2019 09:42:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190604071915.288045-1-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:JlueatdYNqEFMVBfOcRtl6IdWgEoTh2Rg+W3cKYSRjJOW/ld0Sg
	TqaOYII5EJTjw1+W/kT8wtrKzXXAW6K4w5qIlv85PsyVrQ5O69YT3ySCq15jDRd4gnkdYmA
	d9kQqCvXxN0dLhxLZb7c48OJNDFW/rLAo5wDRJ/SNPid0haUMCVQ/OYKCzS7LUkFVSewYbZ
	Eij5HnyG3O95QBDjMTeSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UElnKSXDHUY=:zUnWRcaHBSpxA34KpSbusl
	014R7SaDT6kV+72KzFc5AkS4nTVCHFTcM0qWBCxc8IFfRq111YyFwY87vYiJyzD6nO3GG+wkB
	Y/AIiJFbFTpjaW1qaaaUZ9pPfmR8vmyGARmsAZwCSyu5ULfUggHpQjZvSKJ518vv23SjXL+Z0
	oGJglfU/3/fPYe5Xooe4Zp7cjyK0HuEuM0d/FMPUlmsY8++6govrXF9ElHVgd2WjxmElzud24
	vQ/MQZJTYumxho8erB6a1BpPeYiaFYDkvJsYMiX0yMJPJX8aemOExxa6EdN7h2RIs0L5RyFLi
	9AqQC30ZKIt9SLcqrfoBmtfGrOYiQYI1TSmekRxT6/5MKMMecdDCIkFLlW0X7iMpjUt+HT1Oc
	1BoutTO7T6l4UVLWMoEmIlU0BReRAafcXlLURKnKTXXB7IX4vXO64gfP5o6qcpolbre4zyg/k
	AHEB9r7rwSDV4F8OsdCkAeFiXI0wU3Qwz+RLATcRIxQ8bntTPzrVsfTsRzgdpn31Ls2NPCde1
	gECiwf6PTcXf4diepE2yQIpW1JpH6/N+uBRhbb2Gxb0cdIWyVP/yWEhaMc2OdVjF3Bj4SzZHB
	lBGuLbXow5esQp/LrBz6gvxNRRm4Tt3AHW8CLhCQPlirPeTu2itmuK+cmzVLLl+utwhW45SJE
	fHUe7LMZD5qD3wHdRX57v7ec0ieWzZL+LbLzD49eGClE/sRYpUuGTS5g7bEvP9QJ7VT/uIjHr
	xR2SFNNeEVdxWazpAdxDVwsNyYqIqPtT96JG3gf6tWOxsPHqE5nzm0o1pgs=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
Subject: Re: [Qemu-devel] [PATCH] linux-user: fix build with 5.2-rc2 kernel
 headers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Gerhard Stenzel <gerhard.stenzel@de.ibm.com>, qemu-s390x@nongnu.org,
	Riku Voipio <riku.voipio@iki.fi>, Arnd Bergmann <arnd@arndb.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 04/06/2019 à 09:19, Christian Borntraeger a écrit :
> Since kernel commit 0768e17073dc527ccd ("net: socket: implement 64-bit
> timestamps") the linux kernel headers (those installed on the build
> system, not those that are synced to QEMU) will make qemu-user fail to
> build:
> 
> /root/rpmbuild/BUILD/qemu-4.0.50/linux-user/ioctls.h:222:9: error: 'SIOCGSTAMP' undeclared here (not in a function); did you mean 'SIOCSRARP'?
>   222 |   IOCTL(SIOCGSTAMP, IOC_R, MK_PTR(MK_STRUCT(STRUCT_timeval)))
>       |         ^~~~~~~~~~
> 
> Let us fix this by including  "linux/sockios.h" instead of relying on
> "sys/socket.h" providing those defines via an include chain.

I'm not sure it is as simple as this:
the value of SIOCGSTAMP depends on the size of struct timeval, and we
should use SIOCGSTAMP_OLD and SIOCGSTAMP_NEW to have the host and the
guest parts in sync.

Thanks,
Laurent
> 
> Cc: Riku Voipio <riku.voipio@iki.fi>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Reported-by: Gerhard Stenzel <gerhard.stenzel@de.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  linux-user/syscall.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index efa3ec2837..7332be9b06 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -34,6 +34,7 @@
>  #include <sys/resource.h>
>  #include <sys/swap.h>
>  #include <linux/capability.h>
> +#include <linux/sockios.h>
>  #include <sched.h>
>  #include <sys/timex.h>
>  #include <sys/socket.h>
> 


