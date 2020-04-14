Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD8DC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:30:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739D720644
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 10:30:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycrIDqTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739D720644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOIpT-0002VY-It
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 06:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOIoO-0001NI-Tn
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:29:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOIoF-0000mj-1N
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:29:00 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45621)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOIoE-0000mO-SZ
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 06:28:50 -0400
Received: by mail-oi1-x242.google.com with SMTP id k133so9258633oih.12
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 03:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XciK45GsfgX5heMyt1IgD8WwyPdfOPy+CqHGA6JbR6k=;
 b=ycrIDqTgCOO1wb+hEGXdkzxa61MDca7hJXZZXLa0kqnaig0A7rGXOPzPyiQ834jP8u
 94O4iHUcDvvYoymoPgjlhjo7gpg213etePvEb21cI4V51D6ADU2JEYA3aQmUfTSQ3nnE
 sE3O1AMtuQ0B2d7fPCG7YTDvQGW8XZuhuQod2vCyIdx7NiFoSclIMxtvOZYFNuVZMDTh
 VABgwoM0RQ/ePluUDVDozpYUbfcQNARkPat+E9x4PWeIiNytqnPaBSnBhvNw9tzFRnYi
 i8QB/FwS/68qXDVuaCuPNU91z7B2jigim6b81286B8g/zKageQqDJIYT7wWNANsPL3Es
 7NAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XciK45GsfgX5heMyt1IgD8WwyPdfOPy+CqHGA6JbR6k=;
 b=cqnENqL64YhB5iGGjwlUea4XYwHTmpnpzRd93lXq9QWfoveOZbWizYgqae0a+ZrkZR
 w/ISaI0l/jpMeVnD4wdBV+Vw7+mUly3h70820P+Unr3+bv2j921AORwStuCqRonzEBNS
 SmEhbV9UsdPsZP/cAjeX3KlwdgZX378LYAdX4JvwHujUoyB1Ci1kUet5jNomio+pdow2
 BdzzBRq9i/Pk5DwfTechfPjbtsWiYRVxctmWXDSR9GOkCDAXOngRIIh8htFFPGmm/ncC
 4La9sdDRiZqNw6cKNWasL99T8DIIclZ6tvFrkG42NV539lAzP7t9eZxOsx7g2fml+9IV
 0uOg==
X-Gm-Message-State: AGi0PuYIcGgJhPTniOBI2aSK3JPMW7tU0njphh4U8KeAN+lnTfwF2/iu
 0Cx8HF62xRsxFARdGeCGS1Sd+sQAwZr+iTpWqHEW4w==
X-Google-Smtp-Source: APiQypKlpyIpMlp1JQaZoHjWTrNtt/c9/yMQcAv041VpElRLtSi2mOzulyjWy6rqWk5zynCEDYYweBdCbP+W+z4FW3I=
X-Received: by 2002:aca:3a8a:: with SMTP id h132mr436195oia.146.1586860130059; 
 Tue, 14 Apr 2020 03:28:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200411182934.28678-1-peter.maydell@linaro.org>
 <4873c74c-f590-62bf-bd64-dd5ab391c252@redhat.com>
In-Reply-To: <4873c74c-f590-62bf-bd64-dd5ab391c252@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Apr 2020 11:28:38 +0100
Message-ID: <CAFEAcA-oRGxEK9xqrU1o88xga-Zn4Xpb5Nr84NhRA=GD2JCoQg@mail.gmail.com>
Subject: Re: Supported Sphinx Versions (was: Re: [PATCH for-5.0? 0/3] Make
 docs build work with Sphinx 3)
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Apr 2020 at 19:08, John Snow <jsnow@redhat.com> wrote:
> 1.5 - 1.5.6: Fails to build.
>
> Warning, treated as error:
> /home/jsnow/src/qemu/docs/system/invocation.rst:544: WARNING: Malformed
> option description '[enable=]PATTERN', should look like "opt", "-opt
> args", "--opt args", "/opt args" or "+opt args"
>
> ... I actually don't know where this one goes wrong; that's not a valid
> line number there. device-url-syntax.rst.inc isn't that long either, so
> I don't know what this correlates to, unfortunately.

https://github.com/sphinx-doc/sphinx/issues/3366
is probably relevant here: the regex controlling what Sphinx
thinks is a valid option string was relaxed.

The "1.4 fails with duplicate ID warnings" part is probably
https://github.com/sphinx-doc/sphinx/issues/646
which is a similar earlier issue where the option string
was relaxed to include the '.' character. Without that
Sphinx misparses all the "encrypt.format", "encrypt.key-secret", etc
options of the qcow2 block driver as being a single "encrypt" option
with an argument ".format", ".key-secret", etc and thinks they're
duplicates.

> I want to send patches to:

> 2. Change sphinx conf.py to require >= 1.6.1 so that the requirement is
> documented

I think we should do this for 5.0. My guess is that most users
building QEMU on older distros aren't actually interested in
building the documentation, so they'll be better off having
configure automatically disable docs building and getting a
working binary rather than having it try to build the docs
and then failing. If they really want the docs they'll have
a clear reason why which will point them in the right direction.

PS: why 1.6.1 and not 1.6.0? You don't list 1.6.0 in your set of
things you tested, was it just that you couldn't find it?

thanks
-- PMM

