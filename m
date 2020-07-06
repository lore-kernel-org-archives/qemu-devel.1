Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F720C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C1EF20715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LUp2ISoP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C1EF20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsRds-0004V7-4X
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 09:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsRd1-0002py-5u
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:57:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50655
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jsRcz-0006W5-68
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:57:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594043868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CbqnCJZbYi6D6fugCDKuQNVaoA+0DYp093i/4Fj91GQ=;
 b=LUp2ISoPiGR3ap6Z1jjGF8H90KZYzi4J02jhQcFLaDy563y3BLSNGw3F/9FUcMq9RrIAtw
 K79bE7TubkwO/7v+g+5qwqeYT/e2ZPBl+OWkVsQKN/MbjLczOzvtGqIZVDuihLCOCYC5aO
 fJAddPUXB9y7sQRauEPpy1me7qz/A+M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-vhJZZcMINk-448-RQ2MzHA-1; Mon, 06 Jul 2020 09:57:46 -0400
X-MC-Unique: vhJZZcMINk-448-RQ2MzHA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C966461;
 Mon,  6 Jul 2020 13:57:45 +0000 (UTC)
Received: from [10.3.113.97] (ovpn-113-97.phx2.redhat.com [10.3.113.97])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C8B775BAC5;
 Mon,  6 Jul 2020 13:57:44 +0000 (UTC)
Subject: Re: [PATCH v9 34/34] iotests: Add tests for qcow2 images with
 extended L2 entries
To: Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>,
 qemu-devel@nongnu.org
References: <cover.1593342067.git.berto@igalia.com>
 <536717bef174a2d5405647bf9ecf899e0aafadbb.1593342067.git.berto@igalia.com>
 <2a791051-5967-0279-75a1-4a44817b83b3@redhat.com>
 <w51o8owwxvz.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <bb872fe3-e109-c415-dd83-1cabdc01665f@redhat.com>
Date: Mon, 6 Jul 2020 08:57:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <w51o8owwxvz.fsf@maestria.local.igalia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:59:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Derek Su <dereksu@qnap.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/20 8:06 AM, Alberto Garcia wrote:

>>> +    printf -v expected_bitmap "%llu" $expected_bitmap # Convert to unsigned
>>
>> Does the length modifier “ll” actually do anything?
>>
>>> +
>>> +    printf "L2 entry #%d: 0x%016lx %016lx\n" "$entry_no" "$entry" "$bitmap"
>>
>> Or the “l” here?
> 
> Actually they don't (I just tested in i386 and x86_64), I assumed that
> it would require the length modifiers like in C.
> 
> I'm tempted to leave them for clarity (using 'll' in both cases),
> opinions?

POSIX doesn't require support for modifiers; %d and %lld are the same 
even in 32-bit bash.  If this is a #!/bin/bash script, then use it for 
clarity; if it is #!/bin/sh, omit it for portability.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


