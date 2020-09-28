Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 349FFC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:55:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0E072067D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 12:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bea79AqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0E072067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMsh9-0007no-Lj
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 08:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMsR2-00073M-GK
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:39:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kMsR0-0005uZ-5P
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 08:39:15 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601296752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3B1q05j8TnSPoBzAIhwENAcloRoNu5q/RAbciPJmdDE=;
 b=bea79AqQpsr5ZOoF5/x0Ie26BkK7NT3bNo+mPhOph3WvfFI8HGiXTQH//zUmrAu8tQP0FG
 oFXXKy5hHvWeDphRzKkrwN2KzDH2vtpSloFh8DblS3XSi4cAMqQ1zDFgqcTt3WM9eQH8rZ
 NJdlxXWUEK2+3sDpAxel3461AXwJCJ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-uy5BplWYN76MbzY6yIRMHA-1; Mon, 28 Sep 2020 08:39:10 -0400
X-MC-Unique: uy5BplWYN76MbzY6yIRMHA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9276E1091061;
 Mon, 28 Sep 2020 12:39:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-70.ams2.redhat.com
 [10.36.112.70])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65B3060CD0;
 Mon, 28 Sep 2020 12:39:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1207113865F; Mon, 28 Sep 2020 14:39:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 01/21] qapi: Fix doc comment indentation again
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-2-peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 14:39:07 +0200
In-Reply-To: <20200925162316.21205-2-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 25 Sep 2020 17:22:56 +0100")
Message-ID: <87wo0ef53o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
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

> In commit 26ec4e53f2 and similar commits we fixed the indentation
> for doc comments in our qapi json files to follow a new stricter
> standard for indentation, which permits only:
>     @arg: description line 1
>           description line 2
>
> or:
>     @arg:
>     line 1
>     line 2
>
> but because the script updates that enforce this are not yet in the
> tree we have had a steady trickle of subsequent changes which didn't
> follow the new rules.
>
> Fix the latest round of mis-indented doc comments.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/block-core.json |   4 +-
>  qapi/migration.json  | 102 +++++++++++++++++++++----------------------
>  2 files changed, 53 insertions(+), 53 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 3c16f1e11d6..dd77a91174c 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4316,8 +4316,8 @@
>  # @data-file-raw: True if the external data file must stay valid as a
>  #                 standalone (read-only) raw image without looking at qcow2
>  #                 metadata (default: false; since: 4.0)
> -# @extended-l2      True to make the image have extended L2 entries
> -#                   (default: false; since 5.2)
> +# @extended-l2: True to make the image have extended L2 entries
> +#               (default: false; since 5.2)
>  # @size: Size of the virtual disk in bytes
>  # @version: Compatibility level (default: v3)
>  # @backing-file: File name of the backing file if a backing file

Fixes a missing colon in addition to indentation.

[...]

Reviewed-by: Markus Armbruster <armbru@redhat.com>


