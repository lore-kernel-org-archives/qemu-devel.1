Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58C0C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:41:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ABDC206A4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzOFfRrh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABDC206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kONBt-0003W9-8B
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:41:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kOMnf-0002Bz-9q
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kOMnd-00013T-Bo
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601651803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G2fpkYqU9iJCXIBox2lJsKSpHcKUZmyboo4d5mAPzLM=;
 b=XzOFfRrhwsR/tNUeIeFHfaIQUWCcASE88tA0Uike/6kjMUhif/HcnOIfczPeQHhYhn56QD
 T1xiyepvwPpe/YOBFLjf9w5deaSWSZgeLtRR7SQLOT9ctL4+fd599lgPkKtPIAI5wPvDU8
 BRq/wNmK32P2jjDpBajVwl+jwQds8+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-8bnMP2yQMveGWDrI6HNghg-1; Fri, 02 Oct 2020 11:16:40 -0400
X-MC-Unique: 8bnMP2yQMveGWDrI6HNghg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1A3B84F226;
 Fri,  2 Oct 2020 15:16:39 +0000 (UTC)
Received: from [10.10.120.38] (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 380325C1DA;
 Fri,  2 Oct 2020 15:16:39 +0000 (UTC)
Subject: Re: KVM call for agenda for 2020-10-06
To: quintela@redhat.com, kvm-devel <kvm@vger.kernel.org>, qemu-devel@nongnu.org
References: <874kndm1t3.fsf@secure.mitica>
From: John Snow <jsnow@redhat.com>
Message-ID: <c64f5686-b656-226d-8c4c-95965dcc574a@redhat.com>
Date: Fri, 2 Oct 2020 11:16:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <874kndm1t3.fsf@secure.mitica>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.256, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 5:09 AM, Juan Quintela wrote:
> 
> 
> Hi
> 
> Please, send any topic that you are interested in covering.
> 
> At the end of Monday I will send an email with the agenda or the
> cancellation of the call, so hurry up.
> 
> 
> For this call, we have agenda!!
> 
> John Snow wants to talk about his new (and excting) developments with
> x-configure.  Stay tuned.
> 

I'm working on an email to qemu-devel now detailing some of our work 
trying to make good on a renewed effort for better APIs for QEMU.

In short, I'd like to discuss a roadmap for converting our CLI to 
something QAPI-based, and discuss ways to coordinate and distribute this 
work to interested maintainers and developers.

Look out for it!

--js

> 
> After discussions on the QEMU Summit, we are going to have always open a
> KVM call where you can add topics.
> 
>   Call details:
> 
> By popular demand, a google calendar public entry with it
> 
>    https://www.google.com/calendar/embed?src=dG9iMXRqcXAzN3Y4ZXZwNzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
> 
> (Let me know if you have any problems with the calendar entry.  I just
> gave up about getting right at the same time CEST, CET, EDT and DST).
> 
> If you need phone number details,  contact me privately
> 
> Thanks, Juan.
> 


