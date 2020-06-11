Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50785C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:27:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164C22065C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:27:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvuAs3sW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164C22065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOAV-0003R1-0Q
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jjO9O-0002yk-Ff
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:25:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24869
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jjO9L-0008Fu-UF
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591885545;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EHHdQXmdBCUgn4az2FgZq2kxcC2IyeSQjqW14EtMlSM=;
 b=TvuAs3sWEMU9vZiwYpIgWNKFwwRnS83a9al2Kmzkj3mVOZwp37U483sKuDqcQxtN+aeX9j
 pmm6HYh12PcruE3sElcEjJI6yCWhZblOvhQauhFWWTIWWkZBINdykXaJHu6FpuEq1UphQE
 6kNM3u1INyWtD+0z6epzh+bhUD2Ar+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-ODSV_axGPKqdpiAD2upb6A-1; Thu, 11 Jun 2020 10:25:41 -0400
X-MC-Unique: ODSV_axGPKqdpiAD2upb6A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AADD1845167;
 Thu, 11 Jun 2020 14:25:41 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C3F655C3F8;
 Thu, 11 Jun 2020 14:25:40 +0000 (UTC)
Subject: Re: [PATCH v2 3/5] configure: Clean up warning flag lists
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200610203942.887374-1-richard.henderson@linaro.org>
 <20200610203942.887374-4-richard.henderson@linaro.org>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <61557057-f4be-9a74-1422-3dee74be7f03@redhat.com>
Date: Thu, 11 Jun 2020 09:25:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200610203942.887374-4-richard.henderson@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 6/10/20 3:39 PM, Richard Henderson wrote:
> Use a helper function to tidy the assembly of gcc_flags.
> Separate flags that disable warnings from those that enable,
> and sort the disable warnings to the end.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configure | 40 ++++++++++++++++++++++++++++++----------
>   1 file changed, 30 insertions(+), 10 deletions(-)
> 

> +# Accumulate -Wfoo and -Wno-bar separately.
> +# We will list all of the enable flags first, and the disable flags second.
> +# Note that we do not add -Werror, because that would enable it for all
> +# configure tests. If a configure test failed due to -Werror this would
> +# just silently disable some features, so it's too error prone.
> +
> +add_to warn_flags -Wold-style-declaration

Hmm - should we add:
warn_flags= nowarn_flags=
prior to this line, to ensure that something inherited from the 
environment doesn't mess us up.

> +add_to warn_flags -Wold-style-definition
> +add_to warn_flags -Wtype-limits
> +add_to warn_flags -Wformat-security
> +add_to warn_flags -Wformat-y2k
> +add_to warn_flags -Winit-self
> +add_to warn_flags -Wignored-qualifiers
> +add_to warn_flags -Wempty-body
> +add_to warn_flags -Wnested-externs
> +add_to warn_flags -Wendif-labels
> +add_to warn_flags -Wno-initializer-overrides

wrong list

> +add_to warn_flags -Wexpansion-to-defined
> +
> +add_to nowarn_flags -Wno-missing-include-dirs
> +add_to nowarn_flags -Wno-shift-negative-value
> +add_to nowarn_flags -Wno-string-plus-int
> +add_to nowarn_flags -Wno-typedef-redefinition
> +
> +gcc_flags="$warn_flags $nowarn_flags"

Otherwise looks sane.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


