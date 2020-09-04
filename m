Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80992C43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:03:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A8312073B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 13:03:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A8312073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEBMq-0002mB-HN
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 09:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kEBMF-00029U-Gj
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:02:23 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60013
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kEBMD-00011H-62
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 09:02:22 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-lCLEckJHPdWbDX88_G1w7A-1; Fri, 04 Sep 2020 09:02:18 -0400
X-MC-Unique: lCLEckJHPdWbDX88_G1w7A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B7081DE08;
 Fri,  4 Sep 2020 13:02:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-68.ams2.redhat.com
 [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BC915D9D2;
 Fri,  4 Sep 2020 13:02:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 955201132B59; Fri,  4 Sep 2020 15:02:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 12/20] qapi: Use rST markup for literal blocks
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-13-peter.maydell@linaro.org>
Date: Fri, 04 Sep 2020 15:02:15 +0200
In-Reply-To: <20200810195019.25427-13-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 10 Aug 2020 20:50:11 +0100")
Message-ID: <87ft7x7l0o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:57:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> There are exactly two places in our json doc comments where we
> use the markup accepted by the texi doc generator where a '|' in
> the first line of a doc comment means the line should be emitted
> as a literal block (fixed-width font, whitespace preserved).

Has always been pretty broken, though: each line ends up in its own
@example environment.  See doc-good.texi.

> Since we use this syntax so rarely, instead of making the rST
> generator support it, instead just convert the two uses to
> rST-format literal blocks, which are indented and introduced
> with '::'.

Also, we should not reinvent what reST already provides.

> (The rST generator doesn't complain about the old style syntax,
> it just emits it with the '|' and with the whitespace not
> preserved, which looks odd, but means we can safely leave this
> change until after we've stopped generating texinfo.)

In other words, the recent switch to the reST generator messed these
examples up, and this commit tidies up.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/block-core.json  | 16 +++++++++-------
>  qapi/qapi-schema.json |  6 ++++--
>  2 files changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 535b2b2e7bf..12758116e85 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -566,13 +566,15 @@
>  #        For the example above, @bins may be something like [3, 1, 5, 2],
>  #        and corresponding histogram looks like:
>  #
> -# |      5|           *
> -# |      4|           *
> -# |      3| *         *
> -# |      2| *         *    *
> -# |      1| *    *    *    *
> -# |       +------------------
> -# |           10   50   100
> +# ::
> +#
> +#        5|           *
> +#        4|           *
> +#        3| *         *
> +#        2| *         *    *
> +#        1| *    *    *    *
> +#         +------------------
> +#             10   50   100
>  #
>  # Since: 4.0
>  ##

Could exploit that reST is the Perl of ASCII-based markups, and write

   #        For the example above, @bins may be something like [3, 1, 5, 2],
   #        and corresponding histogram looks like::
   #
   #        5|           *
   #        4|           *
   #        3| *         *
   #        2| *         *    *
   #        1| *    *    *    *
   #         +------------------
   #             10   50   100
   #
   # Since: 4.0
   ##

Matter of taste.  I find both similarly arcane.

> diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
> index 5fc0771eb04..c19b4267058 100644
> --- a/qapi/qapi-schema.json
> +++ b/qapi/qapi-schema.json
> @@ -23,8 +23,10 @@
>  #
>  # Example:
>  #
> -# | -> data issued by the Client
> -# | <- Server data response
> +# ::
> +#
> +#   -> data issued by the Client
> +#   <- Server data response
>  #
>  # Please, refer to the QMP specification (docs/interop/qmp-spec.txt) for
>  # detailed information on the Server command and response formats.

Likewise.

Regardless::
Reviewed-by: Markus Armbruster <armbru@redhat.com>


