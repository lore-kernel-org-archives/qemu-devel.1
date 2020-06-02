Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2CAC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:55:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321B4206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 21:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KSlQ30tD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321B4206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgEsO-0001Fe-Dl
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 17:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgEoe-0004As-LL
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:51:24 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23444
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgEod-0001ml-Gd
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 17:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591134682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E7PJIm+3ASGayDT6ooPCCApE3uiIVTPuTGeR1kI0F5o=;
 b=KSlQ30tD0a/4UXTJyVnzmBjLll6TX/dQnPp6eydBRro0auNpdVZf3QSIq7j/GKFkaoRW/B
 texdrUwsGo1RC0EN8hu+S6GPsRJP5Fx+jGw/qBCShXfKHtuPIiIms0Lix3oulUaESK/XXG
 YL1e+9bzfSmXpH2iY4IrtQvnxcZ35VM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-H9pIhTGBP2eBSP74Yr4zyQ-1; Tue, 02 Jun 2020 17:51:15 -0400
X-MC-Unique: H9pIhTGBP2eBSP74Yr4zyQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9DDE5464;
 Tue,  2 Jun 2020 21:51:14 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 105571BCBE;
 Tue,  2 Jun 2020 21:51:14 +0000 (UTC)
Subject: Re: [PATCH v2 00/16] python: add mypy support to python/qemu
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20200602214528.12107-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <da267698-75a7-1c2c-ea0c-cc95427233d3@redhat.com>
Date: Tue, 2 Jun 2020 16:51:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602214528.12107-1-jsnow@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 15:54:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 4:45 PM, John Snow wrote:
> Requires: 20200602194844.15258-1-jsnow@redhat.com

I don't know if patchew understand that, or if it requires:

Based-on: 20200602194844.15258-1-jsnow@redhat.com

> 
> This series is extracted from my larger series that attempted to bundle
> our python module as an installable module. These fixes don't require that,
> so they are being sent first as I think there's less up for debate in here.
> 
> This requires my "refactor shutdown" patch as a pre-requisite.
> 
> "v2":
> - This version supports iotests 297
> - Many patches merged by Phil are removed
> - Replaces iotests.py type aliases with centralized ones
>    (See patch 2)
> - Imports etc are reworked to use the non-installable
>    package layout instead. (Mostly important for patch 3)
> 
> Testing this out:
> - You'll need Python3.6+
> - I encourage you to use a virtual environment!
> - You don't necessarily need these exact versions, but I didn't test the
>    lower bounds, use older versions at your peril:
>    - pylint==2.5.0
>    - mypy=0.770
>    - flake8=3.7.8
> 
>> cd ~/src/qemu/python/
>> flake8 qemu
>> mypy --strict qemu
>> cd qemu
>> pylint *.py
> 
> These should all 100% pass.
> 
> ---
> 
> Open RFC: What's the right way to hook this into make check to prevent
> regressions?

We recently added iotest 297 in group meta; is there a way to run 
'./check -g meta' alongside the other iotests that 'make check' already 
triggers?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


