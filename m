Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883BAC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DFC20679
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 14:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NUngThyV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DFC20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgU7s-0007mX-Kc
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 10:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58658)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgU7B-0007JL-1z
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:11:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29337
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jgU7A-0008IQ-8y
 for qemu-devel@nongnu.org; Wed, 03 Jun 2020 10:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591193491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DENMzCplHi4KrQ8Fk1bq5AeMR2riwfoVVjAkW75cRYA=;
 b=NUngThyVLEIV3VIupCfUEi6OiWnS7gB1VWO2FFzLqFg853ORdvh79yCS7G7ZL6ExAf8jEv
 /0YfJvXhvjCpxaZS85UmIAGkZhEZ63aqBhuAwix5HkhDZlotepJkbWVM171XlxNANIOQZh
 RC6ceUzI5CLBMfUT/lRpO7sMz/mLBaI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-RtJE1CXpN821pp7x19gmHg-1; Wed, 03 Jun 2020 10:11:23 -0400
X-MC-Unique: RtJE1CXpN821pp7x19gmHg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A5BE1009618;
 Wed,  3 Jun 2020 14:11:20 +0000 (UTC)
Received: from [10.3.113.22] (ovpn-113-22.phx2.redhat.com [10.3.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE6AB6C77C;
 Wed,  3 Jun 2020 14:11:19 +0000 (UTC)
Subject: Re: [PATCH 1/2] Introduce (x86) CPU model deprecation API
To: Robert Hoo <robert.hu@linux.intel.com>, pbonzini@redhat.com,
 rth@twiddle.net, ehabkost@redhat.com, armbru@redhat.com
References: <1591184823-140846-1-git-send-email-robert.hu@linux.intel.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <70e5d2d1-8bd0-5582-4f8f-066824a7d263@redhat.com>
Date: Wed, 3 Jun 2020 09:11:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1591184823-140846-1-git-send-email-robert.hu@linux.intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/03 01:04:34
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
Cc: robert.hu@intel.com, xiaoyao.li@intel.com, qemu-devel@nongnu.org,
 chenyi.qiang@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/20 6:47 AM, Robert Hoo wrote:
> Complement versioned CPU model framework with the ability of marking some
> versions deprecated. When that CPU model is chosen, get some warning. The
> warning message is customized, e.g. telling in which future QEMU version will
> it be obsoleted.
> The deprecation message will also appear by x86_cpu_list_entry(), e.g. '-cpu
> help'.
> QMP 'query-cpu-definitions' will also return a bool value indicating the
> deprecation status.
> 
> Signed-off-by: Robert Hoo <robert.hu@linux.intel.com>
> ---
>   exec.c                   |  3 +++
>   include/hw/core/cpu.h    |  1 +
>   qapi/machine-target.json |  3 ++-
>   target/i386/cpu.c        | 45 +++++++++++++++++++++++++++++++++++++++++++--
>   4 files changed, 49 insertions(+), 3 deletions(-)

> +++ b/qapi/machine-target.json
> @@ -309,7 +309,8 @@
>               'static': 'bool',
>               '*unavailable-features': [ 'str' ],
>               'typename': 'str',
> -            '*alias-of' : 'str' },
> +            '*alias-of' : 'str',
> +            'deprecated' : 'bool' },

Missing documentation of the new member.  Should it be optional (present 
only when true)?

> @@ -1638,6 +1639,11 @@ struct X86CPUModel {
>        * This matters only for "-cpu help" and query-cpu-definitions
>        */
>       bool is_alias;
> +    /*
> +     * If true, this is deprecated and obsoleted in the future.
> +     * Trying to use deprecated CPU model shall be warned.

If true, this model is deprecated, and may be removed in the future. 
Trying to use it now will cause a warning.

> +     */
> +    bool deprecated;
>   };
>   


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


