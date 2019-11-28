Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EC3C43215
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 09:15:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDC921774
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 09:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d1LOQjId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDC921774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaFtj-00005E-7C
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 04:15:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iaFrZ-0007VM-2O
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iaFrV-0006Xa-Kc
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:13:23 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29805
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iaFrT-0006SG-Tj
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 04:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574932396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cYjZT/dVpGUgQJjJwGTxHqxZI3kccmQJTjEZD49/Z2Y=;
 b=d1LOQjIdxPYhKxpGhKipAByNH6ykrchSV/qJOhS9P4fAVYdPeE0B/HWvf+3uap83pdZwqz
 ppfZ12J8Fw9GePiKyCBOjsAeMOrGUQGZBeKXv+bHElL5K12L69HjHHgCuWXhHXNgnX/HdB
 dzPwKj7HPppRh2rmmeJ9P6tAmOfoRJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-120-vW_nv-_EMyWVS6MOMbvzbQ-1; Thu, 28 Nov 2019 04:13:15 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28207107ACFA;
 Thu, 28 Nov 2019 09:13:14 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-114.ams2.redhat.com [10.36.116.114])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F19A608B9;
 Thu, 28 Nov 2019 09:13:09 +0000 (UTC)
Subject: Re: [PATCH v5] s390x: Move initial reset
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191127175046.4911-4-frankja@linux.ibm.com>
 <20191128083723.11937-1-frankja@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <645ac357-046f-1778-85cf-dfd28e19670f@redhat.com>
Date: Thu, 28 Nov 2019 10:13:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191128083723.11937-1-frankja@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: vW_nv-_EMyWVS6MOMbvzbQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: pmorel@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 28/11/2019 09.37, Janosch Frank wrote:
> Let's move the intial reset into the reset handler and cleanup
> afterwards.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Fixed the kvm vcpu reset.
> 
> ---
>   target/s390x/cpu-qom.h |  2 +-
>   target/s390x/cpu.c     | 46 +++++++++++++++++-------------------------
>   target/s390x/cpu.h     |  2 +-
>   target/s390x/sigp.c    |  2 +-
>   4 files changed, 21 insertions(+), 31 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


