Return-Path: <SRS0=SOuJ=D7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9D1C2D0A3
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 05:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 608402225F
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2020 05:35:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="az1LD394"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 608402225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWCD0-0003SU-6G
	for qemu-devel@archiver.kernel.org; Sat, 24 Oct 2020 01:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWCCL-0002r3-Oa
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 01:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:58304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWCCK-0000c1-1u
 for qemu-devel@nongnu.org; Sat, 24 Oct 2020 01:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603517674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LVRtNw4D5HTKpjJUcJRv0V5nzhIcW2QoXRWLTfJSAJM=;
 b=az1LD3945iHj7BLEJX3biRUzkqGP2S6mrWD5ln8/l8OstA58zckWpgPeJO+kJeNz3/LiOu
 Z0dh0nuV+6OnrRQ1iXtgVY77b428t0H4UzVqQzpCf4RHBIAijIVk6KHFsQ7iA5bQV7eXxc
 52aeh3ISy+BLAVNkpdZbs1MNf8g5ngo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-CHCVL9iANrqZ6SgMY3Bt8w-1; Sat, 24 Oct 2020 01:34:32 -0400
X-MC-Unique: CHCVL9iANrqZ6SgMY3Bt8w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5A6E5F9EE;
 Sat, 24 Oct 2020 05:34:31 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-13.ams2.redhat.com [10.36.112.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DFAB5D9D5;
 Sat, 24 Oct 2020 05:34:24 +0000 (UTC)
Subject: Re: [PATCH 1/4] qdev: Fix two typos
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20201019163702.471239-1-mlevitsk@redhat.com>
 <20201019163702.471239-2-mlevitsk@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ce809c9e-c6ad-2d4b-a186-d32ab79213ef@redhat.com>
Date: Sat, 24 Oct 2020 07:34:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201019163702.471239-2-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/24 01:26:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.108, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/2020 18.36, Maxim Levitsky wrote:
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  include/hw/qdev-core.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 868973319e..3761186804 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -163,8 +163,8 @@ struct NamedClockList {
>  /**
>   * DeviceState:
>   * @realized: Indicates whether the device has been fully constructed.
> - *            When accessed outsize big qemu lock, must be accessed with
> - *            atomic_load_acquire()
> + *            When accessed outside big qemu lock, must be accessed with
> + *            qatomic_load_acquire()
>   * @reset: ResettableState for the device; handled by Resettable interface.
>   *
>   * This structure should not be accessed directly.  We declare it here
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


