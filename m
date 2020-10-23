Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E93C388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E33E2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVFX6nxY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E33E2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVuvV-0003zv-0T
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVuuV-00031z-2d; Fri, 23 Oct 2020 07:07:03 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530]:33285)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1kVuuS-0004FQ-W4; Fri, 23 Oct 2020 07:07:02 -0400
Received: by mail-ed1-x530.google.com with SMTP id w23so1154276edl.0;
 Fri, 23 Oct 2020 04:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xM9LA3MZmY7fvR92BJFaU8iMYFV0L1EE7ErRyRrwEoA=;
 b=XVFX6nxYdap1IdB+3FY4ki3A5qnWYBUgkZLWa9FDYaqF61Ms1yt9RAcpYe7Bc/9V6A
 4xIhAx7lkPa5rG/NqdMZCJzP6xg+s6EIC7lEWhku8icQHgjBoWeFOqg4RGgcUbBKsFqn
 qs1Ll67gmQ42q6tYz5QE8ADQH2S115LrJhSej79KtHHn+6Lsh9AxrYGQsHMDucNpWHez
 gTd4KfCxw+SagI4/YvluTTifGu4Q70jrcUienQay0MDWENA2c6pxxWN4kgPssz5WvmSy
 YH0df6h0791TsDiRjIhIukXHjVFinVANxpv5bLj4BgD451bcdahpGTWRoAonTIeGMNaJ
 zLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xM9LA3MZmY7fvR92BJFaU8iMYFV0L1EE7ErRyRrwEoA=;
 b=ttfbrN/ryvvdWMz5foBsVprbYtb0t/ChbGiCx8pREqXzhelyAjd5tiImfN5jOBBtFK
 sGn70Ynp0EJtHEpkOk16gfP5PQjk5qO8V+N22ArFwGMT9gdyMC/65mciwed1WY9566QS
 5xZWXgqHtYa4ZGxP3hJFRbFTbhx1/QjvLJliS75BIhEdsHGNaBCiTpBSXO2UEhpZJ+d7
 u8crI5etALtLL3k/racIyiIUjvQOTVjpA5nICBbr/jn8wS5eR6EYCPvV7gHLW0ej9B1n
 88ItdZhlTiYEs1MVQeqCfv763Q5ew9EIAqAFS6tHQHrrZJoyIsWCrswzVZDM2F9p4+Av
 ytsQ==
X-Gm-Message-State: AOAM532Noa1v7p98Mt542/bte1xZwXUykvCXzI95Zdw4rPsehIyd5pFb
 0QSGrX/ZF1LZND1+vLMW0N/1WqeYAAAo+95iUNw=
X-Google-Smtp-Source: ABdhPJyLjRGHdXAQDYeAmb/QzXI1nZ3QLO05GQUjuELeXQNa0n2DmzM1pCD5jXvGu4lzouTyduMCToJpB0OMbncm+d0=
X-Received: by 2002:a05:6402:1615:: with SMTP id
 f21mr1651887edv.257.1603451218410; 
 Fri, 23 Oct 2020 04:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <20201023101222.250147-1-kwolf@redhat.com>
 <20201023101222.250147-4-kwolf@redhat.com>
 <CAJ+F1CJAzbRwab5E7XQUEpTXX1e+DE_QkknoEgvYqmHAeqY2MQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CJAzbRwab5E7XQUEpTXX1e+DE_QkknoEgvYqmHAeqY2MQ@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Oct 2020 15:06:46 +0400
Message-ID: <CAJ+F1CKd24SSYyTje=rVFJa9+Oew2y4OXabP2ZqnqhtW33AoZg@mail.gmail.com>
Subject: Re: [PATCH 3/6] qapi: Remove wrapper struct for simple unions
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000049c20805b2549479"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-ed1-x530.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000049c20805b2549479
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Fri, Oct 23, 2020 at 2:40 PM Marc-Andr=C3=A9 Lureau <
marcandre.lureau@gmail.com> wrote:

> Hi
>
> On Fri, Oct 23, 2020 at 2:14 PM Kevin Wolf <kwolf@redhat.com> wrote:
>
>> Variants of simple unions are always contained in a wrapper object
>> called 'data' that serves no real use. When mapping a QAPI object to the
>> command line, this becomes very visible to users because they have to
>> add one or more useless 'data.' to many option names.
>>
>> As a first step towards avoiding this painful CLI experience, this gets
>> rid of the 'data' indirection internally: The QAPI parser doesn't use a
>> wrapper object as the variant type any more, so the indirection is
>> removed from the generated C types. As a result, the C type looks the
>> same for flat and simple unions now. A large part of this patch is
>> mechanical conversion of C code to remove the 'data' indirection.
>>
>> Conceptually, the important change is that variants can now have flat
>> and wrapped representations. For a transitioning period, we'll allow
>> variants to support both representations in a later patch. Eventually,
>> the plan is to deprecate and remove wrapped representations entirely,
>> unifying simple and flat unions.
>>
>> The externally visible interfaces stay unchanged: Visitors still expect
>> the 'data' wrappers, and introspection still shows it.
>>
>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>
>
> breaks the build for me:
>
>
Other than that, I like the change, and it looks quite straightforward. I
hope it's acceptable and we are not missing the reasons that extra data
indirection was necessary.

Having to support both flat and wrapped versions in the externally visible
interfaces might be tricky though.

--=20
Marc-Andr=C3=A9 Lureau

--00000000000049c20805b2549479
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2020 at 2:40 PM Marc-Andr=C3=
=A9 Lureau &lt;<a href=3D"mailto:marcandre.lureau@gmail.com">marcandre.lure=
au@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D=
"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Oct 23, 2020 at=
 2:14 PM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" target=3D"_blan=
k">kwolf@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">Variants of simple unions are always contained in a wrap=
per object<br>
called &#39;data&#39; that serves no real use. When mapping a QAPI object t=
o the<br>
command line, this becomes very visible to users because they have to<br>
add one or more useless &#39;data.&#39; to many option names.<br>
<br>
As a first step towards avoiding this painful CLI experience, this gets<br>
rid of the &#39;data&#39; indirection internally: The QAPI parser doesn&#39=
;t use a<br>
wrapper object as the variant type any more, so the indirection is<br>
removed from the generated C types. As a result, the C type looks the<br>
same for flat and simple unions now. A large part of this patch is<br>
mechanical conversion of C code to remove the &#39;data&#39; indirection.<b=
r>
<br>
Conceptually, the important change is that variants can now have flat<br>
and wrapped representations. For a transitioning period, we&#39;ll allow<br=
>
variants to support both representations in a later patch. Eventually,<br>
the plan is to deprecate and remove wrapped representations entirely,<br>
unifying simple and flat unions.<br>
<br>
The externally visible interfaces stay unchanged: Visitors still expect<br>
the &#39;data&#39; wrappers, and introspection still shows it.<br>
<br>
Signed-off-by: Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com" target=3D=
"_blank">kwolf@redhat.com</a>&gt;<br></blockquote><div><br></div><div>break=
s the build for me:<br></div></div><br></div></blockquote><br></div><div cl=
ass=3D"gmail_quote">Other than that, I like the change, and it looks quite =
straightforward. I hope it&#39;s acceptable and we are not missing the reas=
ons that extra data indirection was necessary. <br></div><div><br></div><di=
v>Having to support both flat and wrapped versions in the externally visibl=
e interfaces might be tricky though.</div><div><br></div>-- <br><div dir=3D=
"ltr" class=3D"gmail_signature">Marc-Andr=C3=A9 Lureau<br></div></div>

--00000000000049c20805b2549479--

