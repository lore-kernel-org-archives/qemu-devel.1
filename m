Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A79AC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:47:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D929D206E2
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 21:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d3kNeUBu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D929D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfsHe-0002mY-3Z
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 17:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jfsGg-00024a-FJ
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:46:50 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24187
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jfsGf-0001yR-Oi
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 17:46:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591048008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k70J/xEql3whODOe8BWaChMUyeukc5me9BfrfA/Wy/k=;
 b=d3kNeUBuoWYuT071ttRU9lkXpvoulAE/xPssgwQQg+VfET9mam2KVFeoIu+Hg/08y+SoS/
 7CeacNDpVTLBf6iKZWgcb+WGdKo0Gkk/9HWcYFT++i6vIG/PNfRwEOMOOeVW2LtLNAF58O
 KTms61P2rGChgVXPbu3juDOJ80Z6RaU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-w-QVl25BMludBNobngXBkQ-1; Mon, 01 Jun 2020 17:46:41 -0400
X-MC-Unique: w-QVl25BMludBNobngXBkQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99E82809881;
 Mon,  1 Jun 2020 21:46:39 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9DA675C1D6;
 Mon,  1 Jun 2020 21:46:38 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] iotests: Dump QCOW2 dirty bitmaps metadata
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <0df8d1a7-6f72-48a2-0433-cdf1c5e97492@redhat.com>
Date: Mon, 1 Jun 2020 16:46:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591019293-211155-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 17:46:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 8:48 AM, Andrey Shinkevich wrote:
> Add dirty bitmap information to QCOW2 metadata dump in qcow2.py script.
> 
> v3:
>    01: JSON format output possibility added.

Also, you split it into a series.  Thanks; this makes it easier to 
review each step :)

> 
> v2:
>    01: Refactoring of the Python code in the script qcow2.py.
>        New methods were added. The bitmap dictionary was instantiated.
>        The all of bitmaps information is read completely before
>        printing the dictionary.
>    02: The outputs of the tests 031, 036 and 061 were modified.
> 
> Andrey Shinkevich (6):
>    iotests: Add extension names to qcow2.py dump
>    iotests: move check for printable data to QcowHeaderExtension class
>    iotests: dump bitmap extension data with qcow2.py
>    iotests: Dump bitmap directory info with qcow2.py
>    iotests: Dump bitmap table entries serialized in QCOW2 image
>    iotests: Dump QCOW2 image metadata in JSON format with qcow2.py
> 
>   tests/qemu-iotests/031.out  |  22 +--
>   tests/qemu-iotests/036.out  |   4 +-
>   tests/qemu-iotests/061.out  |  18 +--
>   tests/qemu-iotests/qcow2.py | 338 ++++++++++++++++++++++++++++++++++++++++++--
>   4 files changed, 346 insertions(+), 36 deletions(-)
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


