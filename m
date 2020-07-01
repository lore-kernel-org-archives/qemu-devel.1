Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8E7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FA820702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTOfXM2k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FA820702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqdTD-0003OF-5s
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jqdGM-0005DV-O1
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:58:58 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55665
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jqdGJ-00060d-Dy
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 09:58:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593611934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tgYA0EHWFAwvu5qD3dGgus0fxbYOJdihA03XD/r08Xo=;
 b=XTOfXM2k3WTWcvGucfvJMBjNExEhSfZ2gdO//ZyHuSDXrTZDfZF5VLDeMVQUeLJ9tVKFsW
 DcVb4snNqP126FuTfLSzeyOyqHJ4HOK6wVQU2zgWXG2iGArpU3zx6J+beGK/jKI8z69vW9
 7yzBtx523hoiGWkkUlGmcwiB6Ed4L3k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-ptOgUm01MtS4JP0IBOdWag-1; Wed, 01 Jul 2020 09:58:53 -0400
X-MC-Unique: ptOgUm01MtS4JP0IBOdWag-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11030107B7CB;
 Wed,  1 Jul 2020 13:58:52 +0000 (UTC)
Received: from [10.3.114.107] (ovpn-114-107.phx2.redhat.com [10.3.114.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C210819C79;
 Wed,  1 Jul 2020 13:58:51 +0000 (UTC)
Subject: Re: [PATCH 1/9] Enabling BSD symbols
To: David CARLIER <devnexen@gmail.com>, QEMU Trivial
 <qemu-trivial@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>
References: <CA+XhMqxuYwkJLbCRZpAM7pM14CbLzx3BZ=n6FW14cg344xsFJA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <23df1820-03c8-1810-4315-b533b2c1e09b@redhat.com>
Date: Wed, 1 Jul 2020 08:58:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CA+XhMqxuYwkJLbCRZpAM7pM14CbLzx3BZ=n6FW14cg344xsFJA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/29/20 4:48 PM, David CARLIER wrote:
>>From 5c6022f21289eb6e78e93d584c766db82165dced Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Mon, 29 Jun 2020 22:13:35 +0000
> Subject: [PATCH 1/9] Enabling BSD symbols.

Suggestion for the title:

build: Enable BSD symbols for Haiku

Rationale for that suggestion: most commits start with a category (here, 
'build:' is a nice catch-all, since you are improving the build for a 
given platform).  We tend to avoid trailing '.' in the subject.  And 
mentioning which platform is affected is useful for someone browsing 
one-line summaries to know the scope of theh change.

Also, this message (and the rest of the series) came through as a 
top-level thread, rather than in-reply-to the 0/9 message.  That makes 
it harder to track the changes as a group.

> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>   configure | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/configure b/configure
> index 4a22dcd563..d81931ba5e 100755
> --- a/configure
> +++ b/configure
> @@ -903,8 +903,8 @@ SunOS)
>   ;;
>   Haiku)
>     haiku="yes"
> -  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS $QEMU_CFLAGS"
> -  LIBS="-lposix_error_mapper -lnetwork $LIBS"
> +  QEMU_CFLAGS="-DB_USE_POSITIVE_POSIX_ERRORS -DBSD_SOURCE $QEMU_CFLAGS"
> +  LIBS="-lposix_error_mapper -lnetwork -lbsd $LIBS"
>   ;;
>   Linux)
>     audio_drv_list="try-pa oss"
> --
> 2.26.0
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


