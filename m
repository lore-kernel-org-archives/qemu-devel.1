Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67791C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:58:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72C7820897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 04:58:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jFWAoR1q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72C7820897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kN7ip-0007NL-DQ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 00:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kN7hz-0006y0-TI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:57:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kN7hy-0006ME-77
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 00:57:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601355465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ymmWkHsXwSf0Aj+CkY7Q9g2XP7rXrYTCQobcFqutIN8=;
 b=jFWAoR1qsae4c4uk2fATIhB2al3iDDpFj3YMjUIO9XiP+nSLX4tjoiGx/0pNx+L6+P2h2q
 F/l5Wxr31pUz/Lrq5M4S/sDGmi6R/2yoAlPkgPwMomdl6HjAHe5nIr7O21Ds0/4HEmwvVo
 GSOjUwIxOnaOouw6Iq9/o1kGsiV/Aww=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-554-9A3KjVtsMTWz69ZQ_bmlCg-1; Tue, 29 Sep 2020 00:57:43 -0400
X-MC-Unique: 9A3KjVtsMTWz69ZQ_bmlCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DB3D186DD22;
 Tue, 29 Sep 2020 04:57:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DCB0773661;
 Tue, 29 Sep 2020 04:57:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6CDF8113865F; Tue, 29 Sep 2020 06:57:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 06/21] qapi/machine.json: Escape a literal '*' in doc
 comment
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-7-peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 06:57:40 +0200
In-Reply-To: <20200925162316.21205-7-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 25 Sep 2020 17:23:01 +0100")
Message-ID: <87k0wd6uyj.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> For rST, '*' is a kind of inline markup (for emphasis), so
> "*-softmmu" is a syntax error because of the missing closing '*'.
> Escape the '*' with a '\'.
>
> The texinfo document generator will leave the '\' in the
> output, which is not ideal, but that generator is going to
> go away in a subsequent commit.

Yes, in PATCH 09.  Tolerable.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/machine.json | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 0ac1880e4a4..9c45b04363c 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -13,7 +13,7 @@
>  #
>  # The comprehensive enumeration of QEMU system emulation ("softmmu")
>  # targets. Run "./configure --help" in the project root directory, and
> -# look for the *-softmmu targets near the "--target-list" option. The
> +# look for the \*-softmmu targets near the "--target-list" option. The
>  # individual target constants are not documented here, for the time
>  # being.
>  #

A better markup might be 

    # The comprehensive enumeration of QEMU system emulation ("softmmu")
    # targets. Run ``./configure --help`` in the project root directory, and
    # look for the ``*-softmmu`` targets near the ``--target-list``
    # option. The individual target constants are not documented here, for
    # the time being.

But that should be done systematically, not just here, which makes it
worse than your patch at this point of the conversion.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


