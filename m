Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315BDC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6676620725
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 15:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+BM5Ot9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6676620725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYWI5-0002VL-2r
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 11:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kYWGz-0001bT-MB
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21300)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kYWGx-000091-3O
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 11:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604071498;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JjxdNJZN9vTwED8skXnPPG/hlG7mAirMyQBeWztyzKg=;
 b=W+BM5Ot9JWW03jbFO/lLa7oL5A733GCCxATAJh/12f//GelQ8r9Hx3aCDbrCnfo+NF29KN
 eqG4QzBd43OunIunQiqZu/aptDmo2Nqwqm1EJ41YDkioRZkqMDO79epIfZ+KtQoQsMEquq
 xc+FnkEpBCJ7EokgygKbAOd2YwB8SGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-1a6dZym_PKe-pA2Ae7qvwA-1; Fri, 30 Oct 2020 11:24:56 -0400
X-MC-Unique: 1a6dZym_PKe-pA2Ae7qvwA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C344818B9F0C;
 Fri, 30 Oct 2020 15:24:54 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-87.ams2.redhat.com [10.36.113.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 199B255772;
 Fri, 30 Oct 2020 15:24:53 +0000 (UTC)
Subject: Re: [PATCH] configure: surface deprecated targets in the help output
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20201029201449.6926-1-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <77fa0da6-ff0a-de8c-6ba1-a74fbf44dcb5@redhat.com>
Date: Fri, 30 Oct 2020 16:24:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201029201449.6926-1-alex.bennee@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 01:22:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.253, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/10/2020 21.14, Alex Bennée wrote:
> Show the targets but keep them separate from the main list.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 55e07c82dd..6c2e9ff37c 100755
> --- a/configure
> +++ b/configure
> @@ -1644,9 +1644,11 @@ Standard options:
>    --prefix=PREFIX          install in PREFIX [$prefix]
>    --interp-prefix=PREFIX   where to find shared libraries, etc.
>                             use %M for cpu name [$interp_prefix]
> -  --target-list=LIST       set target list (default: build everything)
> +  --target-list=LIST       set target list (default: build all non-deprecated)
>  $(echo Available targets: $default_target_list | \
>    fold -s -w 53 | sed -e 's/^/                           /')
> +$(echo Deprecated targets: $deprecated_targets_list | \
> +  fold -s -w 53 | sed -e 's/^/                           /')
>    --target-list-exclude=LIST exclude a set of targets from the default target-list
>  
>  Advanced options (experts only):
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


