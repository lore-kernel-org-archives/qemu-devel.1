Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9677C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4AD2206E6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 14:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgBNz1CW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4AD2206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVcFC-0000Sl-Oi
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 09:06:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57487)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <programmingkidx@gmail.com>) id 1iVcEN-0008UQ-PF
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:05:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <programmingkidx@gmail.com>) id 1iVcEM-0006HF-H1
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:05:47 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:46866)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
 id 1iVcEL-0006FO-Nj
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 09:05:45 -0500
Received: by mail-wr1-x42f.google.com with SMTP id b3so11095710wrs.13
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 06:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cUwo64kXmdDd+ERWVIJAka8Pn+9Z8SfxVN+QmaEaMRA=;
 b=LgBNz1CW0OJ9rNrUG7n1NAonVszHa41FNVVAt6PRV8l9838V7YXUp77lLu+TfO950z
 M/h7cVS33eA5X0ploWbR5DUrUvTpfcuWXuNAEoy0uBk0HBILAkdJB2W4Lj/Ei26R0jRr
 feBjPSKMmJtWgREMbhClRSdgk8ScZhQmm3XRsDqfshWBmdf+3Q1ZuwqgI0M8eSSh6Tq7
 HUSwW/Qr/wfTRelsp0Tb1GIAsKvuSy9sIn60Z2zQp6aoDIAhWenFnFuXcTF8FCYg7jNE
 MQsJ4o+4ycHU9BPbyF5j0z3a9XaH/6j2tOrxtwpBbgdGjcoV37mO87QVEm8PmYbTLshU
 +zJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cUwo64kXmdDd+ERWVIJAka8Pn+9Z8SfxVN+QmaEaMRA=;
 b=JosLLL9j5WqltotGkwW2KnpKVqE86bonTbdXWDQPDsMQZQiHHKWL5yUysdpnUrPGik
 LpF9CPK7a7cMNlirnEAcQpI+24bkW+ZQ6NztkOdSKKH9vJx7nF+h3nXfipK7EGlyehAv
 qcTx4ojqaSQ5fcI+TmD+YvXSCk3oV1Mb2Q/RowPxbhylqmZlzLo7JRWY3RzViYIi0hsz
 VF9X/5lVZJD3ZUVUj3lCfaUOnicu1/5caU7VBHQq4CdoGZROYDg1he0CexyFY/E+9LMf
 CUVAZI8tKTaJDzNRbOty1mEO/SVvoO+/w3k8jDJA9OxZoc4PJ/fh392IhsQn8BHr1nkG
 suEw==
X-Gm-Message-State: APjAAAU7+8k3jnYZ7kcl2avbNTO+oCNRgAenBy8riSIoS1z2zCsAmPXP
 7CxC+6zhqCz4sioUF/gTia74yB5mQrblwCpeftNZIwJF
X-Google-Smtp-Source: APXvYqzNZVF2fSOS57JsVRQgoJO6A+R7yRCf4Shyc4m3ahznk89WaUbtkBr//Xr0qpMHmufxBz2PY503fbcjx6Hxh90=
X-Received: by 2002:a5d:5224:: with SMTP id i4mr317851wra.303.1573826743929;
 Fri, 15 Nov 2019 06:05:43 -0800 (PST)
MIME-Version: 1.0
References: <mailman.2098.1573202511.13329.qemu-devel@nongnu.org>
In-Reply-To: <mailman.2098.1573202511.13329.qemu-devel@nongnu.org>
From: G 3 <programmingkidx@gmail.com>
Date: Fri, 15 Nov 2019 09:05:32 -0500
Message-ID: <CAKyx-3OHvfqYbzqhVxGYJr46massr6h9H81FO2OtxWL7T9exZA@mail.gmail.com>
Subject: Re: QEMU HTML documentation now on qemu.org
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000002934f059763185c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000002934f059763185c
Content-Type: text/plain; charset="UTF-8"

> You can now access the latest QEMU HTML documentation built from

https://wiki.qemu.org/docs/qemu-doc.html
<snip>

This is a welcome start. Could we add version support to the URL?

What I mean is add the version number to the path of the URL.
Like this:
https://wiki.qemu.org/docs/4.2/qemu-doc.html

This way users of older versions of QEMU can still access documentation
relevant to his or her version.

Thank you.

--00000000000002934f059763185c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div>&gt;=20
You can now access the latest QEMU HTML documentation built from <br></div>=
<div><br></div><div>
<a href=3D"https://wiki.qemu.org/docs/qemu-doc.html" rel=3D"noreferrer" tar=
get=3D"_blank">https://wiki.qemu.org/docs/qemu-doc.html</a>

</div><div>&lt;snip&gt;</div><div><br></div><div>This is a welcome start. C=
ould we add version support to the URL?</div><div><br></div><div>What I mea=
n is add the version number to the path of the URL.</div><div>Like this: <b=
r></div><div>
<a href=3D"https://wiki.qemu.org/docs/4.2/qemu-doc.html">https://wiki.qemu.=
org/docs/4.2/qemu-doc.html</a> <br></div><div><br></div><div>This way users=
 of older versions of QEMU can still access documentation relevant to his o=
r her version.</div><div><br></div><div>Thank you.<br></div></div>

--00000000000002934f059763185c--

