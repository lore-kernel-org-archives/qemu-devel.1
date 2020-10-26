Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24195C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:54:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB2122403
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 08:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnJbwGbb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB2122403
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kWyGx-0000rf-HB
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 04:54:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWyFp-0000K0-T1
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:53:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kWyFl-0004Ts-Uv
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 04:53:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603702400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h64YhrLXBWBvz0jlypSyvO34GMYZD0A69L3f/FpoR2Y=;
 b=WnJbwGbbbY+nNpVTYdU8jNtKKE9bVqon3Qd4NRhIVr2shDR+I9D82I1UWAknf0zm8IEtBt
 f7i/pMzs8vH19AGoYG+amSgphKPA8MWmPmBqxoG5+RC9BLsVel9KbTLL2ACDq0PvJupCUX
 jbJiFJllGgJ6YQWuG2603+yn46zDyBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-zeL_pcevNSWHZJ7LJ4V4kQ-1; Mon, 26 Oct 2020 04:53:16 -0400
X-MC-Unique: zeL_pcevNSWHZJ7LJ4V4kQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D95C1084C84;
 Mon, 26 Oct 2020 08:53:15 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-104.ams2.redhat.com [10.36.112.104])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 86FC06EF5F;
 Mon, 26 Oct 2020 08:53:03 +0000 (UTC)
Subject: Re: [PATCH v7 17/17] scripts/oss-fuzz: ignore the generic-fuzz target
To: Alexander Bulekov <alxndr@bu.edu>, qemu-devel@nongnu.org
References: <20201023150746.107063-1-alxndr@bu.edu>
 <20201023150746.107063-18-alxndr@bu.edu>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <530c65df-4d4b-6132-cd2f-8217f4b1674b@redhat.com>
Date: Mon, 26 Oct 2020 09:53:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201023150746.107063-18-alxndr@bu.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: f4bug@amsat.org, darren.kenny@oracle.com, bsd@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, dimastep@yandex-team.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/10/2020 17.07, Alexander Bulekov wrote:
> generic-fuzz is not a standalone fuzzer - it requires some env variables
> to be set. On oss-fuzz, we set these with some predefined
> generic-fuzz-{...} targets, that are thin wrappers around generic-fuzz.
> Do not make a link for the generic-fuzz from the oss-fuzz build, so
> oss-fuzz does not treat it as a standalone fuzzer.
> 
> Signed-off-by: Alexander Bulekov <alxndr@bu.edu>
> ---
>  scripts/oss-fuzz/build.sh | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/oss-fuzz/build.sh b/scripts/oss-fuzz/build.sh
> index 0ce2867732..40e15985cf 100755
> --- a/scripts/oss-fuzz/build.sh
> +++ b/scripts/oss-fuzz/build.sh
> @@ -99,8 +99,14 @@ cp "./qemu-fuzz-i386" "$DEST_DIR/bin/"
>  # executable name)
>  for target in $(./qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
>  do
> -    ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
> -        "$DEST_DIR/qemu-fuzz-i386-target-$target"
> +    # Ignore the generic-fuzz target, as it requires some environment variables to
> +    # be configured. We have some generic-fuzz-{pc-q35, floppy, ...} targets that
> +    # are thin wrappers around this target that set the required environment
> +    # variables according to predefined configs.

Just FYI, I'll rewrap this comment so that it stays within the 80 columns
limit to avoid a warning from checkpatch.pl.

> +    if [ "$target" != "generic-fuzz" ]; then
> +        ln  "$DEST_DIR/bin/qemu-fuzz-i386" \
> +            "$DEST_DIR/qemu-fuzz-i386-target-$target"
> +    fi
>  done
>  
>  echo "Done. The fuzzers are located in $DEST_DIR"
> 

 Thomas


