Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92896C2BB84
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 120F02080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCbsQTlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120F02080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57790 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLMF-0004nn-3l
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLKh-0001Yl-4B; Mon, 07 Sep 2020 13:53:35 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFLKc-0000vB-Oz; Mon, 07 Sep 2020 13:53:34 -0400
Received: by mail-lj1-x241.google.com with SMTP id s205so17019845lja.7;
 Mon, 07 Sep 2020 10:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:reply-to:from:date:message-id
 :subject:to:cc;
 bh=Rl9ibgrlv/offHmvZeZnsqOhlxzv4cLLe6pFW55PIsU=;
 b=FCbsQTlTTdakvgNkGg+HpvOPD5KMTjkZNNwovHWGiId5vuxgRUoZ63SHoYlfBXR0oa
 MJE7ik0mfQWyL+dvi2ggquMeJyGuI//r+s2OyFm4NrXr1uzN+4CcW4oa4aMFAOs2SlWW
 K14HvV19n+TQOLv2aP/g8y3zIxLBQng0DfGRlbH7X86sUq1N92WMqgHoDXTR+dkg5J6v
 yVgJ0dseUom40lH4byJBBTn5AggFtfSTC8QLAs7hjIyowpDeJ6y1vXUWbaFpHa/FHhe0
 Uz2UbB3Qcdpv6sZa4xpe//vCmaYVRVO9DPgEHSoof/3mc60pf0JrcMfu0UlkwTICbG3r
 TStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=Rl9ibgrlv/offHmvZeZnsqOhlxzv4cLLe6pFW55PIsU=;
 b=e/qPhnsDo8C62yOKeBxJNbWXegK5tFJNkov3nwlMVIPBy1IY1JwaYA43Ev9hSXsj35
 ++lc1i+vOiQPfjPZ5LjfrQsvagiZMNM+tWil7W96MrXLA6jdAForr95J0UkHZgqByHdM
 rnXizKkdVYWE5EPd5qttVAJ+8P6O9tqSNESdRtNpH4No3M2ycS5H30YqNXJq1gml+Efj
 YVbUS3IuQXct4nyw3TASenA3EGXkuDPXjyQoYZDwuukvWe8muBP7XjEQQVhIDQ1Xa/uL
 4oe0mIGtRkZaKbDhfJrhJMz23KHMlBWIXx8COLMaF5OI+eV27mxrs0UN3OW8VHy3KdZO
 10ig==
X-Gm-Message-State: AOAM532gyjs2aDn3XtlNaHic2Q1wRdwQR5Bfv6WlMMZCmTIV2BquPny0
 A6/d9j+88VATXgdbtJMNTB0pG/xBJkFpa2JYrbpukORlRcHJzg==
X-Google-Smtp-Source: ABdhPJxqu1TiegwXvH+H+y7mwArniew/Z4mTFLBc7JGeYChD9PLWp5e/vYsTnaDlz0poMNJqGVm/IMv80cOPYQbrzJA=
X-Received: by 2002:a2e:87d9:: with SMTP id v25mr11082807ljj.171.1599501208270; 
 Mon, 07 Sep 2020 10:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200907174828.1768-1-luoyonggang@gmail.com>
In-Reply-To: <20200907174828.1768-1-luoyonggang@gmail.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Tue, 8 Sep 2020 01:53:16 +0800
Message-ID: <CAE2XoE8ePZUKNOMcQu5yZtP8NHsru+xsAuwrD1AGh72NPbqnvA@mail.gmail.com>
Subject: Re: [PATCH v2] meson: Use -b to ignore CR vs. CR-LF issues on Windows
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000563a4605aebce5b3"
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000563a4605aebce5b3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forgot your

On Tue, Sep 8, 2020 at 1:48 AM Yonggang Luo <luoyonggang@gmail.com> wrote:

