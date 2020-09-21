Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872ECC43466
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66D520888
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 15:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XQMlw5SW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66D520888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKNt3-0001ET-Ph
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 11:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39252)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKNmb-0006Lj-M9
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:31:14 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:40847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKNmY-0005dg-7f
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 11:31:13 -0400
Received: by mail-ej1-x641.google.com with SMTP id z22so18312128ejl.7
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 08:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eJ8IxxkankdquCR3vrLLTpL7dj4nEonmsbUNK1XHvt4=;
 b=XQMlw5SWZN3ejJJrvvunA55Fo3iQ8gViZgrVCrc3oNH+r5tCaR50NsVFtvdCKkNYSo
 M/Yj6jsY2+Zjd43PQVVVfzppuCKThoQ8yMmWVDY1d58aQAo0QTw5kEktpGIl90sXF6xz
 vYbhr7o2fm+zH5VEYS4Rj2eUkRZT7UCcEYEQE3/ygV8/xjW/C0wNL/CuLxPaCdci5xac
 NxaQwL+dRAquZdFlFpVtN2Vr5ZJYmla7n6ZrTlZlibjF2Eq4tlG83udhQ79unS77T4mr
 QIImPl2zDccupU9JcqimSTonU8tWBwvn94Gv5N5CDfA68Xq0OKb1kI8gTHy4UYlrKXad
 yiuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eJ8IxxkankdquCR3vrLLTpL7dj4nEonmsbUNK1XHvt4=;
 b=mGwGlo3U8AduC9HOrh3PhnuQ6q7deB+JwXXzxVn92WmNUxarrrpeNzDW6K8uL9yxI9
 DRsHhIH0w9Kq2ngZ+eSzS5BMjWp13ByWV+McVX82F9A4KEIEepvlKD1KcXVXteVRtSxS
 nFVnXRknQSwJgJO5Zj9P+C3YvH3ucYYbfY2T5bJS73uaaMKCTQJUN7uoTWX/eWvprO7D
 DjYq+Uc1xElcU+JGc6Zmlr8zyf+YxvDOqWxg4qj3J9o7hS/Tu3wAaL91bdrgDK0/HSdH
 NHzQEwgtteHiHlFPf8+Du3T1XdbVlHmIewlvJbOXjVlcZlbzPn7YIk6dBsbEBBLABTus
 cVng==
X-Gm-Message-State: AOAM532TEiKCpIVECVkxNgAm+/J3Toq7ZcwBmoHd4wlWWQcBWymVmduh
 62YvlxBLxk+R742MC/ejIODam24QVNl0RAaCNoqVYw==
X-Google-Smtp-Source: ABdhPJzOivhaDy4cncFdLNLdMN1xpfK5iaIGbjQlFg/a7+l/ZvESNoj0usMiG8SwMigKv6DIfL4gTmhfXljiWcoqLZI=
X-Received: by 2002:a17:907:20d9:: with SMTP id
 qq25mr6683ejb.382.1600702268560; 
 Mon, 21 Sep 2020 08:31:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200810195019.25427-1-peter.maydell@linaro.org>
 <20200810195019.25427-11-peter.maydell@linaro.org>
 <875z8t7kd0.fsf@dusky.pond.sub.org>
In-Reply-To: <875z8t7kd0.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Sep 2020 16:30:57 +0100
Message-ID: <CAFEAcA9ZPO32XC1NwH=qa4mNF8c_xZeW8Z6MTrJ0FLmB6kytXQ@mail.gmail.com>
Subject: Re: [PATCH v5 10/20] docs/interop: Convert qemu-ga-ref to rST
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 14:16, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > Convert qemu-ga-ref to rST format. This includes dropping
> > the plain-text, pdf and info format outputs for this document;
> > as with all our other Sphinx-based documentation, we provide
> > HTML and manpage only.

> > -@copying
> > -This is the QEMU Guest Agent Protocol reference manual.
> > -
> > -Copyright @copyright{} 2016 The QEMU Project developers
> > -
> > -@quotation
> > -This manual is free documentation: you can redistribute it and/or
> > -modify it under the terms of the GNU General Public License as
> > -published by the Free Software Foundation, either version 2 of the
> > -License, or (at your option) any later version.
> > -
> > -This manual is distributed in the hope that it will be useful, but
> > -WITHOUT ANY WARRANTY; without even the implied warranty of
> > -MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > -General Public License for more details.
> > -
> > -You should have received a copy of the GNU General Public License
> > -along with this manual.  If not, see http://www.gnu.org/licenses/.
> > -@end quotation
> > -@end copying
>
> Does the interop manual carry an equivalent copyright notice?

NB: in the Texinfo versions, Texinfo does not put this copyright/license
notice in its generated manpages, and it is in the generated HTML only
as an HTML comment, not visible to the ordinary reader.

The Sphinx interop manual has the usual footer:
https://www.qemu.org/docs/master/interop/index.html
"=C2=A92020, The QEMU Project Developers."

The system manual has an explicit "License" section:
https://www.qemu.org/docs/master/system/license.html
but that's documenting the license of the program, not the
manual (it's docs/system/license.rst).

We could do any or all of:
 * decide that we're happy with the current situation
 * expand the "copyright" footer to something like
   '=C2=A92020, The QEMU Project Developers; this manual is GPLv2'
 * have a docs/foo/license.rst for each manual, and expand
   it to mention the documentation license as well as the
   code license

Given that the Texinfo generated QMP/QGA references don't
actually present this text to the reader, my inclination
is to say that this is something we should address in
a separate patchseries, not as part of this conversion.

thanks
-- PMM

