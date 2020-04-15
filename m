Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E180FC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:02:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD68720737
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="gdIe904X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD68720737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOhgu-0006x4-KL
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <r.bolshakov@yadro.com>) id 1jOhfT-0006EI-KY
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:01:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <r.bolshakov@yadro.com>) id 1jOhfS-0003gg-Ic
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:01:27 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:37694 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
 id 1jOhfS-0003fv-Ae
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:01:26 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 8239C42E12;
 Wed, 15 Apr 2020 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1586955677;
 x=1588770078; bh=t/8cO5SM1SzJSxPQofJkoM4/etqeKcHWSg5fehcvZCs=; b=
 gdIe904XE3VonLk65T7lCwVVHG1Mt5MCGn1EF9dDZhMT9ROabPQqBQK8NGubRaJD
 wQ8+e+Tdk3UPNn31P3+D/+ydbdT20ZKtQjeQIXAmO8qFuGX0y705YG6dURnlLbjF
 19IwxergwriTgZF7ijoCTA91SXpfHD1ox97eZqmOBUU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EB-qulNf2zfa; Wed, 15 Apr 2020 16:01:17 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 149044128C;
 Wed, 15 Apr 2020 16:01:17 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Wed, 15
 Apr 2020 16:01:17 +0300
Date: Wed, 15 Apr 2020 16:01:19 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH v2] hvf: use standard CR0 and CR4 register definitions
Message-ID: <20200415130119.GA7853@SPB-NB-133.local>
References: <a31c1c7f7a7b4f537be9d307ccddc6e17761f1b0.1586927010.git.dirty@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a31c1c7f7a7b4f537be9d307ccddc6e17761f1b0.1586927010.git.dirty@apple.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 89.207.88.252
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 14, 2020 at 10:12:12PM -0700, Cameron Esfahani wrote:
>  target/i386/cpu.h          |  2 ++
>  target/i386/hvf/hvf.c      |  2 +-
>  target/i386/hvf/vmx.h      | 15 ++++++++-------
>  target/i386/hvf/x86.c      |  6 +++---
>  target/i386/hvf/x86.h      | 34 ----------------------------------
>  target/i386/hvf/x86_mmu.c  |  2 +-
>  target/i386/hvf/x86_task.c |  3 ++-
>  7 files changed, 17 insertions(+), 47 deletions(-)
> 

Hi Cameron,

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman

