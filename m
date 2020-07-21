Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2F8C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 07:11:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B0921702
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 07:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ie1wL/9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B0921702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxmQb-0007nb-MB
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 03:11:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxmQ0-0007Nr-DA
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 03:10:28 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39533
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jxmPx-0002QD-69
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 03:10:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595315424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=udG+iUoPj4f6ExWEkcmqj0J32VqSH4BMB2gK0TiCtkM=;
 b=Ie1wL/9CUSkxTNMg7wzepmVbYJpMNiTu062f2X8ettSg0kTf6QUK0qEiRiprLzQ4x0szwJ
 UNxahQ91rVkXUD/zN18v+q0+hV+YZOKcr75CiSbvBqetA+HD9rePMuW3KkPXhO/l5RH77/
 ofBvkV0LVVgFW77+SQT0Q9WhiqAbbdE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-0PxrTT1jOjWo6k9YY0mHXg-1; Tue, 21 Jul 2020 03:10:22 -0400
X-MC-Unique: 0PxrTT1jOjWo6k9YY0mHXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D4E880183C;
 Tue, 21 Jul 2020 07:10:21 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-102.ams2.redhat.com [10.36.112.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6EEBC6931A;
 Tue, 21 Jul 2020 07:10:05 +0000 (UTC)
Subject: Re: [PATCH 3/7] pc-bios: s390x: Remove unneeded dasd-ipl.c reset psw
 mask changes
To: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org
References: <20200715094045.381984-1-frankja@linux.ibm.com>
 <20200715094045.381984-4-frankja@linux.ibm.com>
 <fdc4168f-ea1d-de51-9b6f-ddced1d19f5e@redhat.com>
 <19b628cd-9766-4ccb-995f-4374aac851dc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5241ad31-5f82-3736-2792-1fdc59b256a8@redhat.com>
Date: Tue, 21 Jul 2020 09:10:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <19b628cd-9766-4ccb-995f-4374aac851dc@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 01:26:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20/07/2020 14.16, Janosch Frank wrote:
> On 7/20/20 1:45 PM, Thomas Huth wrote:
>> On 15/07/2020 11.40, Janosch Frank wrote:
>>> jump_to_low_kernel() and the functions that it calls will already or
>>> 64 bit addressing into the reset psw mask when executing
>>> jump_to_IPL_2() after the diag308 subcode 1.
>>
>> But there is also a check in jump_to_low_kernel that could be affected
>> by your change:
>>
>>     if (*((uint64_t *)0) & RESET_PSW_MASK) {
>>         jump_to_IPL_code((*((uint64_t *)0)) & PSW_MASK_SHORT_ADDR);
>>     }
>>
>> ... but I assume that there should not be any kernels out there in the
>> wild which do not have these bits set, so I think your modifications
>> here should be ok.
> 
> The mask needs to have the short bit indication set so it needs to be !=
> 0 anyway, no?

That's true. If there were still broken images out there, they should
have stopped working since commit 104130cb7c106378da anyway.

 Thomas


