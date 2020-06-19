Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D38EC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58E5C20EDD
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HDmr4ght"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58E5C20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmMJZ-00025q-Hr
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 15:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jmMIF-0001MQ-3G
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:03:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57850
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jmMI7-0007F9-8n
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:03:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592593385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=DtHh8A8GGmc6VjjW4y8c7Ua7sbPKZcsqeJuONW2nn7s=;
 b=HDmr4ghtvYi096Mez9IPJ8APT8AUCwfF96r4BEbZkJjb6G+yvO/dWObdRC2tT87qpksgmZ
 m83v3WO+gAiiVKtIVBu0jcxEKoSW/+EqjCGUdaAhZvBkRQysvqkHhuhPIAsBBNwsAFU3IU
 DSJ6x1iCeRxlW68/a2JLsEY1WF5iaCc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-kHlNkMdkPEily9IPrJi4eA-1; Fri, 19 Jun 2020 15:03:02 -0400
X-MC-Unique: kHlNkMdkPEily9IPrJi4eA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5F10380B722;
 Fri, 19 Jun 2020 19:03:01 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-47.ams2.redhat.com [10.36.112.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DF485C1D0;
 Fri, 19 Jun 2020 19:02:59 +0000 (UTC)
Subject: Re: [PATCH] Deprecate TileGX port
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20200619154831.26319-1-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a510ec49-6883-b779-6ebc-109e5e4d1309@redhat.com>
Date: Fri, 19 Jun 2020 21:02:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200619154831.26319-1-peter.maydell@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 02:45:39
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
Cc: Chen Gang <chengang@emindsoft.com.cn>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/06/2020 17.48, Peter Maydell wrote:
> Deprecate our TileGX target support:
>  * we have no active maintainer for it
>  * it has had essentially no contributions (other than tree-wide cleanups
>    and similar) since it was first added
>  * the Linux kernel dropped support in 2018, as has glibc
> 
> Note the deprecation in the manual, but don't try to print a warning
> when QEMU runs -- printing unsuppressable messages is more obtrusive
> for linux-user mode than it would be for system-emulation mode, and
> it doesn't seem worth trying to invent a new suppressible-error
> system for linux-user just for this.

I wonder whether anybody will notice the deprecation note in the manual
only, though. If we want to find out whether there are still any users
left, I think printing an unsuppressable message would be better... or
maybe something like:

    if (!getenv("QEMU_SUPPRESS_TILEGX_DEPRECATION_WARNING")) {
        fprintf(stderr, "Warning: TileGX CPU support is deprecated and "
                        "will be removed soon!\n"
                        "Set QEMU_SUPPRESS_TILEGX_DEPRECATION_WARNING "
                        "environment variable to hide this warning.");
    }

?

> diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
> index 3a255591c34..e9097e089bb 100644
> --- a/docs/system/deprecated.rst
> +++ b/docs/system/deprecated.rst
> @@ -387,6 +387,17 @@ The above, converted to the current supported format::
>  
>    json:{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"}
>  
> +linux-user mode CPUs
> +--------------------
> +
> +``tilegx`` CPUs (since 5.1.0)
> +'''''''''''''''''''''''''''''
> +
> +The ``tilegx`` guest CPU support (which was only implemented in
> +linux-user mode) is deprecated and will be removed in a future version
> +of QEMU. Support for this CPU was removed from the upstream Linux
> +kernel in 2018, and has also been dropped from glibc.

Reviewed-by: Thomas Huth <thuth@redhat.com>


