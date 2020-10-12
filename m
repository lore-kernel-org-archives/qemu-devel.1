Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E1FC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36DEF20776
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 09:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QBn5Puo1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DEF20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRuSL-0003X2-Q7
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 05:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43388)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRuQP-00023f-Aw
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:47:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24494)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kRuQM-0001QX-UW
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 05:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602496042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DORu/2dEgR15H323oG1TDNnVoQdu2cxlBC0nuYBTL9E=;
 b=QBn5Puo1gYQ/Cc4Yb5XYPBKRDKql/Y9zNWgWjt7tUEhSOmvle5uhlFJkVC2lMDdgf5QXfe
 /VaYydMi0xKI2V593I2nWwmRAmFHAacTUhXdRKvpBNjQtUkYOZTQZHCV6Vo35i4GDOFPpz
 w0zae8k0bE3ZvWkSYUS37DFjH4I+UJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-lvBjJhz-MZqCOti74C1uCw-1; Mon, 12 Oct 2020 05:47:19 -0400
X-MC-Unique: lvBjJhz-MZqCOti74C1uCw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 54AE91800D42;
 Mon, 12 Oct 2020 09:47:18 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 343925D9CD;
 Mon, 12 Oct 2020 09:47:16 +0000 (UTC)
Subject: Re: [PATCH v2 2/4] Makefile: Require GNU make 3.82+
To: Roman Bolshakov <r.bolshakov@yadro.com>, qemu-devel@nongnu.org
References: <20200825202755.50626-1-r.bolshakov@yadro.com>
 <20200825202755.50626-3-r.bolshakov@yadro.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <1ff85cc3-40dc-98da-fb18-a1b3d134d7dc@redhat.com>
Date: Mon, 12 Oct 2020 11:47:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200825202755.50626-3-r.bolshakov@yadro.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 23:52:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/08/2020 22.27, Roman Bolshakov wrote:
> QEMU build fails with cryptic messages if make is too old:
> 
>   Makefile.ninja:2655: *** multiple target patterns.  Stop.
> 
> To avoid the confusion it's worth to fail the build right away and print
> a friendly error message.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Roman Bolshakov <r.bolshakov@yadro.com>
> ---
>  Makefile | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 81794d5c34..b4ebf3e30f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -4,6 +4,11 @@ ifneq ($(words $(subst :, ,$(CURDIR))), 1)
>    $(error main directory cannot contain spaces nor colons)
>  endif
>  
> +ifeq ($(filter undefine,$(value .FEATURES)),)
> +$(error Unsupported Make version: $(MAKE_VERSION). \
> +        Please use GNU Make 3.82 or above)
> +endif
> +
>  # Always point to the root of the build tree (needs GNU make).
>  BUILD_DIR=$(CURDIR)

Reviewed-by: Thomas Huth <thuth@redhat.com>


