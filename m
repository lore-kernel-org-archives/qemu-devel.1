Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F674C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A079206A4
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 15:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGJC3PId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A079206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jegrS-0003be-EK
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 11:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jegq5-0002HE-0D
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:22:29 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39316
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1jegq4-0003wd-83
 for qemu-devel@nongnu.org; Fri, 29 May 2020 11:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590765747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kK5RZIgtCoSi0Irr4+IECtyk/JQBq9aX1/4KifSyNCY=;
 b=WGJC3PIdGXxM3yl6lGVp3c4ms9KIR+R8/FGOm2V4UuMmdKLYVUVKfKc6GVG6bK537cAboM
 QAKuEEaXXNeSgm1EPD/4/mpNZgXPCkOQ3NkKqpHfsNm83BmlAcBY2GPSXiCTfVtcJ0Vzb5
 SrN+QTgyO1WkR5dbpL1tR/XrdNBQSiA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-n6AwJfa8O2Kwj5b7S2RgMA-1; Fri, 29 May 2020 11:22:23 -0400
X-MC-Unique: n6AwJfa8O2Kwj5b7S2RgMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD4DB8AB380;
 Fri, 29 May 2020 15:22:22 +0000 (UTC)
Received: from [10.40.192.165] (unknown [10.40.192.165])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1F5D5D9EF;
 Fri, 29 May 2020 15:22:21 +0000 (UTC)
Subject: Re: [PATCH 2/3] numa: Allow HMAT cache to be defined before HMAT
 latency/bandwidth
To: Igor Mammedov <imammedo@redhat.com>
References: <cover.1590753455.git.mprivozn@redhat.com>
 <ecccd6ff03e14692a4b23f93cf9b0327e0c6bd5d.1590753455.git.mprivozn@redhat.com>
 <20200529165947.36a8cf55@redhat.com>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <182c849b-0f0f-9393-f1db-fba9bb885d6a@redhat.com>
Date: Fri, 29 May 2020 17:22:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200529165947.36a8cf55@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 4:59 PM, Igor Mammedov wrote:
> On Fri, 29 May 2020 15:33:47 +0200
> Michal Privoznik <mprivozn@redhat.com> wrote:
> 
>> Currently, when defining a HMAT cache for a NUMA node (in
>> parse_numa_hmat_cache()) there is this check that forces users to
>> define HMAT latency/bandwidth first. There is no real need for
>> this, because nothing in the parse function relies on that and
>> the HMAT table is constructed way later - when ACPI table is
>> constructed.
> 
> see comment in
>    https://lists.gnu.org/archive/html/qemu-devel/2019-11/msg01206.html
> 
> in short doing check at this time allow us not to have more complex
> check later on.
> 
> perhaps it needs a comment so that later it won't be dropped by accident

Fair enough. Discard this one then and I will post a patch that document 
this.

Michal


