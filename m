Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C9DC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:25:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2164E206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLa7XsIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2164E206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqAn-0005qu-7p
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 05:25:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47718)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIq9v-0005MC-Jz
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:24:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59716)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIq9t-0005gC-Gx
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:24:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600334692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BLek0CAS/2W7CGTExmxEuZ3+YnUTXJDS50XNsY4Sixs=;
 b=GLa7XsIAEJBtSO1QpDgwa3BBPZ0HPlPEIPua0+o5Waa7HXNCMy4jpTSvLkySfEWPT3X1UP
 bda076HMy6mSoua4dZPSDSLJI2Mj4sQUy1lbSESKFfAJJdDV644hDOl49qjyjWpZHHSncq
 DVmRTuswIIpYI10J4+KOu0tdO4xXnrY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-7i6o_HAeOe-lh6vfIn--SA-1; Thu, 17 Sep 2020 05:24:50 -0400
X-MC-Unique: 7i6o_HAeOe-lh6vfIn--SA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A67E10BBEEC;
 Thu, 17 Sep 2020 09:24:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 06D721002D41;
 Thu, 17 Sep 2020 09:24:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8350F113864A; Thu, 17 Sep 2020 11:24:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 15/20] docs/devel/qapi-code-gen.txt: Update to new
 rST backend conventions
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-16-peter.maydell@linaro.org>
Date: Thu, 17 Sep 2020 11:24:47 +0200
In-Reply-To: <20200810195019.25427-16-peter.maydell@linaro.org> (Peter
 Maydell's message of "Mon, 10 Aug 2020 20:50:14 +0100")
Message-ID: <87mu1o3gdc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Update the documentation of QAPI document comment syntax to match
> the new rST backend requirements. The principal changes are:
>  * whitespace is now significant,

Well, differently significant :)

>                                   and multiline definitions
>    must have their second and subsequent lines indented to
>    match the first line
>  * general rST format markup is permitted, not just the small
>    set of markup the old texinfo generator handled. For most
>    things (notably bulleted and itemized lists) the old format
>    is the same as rST was.
>  * Specific things that might trip people up:
>    - instead of *bold* and _italic_ rST has **bold** and *italic*
>    - lists need a preceding and following blank line
>    - a lone literal '*' will need to be backslash-escaped to
>      avoid a rST syntax error
>  * the old leading '|' for example (literal text) blocks is
>    replaced by the standard rST '::' literal block.
>  * headings and subheadings must now be in a freeform
>    documentation comment of their own
>  * we support arbitrary levels of sub- and sub-sub-heading, not
>    just a main and sub-heading like the old texinfo generator

Possibly noteworthy: lists can now be nested.

>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/qapi-code-gen.txt | 90 ++++++++++++++++++++++++------------
>  1 file changed, 61 insertions(+), 29 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 69eede6c283..263f1c0b44c 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -824,21 +824,39 @@ See below for more on definition documentation.
>  Free-form documentation may be used to provide additional text and
>  structuring content.
>  
> +==== Headings and subheadings ====
> +
> +A free-form documentation comment containing a single line
> +which starts with some '=' symbols and then a space defines
> +a section heading:
> +
> +    ##
> +    # = This is a top level heading
> +    ##
> +
> +    ##
> +    # This is a free-form comment which will go under the
> +    # top level heading.
> +    ##
> +
> +    ##
> +    # == This is a second level heading
> +    ##
> +
> +Section headings must always be correctly nested, so you can only
> +define a third-level heading inside a second-level heading, and so
> +on. The documentation generator will catch nesting mistakes and report
> +a syntax error.

Is the last sentence is useful?  We don't explicitly document other
parse errors.

>  
>  ==== Documentation markup ====
>  
> -Comment text starting with '=' is a section title:
> +Documentation comments can use most rST markup. In particular,

Please put two spaces after sentence-ending punctuation, for local
consistency, and to keep Emacs sentence commands working.

> +a '::' literal block can be used for examples:
>  
> -    # = Section title
> -
> -Double the '=' for a subsection title:
> -
> -    # == Subsection title
> -
> -'|' denotes examples:
> -
> -    # | Text of the example, may span
> -    # | multiple lines
> +    # ::
> +    #
> +    #   Text of the example, may span
> +    #   multiple lines
>  
>  '*' starts an itemized list:
>  
> @@ -854,37 +872,35 @@ A decimal number followed by '.' starts a numbered list:
>      #    multiple lines
>      # 2. Second item
>  
> -The actual number doesn't matter.  You could even use '*' instead of
> -'2.' for the second item.
> +The actual number doesn't matter.
>  
> -Lists can't be nested.  Blank lines are currently not supported within
> -lists.
> +Lists of either kind must be preceded and followed by a blank line.
> +If a list item's text spans multiple lines, then the second and
> +subsequent lines must be correctly indented to line up with the
> +first character of the first line.
>  
> -Additional whitespace between the initial '#' and the comment text is
> -permitted.
> -
> -*foo* and _foo_ are for strong and emphasis styles respectively (they
> -do not work over multiple lines).  @foo is used to reference a name in
> -the schema.
> +The usual '**strong**', '*emphasised*' and '``literal``' markup should
> +be used. If you need a single literal '*' you will need to backslash-escape it.

Long line.

> +As an extension beyond the usual rST syntax, you can also
> +use '@foo' to reference a name in the schema; this is rendered
> +the same way as '``foo``'.
>  
>  Example:
>  
>  ##
> -# = Section
> -# == Subsection
> -#
> -# Some text foo with *strong* and _emphasis_
> +# Some text foo with **bol** and *emphasis*

Do you mean **bold**?

>  # 1. with a list
>  # 2. like that
>  #
>  # And some code:
> -# | $ echo foo
> -# | -> do this
> -# | <- get that
>  #
> +# ::
> +#
> +#   $ echo foo
> +#   -> do this
> +#   <- get that
>  ##
>  
> -

Did you mean to drop the blank line?

>  ==== Definition documentation ====
>  
>  Definition documentation, if present, must immediately precede the
> @@ -899,6 +915,12 @@ commands and events), member (for structs and unions), branch (for
>  alternates), or value (for enums), and finally optional tagged
>  sections.
>  
> +Descriptions of arguments can span multiple lines; if they
> +do then the second and subsequent lines must be indented
> +to line up with the first character of the first line of the
> +description. The parser will report a syntax error if there
> +is insufficient indentation.

Is the last sentence is useful?

> +
>  FIXME: the parser accepts these things in almost any order.
>  FIXME: union branches should be described, too.
>  
> @@ -912,6 +934,16 @@ The section ends with the start of a new section.
>  A 'Since: x.y.z' tagged section lists the release that introduced the
>  definition.
>  
> +The text of a section can start on a new line, in
> +which case it must not be indented at all. It can also start
> +on the same line as the 'Note:', 'Returns:', etc tag. In this
> +case if it spans multiple lines then second and subsequent
> +lines must be indented to match the first.
> +
> +An 'Example' or 'Examples' section is automatically rendered
> +entirely as literal fixed-width text. In other sections,
> +the text is formatted, and rST markup can be used.
> +
>  For example:
>  
>  ##


