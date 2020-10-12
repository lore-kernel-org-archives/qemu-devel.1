Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E89C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 973F720838
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 18:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=lse.epita.fr header.i=@lse.epita.fr header.b="d3a/vG7U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973F720838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lse.epita.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS2rg-0000gi-PP
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 14:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=obtr=dt=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1kS2ZV-0004Cb-Mw
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:29:21 -0400
Received: from gate-2.cri.epita.net ([163.5.55.20]:48734
 helo=mail-2.srv.cri.epita.fr)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <srs0=obtr=dt=lse.epita.fr=cesar.belley@cri.epita.fr>)
 id 1kS2ZM-0004Dr-6t
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 14:29:21 -0400
Received: from [172.20.10.2] (unknown [37.172.107.98])
 (Authenticated sender: cesar.belley)
 by mail-2.srv.cri.epita.fr (Postfix) with ESMTPSA id 9905F415C8;
 Mon, 12 Oct 2020 20:28:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=lse.epita.fr; s=cri;
 t=1602527346; bh=Xk6vEREJYuV/jBBDU2hIMS/zKt9iFDgHDsw33NoSXXw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=d3a/vG7USicfnhWO01owxdmcsy3pCoN03epO1sa6YvnMO42P9/w+aTpv4gE93JOWU
 KRqR2fjqqXlwkGeU6ZlJUNPoIT8rerNrXoBeJKT6AeqPZ6065woeR8sFmJAi0/A5Bs
 EK3FzYS2Pyo6ERAMNLx8cV36EBjmDEAdD+8w78Sw=
Subject: Re: [RFC PATCH 2/2] contrib/gitdm: Add more academic domains
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20201004204010.2048608-1-f4bug@amsat.org>
 <20201004204010.2048608-3-f4bug@amsat.org>
From: =?UTF-8?Q?C=c3=a9sar_Belley?= <cesar.belley@lse.epita.fr>
Message-ID: <d9daf2af-eaeb-4a82-4742-137d23d56ca4@lse.epita.fr>
Date: Mon, 12 Oct 2020 20:28:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.1
MIME-Version: 1.0
In-Reply-To: <20201004204010.2048608-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=163.5.55.20;
 envelope-from=srs0=obtr=dt=lse.epita.fr=cesar.belley@cri.epita.fr;
 helo=mail-2.srv.cri.epita.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 14:29:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, NICE_REPLY_A=-0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Mike Ryan <mikeryan@isi.edu>,
 Stephen Checkoway <stephen.checkoway@oberlin.edu>,
 Vince Weaver <vince@csl.cornell.edu>, qemu-devel@nongnu.org,
 Xinyu Li <precinct@mail.ustc.edu.cn>,
 Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 Amir Charif <amir.charif@cea.fr>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Alex Barcelo <abarcelo@ac.upc.edu>,
 =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>,
 linzhecheng <linzc@zju.edu.cn>,
 Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>,
 Dayeol Lee <dayeol@berkeley.edu>, Nickolai Zeldovich <nickolai@csail.mit.edu>,
 Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>,
 Brian Wheeler <bdwheele@indiana.edu>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Christoffer Dall <cdall@cs.columbia.edu>, Colin Lord <cdlord2@illinois.edu>,
 Gabriel Somlo <somlo@cmu.edu>, Alexander Bulekov <alxndr@bu.edu>,
 Fan Yang <Fan_Yang@sjtu.edu.cn>, Fabrice Desclaux <fabrice.desclaux@cea.fr>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Akkarit Sangpetch <asangpet@andrew.cmu.edu>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Chen Wei-Ren <chenwj@iis.sinica.edu.tw>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Zhang Mengchi <zhangmengchi@mprc.pku.edu.cn>,
 Timothy Edward Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Acked-by: César Belley <cesar.belley@lse.epita.fr>

On 10/4/20 10:40 PM, Philippe Mathieu-Daudé wrote:
> There is a number of contributions from these academic domains.
> Add the entries to the gitdm 'academic' domain map.
> 
> Cc: Akkarit Sangpetch <asangpet@andrew.cmu.edu>
> Cc: Alexander Bulekov <alxndr@bu.edu>
> Cc: Alexander Oleinik <alxndr@bu.edu>
> Cc: Alex Barcelo <abarcelo@ac.upc.edu>
> Cc: Brian Wheeler <bdwheele@indiana.edu>
> Cc: Chen Wei-Ren <chenwj@iis.sinica.edu.tw>
> Cc: Christoffer Dall <cdall@cs.columbia.edu>
> Cc: Colin Lord <cdlord2@illinois.edu>
> Cc: Dayeol Lee <dayeol@berkeley.edu>
> Cc: Fan Yang <Fan_Yang@sjtu.edu.cn>
> Cc: Gabriel Somlo <somlo@cmu.edu>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: linzhecheng <linzc@zju.edu.cn>
> Cc: Lluís Vilanova <vilanova@ac.upc.edu>
> Cc: Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>
> Cc: Mike Ryan <mikeryan@isi.edu>
> Cc: Nickolai Zeldovich <nickolai@csail.mit.edu>
> Cc: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
> Cc: Vince Weaver <vince@csl.cornell.edu>
> Cc: Xinyu Li <precinct@mail.ustc.edu.cn>
> Cc: Zhang Mengchi <zhangmengchi@mprc.pku.edu.cn>
> Cc: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
> Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> Cc: Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>
> Cc: Timothy Edward Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
> Cc: Pavel Pisa <pisa@cmp.felk.cvut.cz>
> Cc: César Belley <cesar.belley@lse.epita.fr>
> Cc: Amir Charif <amir.charif@cea.fr>
> Cc: Fabrice Desclaux <fabrice.desclaux@cea.fr>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> To the developers Cc'ed: If you agree with the entry of your
> domain, please reply with a Reviewed-by/Acked-by tag. If you
> disagree or doesn't care, please either reply with Nack-by or
> ignore this patch.
> I'll repost in 2 weeks as formal patch (not RFC) with only the
> entries acked by their author.
> One Reviewed-by/Ack-by from someone from a domain should be
> sufficient to get the domain included in the final patch.
> ---
>  contrib/gitdm/group-map-academics | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-academics
> index c7b0dd46a3..fd42bb8069 100644
> --- a/contrib/gitdm/group-map-academics
> +++ b/contrib/gitdm/group-map-academics
> @@ -11,9 +11,17 @@ ispras.ru
>  pavel.dovgaluk@gmail.com
>  
>  # Columbia University
> -cs.columbia.edu
>  cota@braap.org
>  
>  jiaxun.yang@flygoat.com
>  
>  artem.k.pisarenko@gmail.com
> +
> +uni-paderborn.de
> +edu
> +ac.uk
> +edu.cn
> +edu.tw
> +cmp.felk.cvut.cz
> +epita.fr
> +cea.fr
> -- 
> 2.26.2
>

