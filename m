Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB03C4741F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE64220897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 08:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaP1KU2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE64220897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNB4T-0007Fl-L6
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 04:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47676)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNB2L-0006cD-7Q
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:31:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41272)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNB2I-0005E4-Cj
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 04:31:00 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601368257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T3b3hzTgZWqI3rNZkyq63Niu+mDYsl0SzEF2mJ5lWgg=;
 b=UaP1KU2zqQPFU1+3sWVIDqAghda8NUm+/Xd/aQMHYTxMbgcClYWOGP7pKoqWBAdpeX2Xzx
 QTZDjRjc9a5W3tkMTHPwVZNJa+zS1T+XyibusYRA4VB5iNDVtlSCIFB9CpU8Ni35fPqi4r
 aIUeCOtFKoPXqWp8lsx7LbuI/8u8oMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-kKVr7b9-PvSjUqj9GSYNHg-1; Tue, 29 Sep 2020 04:30:55 -0400
X-MC-Unique: kKVr7b9-PvSjUqj9GSYNHg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A9401019629;
 Tue, 29 Sep 2020 08:30:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CE58C5D9CA;
 Tue, 29 Sep 2020 08:30:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 56464113864A; Tue, 29 Sep 2020 10:30:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 11/21] qga/qapi-schema.json: Add some headings
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-12-peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 10:30:52 +0200
In-Reply-To: <20200925162316.21205-12-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 25 Sep 2020 17:23:06 +0100")
Message-ID: <875z7x0ytf.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

> Add some section headings to the QGA json; this is purely so that we
> have some H1 headings, as otherwise each command ends up being
> visible in the interop/ manual's table of contents.  In an ideal
> world there might be a proper 'Introduction' section the way there is
> in qapi/qapi-schema.json.

Definitely.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qga/qapi-schema.json | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index d2ea7446db6..cec98c7e065 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -2,14 +2,16 @@
>  # vim: filetype=python
>  
>  ##
> -#
> -# General note concerning the use of guest agent interfaces:
> +# = General note concerning the use of guest agent interfaces
>  #
>  # "unsupported" is a higher-level error than the errors that individual
>  # commands might document. The caller should always be prepared to receive
>  # QERR_UNSUPPORTED, even if the given command doesn't specify it, or doesn't
>  # document any failure mode at all.
> -#
> +##
> +
> +##
> +# = QEMU guest agent protocol commands and structs
>  ##
>  
>  { 'pragma': { 'doc-required': true } }

Good enough for now.

Reviewed-by: Markus Armbruster <armbru@redhat.com>


