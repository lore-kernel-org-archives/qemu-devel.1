Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64247ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:04:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33B3A2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33B3A2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9Bw-0005aV-48
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iL8QW-000445-Jm
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:15:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iL8QV-00023O-M3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:15:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iL8QV-000236-G7; Thu, 17 Oct 2019 12:14:59 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4CDD30842A9;
 Thu, 17 Oct 2019 16:14:58 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 311185D6C8;
 Thu, 17 Oct 2019 16:14:58 +0000 (UTC)
Subject: Re: [PATCH] hw/s390x: Emit a warning if user tried to enable USB
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x@nongnu.org
References: <20191017142123.1236-1-thuth@redhat.com>
 <c35a910b-4a61-331b-e0b7-3dfc6f0b256f@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <3f32cfc0-3d32-3648-3b58-900d1f9f1331@redhat.com>
Date: Thu, 17 Oct 2019 11:14:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c35a910b-4a61-331b-e0b7-3dfc6f0b256f@de.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Thu, 17 Oct 2019 16:14:58 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Halil Pasic <pasic@linux.ibm.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/17/19 9:45 AM, Christian Borntraeger wrote:
> 
> 
> On 17.10.19 16:21, Thomas Huth wrote:
>> There is no USB on s390x, so running qemu-system-s390x with
>> "-machine ...,usb=on" is certainly wrong. Emit a warning to make
>> the users aware of their misconfiguration.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   After a year or two, we could finally turn this into a hard error,
>>   but I think we should give the users some time to fix their command
>>   lines first, so I'm initially only emitting a warning here.
> 
> I think a warn message is ok, but we should never make  this a hard
> error.
> 
> I am pretty sure that there are some tools in the wild that create xmls
> or qemu commands lines cross-platform and deploy those  dynamically.
> These tools have probably been fixed to work good enough with s390x
> but nobody with qemu clue has ever looked at these command lines. And
> I am pretty sure that no user will actually see the command like nor
> the error message.
> 
> So this warning will stay unnoticed until we make this a hard error. And
> then we have broken a previously working setup.
> 
> In other words, I appreciate the willingness to detect mis-uses but I
> fear that we will never be able to assume that everything is fixed.

That's what the deprecation process is for. This patch is incomplete 
unless it also touches qemu-deprecated.texi.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

