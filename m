Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DEFBC433F4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFEC207FC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KEv73Pkl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFEC207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k03nU-0001vB-BS
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k03l4-0007Oo-13
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:05:38 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:25507
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k03l1-0005eJ-9f
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595858734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=rImtNr/P7oOyjiUw87bm4Cuj5xrJhLGoRjppvfWNwng=;
 b=KEv73PklVfBkqTORWUSkwucw5F3J2MhJmin+d8wOV1SE/rOAX1LrmJBjl3u04O2bKndMOs
 LHIjOobE3jiE5sakGKra+XG6iRpMNzMIKcG1bKXLiDTqqSAtI/wmK8vGjmcbTev0gS5H73
 dnjyu4mP2y2SjAfwnvJycdy7iOqzVTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-8w8s5OurMWa7QP0KM9GBlg-1; Mon, 27 Jul 2020 10:05:32 -0400
X-MC-Unique: 8w8s5OurMWa7QP0KM9GBlg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 344B31005504;
 Mon, 27 Jul 2020 14:05:31 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-156.ams2.redhat.com [10.36.112.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41C7671D0C;
 Mon, 27 Jul 2020 14:05:30 +0000 (UTC)
Subject: Re: [PATCH 0/3] configure: fix forSunOS based systems
To: David CARLIER <devnexen@gmail.com>, qemu-devel <qemu-devel@nongnu.org>
References: <CA+XhMqy95D8X-QvBcEfL=a-Rkgy6aJtheskkqZwQkreru+T_Wg@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <5ac1126a-2144-b94f-d892-0834e13727f7@redhat.com>
Date: Mon, 27 Jul 2020 16:05:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+XhMqy95D8X-QvBcEfL=a-Rkgy6aJtheskkqZwQkreru+T_Wg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi David,

On 18/07/2020 15.19, David CARLIER wrote:
> From 63a3c9639d708a796abd958607aa6376fc9b99f2 Mon Sep 17 00:00:00 2001
> From: David Carlier <devnexen@gmail.com>
> Date: Sat, 18 Jul 2020 13:27:52 +0100

These headers --^ should not be part of the e-mail body (otherwise they
will be part of the patch description if this patch gets picked up with
"git am").

> Subject: [PATCH 1/3] configure: fix for SunOS based systems.
> 
> local directive make the configure fails on these systems.
> 
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/configure b/configure
> index e93836aaae..5d100eba72 100755
> --- a/configure
> +++ b/configure
> @@ -59,7 +59,7 @@ error_exit() {
>  do_compiler() {
>      # Run the compiler, capturing its output to the log. First argument
>      # is compiler binary to execute.
> -    local compiler="$1"
> +    compiler="$1"
>      shift
>      if test -n "$BASH_VERSION"; then eval '
>          echo >>config.log "
> 

We're not using $compiler anywhere else outside of this function in the
configure script, so I think this should be ok.

Reviewed-by: Thomas Huth <thuth@redhat.com>


