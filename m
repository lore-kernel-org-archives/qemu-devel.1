Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64426C10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 394C020650
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 394C020650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNeV-0002fl-3n
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:18:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59546)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iKNdU-0001nP-4m
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iKNdS-0002yI-4c
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:17:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33242)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1iKNdI-0002t1-VY; Tue, 15 Oct 2019 10:17:07 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A00DA300CA4B;
 Tue, 15 Oct 2019 14:17:01 +0000 (UTC)
Received: from [10.3.116.168] (ovpn-116-168.phx2.redhat.com [10.3.116.168])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 482C3608C0;
 Tue, 15 Oct 2019 14:17:01 +0000 (UTC)
Subject: Re: [PATCH] doc: Describe missing generic -blockdev options
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20191015123854.12039-1-kwolf@redhat.com>
 <CAFEAcA8vUcj2bQDno17ncH=zoDvW-9wrzaWo4pLyPTX_Ot=AAQ@mail.gmail.com>
 <20191015140510.GB4093@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <14f7bf57-6774-1a72-9ecd-10ac18931ee0@redhat.com>
Date: Tue, 15 Oct 2019 09:17:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191015140510.GB4093@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Tue, 15 Oct 2019 14:17:01 +0000 (UTC)
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/15/19 9:05 AM, Kevin Wolf wrote:

>>> +@item force-share
>>> +Override the image locking system of QEMU and force the node to allowing
>>> +sharing all permissions with other uses.
>>
>> Grammar nit: "to allow sharing"; but maybe the phrasing could
>> be clarified anyway -- I'm not entirely sure what 'sharing
>> permissions" would be. The first part of the sentence suggests
>> this option is "force the image file to be opened even if some
>> other QEMU instance has it open already", but the second half
>> soudns like "don't lock the image, so that some other use later
>> is allowed to open it" ? Or is it both, or something else?
> 
> It's more the latter. Open the image file and allow other instances to
> have it open as well (existing and future instances), but still error
> out if the other instance doesn't allow sharing.
> 
> I'm open for suggestions on how to phrase this better.

Here's a shot (although I'm not 100% certain I've captured the nuances 
correctly):

Override the image locking system of QEMU by forcing the node to utilize 
weaker shared access for permissions where it would normally request 
exclusive access.  When there is the potential for multiple instances to 
have the same file open (whether this invocation of qemu is the first or 
the second instance), both instances must permit shared access for the 
second instance to succeed at opening the file.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

