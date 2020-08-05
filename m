Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDADC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5E3022B40
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 13:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MbIZnUfz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5E3022B40
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3J7M-0001h8-2W
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 09:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3J54-0000IY-Bt
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:03:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24164
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1k3J52-0008Dj-DJ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 09:03:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596632619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/enC+SFQjBEkI/V7iS2DBh7D59JR7Kq3n+IUJdw4AIY=;
 b=MbIZnUfz6VqD61fVd3nzTKOeVwkeiGsE9ZFlO6YNfOZPoPfmO61vRq15UjUZMYAqeIHgwJ
 XU7b9UT7a32Iyn2hZuKkO83V3Q8OJXOw6UVX+pDFQ2C8JLMw1Tq/p1RDfArqcXcRisWWIN
 poWFjxKTls9X7LiUfO1eTRFvTS7AyT0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-k342e7RuN3SlBjvmgqwQtQ-1; Wed, 05 Aug 2020 09:03:35 -0400
X-MC-Unique: k342e7RuN3SlBjvmgqwQtQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4AE41DE7;
 Wed,  5 Aug 2020 13:03:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-143.ams2.redhat.com
 [10.36.112.143])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BBECB712C5;
 Wed,  5 Aug 2020 13:03:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4F6471141D60; Wed,  5 Aug 2020 15:03:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v4 04/18] tests/qapi/doc-good.json: Clean up markup
References: <20200309154405.13548-1-peter.maydell@linaro.org>
 <20200309154405.13548-5-peter.maydell@linaro.org>
Date: Wed, 05 Aug 2020 15:03:30 +0200
In-Reply-To: <20200309154405.13548-5-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 9 Mar 2020 15:43:51 +0000")
Message-ID: <87eeolnt25.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:37:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: John Snow <jsnow@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The subject is a bit misleading.  The markup doesn't need cleanup.  It
purposefully tests corner cases of the doc comment parser.  For some of
them, the conversion to rST will change the meaning.  This commit tweaks
the test so it passes before and after the conversion.  Makes it a worse
test for the doc comment parser, which doesn't matter, because the code
in question is about to be deleted.

Peter Maydell <peter.maydell@linaro.org> writes:

> doc-good.json tests some oddities of markup that we don't want to
> accept.  Make them match the more restrictive rST syntax:
>
>  * in a single list the bullet types must all match
>  * lists must have leading and following blank lines
>  * indentation is important

Actually, indentation has always been important, but the conversion to
rST changes where and how it matters.

>  * the '|' example syntax is going to go away entirely, so stop
>    testing it

Before the series, we (try to) cover all doc markup here.

The series replaces the doc markup language by rST + a little extra.
The test must still cover the little extra then, and covering a bit of
rST to ensure basic sanity won't hurt.

Correct?

I'm asking because a "yes" explains why we can drop coverage without
replacement: it's appropriate when the markup in question is replaced by
rST.

> This will avoid the tests spuriously breaking when we tighten up the
> parser code in the following commits.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> New patch in v2
> ---
>  tests/qapi-schema/doc-good.json | 25 +++++++++++++------------
>  tests/qapi-schema/doc-good.out  | 12 ++++++------
>  tests/qapi-schema/doc-good.texi | 12 +++---------
>  3 files changed, 22 insertions(+), 27 deletions(-)
>
> diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
> index d992e713d97..a45dc22848c 100644
> --- a/tests/qapi-schema/doc-good.json
> +++ b/tests/qapi-schema/doc-good.json
> @@ -10,25 +10,25 @@
>  #
>  # *strong* _with emphasis_
>  # @var {in braces}
> +#
>  # * List item one
> -# - Two, multiple
> +# * Two, multiple
>  #   lines
>  #
> -# 3. Three
> -# Still in list
> +# * Three
> +#   Still in list
> +#
> +# Not in list
>  #
> -#   Not in list

This is an example for indentation becoming relevant where it wasn't
before.

The old doc markup language uses blank lines to terminate list items.
The new one uses indentation, which is more flexible.

>  # - Second list
> -# Note: still in list
> +#   Note: still in list
>  #
>  # Note: not in list
> +#
>  # 1. Third list
>  #    is numbered
>  #
> -# - another item
> -#
> -# | example
> -# | multiple lines
> +# 2. another item
>  #
>  # Returns: the King
>  # Since: the first age
> @@ -62,7 +62,7 @@
>  ##
>  # @Base:
>  # @base1:

Here, indentation is relevant even before the series: @base: is only
recognized as an argument section when it's not indented.

> -#   the first member
> +# the first member

Why do you need to unindent this line?

>  ##
>  { 'struct': 'Base', 'data': { 'base1': 'Enum' } }
>  
> @@ -101,7 +101,7 @@
>  ##
>  # @Alternate:
>  # @i: an integer
> -# @b is undocumented
> +#     @b is undocumented

Why do you need to indent this line?

>  ##
>  { 'alternate': 'Alternate',
>    'data': { 'i': 'int', 'b': 'bool' } }
> @@ -115,7 +115,7 @@
>  # @arg1: the first argument
>  #
>  # @arg2: the second
> -# argument
> +#        argument

Why do you need to indent this line?

>  #
>  # Features:
>  # @cmd-feat1: a feature
> @@ -124,6 +124,7 @@
>  # Returns: @Object
>  # TODO: frobnicate
>  # Notes:
> +#
>  # - Lorem ipsum dolor sit amet
>  # - Ut enim ad minim veniam
>  #
> diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
> index 4c9406a464d..9503a3a3178 100644
> --- a/tests/qapi-schema/doc-good.out
> +++ b/tests/qapi-schema/doc-good.out
> @@ -68,25 +68,25 @@ doc freeform
>  
>  *strong* _with emphasis_
>  @var {in braces}
> +
>  * List item one
> -- Two, multiple
> +* Two, multiple
>  lines
>  
> -3. Three
> +* Three
>  Still in list
>  
>  Not in list
> +
>  - Second list
>  Note: still in list
>  
>  Note: not in list
> +
>  1. Third list
>  is numbered
>  
> -- another item
> -
> -| example
> -| multiple lines
> +2. another item
>  
>  Returns: the King
>  Since: the first age
> diff --git a/tests/qapi-schema/doc-good.texi b/tests/qapi-schema/doc-good.texi
> index d4b15dabf03..1e8063c8579 100644
> --- a/tests/qapi-schema/doc-good.texi
> +++ b/tests/qapi-schema/doc-good.texi
> @@ -6,6 +6,7 @@
>  
>  @strong{strong} @emph{with emphasis}
>  @code{var} @{in braces@}
> +
>  @itemize @bullet
>  @item
>  List item one
> @@ -20,6 +21,7 @@ Still in list
>  @end itemize
>  
>  Not in list
> +
>  @itemize @minus
>  @item
>  Second list
> @@ -28,6 +30,7 @@ Note: still in list
>  @end itemize
>  
>  Note: not in list
> +
>  @enumerate
>  @item
>  Third list
> @@ -36,15 +39,6 @@ is numbered
>  @item
>  another item
>  
> -@example
> -example
> -@end example
> -
> -@example
> -multiple lines
> -@end example
> -
> -
>  @end enumerate
>  
>  Returns: the King


