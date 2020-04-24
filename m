Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86FEC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1ED2075A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 14:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PLBGApxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1ED2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRyzB-0004dv-2m
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 10:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRyyD-00043T-71
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jRyyC-0007uI-1Q
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:06:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43365
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jRyy6-0007qt-Qp
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 10:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587737173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aJYVpNDpL+OS6Hw9FsGjZoYm5tlwLTuHzVGt+wtMqZ8=;
 b=PLBGApxisIM9pLj1kMpmDkuYk+2D5KGvWLiChMLcVJP7Ljpq3h7VGdWYPQ7IQUCyanSmf8
 lE6aWuuYqxqjtTc8bxsxic9c/gZkaUhenlMxw13sJIYWy0U09FNOQVElUsYBWpub3rEY0f
 6O6hIKFZW2U85RHsCce1GflxTy6OEuo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-tVw0WEG5N6-f3p68OpVwuw-1; Fri, 24 Apr 2020 10:06:05 -0400
X-MC-Unique: tVw0WEG5N6-f3p68OpVwuw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71DA718A0734;
 Fri, 24 Apr 2020 14:06:04 +0000 (UTC)
Received: from [10.10.116.80] (ovpn-116-80.rdu2.redhat.com [10.10.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 21F7E60C05;
 Fri, 24 Apr 2020 14:06:03 +0000 (UTC)
Subject: Re: [PATCH v2 00/15] qapi: Spring cleaning
To: qemu-devel@nongnu.org, no-reply@patchew.org, armbru@redhat.com
References: <158772281333.22435.14973289862380467538@39012742ff91>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7d8af612-1e74-035f-bfbc-f4bc8345cf89@redhat.com>
Date: Fri, 24 Apr 2020 09:06:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158772281333.22435.14973289862380467538@39012742ff91>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 02:57:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/24/20 5:06 AM, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200424084338.26803-1-armbru@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> make docker-image-centos7 V=1 NETWORK=1
> time make docker-test-quick@centos7 SHOW_ENV=1 J=14 NETWORK=1
> === TEST SCRIPT END ===
> 
> -...........................
> +........................E..
> +======================================================================
> +ERROR: test_stream_pause (__main__.TestSingleDrive)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> +  File "030", line 93, in test_stream_pause

Not sure how this would be related to your series, or if it is a 
spurious flakiness in the test that just chose to hit now.  iotest 30 is 
passing fine for me even with your series applied.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


