Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ABDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6F1C20704
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:09:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QH4TnZ+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6F1C20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT3wL-0003Rg-LR
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 10:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56668)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kT3n6-0003Fo-QZ
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:59:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kT3n0-0002y4-De
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 09:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602770368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/L1jdMZ/q+33CEbeSraBlu82lsmzzZEW1iStj1226Q=;
 b=QH4TnZ+l+wMFbLjYmmXdPuNsi3pbiRMauVYuD0Gk5DhQhPoe0HghXbKeuFPPqPkoG9J8Zg
 Ie862DgX91AS3va+uQeFohf5BJzPuZHF2P+iaMk2KA0qRk0xaibYF8oz3tN6iiLwPZBOTj
 w7ENlmVNp/Lpwgicl6ihU2KUNVn1LDU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-yY2vpd4-MNqDRkHbZ2CRTg-1; Thu, 15 Oct 2020 09:59:25 -0400
X-MC-Unique: yY2vpd4-MNqDRkHbZ2CRTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AC41A34861;
 Thu, 15 Oct 2020 13:59:24 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-184.ams2.redhat.com [10.36.113.184])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A25D078819;
 Thu, 15 Oct 2020 13:58:53 +0000 (UTC)
Subject: Re: [PATCH v5] Add a comment in bios-tables-test.c to clarify the
 reason behind approach
To: Ani Sinha <ani@anisinha.ca>
References: <20200929142501.1057-1-ani@anisinha.ca>
 <105B94CB-1345-49FB-B296-F5236E448BC3@anisinha.ca>
 <72e35a9d-21f4-095d-1ae9-9ed33842dd24@redhat.com>
 <CAARzgwyJ2Cy286wWoo6G+mMZbGQRVyChxEQV++oLpVY+_MOU+g@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ccc5797e-e3d0-6f73-27c2-cdc6c0878320@redhat.com>
Date: Thu, 15 Oct 2020 15:58:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAARzgwyJ2Cy286wWoo6G+mMZbGQRVyChxEQV++oLpVY+_MOU+g@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:10:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.019, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 mst@redhat.com, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 15/10/2020 13.28, Ani Sinha wrote:
> 
> 
> On Mon, Oct 12, 2020 at 19:43 Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> wrote:
> 
>     On 12/10/2020 16.07, Ani Sinha wrote:
>     > Request to queue this patch with the next pull.
> 
>     I can take it via qtest-next in case Michael / Igor do not plan to send a
>     pull request any time soon.
> 
> 
> Michael or Igor, care to comment?

FYI, patch got merged:

https://git.qemu.org/?p=qemu.git;a=commitdiff;h=07f5903c852de10fa7

 Thomas


