Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB251C47425
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:44:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAB5207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 15:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGQQ6gOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAB5207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33166 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNHoE-0003dd-UG
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 11:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNHmh-0002Hh-PH
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:43:19 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:44760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNHmf-0004Gy-OB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 11:43:19 -0400
Received: by mail-ej1-x644.google.com with SMTP id r7so15639156ejs.11
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 08:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tD2TkqZe2KjzbiWg27fwcR975/q7/4o22MkC+UugYrU=;
 b=lGQQ6gOeg982cCWmNGg/2zbsKmAZtNYOfz9+2UQNJgscc2oPpS8cExRUFiVo/y2/H8
 NCM0ayim0jADa7h46jErNZPV/6aPJfPoZ1QN8LsHANzXaX/yk+WpbzMTgnDHuPtqDLIh
 +VP3n2VAx4di0yYWv7uSzOBmvKFL6JpZ8BBTfBG03jfJOc3RvfOwXX8m3E8WKWi4vdjQ
 3wRDt0BeQ+wA+4kFqBE8A7rzQxpv7OgoSe8yate/YXxY08JA46oMW7YKVQOua7tQNuar
 UYbNwpilwPx4u2stl9Otzvnj0XU91/BWtSEVcCx6IjcnAsvpOR6d4JfMIK2xCv0f28zO
 /b1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tD2TkqZe2KjzbiWg27fwcR975/q7/4o22MkC+UugYrU=;
 b=RFAdy/dHU0c/IGlvOm/IBd4uxq+8hfycBv6rywDermaG4cuMjl60a7ylacBWwnELtE
 HIjDs8+f5XCuSwKsyrV8zELJSBqIQLNpTr3nIFR4UtMd4Ka1sX+U1YnCJxf/uWgMe27M
 5xaxKHMAcJPU+id7dnmpc7Zkqq/vpMxNog9yUzdeF3Iuaz1UZ2qljs11qkGDtQMdf0nb
 +FjU/kAdOvFBDfOr22KfFZ06MY/AuOgqhGXqbbcXLoYISPHP0kCRDR02UgdXCHBkCeD4
 9My3tkBCV1ztoH9rjL8821TQShLy/UlU4hjnEj2mBqTQd2AM21EynpSVU72bisqMfz0o
 WVHg==
X-Gm-Message-State: AOAM532JmsmtVrDMPdjt7tmahav7VTCJZSpb7642/jFPUruVUTPb2mIP
 bMlzQvu0KzMNxNiwOFzb8X+mORFFzu7zPI1JoOr8gQ==
X-Google-Smtp-Source: ABdhPJzTVvI9uul+5UcClW3RQDzfA9g9cEZd7fyk2JG6FLyziNDIYdKIJreAdJdNfMQNfgIlS7A+8t4ddNDGA1jfqSs=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr4352058ejb.85.1601394195122; 
 Tue, 29 Sep 2020 08:43:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <160106193961.10465.12078546060105198824@66eaa9a8a123>
 <CAFEAcA8uWY+MCDToz9an+zsrMVrctkBmgpMV82iUR2ZZOgA3Vg@mail.gmail.com>
 <87h7rif3x3.fsf@dusky.pond.sub.org>
 <CAFEAcA9TdEPAHECmLAA3nOzUBEzcpis=OL7MFmMv-76e4yS6+g@mail.gmail.com>
 <87imbwob8g.fsf@dusky.pond.sub.org>
In-Reply-To: <87imbwob8g.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 16:43:03 +0100
Message-ID: <CAFEAcA-4gyjxoyMTY5ZUW47VuGGiQyTwRV_OL91_Rdw-zAb+qw@mail.gmail.com>
Subject: Re: [PATCH v6 00/21] Convert QAPI doc comments to generate rST
 instead of texinfo
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Sep 2020 at 16:26, Markus Armbruster <armbru@redhat.com> wrote:
> One more issue:
>
>     /work/armbru/qemu/docs/../qapi/machine.json:1000: WARNING: Unexpected indentation.
>     /work/armbru/qemu/docs/../qapi/machine.json:1000: WARNING: Block quote ends without a blank line; unexpected unindent.
>
> Line 1000 is at the beginning of a comment block.  Suboptimal.

Yes. There's a comment in qapidoc.py about that:

+            # The reported line number will always be that of the start line
+            # of the doc comment, rather than the actual location of the error.
+            # Being more precise would require overhaul of the QAPIDoc class
+            # to track lines more exactly within all the sub-parts of the doc
+            # comment, as well as counting lines here.

(That is, within qapidoc.py we can count the offset of each line within
this doc comment fragment from the start of the fragment (here, from
the "@value:" line), but only the scripts/qapi code is in a position to
know the offset from the start of the block comment on line 1000 to
the @value line, and it doesn't currently track that.)

> After a bit of guessing, I arrived at this fix:
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 7c9e69a9f5..756dacb06f 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1001,9 +1001,11 @@
>  #
>  # Request the balloon driver to change its balloon size.
>  #
> -# @value: the target logical size of the VM in bytes
> +# @value: the target logical size of the VM in bytes.
>  #         We can deduce the size of the balloon using this formula:
> +#
>  #            logical_vm_size = vm_ram_size - balloon_size
> +#
>  #         From it we have: balloon_size = vm_ram_size - @value
>  #
>  # Returns: - Nothing on success
>
> Looks good?

That will work: it will render the indented text as a block quote.

If you want the formula to be rendered as a fixed-width code
example, you could additionally do s/formula:/formula::/ to
create a rST literal block. But then you'd probably want to
do similar with the equation on the following line, for consistency.

thanks
-- PMM

