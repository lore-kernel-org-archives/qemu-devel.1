Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75926C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D87B208C3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 13:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqCBerrg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D87B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlYWF-0000O2-H9
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 09:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlYVC-0007Vu-Mo
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:53:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55457
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jlYVB-00005x-2t
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 09:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592401996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WhB55h8sw8siX8zZdzsjZFbJox7P0UEspBJ1XKKB1x4=;
 b=fqCBerrger1KPelt0rNULp1xi+nnnDgoi0w3Ew5hXYFWzZqfH1k935pQ4P8RiaQzsxhPrs
 FE+NviqUpRy2wxkI3L4TitgB5HkSp/VJk2h2Dlka/1/GoIgv/fTrMvd7vIPNBG5Mo64/2q
 6JbenVX5/kLnr/wwGU9NUMN+kOaZX78=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-oyFOiP9fNQipl5CyEl1U0w-1; Wed, 17 Jun 2020 09:53:14 -0400
X-MC-Unique: oyFOiP9fNQipl5CyEl1U0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EC39100CC8B;
 Wed, 17 Jun 2020 13:53:13 +0000 (UTC)
Received: from [10.3.112.27] (ovpn-112-27.phx2.redhat.com [10.3.112.27])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7679C512FE;
 Wed, 17 Jun 2020 13:53:12 +0000 (UTC)
Subject: Re: [PATCH 0/3] Add Scripts for Finding Top 25 Executed Functions
To: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, qemu-devel@nongnu.org,
 rth@twiddle.net, aleksandar.qemu.devel@gmail.com, alex.bennee@linaro.org,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <1944be57-7253-c3d5-737c-16537e1e71ac@redhat.com>
Date: Wed, 17 Jun 2020 08:53:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/16/20 6:12 PM, Ahmed Karaman wrote:
> Greetings,
> 
> As a part of the TCG Continous Benchmarking project for GSoC this
> year, detailed reports discussing different performance measurement
> methodologies and analysis results will be sent here on the mailing
> list.
> 
> The project's first report is currently being revised and will be
> posted on the mailing list in the next few days.
> A section in this report will deal with measuring the top 25 executed
> functions when running QEMU. It includes two Python scripts that
> automatically perform this task.
> 
> This series adds these two scripts to a new performance directory
> created under the scripts directory. It also adds a new
> "Miscellaneous" section to the end of the MAINTAINERS file with a
> "Performance Tools and Tests" subsection.
> 
> Best regards,
> Ahmed Karaman
> 
> Ahmed Karaman (3):
>    MAINTAINERS: Add 'Miscellaneous' section
>    scripts/performance: Add callgrind_top_25.py script
>    scripts/performance: Add perf_top_25.py script
> 
>   MAINTAINERS                             |  7 ++
>   scripts/performance/callgrind_top_25.py | 95 +++++++++++++++++++++++++
>   scripts/performance/perf_top_25.py      | 82 +++++++++++++++++++++
>   3 files changed, 184 insertions(+)
>   create mode 100644 scripts/performance/callgrind_top_25.py
>   create mode 100644 scripts/performance/perf_top_25.py

Are the new scripts supposed to have executable permissions, or are they 
always invoked as 'python path/to/script.py' where the executable bit is 
less important?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


