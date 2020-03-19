Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD85C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9F920663
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 13:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="eIAE7nIt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9F920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEvMN-0005gJ-La
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 09:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37771)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <r.bolshakov@yadro.com>) id 1jEvLj-0005G3-PE
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <r.bolshakov@yadro.com>) id 1jEvLi-0001mu-Rb
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:36:39 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:42874 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <r.bolshakov@yadro.com>)
 id 1jEvLi-0001gB-It
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 09:36:38 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 0A66D412E1;
 Thu, 19 Mar 2020 13:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1584624993;
 x=1586439394; bh=ftduRck7+tDm2XJ/NpzowEDDQXafKF21AjDVFlb2F3Q=; b=
 eIAE7nIt1GjzJ1yASlbOX3oyFNoBqiR0QVYcfgMQylxmy7H7VrcSCb/u/si6rV8M
 lcmVPWhtBqsEPxLZGuT0bPyG8U8E2kj/3bontokXVVEeg6Y2sVdlPluup5BYKKey
 v3+0D4cpdTarfR6/1K+neJRuqm/aJ4tZvkncLP3hf9w=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XDzq6LpWthJT; Thu, 19 Mar 2020 16:36:33 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id B29DE411FC;
 Thu, 19 Mar 2020 16:36:31 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 19
 Mar 2020 16:36:31 +0300
Date: Thu, 19 Mar 2020 16:36:31 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Cameron Esfahani <dirty@apple.com>
Subject: Re: [PATCH 04/11] MAINTAINERS: Add an entry for the HVF accelerator
Message-ID: <20200319133631.GA77771@SPB-NB-133.local>
References: <20200316120049.11225-1-philmd@redhat.com>
 <20200316120049.11225-5-philmd@redhat.com>
 <20200316121241.GA4312@SPB-NB-133.local>
 <D599D20D-5F23-48CB-B24C-2D1604AFE94E@apple.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <D599D20D-5F23-48CB-B24C-2D1604AFE94E@apple.com>
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>,
 Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>,
 Patrick Colp <patrick.colp@oracle.com>, Liran Alon <liran.alon@oracle.com>,
 "Reviewed-by : Nikita Leshenko" <nikita.leshchenko@oracle.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Heiher <r@hev.cc>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Mar 17, 2020 at 04:24:44PM -0700, Cameron Esfahani wrote:
> Sorry I didn't see this yesterday.
> 
> We've (Apple) signed up for taking over HVF ownership.  I didn't realize I needed to add to the MAINTAINERS list.
> 
> Roman, we also have a bunch of pending fixes for some of the issues you've listed.  We're in the process of upstreaming them.
> 

Hi Cameron,

That's great news. What exactly are you planning to upstream first?
BTW many thanks for the fixes you made last December.

Best regards,
Roman

