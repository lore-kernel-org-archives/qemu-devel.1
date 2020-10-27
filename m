Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB63C388F9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEFDA22456
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 17:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SVLFbSTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFDA22456
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXT7b-0007VE-E0
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 13:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXSxy-0003VJ-11
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:41:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38241)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kXSxv-00040p-Vz
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 13:41:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603820459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=48cTwl5cOMQMg1SRPCboFMsbZHNQfKW1VVWjUpv8DMo=;
 b=SVLFbSTEmXF5NWSH1MXq/Ml+tfzMSlVpPiSckEpF8z56VgSdS9HCFJ21+6BzKqVHEND5H9
 gXrzxjhrFVVagUHLbtMjhqIlz1YS0yopHTflC++xWRmHWpJIozD1F9haa22rTbLkjq9oyv
 wW21+6Vh72qrQh44U5kYnMrMKy8VLlw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-R7c5K5DaOZmlLuk2BHqsxA-1; Tue, 27 Oct 2020 13:40:56 -0400
X-MC-Unique: R7c5K5DaOZmlLuk2BHqsxA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A7DE101EBFE
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 17:40:55 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-115-35.ams2.redhat.com [10.36.115.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C66826EF51;
 Tue, 27 Oct 2020 17:40:54 +0000 (UTC)
Subject: Re: [qemu-web PATCH v2 01/16] Convert files to UNIX line endings
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20201027132015.621733-1-berrange@redhat.com>
 <20201027132015.621733-2-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f364f30f-2cd7-ab92-a2ed-8d2995c1418e@redhat.com>
Date: Tue, 27 Oct 2020 18:40:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201027132015.621733-2-berrange@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 27/10/2020 14.20, Daniel P. Berrangé wrote:
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  assets/css/style-desktop.css |  586 ++++++++---------
>  assets/css/style-mobile.css  |  750 ++++++++++-----------
>  assets/css/style.css         | 1184 +++++++++++++++++-----------------
>  index.html                   |  178 ++---
>  4 files changed, 1349 insertions(+), 1349 deletions(-)

git am complains:

.git/rebase-apply/patch:62: trailing whitespace.
	}	
.git/rebase-apply/patch:68: trailing whitespace.
	}	
.git/rebase-apply/patch:375: trailing whitespace.
	
.git/rebase-apply/patch:409: trailing whitespace.
	
.git/rebase-apply/patch:414: trailing whitespace.
	
warning: squelched 57 whitespace errors
warning: 62 lines add whitespace errors.

... so in case you respin, please fix these trailing whitespaces, too.

 Thomas


