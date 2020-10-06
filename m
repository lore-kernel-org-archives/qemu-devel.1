Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94FDC4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 03:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1A1208A9
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 03:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B1A1208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPdoV-00086G-51
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 23:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kPdnQ-0007Vh-GN
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 23:37:48 -0400
Received: from relay64.bu.edu ([128.197.228.104]:42033)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1kPdnO-0006cf-Kk
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 23:37:47 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 0963Z1xJ015781
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 5 Oct 2020 23:35:05 -0400
Date: Mon, 5 Oct 2020 23:35:01 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [RFC PATCH 2/2] contrib/gitdm: Add more academic domains
Message-ID: <20201006033501.2s3mhnlbxzvfovrc@mozz.bu.edu>
References: <20201004204010.2048608-1-f4bug@amsat.org>
 <20201004204010.2048608-3-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201004204010.2048608-3-f4bug@amsat.org>
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 23:37:44
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 HK_RANDOM_FROM=0.794, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 =?utf-8?B?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>,
 linzhecheng <linzc@zju.edu.cn>,
 Mike Nawrocki <michael.nawrocki@gtri.gatech.edu>,
 Dayeol Lee <dayeol@berkeley.edu>, Nickolai Zeldovich <nickolai@csail.mit.edu>,
 Hesham Almatary <Hesham.Almatary@cl.cam.ac.uk>,
 Brian Wheeler <bdwheele@indiana.edu>, Pavel Pisa <pisa@cmp.felk.cvut.cz>,
 Christoffer Dall <cdall@cs.columbia.edu>, Colin Lord <cdlord2@illinois.edu>,
 Gabriel Somlo <somlo@cmu.edu>, Fan Yang <Fan_Yang@sjtu.edu.cn>,
 Fabrice Desclaux <fabrice.desclaux@cea.fr>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?B?Q8Opc2Fy?= Belley <cesar.belley@lse.epita.fr>,
 Akkarit Sangpetch <asangpet@andrew.cmu.edu>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Chen Wei-Ren <chenwj@iis.sinica.edu.tw>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Zhang Mengchi <zhangmengchi@mprc.pku.edu.cn>,
 Timothy Edward Baldwin <T.E.Baldwin99@members.leeds.ac.uk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 201004 2240, Philippe Mathieu-Daudé wrote:
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

For both Alexander {Bulekov, Oleinik} <alxndr@bu.edu>

Reviewed-by: Alexander Bulekov <alxndr@bu.edu>

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

