Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CCDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B67B6206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 13:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hY/OZ0Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B67B6206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb1Wo-0006MV-Fy
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 08:11:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kb1VW-0005bl-2e
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:10:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27163)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kb1VT-0002hj-Gg
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 08:10:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604668218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hzWSfnUHyjKG1DuIQvHmwU5Tiz+Zdd3inccYOkDo2IM=;
 b=hY/OZ0Tmq7ox9wMh1fH5a8wQ7Gdq7jC5xvfJA9ISzOXgYeZdGMmZ9HBZDGq7VvQrdxajfw
 G/O08rlfzHG8tujkZkUAw6KT8ri0YNSYG5tWbzWPbW6AaUPfpUINN1T3AKXVaoKO9PCcC4
 ghvLc0YqxC1vyzHqbVSLVwixcvkJJto=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-457-uOT94f7hOoePzn-gKNVK1Q-1; Fri, 06 Nov 2020 08:10:15 -0500
X-MC-Unique: uOT94f7hOoePzn-gKNVK1Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF8A7803F69;
 Fri,  6 Nov 2020 13:10:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-103.ams2.redhat.com
 [10.36.112.103])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 552145D9CD;
 Fri,  6 Nov 2020 13:10:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C83461132BD6; Fri,  6 Nov 2020 14:10:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] CODING_STYLE.rst: Be less strict about 80 character limit
References: <20201106112940.31300-1-peter.maydell@linaro.org>
Date: Fri, 06 Nov 2020 14:10:08 +0100
In-Reply-To: <20201106112940.31300-1-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 6 Nov 2020 11:29:40 +0000")
Message-ID: <878sbek4wf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 07:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Gan Qixin <ganqixin@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Chenqun \(kuhn\)" <kuhn.chenqun@huawei.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Relax the wording about line lengths a little bit; this goes with the
> checkpatch changes to warn at 100 characters rather than 80.
>
> (Compare the Linux kernel commit bdc48fa11e46f8; our coding style is
> not theirs, but the rationale is good and applies to us too.)
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  CODING_STYLE.rst | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/CODING_STYLE.rst b/CODING_STYLE.rst
> index 8b13ef0669e..7bf4e39d487 100644
> --- a/CODING_STYLE.rst
> +++ b/CODING_STYLE.rst
> @@ -85,8 +85,13 @@ Line width
>  Lines should be 80 characters; try not to make them longer.
>  
>  Sometimes it is hard to do, especially when dealing with QEMU subsystems
> -that use long function or symbol names.  Even in that case, do not make
> -lines much longer than 80 characters.
> +that use long function or symbol names. If wrapping the line at 80 columns
> +is obviously less readable and more awkward, prefer not to wrap it; better
> +to have an 85 character line than one which is awkwardly wrapped.
> +
> +Even in that case, try not to make lines much longer than 80 characters.
> +(The checkpatch script will warn at 100 characters, but this is intended
> +as a guard against obviously-overlength lines, not a target.)
>  
>  Rationale:

Alright, that's much more reasobale than I expected.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

One more thing that might be worth explaining: the width of the text
matters, i.e. line length less indentation.


