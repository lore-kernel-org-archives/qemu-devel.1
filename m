Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D75C433E7
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:53:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C612224E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 20:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzxAY7cp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C612224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSnm0-000423-Ub
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 16:53:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59046)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kSnkm-0003PU-MG
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:52:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28474)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kSnkk-0004Yc-QA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 16:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602708724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F2NYo+pOE6KCrj2aeA32Zfs6QFh57LeSmw2AVEcKEFs=;
 b=dzxAY7cp0s7X5kmSbHEMiWALHuBnl7MMIMa60NtS6FTJ3V3yKId6ziDzWn2zB66OoPDT5t
 IP90uOMFhksiKfLV/DHUnyxIKjSZND1NB2B1D7dFecCcQ23vT3XQJTf6YpyIZqSCKFvgiE
 fEK16hs/xuPTngZxGqFLB/8L6PFe7so=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-O2XgDzsJPK-z4xPuodN2-A-1; Wed, 14 Oct 2020 16:52:03 -0400
X-MC-Unique: O2XgDzsJPK-z4xPuodN2-A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 845C41006716;
 Wed, 14 Oct 2020 20:52:01 +0000 (UTC)
Received: from [10.10.117.231] (ovpn-117-231.rdu2.redhat.com [10.10.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49F2576649;
 Wed, 14 Oct 2020 20:51:53 +0000 (UTC)
Subject: Re: [PATCH v2 04/15] python: add directory structure README.rst files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20201014142957.763624-1-jsnow@redhat.com>
 <20201014142957.763624-5-jsnow@redhat.com>
 <7e0232fc-d5e1-f0aa-1701-bbc6d95522d3@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <a6789691-503f-be11-9957-ed0297617a92@redhat.com>
Date: Wed, 14 Oct 2020 16:51:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7e0232fc-d5e1-f0aa-1701-bbc6d95522d3@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 01:12:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Ben Widawsky <ben@bwidawsk.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Rohit Shinde <rohit.shinde12194@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 2:05 PM, Philippe Mathieu-Daudé wrote:
> On 10/14/20 4:29 PM, John Snow wrote:
>> Add short readmes to python/, python/qemu/, and python/qemu/core that
>> explain the directory hierarchy. These readmes are visible when browsing
> 
> Maybe readmes -> READMEs
> 

If you want it to match the filename, "README files".

--js

> Otherwise:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
>> the source on e.g. gitlab/github and are designed to help new
>> developers/users quickly make sense of the source tree.
>>
>> They are not designed for inclusion in a published manual.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   python/README.rst           | 27 +++++++++++++++++++++++++++
>>   python/qemu/README.rst      |  8 ++++++++
>>   python/qemu/core/README.rst |  9 +++++++++
>>   3 files changed, 44 insertions(+)
>>   create mode 100644 python/README.rst
>>   create mode 100644 python/qemu/README.rst
>>   create mode 100644 python/qemu/core/README.rst
> 


