Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7770DC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:46:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F98D22204
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 12:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Puzrk+5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F98D22204
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGiRR-0005Ba-2t
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 08:46:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36934)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGiPJ-0003ST-Qf
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 08:44:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28160)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kGiPI-0002Zc-Av
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 08:44:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599828239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pgFi1YMJfjaYvczneVY0JAwxPndzFObGCVw84IKkvfg=;
 b=Puzrk+5pLKa5ZeGcCMFJuzg9S7DSYrSTNeTBtsPieCEH3Hxf4b30a0Hk3xzfUoeYkAnqNb
 fVFkkgaMePwEDFz6kJ63Zjvckma36QXiDtHce2g3J/qhU0EOgOU8M00JMn1NPZBqORwPBD
 sU4vD5VswFg3LGkAU8xmMu2A3zOmZgc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-h2w3smUBNSGZwn975_PR1w-1; Fri, 11 Sep 2020 08:43:55 -0400
X-MC-Unique: h2w3smUBNSGZwn975_PR1w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 262B581F02E;
 Fri, 11 Sep 2020 12:43:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-115-1.ams2.redhat.com [10.36.115.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 19C9260C15;
 Fri, 11 Sep 2020 12:43:35 +0000 (UTC)
Subject: Re: [PATCH] cphp: remove deprecated cpu-add command(s)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200911123329.938221-1-imammedo@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5b5c027e-8f9f-8949-b8c2-7b1a05d98a1e@redhat.com>
Date: Fri, 11 Sep 2020 14:43:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200911123329.938221-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/11 08:18:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.469, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: lvivier@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 libvir-list@redhat.com, cohuck@redhat.com, david@redhat.com,
 dgilbert@redhat.com, armbru@redhat.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

What does cphp in the subject mean?

On 11/09/2020 14.33, Igor Mammedov wrote:
> theses were deprecatedince since 4.0, remove both HMP and QMP variants.

deprecated since

> Users should use device_add commnad instead. To get list of

command

> possible CPUs and options, use 'info hotpluggable-cpus' HMP
> or query-hotpluggable-cpus QMP command.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/boards.h         |   1 -
>  include/hw/i386/pc.h        |   1 -
>  include/monitor/hmp.h       |   1 -
>  docs/system/deprecated.rst  |  25 +++++----
>  hmp-commands.hx             |  15 ------
>  hw/core/machine-hmp-cmds.c  |  12 -----
>  hw/core/machine-qmp-cmds.c  |  12 -----
>  hw/i386/pc.c                |  27 ----------
>  hw/i386/pc_piix.c           |   1 -
>  hw/s390x/s390-virtio-ccw.c  |  12 -----
>  qapi/machine.json           |  24 ---------
>  tests/qtest/cpu-plug-test.c | 100 ++++--------------------------------
>  tests/qtest/test-hmp.c      |   1 -
>  13 files changed, 21 insertions(+), 211 deletions(-)

With the typos fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