> Or the tests result would cause following test failure:
> Running test QAPI doc
>   LINK    tests/check-qdict.exe
> ---
> C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/../cirrus-c=
i-build/tests/qapi-schema/doc-good.texi
>   2020-09-02 10:26:02.396028200 -0700
> +++
> C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/tests/qapi-=
schema/doc-good-qapi-doc.texi
>     2020-09-02 10:43:09.849568200 -0700
> @@ -1,319 +1,319 @@
> -@c AUTOMATICALLY GENERATED, DO NOT MODIFY
> -
> -@section Section
> -
> -@subsection Subsection
> -
> -@strong{strong} @emph{with emphasis}
> -@code{var} @{in braces@}
> -@itemize @bullet
> -@item
> -List item one
> -@item
> -Two, multiple
> -lines
> -
> -@item
> -Three
> -Still in list
> -
> -@end itemize
> -
> -Not in list
> -@itemize @minus
> -@item
> -Second list
> -Note: still in list
> -
> -@end itemize
> -
> -Note: not in list
> -@enumerate
> -@item
> -Third list
> -is numbered
> -
> -@item
> -another item
> -
> -@example
> -example
> -@end example
> -
> -@example
> -multiple lines
> -@end example
> -
> -
> -@end enumerate
> -
> -Returns: the King
> -Since: the first age
> -Notes:
> -
> -@enumerate
> -@item
> -Lorem ipsum dolor sit amet
> -
> -@item
> -Ut enim ad minim veniam
> -
> -@end enumerate
> -
> -Duis aute irure dolor
> -
> -Example:
> -
> --> in
> -<- out
> -Examples:
> -@itemize @minus
> -@item
> -@strong{verbatim}
> -@item
> -@{braces@}
> -@end itemize
> -
> -
> -
> -@deftp {Enum} Enum
> -
> -
> -
> -@b{Values:}
> -@table @asis
> -@item @code{one}
> -The @emph{one} @{and only@}
> -@*@b{If:} @code{defined(IFONE)}
> -@item @code{two}
> -Not documented
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{enum-feat}
> -Also @emph{one} @{and only@}
> -@end table
> -@code{two} is undocumented
> -
> -@b{If:} @code{defined(IFCOND)}
> -@end deftp
> -
> -
> -
> -@deftp {Object} Base
> -
> -
> -
> -@b{Members:}
> -@table @asis
> -@item @code{base1: Enum}
> -the first member
> -@end table
> -
> -@end deftp
> -
> -
> -
> -@deftp {Object} Variant1
> -
> -A paragraph
> -
> -Another paragraph (but no @code{var}: line)
> -
> -@b{Members:}
> -@table @asis
> -@item @code{var1: string}
> -Not documented
> -@*@b{If:} @code{defined(IFSTR)}
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{variant1-feat}
> -a feature
> -@item @code{member-feat}
> -a member feature
> -@end table
> -
> -@end deftp
> -
> -
> -
> -@deftp {Object} Variant2
> -
> -
> -
> -@end deftp
> -
> -
> -
> -@deftp {Object} Object
> -
> -
> -
> -@b{Members:}
> -@table @asis
> -@item The members of @code{Base}
> -@item The members of @code{Variant1} when @code{base1} is @t{"one"}
> -@item The members of @code{Variant2} when @code{base1} is @t{"two"}
> (@b{If:} @code{IFTWO})
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{union-feat1}
> -a feature
> -@end table
> -
> -@end deftp
> -
> -
> -
> -@deftp {Object} SugaredUnion
> -
> -
> -
> -@b{Members:}
> -@table @asis
> -@item @code{type}
> -One of @t{"one"}, @t{"two"}
> -@item @code{data: Variant1} when @code{type} is @t{"one"}
> -@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:}
> @code{IFTWO})
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{union-feat2}
> -a feature
> -@end table
> -
> -@end deftp
> -
> -
> -
> -@deftp {Alternate} Alternate
> -
> -
> -
> -@b{Members:}
> -@table @asis
> -@item @code{i: int}
> -an integer
> -@code{b} is undocumented
> -@item @code{b: boolean}
> -Not documented
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{alt-feat}
> -a feature
> -@end table
> -
> -@end deftp
> -
> -
> -@subsection Another subsection
> -
> -
> -@deftypefn Command {} cmd
> -
> -
> -
> -@b{Arguments:}
> -@table @asis
> -@item @code{arg1: int}
> -the first argument
> -@item @code{arg2: string} (optional)
> -the second
> -argument
> -@item @code{arg3: boolean}
> -Not documented
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{cmd-feat1}
> -a feature
> -@item @code{cmd-feat2}
> -another feature
> -@end table
> -
> -@b{Note:}
> -@code{arg3} is undocumented
> -
> -@b{Returns:}
> -@code{Object}
> -
> -@b{TODO:}
> -frobnicate
> -
> -@b{Notes:}
> -@itemize @minus
> -@item
> -Lorem ipsum dolor sit amet
> -@item
> -Ut enim ad minim veniam
> -
> -@end itemize
> -
> -Duis aute irure dolor
> -
> -@b{Example:}
> -@example
> --> in
> -<- out
> -@end example
> -
> -@b{Examples:}
> -@example
> -- *verbatim*
> -- @{braces@}
> -@end example
> -
> -@b{Since:}
> -2.10
> -
> -@end deftypefn
> -
> -
> -
> -@deftypefn Command {} cmd-boxed
> -
> -If you're bored enough to read this, go see a video of boxed cats
> -
> -@b{Arguments:} the members of @code{Object}
> -
> -@b{Features:}
> -@table @asis
> -@item @code{cmd-feat1}
> -a feature
> -@item @code{cmd-feat2}
> -another feature
> -@end table
> -
> -@b{Example:}
> -@example
> --> in
> -
> -<- out
> -@end example
> -
> -@end deftypefn
> -
> -
> -
> -@deftypefn Event {} EVT-BOXED
> -
> -
> -
> -@b{Arguments:} the members of @code{Object}
> -
> -@b{Features:}
> -@table @asis
> -@item @code{feat3}
> -a feature
> -@end table
> -
> -@end deftypefn
> -
> +@c AUTOMATICALLY GENERATED, DO NOT MODIFY
> +
> +@section Section
> +
> +@subsection Subsection
> +
> +@strong{strong} @emph{with emphasis}
> +@code{var} @{in braces@}
> +@itemize @bullet
> +@item
> +List item one
> +@item
> +Two, multiple
> +lines
> +
> +@item
> +Three
> +Still in list
> +
> +@end itemize
> +
> +Not in list
> +@itemize @minus
> +@item
> +Second list
> +Note: still in list
> +
> +@end itemize
> +
> +Note: not in list
> +@enumerate
> +@item
> +Third list
> +is numbered
> +
> +@item
> +another item
> +
> +@example
> +example
> +@end example
> +
> +@example
> +multiple lines
> +@end example
> +
> +
> +@end enumerate
> +
> +Returns: the King
> +Since: the first age
> +Notes:
> +
> +@enumerate
> +@item
> +Lorem ipsum dolor sit amet
> +
> +@item
> +Ut enim ad minim veniam
> +
> +@end enumerate
> +
> +Duis aute irure dolor
> +
> +Example:
> +
> +-> in
> +<- out
> +Examples:
> +@itemize @minus
> +@item
> +@strong{verbatim}
> +@item
> +@{braces@}
> +@end itemize
> +
> +
> +
> +@deftp {Enum} Enum
> +
> +
> +
> +@b{Values:}
> +@table @asis
> +@item @code{one}
> +The @emph{one} @{and only@}
> +@*@b{If:} @code{defined(IFONE)}
> +@item @code{two}
> +Not documented
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{enum-feat}
> +Also @emph{one} @{and only@}
> +@end table
> +@code{two} is undocumented
> +
> +@b{If:} @code{defined(IFCOND)}
> +@end deftp
> +
> +
> +
> +@deftp {Object} Base
> +
> +
> +
> +@b{Members:}
> +@table @asis
> +@item @code{base1: Enum}
> +the first member
> +@end table
> +
> +@end deftp
> +
> +
> +
> +@deftp {Object} Variant1
> +
> +A paragraph
> +
> +Another paragraph (but no @code{var}: line)
> +
> +@b{Members:}
> +@table @asis
> +@item @code{var1: string}
> +Not documented
> +@*@b{If:} @code{defined(IFSTR)}
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{variant1-feat}
> +a feature
> +@item @code{member-feat}
> +a member feature
> +@end table
> +
> +@end deftp
> +
> +
> +
> +@deftp {Object} Variant2
> +
> +
> +
> +@end deftp
> +
> +
> +
> +@deftp {Object} Object
> +
> +
> +
> +@b{Members:}
> +@table @asis
> +@item The members of @code{Base}
> +@item The members of @code{Variant1} when @code{base1} is @t{"one"}
> +@item The members of @code{Variant2} when @code{base1} is @t{"two"}
> (@b{If:} @code{IFTWO})
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{union-feat1}
> +a feature
> +@end table
> +
> +@end deftp
> +
> +
> +
> +@deftp {Object} SugaredUnion
> +
> +
> +
> +@b{Members:}
> +@table @asis
> +@item @code{type}
> +One of @t{"one"}, @t{"two"}
> +@item @code{data: Variant1} when @code{type} is @t{"one"}
> +@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:}
> @code{IFTWO})
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{union-feat2}
> +a feature
> +@end table
> +
> +@end deftp
> +
> +
> +
> +@deftp {Alternate} Alternate
> +
> +
> +
> +@b{Members:}
> +@table @asis
> +@item @code{i: int}
> +an integer
> +@code{b} is undocumented
> +@item @code{b: boolean}
> +Not documented
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{alt-feat}
> +a feature
> +@end table
> +
> +@end deftp
> +
> +
> +@subsection Another subsection
> +
> +
> +@deftypefn Command {} cmd
> +
> +
> +
> +@b{Arguments:}
> +@table @asis
> +@item @code{arg1: int}
> +the first argument
> +@item @code{arg2: string} (optional)
> +the second
> +argument
> +@item @code{arg3: boolean}
> +Not documented
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{cmd-feat1}
> +a feature
> +@item @code{cmd-feat2}
> +another feature
> +@end table
> +
> +@b{Note:}
> +@code{arg3} is undocumented
> +
> +@b{Returns:}
> +@code{Object}
> +
> +@b{TODO:}
> +frobnicate
> +
> +@b{Notes:}
> +@itemize @minus
> +@item
> +Lorem ipsum dolor sit amet
> +@item
> +Ut enim ad minim veniam
> +
> +@end itemize
> +
> +Duis aute irure dolor
> +
> +@b{Example:}
> +@example
> +-> in
> +<- out
> +@end example
> +
> +@b{Examples:}
> +@example
> +- *verbatim*
> +- @{braces@}
> +@end example
> +
> +@b{Since:}
> +2.10
> +
> +@end deftypefn
> +
> +
> +
> +@deftypefn Command {} cmd-boxed
> +
> +If you're bored enough to read this, go see a video of boxed cats
> +
> +@b{Arguments:} the members of @code{Object}
> +
> +@b{Features:}
> +@table @asis
> +@item @code{cmd-feat1}
> +a feature
> +@item @code{cmd-feat2}
> +another feature
> +@end table
> +
> +@b{Example:}
> +@example
> +-> in
> +
> +<- out
> +@end example
> +
> +@end deftypefn
> +
> +
> +
> +@deftypefn Event {} EVT-BOXED
> +
> +
> +
> +@b{Arguments:} the members of @code{Object}
> +
> +@b{Features:}
> +@table @asis
> +@item @code{feat3}
> +a feature
> +@end table
> +
> +@end deftypefn
> +
> make: *** [Makefile.mtest:85: check-qapi-doc] Error 1
> make: *** Waiting for unfinished jobs....
> Running test QAPI doc
> ---
> C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/../cirrus-c=
i-build/tests/qapi-schema/doc-good.texi
>   2020-09-02 10:26:02.396028200 -0700
> +++
> C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/tests/qapi-=
schema/doc-good-qapi-doc.texi
>     2020-09-02 10:43:09.849568200 -0700
> @@ -1,319 +1,319 @@
> -@c AUTOMATICALLY GENERATED, DO NOT MODIFY
> -
> -@section Section
> -
> -@subsection Subsection
> -
> -@strong{strong} @emph{with emphasis}
> -@code{var} @{in braces@}
> -@itemize @bullet
> -@item
> -List item one
> -@item
> -Two, multiple
> -lines
> -
> -@item
> -Three
> -Still in list
> -
> -@end itemize
> -
> -Not in list
> -@itemize @minus
> -@item
> -Second list
> -Note: still in list
> -
> -@end itemize
> -
> -Note: not in list
> -@enumerate
> -@item
> -Third list
> -is numbered
> -
> -@item
> -another item
> -
> -@example
> -example
> -@end example
> -
> -@example
> -multiple lines
> -@end example
> -
> -
> -@end enumerate
> -
> -Returns: the King
> -Since: the first age
> -Notes:
> -
> -@enumerate
> -@item
> -Lorem ipsum dolor sit amet
> -
> -@item
> -Ut enim ad minim veniam
> -
> -@end enumerate
> -
> -Duis aute irure dolor
> -
> -Example:
> -
> --> in
> -<- out
> -Examples:
> -@itemize @minus
> -@item
> -@strong{verbatim}
> -@item
> -@{braces@}
> -@end itemize
> -
> -
> -
> -@deftp {Enum} Enum
> -
> -
> -
> -@b{Values:}
> -@table @asis
> -@item @code{one}
> -The @emph{one} @{and only@}
> -@*@b{If:} @code{defined(IFONE)}
> -@item @code{two}
> -Not documented
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{enum-feat}
> -Also @emph{one} @{and only@}
> -@end table
> -@code{two} is undocumented
> -
> -@b{If:} @code{defined(IFCOND)}
> -@end deftp
> -
> -
> -
> -@deftp {Object} Base
> -
> -
> -
> -@b{Members:}
> -@table @asis
> -@item @code{base1: Enum}
> -the first member
> -@end table
> -
> -@end deftp
> -
> -
> -
> -@deftp {Object} Variant1
> -
> -A paragraph
> -
> -Another paragraph (but no @code{var}: line)
> -
> -@b{Members:}
> -@table @asis
> -@item @code{var1: string}
> -Not documented
> -@*@b{If:} @code{defined(IFSTR)}
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{variant1-feat}
> -a feature
> -@item @code{member-feat}
> -a member feature
> -@end table
> -
> -@end deftp
> -
> -
> -
> -@deftp {Object} Variant2
> -
> -
> -
> -@end deftp
> -
> -
> -
> -@deftp {Object} Object
> -
> -
> -
> -@b{Members:}
> -@table @asis
> -@item The members of @code{Base}
> -@item The members of @code{Variant1} when @code{base1} is @t{"one"}
> -@item The members of @code{Variant2} when @code{base1} is @t{"two"}
> (@b{If:} @code{IFTWO})
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{union-feat1}
> -a feature
> -@end table
> -
> -@end deftp
> -
> -
> -
> -@deftp {Object} SugaredUnion
> -
> -
> -
> -@b{Members:}
> -@table @asis
> -@item @code{type}
> -One of @t{"one"}, @t{"two"}
> -@item @code{data: Variant1} when @code{type} is @t{"one"}
> -@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:}
> @code{IFTWO})
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{union-feat2}
> -a feature
> -@end table
> -
> -@end deftp
> -
> -
> -
> -@deftp {Alternate} Alternate
> -
> -
> -
> -@b{Members:}
> -@table @asis
> -@item @code{i: int}
> -an integer
> -@code{b} is undocumented
> -@item @code{b: boolean}
> -Not documented
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{alt-feat}
> -a feature
> -@end table
> -
> -@end deftp
> -
> -
> -@subsection Another subsection
> -
> -
> -@deftypefn Command {} cmd
> -
> -
> -
> -@b{Arguments:}
> -@table @asis
> -@item @code{arg1: int}
> -the first argument
> -@item @code{arg2: string} (optional)
> -the second
> -argument
> -@item @code{arg3: boolean}
> -Not documented
> -@end table
> -
> -@b{Features:}
> -@table @asis
> -@item @code{cmd-feat1}
> -a feature
> -@item @code{cmd-feat2}
> -another feature
> -@end table
> -
> -@b{Note:}
> -@code{arg3} is undocumented
> -
> -@b{Returns:}
> -@code{Object}
> -
> -@b{TODO:}
> -frobnicate
> -
> -@b{Notes:}
> -@itemize @minus
> -@item
> -Lorem ipsum dolor sit amet
> -@item
> -Ut enim ad minim veniam
> -
> -@end itemize
> -
> -Duis aute irure dolor
> -
> -@b{Example:}
> -@example
> --> in
> -<- out
> -@end example
> -
> -@b{Examples:}
> -@example
> -- *verbatim*
> -- @{braces@}
> -@end example
> -
> -@b{Since:}
> -2.10
> -
> -@end deftypefn
> -
> -
> -
> -@deftypefn Command {} cmd-boxed
> -
> -If you're bored enough to read this, go see a video of boxed cats
> -
> -@b{Arguments:} the members of @code{Object}
> -
> -@b{Features:}
> -@table @asis
> -@item @code{cmd-feat1}
> -a feature
> -@item @code{cmd-feat2}
> -another feature
> -@end table
> -
> -@b{Example:}
> -@example
> --> in
> -
> -<- out
> -@end example
> -
> -@end deftypefn
> -
> -
> -
> -@deftypefn Event {} EVT-BOXED
> -
> -
> -
> -@b{Arguments:} the members of @code{Object}
> -
> -@b{Features:}
> -@table @asis
> -@item @code{feat3}
> -a feature
> -@end table
> -
> -@end deftypefn
> -
> +@c AUTOMATICALLY GENERATED, DO NOT MODIFY
> +
> +@section Section
> +
> +@subsection Subsection
> +
> +@strong{strong} @emph{with emphasis}
> +@code{var} @{in braces@}
> +@itemize @bullet
> +@item
> +List item one
> +@item
> +Two, multiple
> +lines
> +
> +@item
> +Three
> +Still in list
> +
> +@end itemize
> +
> +Not in list
> +@itemize @minus
> +@item
> +Second list
> +Note: still in list
> +
> +@end itemize
> +
> +Note: not in list
> +@enumerate
> +@item
> +Third list
> +is numbered
> +
> +@item
> +another item
> +
> +@example
> +example
> +@end example
> +
> +@example
> +multiple lines
> +@end example
> +
> +
> +@end enumerate
> +
> +Returns: the King
> +Since: the first age
> +Notes:
> +
> +@enumerate
> +@item
> +Lorem ipsum dolor sit amet
> +
> +@item
> +Ut enim ad minim veniam
> +
> +@end enumerate
> +
> +Duis aute irure dolor
> +
> +Example:
> +
> +-> in
> +<- out
> +Examples:
> +@itemize @minus
> +@item
> +@strong{verbatim}
> +@item
> +@{braces@}
> +@end itemize
> +
> +
> +
> +@deftp {Enum} Enum
> +
> +
> +
> +@b{Values:}
> +@table @asis
> +@item @code{one}
> +The @emph{one} @{and only@}
> +@*@b{If:} @code{defined(IFONE)}
> +@item @code{two}
> +Not documented
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{enum-feat}
> +Also @emph{one} @{and only@}
> +@end table
> +@code{two} is undocumented
> +
> +@b{If:} @code{defined(IFCOND)}
> +@end deftp
> +
> +
> +
> +@deftp {Object} Base
> +
> +
> +
> +@b{Members:}
> +@table @asis
> +@item @code{base1: Enum}
> +the first member
> +@end table
> +
> +@end deftp
> +
> +
> +
> +@deftp {Object} Variant1
> +
> +A paragraph
> +
> +Another paragraph (but no @code{var}: line)
> +
> +@b{Members:}
> +@table @asis
> +@item @code{var1: string}
> +Not documented
> +@*@b{If:} @code{defined(IFSTR)}
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{variant1-feat}
> +a feature
> +@item @code{member-feat}
> +a member feature
> +@end table
> +
> +@end deftp
> +
> +
> +
> +@deftp {Object} Variant2
> +
> +
> +
> +@end deftp
> +
> +
> +
> +@deftp {Object} Object
> +
> +
> +
> +@b{Members:}
> +@table @asis
> +@item The members of @code{Base}
> +@item The members of @code{Variant1} when @code{base1} is @t{"one"}
> +@item The members of @code{Variant2} when @code{base1} is @t{"two"}
> (@b{If:} @code{IFTWO})
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{union-feat1}
> +a feature
> +@end table
> +
> +@end deftp
> +
> +
> +
> +@deftp {Object} SugaredUnion
> +
> +
> +
> +@b{Members:}
> +@table @asis
> +@item @code{type}
> +One of @t{"one"}, @t{"two"}
> +@item @code{data: Variant1} when @code{type} is @t{"one"}
> +@item @code{data: Variant2} when @code{type} is @t{"two"} (@b{If:}
> @code{IFTWO})
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{union-feat2}
> +a feature
> +@end table
> +
> +@end deftp
> +
> +
> +
> +@deftp {Alternate} Alternate
> +
> +
> +
> +@b{Members:}
> +@table @asis
> +@item @code{i: int}
> +an integer
> +@code{b} is undocumented
> +@item @code{b: boolean}
> +Not documented
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{alt-feat}
> +a feature
> +@end table
> +
> +@end deftp
> +
> +
> +@subsection Another subsection
> +
> +
> +@deftypefn Command {} cmd
> +
> +
> +
> +@b{Arguments:}
> +@table @asis
> +@item @code{arg1: int}
> +the first argument
> +@item @code{arg2: string} (optional)
> +the second
> +argument
> +@item @code{arg3: boolean}
> +Not documented
> +@end table
> +
> +@b{Features:}
> +@table @asis
> +@item @code{cmd-feat1}
> +a feature
> +@item @code{cmd-feat2}
> +another feature
> +@end table
> +
> +@b{Note:}
> +@code{arg3} is undocumented
> +
> +@b{Returns:}
> +@code{Object}
> +
> +@b{TODO:}
> +frobnicate
> +
> +@b{Notes:}
> +@itemize @minus
> +@item
> +Lorem ipsum dolor sit amet
> +@item
> +Ut enim ad minim veniam
> +
> +@end itemize
> +
> +Duis aute irure dolor
> +
> +@b{Example:}
> +@example
> +-> in
> +<- out
> +@end example
> +
> +@b{Examples:}
> +@example
> +- *verbatim*
> +- @{braces@}
> +@end example
> +
> +@b{Since:}
> +2.10
> +
> +@end deftypefn
> +
> +
> +
> +@deftypefn Command {} cmd-boxed
> +
> +If you're bored enough to read this, go see a video of boxed cats
> +
> +@b{Arguments:} the members of @code{Object}
> +
> +@b{Features:}
> +@table @asis
> +@item @code{cmd-feat1}
> +a feature
> +@item @code{cmd-feat2}
> +another feature
> +@end table
> +
> +@b{Example:}
> +@example
> +-> in
> +
> +<- out
> +@end example
> +
> +@end deftypefn
> +
> +
> +
> +@deftypefn Event {} EVT-BOXED
> +
> +
> +
> +@b{Arguments:} the members of @code{Object}
> +
> +@b{Features:}
> +@table @asis
> +@item @code{feat3}
> +a feature
> +@end table
> +
> +@end deftypefn
> +
> make: *** [Makefile.mtest:63: check-qapi-schema] Error 1
>
> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> ---
>  tests/qapi-schema/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.buil=
d
> index c87d141417..f1449298b0 100644
> --- a/tests/qapi-schema/meson.build
> +++ b/tests/qapi-schema/meson.build
> @@ -220,6 +220,6 @@ qapi_doc =3D custom_target('QAPI doc',
>
>  # "full_path()" needed here to work around
>  # https://github.com/mesonbuild/meson/issues/7585
> -test('QAPI doc', diff, args: ['-u', files('doc-good.texi'),
> qapi_doc[0].full_path()],
> +test('QAPI doc', diff, args: ['-b', '-u', files('doc-good.texi'),
> qapi_doc[0].full_path()],
>       depends: qapi_doc,
>       suite: ['qapi-schema', 'qapi-doc'])
> --
> 2.28.0.windows.1
>
>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000563a4605aebce5b3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Forgot your=C2=A0</div><br><div class=3D"gmail_quote"=
><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 8, 2020 at 1:48 AM Yongg=
ang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">O=
r the tests result would cause following test failure:<br>
Running test QAPI doc<br>
=C2=A0 LINK=C2=A0 =C2=A0 tests/check-qdict.exe<br>
--- C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/../cirrus=
-ci-build/tests/qapi-schema/doc-good.texi=C2=A0 =C2=A0 2020-09-02 10:26:02.=
396028200 -0700<br>
+++ C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/tests/qap=
i-schema/doc-good-qapi-doc.texi=C2=A0 =C2=A0 =C2=A0 2020-09-02 10:43:09.849=
568200 -0700<br>
@@ -1,319 +1,319 @@<br>
-@c AUTOMATICALLY GENERATED, DO NOT MODIFY<br>
-<br>
-@section Section<br>
-<br>
-@subsection Subsection<br>
-<br>
-@strong{strong} @emph{with emphasis}<br>
-@code{var} @{in braces@}<br>
-@itemize @bullet<br>
-@item<br>
-List item one<br>
-@item<br>
-Two, multiple<br>
-lines<br>
-<br>
-@item<br>
-Three<br>
-Still in list<br>
-<br>
-@end itemize<br>
-<br>
-Not in list<br>
-@itemize @minus<br>
-@item<br>
-Second list<br>
-Note: still in list<br>
-<br>
-@end itemize<br>
-<br>
-Note: not in list<br>
-@enumerate<br>
-@item<br>
-Third list<br>
-is numbered<br>
-<br>
-@item<br>
-another item<br>
-<br>
-@example<br>
-example<br>
-@end example<br>
-<br>
-@example<br>
-multiple lines<br>
-@end example<br>
-<br>
-<br>
-@end enumerate<br>
-<br>
-Returns: the King<br>
-Since: the first age<br>
-Notes:<br>
-<br>
-@enumerate<br>
-@item<br>
-Lorem ipsum dolor sit amet<br>
-<br>
-@item<br>
-Ut enim ad minim veniam<br>
-<br>
-@end enumerate<br>
-<br>
-Duis aute irure dolor<br>
-<br>
-Example:<br>
-<br>
--&gt; in<br>
-&lt;- out<br>
-Examples:<br>
-@itemize @minus<br>
-@item<br>
-@strong{verbatim}<br>
-@item<br>
-@{braces@}<br>
-@end itemize<br>
-<br>
-<br>
-<br>
-@deftp {Enum} Enum<br>
-<br>
-<br>
-<br>
-@b{Values:}<br>
-@table @asis<br>
-@item @code{one}<br>
-The @emph{one} @{and only@}<br>
-@*@b{If:} @code{defined(IFONE)}<br>
-@item @code{two}<br>
-Not documented<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{enum-feat}<br>
-Also @emph{one} @{and only@}<br>
-@end table<br>
-@code{two} is undocumented<br>
-<br>
-@b{If:} @code{defined(IFCOND)}<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Object} Base<br>
-<br>
-<br>
-<br>
-@b{Members:}<br>
-@table @asis<br>
-@item @code{base1: Enum}<br>
-the first member<br>
-@end table<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Object} Variant1<br>
-<br>
-A paragraph<br>
-<br>
-Another paragraph (but no @code{var}: line)<br>
-<br>
-@b{Members:}<br>
-@table @asis<br>
-@item @code{var1: string}<br>
-Not documented<br>
-@*@b{If:} @code{defined(IFSTR)}<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{variant1-feat}<br>
-a feature<br>
-@item @code{member-feat}<br>
-a member feature<br>
-@end table<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Object} Variant2<br>
-<br>
-<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Object} Object<br>
-<br>
-<br>
-<br>
-@b{Members:}<br>
-@table @asis<br>
-@item The members of @code{Base}<br>
-@item The members of @code{Variant1} when @code{base1} is @t{&quot;one&quo=
t;}<br>
-@item The members of @code{Variant2} when @code{base1} is @t{&quot;two&quo=
t;} (@b{If:} @code{IFTWO})<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{union-feat1}<br>
-a feature<br>
-@end table<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Object} SugaredUnion<br>
-<br>
-<br>
-<br>
-@b{Members:}<br>
-@table @asis<br>
-@item @code{type}<br>
-One of @t{&quot;one&quot;}, @t{&quot;two&quot;}<br>
-@item @code{data: Variant1} when @code{type} is @t{&quot;one&quot;}<br>
-@item @code{data: Variant2} when @code{type} is @t{&quot;two&quot;} (@b{If=
:} @code{IFTWO})<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{union-feat2}<br>
-a feature<br>
-@end table<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Alternate} Alternate<br>
-<br>
-<br>
-<br>
-@b{Members:}<br>
-@table @asis<br>
-@item @code{i: int}<br>
-an integer<br>
-@code{b} is undocumented<br>
-@item @code{b: boolean}<br>
-Not documented<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{alt-feat}<br>
-a feature<br>
-@end table<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-@subsection Another subsection<br>
-<br>
-<br>
-@deftypefn Command {} cmd<br>
-<br>
-<br>
-<br>
-@b{Arguments:}<br>
-@table @asis<br>
-@item @code{arg1: int}<br>
-the first argument<br>
-@item @code{arg2: string} (optional)<br>
-the second<br>
-argument<br>
-@item @code{arg3: boolean}<br>
-Not documented<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{cmd-feat1}<br>
-a feature<br>
-@item @code{cmd-feat2}<br>
-another feature<br>
-@end table<br>
-<br>
-@b{Note:}<br>
-@code{arg3} is undocumented<br>
-<br>
-@b{Returns:}<br>
-@code{Object}<br>
-<br>
-@b{TODO:}<br>
-frobnicate<br>
-<br>
-@b{Notes:}<br>
-@itemize @minus<br>
-@item<br>
-Lorem ipsum dolor sit amet<br>
-@item<br>
-Ut enim ad minim veniam<br>
-<br>
-@end itemize<br>
-<br>
-Duis aute irure dolor<br>
-<br>
-@b{Example:}<br>
-@example<br>
--&gt; in<br>
-&lt;- out<br>
-@end example<br>
-<br>
-@b{Examples:}<br>
-@example<br>
-- *verbatim*<br>
-- @{braces@}<br>
-@end example<br>
-<br>
-@b{Since:}<br>
-2.10<br>
-<br>
-@end deftypefn<br>
-<br>
-<br>
-<br>
-@deftypefn Command {} cmd-boxed<br>
-<br>
-If you&#39;re bored enough to read this, go see a video of boxed cats<br>
-<br>
-@b{Arguments:} the members of @code{Object}<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{cmd-feat1}<br>
-a feature<br>
-@item @code{cmd-feat2}<br>
-another feature<br>
-@end table<br>
-<br>
-@b{Example:}<br>
-@example<br>
--&gt; in<br>
-<br>
-&lt;- out<br>
-@end example<br>
-<br>
-@end deftypefn<br>
-<br>
-<br>
-<br>
-@deftypefn Event {} EVT-BOXED<br>
-<br>
-<br>
-<br>
-@b{Arguments:} the members of @code{Object}<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{feat3}<br>
-a feature<br>
-@end table<br>
-<br>
-@end deftypefn<br>
-<br>
+@c AUTOMATICALLY GENERATED, DO NOT MODIFY<br>
+<br>
+@section Section<br>
+<br>
+@subsection Subsection<br>
+<br>
+@strong{strong} @emph{with emphasis}<br>
+@code{var} @{in braces@}<br>
+@itemize @bullet<br>
+@item<br>
+List item one<br>
+@item<br>
+Two, multiple<br>
+lines<br>
+<br>
+@item<br>
+Three<br>
+Still in list<br>
+<br>
+@end itemize<br>
+<br>
+Not in list<br>
+@itemize @minus<br>
+@item<br>
+Second list<br>
+Note: still in list<br>
+<br>
+@end itemize<br>
+<br>
+Note: not in list<br>
+@enumerate<br>
+@item<br>
+Third list<br>
+is numbered<br>
+<br>
+@item<br>
+another item<br>
+<br>
+@example<br>
+example<br>
+@end example<br>
+<br>
+@example<br>
+multiple lines<br>
+@end example<br>
+<br>
+<br>
+@end enumerate<br>
+<br>
+Returns: the King<br>
+Since: the first age<br>
+Notes:<br>
+<br>
+@enumerate<br>
+@item<br>
+Lorem ipsum dolor sit amet<br>
+<br>
+@item<br>
+Ut enim ad minim veniam<br>
+<br>
+@end enumerate<br>
+<br>
+Duis aute irure dolor<br>
+<br>
+Example:<br>
+<br>
+-&gt; in<br>
+&lt;- out<br>
+Examples:<br>
+@itemize @minus<br>
+@item<br>
+@strong{verbatim}<br>
+@item<br>
+@{braces@}<br>
+@end itemize<br>
+<br>
+<br>
+<br>
+@deftp {Enum} Enum<br>
+<br>
+<br>
+<br>
+@b{Values:}<br>
+@table @asis<br>
+@item @code{one}<br>
+The @emph{one} @{and only@}<br>
+@*@b{If:} @code{defined(IFONE)}<br>
+@item @code{two}<br>
+Not documented<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{enum-feat}<br>
+Also @emph{one} @{and only@}<br>
+@end table<br>
+@code{two} is undocumented<br>
+<br>
+@b{If:} @code{defined(IFCOND)}<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Object} Base<br>
+<br>
+<br>
+<br>
+@b{Members:}<br>
+@table @asis<br>
+@item @code{base1: Enum}<br>
+the first member<br>
+@end table<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Object} Variant1<br>
+<br>
+A paragraph<br>
+<br>
+Another paragraph (but no @code{var}: line)<br>
+<br>
+@b{Members:}<br>
+@table @asis<br>
+@item @code{var1: string}<br>
+Not documented<br>
+@*@b{If:} @code{defined(IFSTR)}<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{variant1-feat}<br>
+a feature<br>
+@item @code{member-feat}<br>
+a member feature<br>
+@end table<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Object} Variant2<br>
+<br>
+<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Object} Object<br>
+<br>
+<br>
+<br>
+@b{Members:}<br>
+@table @asis<br>
+@item The members of @code{Base}<br>
+@item The members of @code{Variant1} when @code{base1} is @t{&quot;one&quo=
t;}<br>
+@item The members of @code{Variant2} when @code{base1} is @t{&quot;two&quo=
t;} (@b{If:} @code{IFTWO})<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{union-feat1}<br>
+a feature<br>
+@end table<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Object} SugaredUnion<br>
+<br>
+<br>
+<br>
+@b{Members:}<br>
+@table @asis<br>
+@item @code{type}<br>
+One of @t{&quot;one&quot;}, @t{&quot;two&quot;}<br>
+@item @code{data: Variant1} when @code{type} is @t{&quot;one&quot;}<br>
+@item @code{data: Variant2} when @code{type} is @t{&quot;two&quot;} (@b{If=
:} @code{IFTWO})<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{union-feat2}<br>
+a feature<br>
+@end table<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Alternate} Alternate<br>
+<br>
+<br>
+<br>
+@b{Members:}<br>
+@table @asis<br>
+@item @code{i: int}<br>
+an integer<br>
+@code{b} is undocumented<br>
+@item @code{b: boolean}<br>
+Not documented<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{alt-feat}<br>
+a feature<br>
+@end table<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+@subsection Another subsection<br>
+<br>
+<br>
+@deftypefn Command {} cmd<br>
+<br>
+<br>
+<br>
+@b{Arguments:}<br>
+@table @asis<br>
+@item @code{arg1: int}<br>
+the first argument<br>
+@item @code{arg2: string} (optional)<br>
+the second<br>
+argument<br>
+@item @code{arg3: boolean}<br>
+Not documented<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{cmd-feat1}<br>
+a feature<br>
+@item @code{cmd-feat2}<br>
+another feature<br>
+@end table<br>
+<br>
+@b{Note:}<br>
+@code{arg3} is undocumented<br>
+<br>
+@b{Returns:}<br>
+@code{Object}<br>
+<br>
+@b{TODO:}<br>
+frobnicate<br>
+<br>
+@b{Notes:}<br>
+@itemize @minus<br>
+@item<br>
+Lorem ipsum dolor sit amet<br>
+@item<br>
+Ut enim ad minim veniam<br>
+<br>
+@end itemize<br>
+<br>
+Duis aute irure dolor<br>
+<br>
+@b{Example:}<br>
+@example<br>
+-&gt; in<br>
+&lt;- out<br>
+@end example<br>
+<br>
+@b{Examples:}<br>
+@example<br>
+- *verbatim*<br>
+- @{braces@}<br>
+@end example<br>
+<br>
+@b{Since:}<br>
+2.10<br>
+<br>
+@end deftypefn<br>
+<br>
+<br>
+<br>
+@deftypefn Command {} cmd-boxed<br>
+<br>
+If you&#39;re bored enough to read this, go see a video of boxed cats<br>
+<br>
+@b{Arguments:} the members of @code{Object}<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{cmd-feat1}<br>
+a feature<br>
+@item @code{cmd-feat2}<br>
+another feature<br>
+@end table<br>
+<br>
+@b{Example:}<br>
+@example<br>
+-&gt; in<br>
+<br>
+&lt;- out<br>
+@end example<br>
+<br>
+@end deftypefn<br>
+<br>
+<br>
+<br>
+@deftypefn Event {} EVT-BOXED<br>
+<br>
+<br>
+<br>
+@b{Arguments:} the members of @code{Object}<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{feat3}<br>
+a feature<br>
+@end table<br>
+<br>
+@end deftypefn<br>
+<br>
make: *** [Makefile.mtest:85: check-qapi-doc] Error 1<br>
make: *** Waiting for unfinished jobs....<br>
Running test QAPI doc<br>
--- C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/../cirrus=
-ci-build/tests/qapi-schema/doc-good.texi=C2=A0 =C2=A0 2020-09-02 10:26:02.=
396028200 -0700<br>
+++ C:/Users/ContainerAdministrator/AppData/Local/Temp/qemu-build/tests/qap=
i-schema/doc-good-qapi-doc.texi=C2=A0 =C2=A0 =C2=A0 2020-09-02 10:43:09.849=
568200 -0700<br>
@@ -1,319 +1,319 @@<br>
-@c AUTOMATICALLY GENERATED, DO NOT MODIFY<br>
-<br>
-@section Section<br>
-<br>
-@subsection Subsection<br>
-<br>
-@strong{strong} @emph{with emphasis}<br>
-@code{var} @{in braces@}<br>
-@itemize @bullet<br>
-@item<br>
-List item one<br>
-@item<br>
-Two, multiple<br>
-lines<br>
-<br>
-@item<br>
-Three<br>
-Still in list<br>
-<br>
-@end itemize<br>
-<br>
-Not in list<br>
-@itemize @minus<br>
-@item<br>
-Second list<br>
-Note: still in list<br>
-<br>
-@end itemize<br>
-<br>
-Note: not in list<br>
-@enumerate<br>
-@item<br>
-Third list<br>
-is numbered<br>
-<br>
-@item<br>
-another item<br>
-<br>
-@example<br>
-example<br>
-@end example<br>
-<br>
-@example<br>
-multiple lines<br>
-@end example<br>
-<br>
-<br>
-@end enumerate<br>
-<br>
-Returns: the King<br>
-Since: the first age<br>
-Notes:<br>
-<br>
-@enumerate<br>
-@item<br>
-Lorem ipsum dolor sit amet<br>
-<br>
-@item<br>
-Ut enim ad minim veniam<br>
-<br>
-@end enumerate<br>
-<br>
-Duis aute irure dolor<br>
-<br>
-Example:<br>
-<br>
--&gt; in<br>
-&lt;- out<br>
-Examples:<br>
-@itemize @minus<br>
-@item<br>
-@strong{verbatim}<br>
-@item<br>
-@{braces@}<br>
-@end itemize<br>
-<br>
-<br>
-<br>
-@deftp {Enum} Enum<br>
-<br>
-<br>
-<br>
-@b{Values:}<br>
-@table @asis<br>
-@item @code{one}<br>
-The @emph{one} @{and only@}<br>
-@*@b{If:} @code{defined(IFONE)}<br>
-@item @code{two}<br>
-Not documented<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{enum-feat}<br>
-Also @emph{one} @{and only@}<br>
-@end table<br>
-@code{two} is undocumented<br>
-<br>
-@b{If:} @code{defined(IFCOND)}<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Object} Base<br>
-<br>
-<br>
-<br>
-@b{Members:}<br>
-@table @asis<br>
-@item @code{base1: Enum}<br>
-the first member<br>
-@end table<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Object} Variant1<br>
-<br>
-A paragraph<br>
-<br>
-Another paragraph (but no @code{var}: line)<br>
-<br>
-@b{Members:}<br>
-@table @asis<br>
-@item @code{var1: string}<br>
-Not documented<br>
-@*@b{If:} @code{defined(IFSTR)}<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{variant1-feat}<br>
-a feature<br>
-@item @code{member-feat}<br>
-a member feature<br>
-@end table<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Object} Variant2<br>
-<br>
-<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Object} Object<br>
-<br>
-<br>
-<br>
-@b{Members:}<br>
-@table @asis<br>
-@item The members of @code{Base}<br>
-@item The members of @code{Variant1} when @code{base1} is @t{&quot;one&quo=
t;}<br>
-@item The members of @code{Variant2} when @code{base1} is @t{&quot;two&quo=
t;} (@b{If:} @code{IFTWO})<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{union-feat1}<br>
-a feature<br>
-@end table<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Object} SugaredUnion<br>
-<br>
-<br>
-<br>
-@b{Members:}<br>
-@table @asis<br>
-@item @code{type}<br>
-One of @t{&quot;one&quot;}, @t{&quot;two&quot;}<br>
-@item @code{data: Variant1} when @code{type} is @t{&quot;one&quot;}<br>
-@item @code{data: Variant2} when @code{type} is @t{&quot;two&quot;} (@b{If=
:} @code{IFTWO})<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{union-feat2}<br>
-a feature<br>
-@end table<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-<br>
-@deftp {Alternate} Alternate<br>
-<br>
-<br>
-<br>
-@b{Members:}<br>
-@table @asis<br>
-@item @code{i: int}<br>
-an integer<br>
-@code{b} is undocumented<br>
-@item @code{b: boolean}<br>
-Not documented<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{alt-feat}<br>
-a feature<br>
-@end table<br>
-<br>
-@end deftp<br>
-<br>
-<br>
-@subsection Another subsection<br>
-<br>
-<br>
-@deftypefn Command {} cmd<br>
-<br>
-<br>
-<br>
-@b{Arguments:}<br>
-@table @asis<br>
-@item @code{arg1: int}<br>
-the first argument<br>
-@item @code{arg2: string} (optional)<br>
-the second<br>
-argument<br>
-@item @code{arg3: boolean}<br>
-Not documented<br>
-@end table<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{cmd-feat1}<br>
-a feature<br>
-@item @code{cmd-feat2}<br>
-another feature<br>
-@end table<br>
-<br>
-@b{Note:}<br>
-@code{arg3} is undocumented<br>
-<br>
-@b{Returns:}<br>
-@code{Object}<br>
-<br>
-@b{TODO:}<br>
-frobnicate<br>
-<br>
-@b{Notes:}<br>
-@itemize @minus<br>
-@item<br>
-Lorem ipsum dolor sit amet<br>
-@item<br>
-Ut enim ad minim veniam<br>
-<br>
-@end itemize<br>
-<br>
-Duis aute irure dolor<br>
-<br>
-@b{Example:}<br>
-@example<br>
--&gt; in<br>
-&lt;- out<br>
-@end example<br>
-<br>
-@b{Examples:}<br>
-@example<br>
-- *verbatim*<br>
-- @{braces@}<br>
-@end example<br>
-<br>
-@b{Since:}<br>
-2.10<br>
-<br>
-@end deftypefn<br>
-<br>
-<br>
-<br>
-@deftypefn Command {} cmd-boxed<br>
-<br>
-If you&#39;re bored enough to read this, go see a video of boxed cats<br>
-<br>
-@b{Arguments:} the members of @code{Object}<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{cmd-feat1}<br>
-a feature<br>
-@item @code{cmd-feat2}<br>
-another feature<br>
-@end table<br>
-<br>
-@b{Example:}<br>
-@example<br>
--&gt; in<br>
-<br>
-&lt;- out<br>
-@end example<br>
-<br>
-@end deftypefn<br>
-<br>
-<br>
-<br>
-@deftypefn Event {} EVT-BOXED<br>
-<br>
-<br>
-<br>
-@b{Arguments:} the members of @code{Object}<br>
-<br>
-@b{Features:}<br>
-@table @asis<br>
-@item @code{feat3}<br>
-a feature<br>
-@end table<br>
-<br>
-@end deftypefn<br>
-<br>
+@c AUTOMATICALLY GENERATED, DO NOT MODIFY<br>
+<br>
+@section Section<br>
+<br>
+@subsection Subsection<br>
+<br>
+@strong{strong} @emph{with emphasis}<br>
+@code{var} @{in braces@}<br>
+@itemize @bullet<br>
+@item<br>
+List item one<br>
+@item<br>
+Two, multiple<br>
+lines<br>
+<br>
+@item<br>
+Three<br>
+Still in list<br>
+<br>
+@end itemize<br>
+<br>
+Not in list<br>
+@itemize @minus<br>
+@item<br>
+Second list<br>
+Note: still in list<br>
+<br>
+@end itemize<br>
+<br>
+Note: not in list<br>
+@enumerate<br>
+@item<br>
+Third list<br>
+is numbered<br>
+<br>
+@item<br>
+another item<br>
+<br>
+@example<br>
+example<br>
+@end example<br>
+<br>
+@example<br>
+multiple lines<br>
+@end example<br>
+<br>
+<br>
+@end enumerate<br>
+<br>
+Returns: the King<br>
+Since: the first age<br>
+Notes:<br>
+<br>
+@enumerate<br>
+@item<br>
+Lorem ipsum dolor sit amet<br>
+<br>
+@item<br>
+Ut enim ad minim veniam<br>
+<br>
+@end enumerate<br>
+<br>
+Duis aute irure dolor<br>
+<br>
+Example:<br>
+<br>
+-&gt; in<br>
+&lt;- out<br>
+Examples:<br>
+@itemize @minus<br>
+@item<br>
+@strong{verbatim}<br>
+@item<br>
+@{braces@}<br>
+@end itemize<br>
+<br>
+<br>
+<br>
+@deftp {Enum} Enum<br>
+<br>
+<br>
+<br>
+@b{Values:}<br>
+@table @asis<br>
+@item @code{one}<br>
+The @emph{one} @{and only@}<br>
+@*@b{If:} @code{defined(IFONE)}<br>
+@item @code{two}<br>
+Not documented<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{enum-feat}<br>
+Also @emph{one} @{and only@}<br>
+@end table<br>
+@code{two} is undocumented<br>
+<br>
+@b{If:} @code{defined(IFCOND)}<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Object} Base<br>
+<br>
+<br>
+<br>
+@b{Members:}<br>
+@table @asis<br>
+@item @code{base1: Enum}<br>
+the first member<br>
+@end table<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Object} Variant1<br>
+<br>
+A paragraph<br>
+<br>
+Another paragraph (but no @code{var}: line)<br>
+<br>
+@b{Members:}<br>
+@table @asis<br>
+@item @code{var1: string}<br>
+Not documented<br>
+@*@b{If:} @code{defined(IFSTR)}<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{variant1-feat}<br>
+a feature<br>
+@item @code{member-feat}<br>
+a member feature<br>
+@end table<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Object} Variant2<br>
+<br>
+<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Object} Object<br>
+<br>
+<br>
+<br>
+@b{Members:}<br>
+@table @asis<br>
+@item The members of @code{Base}<br>
+@item The members of @code{Variant1} when @code{base1} is @t{&quot;one&quo=
t;}<br>
+@item The members of @code{Variant2} when @code{base1} is @t{&quot;two&quo=
t;} (@b{If:} @code{IFTWO})<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{union-feat1}<br>
+a feature<br>
+@end table<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Object} SugaredUnion<br>
+<br>
+<br>
+<br>
+@b{Members:}<br>
+@table @asis<br>
+@item @code{type}<br>
+One of @t{&quot;one&quot;}, @t{&quot;two&quot;}<br>
+@item @code{data: Variant1} when @code{type} is @t{&quot;one&quot;}<br>
+@item @code{data: Variant2} when @code{type} is @t{&quot;two&quot;} (@b{If=
:} @code{IFTWO})<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{union-feat2}<br>
+a feature<br>
+@end table<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+<br>
+@deftp {Alternate} Alternate<br>
+<br>
+<br>
+<br>
+@b{Members:}<br>
+@table @asis<br>
+@item @code{i: int}<br>
+an integer<br>
+@code{b} is undocumented<br>
+@item @code{b: boolean}<br>
+Not documented<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{alt-feat}<br>
+a feature<br>
+@end table<br>
+<br>
+@end deftp<br>
+<br>
+<br>
+@subsection Another subsection<br>
+<br>
+<br>
+@deftypefn Command {} cmd<br>
+<br>
+<br>
+<br>
+@b{Arguments:}<br>
+@table @asis<br>
+@item @code{arg1: int}<br>
+the first argument<br>
+@item @code{arg2: string} (optional)<br>
+the second<br>
+argument<br>
+@item @code{arg3: boolean}<br>
+Not documented<br>
+@end table<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{cmd-feat1}<br>
+a feature<br>
+@item @code{cmd-feat2}<br>
+another feature<br>
+@end table<br>
+<br>
+@b{Note:}<br>
+@code{arg3} is undocumented<br>
+<br>
+@b{Returns:}<br>
+@code{Object}<br>
+<br>
+@b{TODO:}<br>
+frobnicate<br>
+<br>
+@b{Notes:}<br>
+@itemize @minus<br>
+@item<br>
+Lorem ipsum dolor sit amet<br>
+@item<br>
+Ut enim ad minim veniam<br>
+<br>
+@end itemize<br>
+<br>
+Duis aute irure dolor<br>
+<br>
+@b{Example:}<br>
+@example<br>
+-&gt; in<br>
+&lt;- out<br>
+@end example<br>
+<br>
+@b{Examples:}<br>
+@example<br>
+- *verbatim*<br>
+- @{braces@}<br>
+@end example<br>
+<br>
+@b{Since:}<br>
+2.10<br>
+<br>
+@end deftypefn<br>
+<br>
+<br>
+<br>
+@deftypefn Command {} cmd-boxed<br>
+<br>
+If you&#39;re bored enough to read this, go see a video of boxed cats<br>
+<br>
+@b{Arguments:} the members of @code{Object}<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{cmd-feat1}<br>
+a feature<br>
+@item @code{cmd-feat2}<br>
+another feature<br>
+@end table<br>
+<br>
+@b{Example:}<br>
+@example<br>
+-&gt; in<br>
+<br>
+&lt;- out<br>
+@end example<br>
+<br>
+@end deftypefn<br>
+<br>
+<br>
+<br>
+@deftypefn Event {} EVT-BOXED<br>
+<br>
+<br>
+<br>
+@b{Arguments:} the members of @code{Object}<br>
+<br>
+@b{Features:}<br>
+@table @asis<br>
+@item @code{feat3}<br>
+a feature<br>
+@end table<br>
+<br>
+@end deftypefn<br>
+<br>
make: *** [Makefile.mtest:63: check-qapi-schema] Error 1<br>
<br>
Signed-off-by: Yonggang Luo &lt;<a href=3D"mailto:luoyonggang@gmail.com" ta=
rget=3D"_blank">luoyonggang@gmail.com</a>&gt;<br>
---<br>
=C2=A0tests/qapi-schema/meson.build | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build<=
br>
index c87d141417..f1449298b0 100644<br>
--- a/tests/qapi-schema/meson.build<br>
+++ b/tests/qapi-schema/meson.build<br>
@@ -220,6 +220,6 @@ qapi_doc =3D custom_target(&#39;QAPI doc&#39;,<br>
<br>
=C2=A0# &quot;full_path()&quot; needed here to work around<br>
=C2=A0# <a href=3D"https://github.com/mesonbuild/meson/issues/7585" rel=3D"=
noreferrer" target=3D"_blank">https://github.com/mesonbuild/meson/issues/75=
85</a><br>
-test(&#39;QAPI doc&#39;, diff, args: [&#39;-u&#39;, files(&#39;doc-good.te=
xi&#39;), qapi_doc[0].full_path()],<br>
+test(&#39;QAPI doc&#39;, diff, args: [&#39;-b&#39;, &#39;-u&#39;, files(&#=
39;doc-good.texi&#39;), qapi_doc[0].full_path()],<br>
=C2=A0 =C2=A0 =C2=A0 depends: qapi_doc,<br>
=C2=A0 =C2=A0 =C2=A0 suite: [&#39;qapi-schema&#39;, &#39;qapi-doc&#39;])<br=
>
-- <br>
2.28.0.windows.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=
=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=
=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000563a4605aebce5b3--

