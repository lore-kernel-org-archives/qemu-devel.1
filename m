Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86668C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:19:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5753620720
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 18:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyeD7OVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5753620720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Bdo-0001aI-I0
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 14:19:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k9Bd9-00019H-7y
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 14:19:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26710)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k9Bd6-00080j-Jy
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 14:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598033946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QmAwDxeH6y+1PlDcnXMoltyBx7SHRttrBJeDXoUOs0U=;
 b=UyeD7OVQiWDbW09N+jaIDSaXGWe7+tbv8c04tjT1U5P2rka7oC6PZ221cP5g+mw462sxWC
 /7s7GfhxjRqnqzEqdiBCIVb+W9VvUHvLF2SO6FuelSGdUI1TuMxps2DHucOvm0uAXbdESt
 qhGqE+yCKq3AE8bd90xkbCbpS5vTsyc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-ZHI2v-taPKCdHDnkpPIcOQ-1; Fri, 21 Aug 2020 14:19:03 -0400
X-MC-Unique: ZHI2v-taPKCdHDnkpPIcOQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8AAB10ABDA0;
 Fri, 21 Aug 2020 18:18:58 +0000 (UTC)
Received: from [10.3.113.76] (ovpn-113-76.phx2.redhat.com [10.3.113.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58BD17A40B;
 Fri, 21 Aug 2020 18:18:55 +0000 (UTC)
Subject: Re: [PATCH v2] configure: silence 'shift' error message in
 version_ge()
To: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20200821163312.98184-1-sgarzare@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <27abc546-0edc-caa1-32be-ac5d6cff79e4@redhat.com>
Date: Fri, 21 Aug 2020 13:18:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200821163312.98184-1-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 02:43:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/21/20 11:33 AM, Stefano Garzarella wrote:
> If there are less than 2 arguments in version_ge(), the second
> 'shift' prints this error:
>      ../configure: line 232: shift: shift count out of range
> 
> Let's skip it if there are no more arguments.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v2:
> - do not shift if there are no more arguments [Peter]
> ---
>   configure | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index 4e5fe33211..5f5f370e2c 100755
> --- a/configure
> +++ b/configure
> @@ -229,7 +229,7 @@ version_ge () {
>           set x $local_ver1
>           local_first=${2-0}
>           # shift 2 does nothing if there are less than 2 arguments
> -        shift; shift
> +        shift; test $# -gt 0 && shift


That works.  Or you could go with the shorter one-liner:

shift ${2:+2}

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


