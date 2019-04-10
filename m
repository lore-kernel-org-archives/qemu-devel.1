Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E89A9C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 11:41:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF6062083E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 11:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="mnaTtgNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF6062083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57889 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEBc0-00019r-TT
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 07:41:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEBbF-0000fd-Bc
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:41:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <r.bolshakov@yadro.com>) id 1hEBbE-0006rb-Ga
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:41:05 -0400
Received: from mta-01.yadro.com ([89.207.88.251]:40554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
	id 1hEBbD-0006oK-VG
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 07:41:04 -0400
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id F0BD341927;
	Wed, 10 Apr 2019 11:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
	user-agent:in-reply-to:content-disposition:content-type
	:content-type:mime-version:references:message-id:subject:subject
	:from:from:date:date:received:received:received; s=mta-01; t=
	1554896458; x=1556710859; bh=gLzRIvUe/B0A9Q+nIznvMw1vtVZxlmG1PIw
	velrVxMk=; b=mnaTtgNILpyDMpcGN52ziRI16R8xziNEP/A6Y10WjirHOAAeTi6
	iEj/OKDp0IGweznQeQU1SUtgbQij/ftGFvsfiGqA9dfp1MmDVDokW1zM/PdZntPU
	mwml6c0fOjeP4Q/xK5rJQIytHLNbKQRvCX+SBkSVzKzZbC35oUVkJS2k=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h9tz3b3ceB9m; Wed, 10 Apr 2019 14:40:58 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
	[172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id 1123C41203;
	Wed, 10 Apr 2019 14:40:58 +0300 (MSK)
Received: from localhost (172.17.128.60) by T-EXCH-02.corp.yadro.com
	(172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32;
	Wed, 10 Apr 2019 14:40:57 +0300
Date: Wed, 10 Apr 2019 14:40:51 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Message-ID: <20190410114027.53l4ph7an3pnclqr@SPB-NB-133.local>
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
	<20190407115839.25054-2-skrtbhtngr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190407115839.25054-2-skrtbhtngr@gmail.com>
User-Agent: NeoMutt/20180716
X-Originating-IP: [172.17.128.60]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
	T-EXCH-02.corp.yadro.com (172.17.10.102)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 89.207.88.251
Subject: Re: [Qemu-devel] [PATCH RESEND v2 1/2] hvf: declare hvf_handle_io
 if NEED_CPU_H is defined
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410114051.TKUcqdsafMik3G_IZDLf1OFrrr61UBpSlWCaSxsvBlI@z>

On Sun, Apr 07, 2019 at 05:28:38PM +0530, Sukrit Bhatnagar wrote:
> hvf_handle_io needs the poisoned type CPUArchState as its argument.
> Declaring it if NEED_CPU_H is defined enables include/sysemu/hvf.h
> to be included for common object compilation as well.
> 

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>
Tested-by: Roman Bolshakov <r.bolshakov@yadro.com>

Thanks,
Roman

