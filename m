Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE921C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB71620C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 15:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dedc/AJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB71620C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw6rL-00025b-VR
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 11:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48700)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hw6qd-0001YM-QZ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hw6qc-00085X-7b
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 11:30:31 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39404)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hw6qc-000851-1w; Fri, 09 Aug 2019 11:30:30 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so128131149otq.6;
 Fri, 09 Aug 2019 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ku8xseFYZ6gO8QVrGjY4WccKor9H1541AceJ4ihjarg=;
 b=Dedc/AJmDXIu6IYp7H4c2kgcOEZAUt7Et3ojVYcvWiJPMORJlUDGuBdPrzZ1Is9Zzh
 avowI8N2AlSRVB7G+hzcdmc+3stFlAIKM5jIFjcaHoPJHIMaDOyU9rFcwLt7BVNV6zLB
 Wb+M2cKXBP9kEPoGfo9zhYInK7okvYAmYBU2IkIZJt0OzskzXQFrmQ2+AmSIUTKGkLEC
 kEE653dQrVyecYoYpzzqEXS2s0CvkUBjHxj8likJand+3SPu+wAo0vatydF8v56ynzlF
 lk3Gaq7BypQvsjPfGsRnA5N0qgzjekVjATcQpD/Zx4jYaOHtYeYfwO4s385Wp94w9X4V
 Pa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ku8xseFYZ6gO8QVrGjY4WccKor9H1541AceJ4ihjarg=;
 b=iBcO1cMSJGR4Dty54Trv35q9Tnp18LTuAtemJ//UVh4r0M77SJGJ8wOahCyUbn5PSk
 q2H3iJ6P90Gw9UmGQcPLWE38AYh+IlFp9xZr6E11MYdZo+WX9JND05p70Pr489HncEN1
 JLhgz50bE4WtDqHK3GUX9mmU6JWg6bKF8NcEFsSJyKloIADtOKqjRjaz3GO6IQb8K5jf
 kVF+yjlMvdOFmw6bSOBu6mldsyUa82/vNpfVaeX2bzRtur6PyRiHF1njtViUBpmw22Yg
 UemeaEzVAVbQC73ODdK160l/PRwzeaXcYxyLKBgL9sJy9Z38Ryn7e/LyJipi66V+a7tE
 tEKA==
X-Gm-Message-State: APjAAAVLBAaOcMtsmet42EE7sLD6ecn3KCbrSe4F+kMUZwMt2/bO6zZo
 PBiqO7z6A14b83UdGLAqy3+CMMfYvqpGckcsdPE=
X-Google-Smtp-Source: APXvYqyfEAZ+VCz6HidZzoL42scRoygHD+uvXitRMWr7mdPEw31GWrsD6OQ+L+e1BNUkvFXreMkhflIbyzxYak3Gmfo=
X-Received: by 2002:a05:6830:c6:: with SMTP id
 x6mr17188765oto.64.1565364628979; 
 Fri, 09 Aug 2019 08:30:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <20190726175032.6769-12-richard.henderson@linaro.org>
 <CAL1e-=gwyGB4ibo_B5W1MpFy-9bB7=5juqTJVBdD9N6XFOOsSQ@mail.gmail.com>
 <0f37edc5-2fb6-c92d-fb47-a381af649072@linaro.org>
 <CAL1e-=hWVfYVYySkMCF4NUkHbe=47qUTuAA0vK23TGMBzuA+PQ@mail.gmail.com>
 <0b6556a5-7db8-bedf-89f3-7ead8e9b19e6@linaro.org>
In-Reply-To: <0b6556a5-7db8-bedf-89f3-7ead8e9b19e6@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 9 Aug 2019 17:30:18 +0200
Message-ID: <CAL1e-=jsEtmWHA1aOzfRVqnh6VVYV6OMA7wAriXTd32vkFuJdA@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 11/67] target/arm: Add stubs for aa32
 decodetree
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:Stellaris" <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 9, 2019 at 4:55 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 8/9/19 3:31 AM, Aleksandar Markovic wrote:
> >
> >
> > On Thu, Aug 8, 2019 at 5:43 PM Richard Henderson <
> richard.henderson@linaro.org
> > <mailto:richard.henderson@linaro.org>> wrote:
> >
> >     On 8/8/19 4:41 AM, Aleksandar Markovic wrote:
> >     >     +/*
> >     >     + * Include the generated decoders.
> >     >     + * Note that the T32 decoder reuses some of the trans_*
> functions
> >     >     + * initially declared by the A32 decoder, which results in
> duplicate
> >     >     + * declaration warnings.  Suppress them.
> >     >     + */
> >     >     +
> >     >     +#ifdef CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE
> >     >     +# pragma GCC diagnostic push
> >     >     +# pragma GCC diagnostic ignored "-Wredundant-decls"
> >     >     +# ifdef __clang__
> >     >     +#  pragma GCC diagnostic ignored "-Wtypedef-redefinition"
> >     >     +# endif
> >     >     +#endif
> >     >     +
> >     >
> >     >
> >     > This looks more like a "band aid" solution rather than the right
> one.
> >
> >     What would the "right" solution be, would you say?
> >
> >
> > The right (without quotation marks) solution is not to generate the code
> that
> > generates compiler complaints.
>
> That would be impossible with the information supplied.
>

That limitation is a fault of decodetree design, not an obstacle per se.


> Emitting zero declarations will result in invalid C.  We ensure that each
> individual decodetree file does not emit duplicates.  However, there is no
> knowledge across separate decodetree files about which declarations are
> duplicate.
>
> In this particular case, I do not even agree that the warnings themselves
> are
> useful.  I suppose it's not impossible that they could diagnose some
> weirdness
> in a code base, where a function is declared in multiple headers or a patch
> application has gone awry leaving multiple sequential declarations, but
> honestly how often does that happen?
>
> I suppose with some work, we could not invoke decodetree multiple times,
> but
> give it all of the input files at once, producing a single output file.
>
>
> > Obviously, in this case, decodetree-generated code shows that it is
> > inferior to human-generated code.
>
> That is not obvious at all.  Moreover, I disagree strongly.
>
>
OK. I'm fine with your disagreeing. That why open source exists - to have
opportunities to hear different views.

Yours,
Aleksandar


> r~
>
