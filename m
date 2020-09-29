Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC30C4727F
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:41:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA3272064E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NpJrfZAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3272064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNEwY-000787-UN
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:41:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNErE-000137-DE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:35:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kNErB-0008M5-MI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 08:35:47 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601382944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dQ3wsfy5KsplaynrJMJyjMESYjSUlnklpCwwhnKYOoQ=;
 b=NpJrfZAjiIXEe50HZTFZ7pqiBuGW8Vc7Ajp/6TAp8DkAQU6gxUYrsYpOg31eaQMiB0bq6Y
 ddNPmoDE/vCV4BKkYZENmUIqdxLV2n0lan36L2yRUvye2oL83tRRm9VZti+sHKtF6DqOYB
 rKLaNLA780ih0aAFmsVUUeR6Ux2Rouk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-GTXIMTrCNx2-ScKVqg2sng-1; Tue, 29 Sep 2020 08:35:42 -0400
X-MC-Unique: GTXIMTrCNx2-ScKVqg2sng-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A411418C89C3;
 Tue, 29 Sep 2020 12:35:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-101.ams2.redhat.com
 [10.36.112.101])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E8125578B;
 Tue, 29 Sep 2020 12:35:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1D28113864A; Tue, 29 Sep 2020 14:35:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v6 17/21] docs/devel/qapi-code-gen.txt: Update to new
 rST backend conventions
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-18-peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 14:35:39 +0200
In-Reply-To: <20200925162316.21205-18-peter.maydell@linaro.org> (Peter
 Maydell's message of "Fri, 25 Sep 2020 17:23:12 +0100")
Message-ID: <87wo0cu5es.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> Update the documentation of QAPI document comment syntax to match
> the new rST backend requirements. The principal changes are:
>  * whitespace is now significant,

Well, differently significant :)  Anyway, close enough.

>                                   and multiline definitions
>    must have their second and subsequent lines indented to
>    match the first line
>  * general rST format markup is permitted, not just the small
>    set of markup the old texinfo generator handled. For most
>    things (notably bulleted and itemized lists) the old format
>    is the same as rST was.

"was the same as rST is"?

>  * Specific things that might trip people up:
>    - instead of *bold* and _italic_ rST has **bold** and *italic*
>    - lists need a preceding and following blank line
>    - a lone literal '*' will need to be backslash-escaped to
>      avoid a rST syntax error
>  * the old leading '|' for example (literal text) blocks is
>    replaced by the standard rST '::' literal block.
>  * we support arbitrary levels of sub- and sub-sub-heading, not
>    just a main and sub-heading like the old texinfo generator

Possibly noteworthy: lists can now be nested.  Can add that in my tree.

>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  docs/devel/qapi-code-gen.txt | 83 +++++++++++++++++++++++-------------
>  1 file changed, 53 insertions(+), 30 deletions(-)
>
> diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
> index 69eaffac376..7d2479dde82 100644
> --- a/docs/devel/qapi-code-gen.txt
> +++ b/docs/devel/qapi-code-gen.txt
> @@ -824,23 +824,37 @@ See below for more on definition documentation.
>  Free-form documentation may be used to provide additional text and
>  structuring content.
>  
> +==== Headings and subheadings ====
> +
> +A free-form documentation comment containing a line which starts with
> +some '=' symbols and then a space defines a section heading:
> +
> +    ##
> +    # = This is a top level heading
> +    #
> +    # This is a free-form comment which will go under the
> +    # top level heading.
> +    ##
> +
> +    ##
> +    # == This is a second level heading
> +    ##
> +
> +A heading line must be the first line of the documentation
> +comment block.
> +
> +Section headings must always be correctly nested, so you can only
> +define a third-level heading inside a second-level heading, and so on.
>  
>  ==== Documentation markup ====
>  
> -Comment text starting with '=' is a section title:
> +Documentation comments can use most rST markup.  In particular,
> +a '::' literal block can be used for examples:
>  
> -    # = Section title
> -
> -Double the '=' for a subsection title:
> -
> -    # == Subsection title
> -
> -Both are only permitted in free-form documentation.
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
> @@ -856,34 +870,33 @@ A decimal number followed by '.' starts a numbered list:
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
> +be used.  If you need a single literal '*' you will need to
> +backslash-escape it.  As an extension beyond the usual rST syntax, you
> +can also use '@foo' to reference a name in the schema; this is
> +rendered the same way as '``foo``'.
>  
>  Example:
>  
>  ##
> -# = Section
> -# == Subsection
> -#
> -# Some text foo with *strong* and _emphasis_
> +# Some text foo with **bold** and *emphasis*
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
>  

v5 had

  @@ -899,6 +915,12 @@ commands and events), member (for structs and unions), branch (for
   alternates), or value (for enums), and finally optional tagged
   sections.
   
  +Descriptions of arguments can span multiple lines; if they
  +do then the second and subsequent lines must be indented
  +to line up with the first character of the first line of the
  +description. The parser will report a syntax error if there
  +is insufficient indentation.
  +
   FIXME: the parser accepts these things in almost any order.
   FIXME: union branches should be described, too.
   
I questioned the value of the last sentence.  You dropped both.
Intentional?

> @@ -937,6 +950,16 @@ multiline argument descriptions.
>  A 'Since: x.y.z' tagged section lists the release that introduced the
>  definition.
>  
> +The text of a section can start on a new line, in
> +which case it must not be indented at all.  It can also start
> +on the same line as the 'Note:', 'Returns:', etc tag.  In this
> +case if it spans multiple lines then second and subsequent
> +lines must be indented to match the first.
> +
> +An 'Example' or 'Examples' section is automatically rendered
> +entirely as literal fixed-width text.  In other sections,
> +the text is formatted, and rST markup can be used.
> +
>  For example:
>  
>  ##


