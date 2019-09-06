Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E098C00307
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:56:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F19720838
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSv8mC2w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F19720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HX6-0002sf-M7
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i6HW5-00020c-By
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jcmvbkbc@gmail.com>) id 1i6HW4-0007v8-97
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:55:21 -0400
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:37378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1i6HW4-0007uL-4g
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:55:20 -0400
Received: by mail-yw1-xc44.google.com with SMTP id u141so2426154ywe.4
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 09:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=gbdWtQJQPhD5f5Z1quRBq/UHl43sb/3b4ToC+FLKqoI=;
 b=QSv8mC2wUS/4luT3ryC6Lca5sBomOJJUCgA8mDkm4D6TQw7lxOFOmJSuosQ+8dqvOh
 iriSY0zHYVA6IDGksPRslivK1omjoydPpgW5iySl80vXIdi2I2XaJyfmYEWtm8PjOg1u
 M8g1+Hyeu6a0vbm5QmuOtFFf4bz3KdINs6OGYUVTi6vZa7QuFjqFfSL+yEYFNIkNoo+6
 Mm/hPCl3ht2mBB3XT4DeBJfOt6krgW0eYJyO85r98ga6CUHrSoOBLrWa3D9X8XHNdgJT
 8FjJqiTFbhIml+nvHJ6/dRfWlbMtJ0lDskEIOaKaX/jR7J8oodeHvKrKrgEGgSDCl2m+
 UrCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=gbdWtQJQPhD5f5Z1quRBq/UHl43sb/3b4ToC+FLKqoI=;
 b=Jf2BcWPkN8rTV1K72wBhinWvH7N+CKRz5KEOHG841MK7ObJw6T2t7Ks1Wr4ao7l5pe
 gVmxhmQoMxsGuM6iXzaiweut4s4Cq+PoVn16VN4GJS0EfWSdKKg6eFPkcmfEuV1YLbWz
 XSl3NnqcUqeldrcpP/ByUaCVzjTCVc7Lrqtk5cm4xRwPVa8LmQ7OJN/oZjNIlDZX3Zhn
 YTDg43qENlp8AT4sqeBpyq9p/yfY7zWNdYiSA5S1zriPktf3IXda/GLyXHANVKboh/Ux
 BrTMOgCkiP/lDw+VxBO7elY5PrE+YiGywBWhQGm/wFTGB3ny9qttnMv8DPNDT4q204sf
 6h4Q==
X-Gm-Message-State: APjAAAW8bOhKC5IGO/hNe2KkW6uLPWzQQ5liA4nbP0kG2zLTbBGWS42R
 yinDsFZoLIJbRNQFBw88q3cqLbMPRnUsWJk/fC4enQ==
X-Google-Smtp-Source: APXvYqywzUZFZFSwpl1rVCl//uIHfOBHuKnoHtH9fle3dko6X49O/UjCotAJrh6N1R4/z6ZkVLVD1xKnBapPX3Rbspc=
X-Received: by 2002:a0d:ddd1:: with SMTP id g200mr7066624ywe.234.1567788919440; 
 Fri, 06 Sep 2019 09:55:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190826195806.15998-1-jcmvbkbc@gmail.com>
 <67f40cbf-39d3-d2d6-0e4b-219f549ae5d5@vivier.eu>
In-Reply-To: <67f40cbf-39d3-d2d6-0e4b-219f549ae5d5@vivier.eu>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 6 Sep 2019 09:55:08 -0700
Message-ID: <CAMo8BfK7vsOU1w1HceWGwJS8XF2D+KQmcqgOu0EvaWE6FLFewQ@mail.gmail.com>
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c44
Subject: Re: [Qemu-devel] [PATCH v3] target/xtensa: linux-user: add call0
 ABI support
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 6, 2019 at 2:33 AM Laurent Vivier <laurent@vivier.eu> wrote:
> Le 26/08/2019 =C3=A0 21:58, Max Filippov a =C3=A9crit :
> > +#if defined(TARGET_XTENSA)
> > +    if (getenv("QEMU_XTENSA_ABI_CALL0")) {
> > +        xtensa_set_abi_call0();
> > +    }
>
> Not needed, this is done by parse_args() that checks
> getenv(arginfo->env) and calls arginfo->handle_opt()
> (handle_arg_abi_call0()).

Thank you, I'll fix that. I got confused by the similar handling of
QEMU_STRACE, I'll post a cleanup that removes that as well.

--=20
Thanks.
-- Max

