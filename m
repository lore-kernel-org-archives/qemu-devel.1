Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D78D2C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:48:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E61420724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 20:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGjtuPug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E61420724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9DxY-0001Hv-Ur
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 16:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k9Dwu-0000n4-Hz
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 16:47:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29132
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k9Dwr-0000nT-VZ
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 16:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598042860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Oe2lDGmZQgIfYP75ZxLxGdrnxFQPP+OVhkO5lD1+/+g=;
 b=IGjtuPugAu59btJrBX95Zv/BV/Av0vNd2oyMZDjSFq/rwTI13jK2bqA1WV2A/xkhfgoSnA
 Z3UmVxSGQUr/HutJwwccakk9TqUwalj9qL8a7o/O1pVKFgdWufRzK15qv5GVFcH7Eunyzl
 XqIOJkIAZUUbWy2aAKKt5iRBzl/VYiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-TK1oew9wPni2f3xFk5M0DA-1; Fri, 21 Aug 2020 16:47:36 -0400
X-MC-Unique: TK1oew9wPni2f3xFk5M0DA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E24BF1074657;
 Fri, 21 Aug 2020 20:47:35 +0000 (UTC)
Received: from [10.3.113.76] (ovpn-113-76.phx2.redhat.com [10.3.113.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3E1FB19728;
 Fri, 21 Aug 2020 20:47:32 +0000 (UTC)
Subject: Re: [PATCH v3] configure: silence 'shift' error message in
 version_ge()
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20200821203558.10338-1-sgarzare@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <4e0a1acb-29ff-8787-aa6b-173a35c0681c@redhat.com>
Date: Fri, 21 Aug 2020 15:47:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821203558.10338-1-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 23:41:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 3:35 PM, Stefano Garzarella wrote:
> If there are less than 2 arguments in version_ge(), the second
> 'shift' prints this error:
>      ../configure: line 232: shift: shift count out of range
> 
> As Eric suggested, we can use 'shift ${2:+2}' which works out to
> 'shift 2' if $2 is set, or 'shift' (implicitly shift 1) if $2
> is not set.
> 
> This patch replaces both 'shift; shift' occurrences in version_ge()
> with 'shift ${2:+2}'.
> 
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v3:
> - use Eric's one-liner solution
> v2:
> - do not shift if there are no more arguments [Peter]
> ---
>   configure | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>


-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


