Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6D3C49ED9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:42:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BEB32081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 16:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kiynKzxU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BEB32081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7jDl-0002d6-IP
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 12:42:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51804)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i7j6m-00031y-7E
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:35:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i7j6k-0000uq-PK
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:35:11 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:45590)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i7j6j-0000oC-Ed
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 12:35:10 -0400
Received: by mail-ot1-x32b.google.com with SMTP id 41so15776983oti.12
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0OcQkIYf2/yDEiExR2ZSf7CkI7OJSLhoVrj5iFn+xFg=;
 b=kiynKzxUuSv0KJPfaP8zVTJlrfxYkkt4ixIee8plUOFaDb/u3bIOMp91+uPfyuuSCp
 Ms/3EX9Thqc/c8Sa1XsL6EQ4EOzPMdwuCMRIFQVdMeaYB6IW4WX+OShzGsKh6t3O2cdJ
 VOvg/bPhsrDjEdJwYQRXF3iGdse/JZrU5AH+yCKNk1fIkX9W/Gyzb16hMuc9tC+EDOTY
 EgfvYvC/RV3DLvo7WotxXJVkvL7dn704OtaFoy27irRvGfGHVIwbk+WqCazGio/BKqgJ
 /IZqD7k0XXQWHG6lDpXJ13PILh6g4+y39AqkPPemByTF2Q9lSnJQX+0zYUk2YKFb/iLc
 jj6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0OcQkIYf2/yDEiExR2ZSf7CkI7OJSLhoVrj5iFn+xFg=;
 b=UgZgOxXWYVyZpubfRdWfxAQ1BvDNNX64ikR4QEA2mzjmMUSDCIHn/kYDjWHKdpO6Ra
 xm+6zf3ZqrU2gH6yiwmVpUiXEIS+G2WDNooD6kPf3wM2O6u/7P1Xwx2eGNsvWZSsF5Ad
 3c09zMEnBFy1vAltIGV7NsmroyBQuj8P3+i1ieDSlgBbM4zYIqzPRpM27nv7MVul6alL
 mOSRfHVEMpVl5QLdxMjA80eU2Ebb8BCFu+22Ahxn56G+Xca1b7q5Yvbh6wgBxOwmi83N
 UdNxObVyCVFjYyWroMX/OimSV4+Mf3nFU9l+Ajh0vWiQyToR49YtIRCFR0ig1hKziu03
 e4Wg==
X-Gm-Message-State: APjAAAVCiyf6a9GvTBAIaxWfA3SXDh/pnqNcvRPDSZ07scz7VLxJID1X
 mWzwW+nC+GOG9hr5A6dPCwYoZoueagw1O+lem8wNTA==
X-Google-Smtp-Source: APXvYqzZy3eR+qkYQvY8FWjJAcRrW5H/MbxLAAr4hj5kyeKD+FRcR5/tFPwa82+krQbw7yoa8/1PHXRSCtVcdc07ABw=
X-Received: by 2002:a9d:7504:: with SMTP id r4mr25799390otk.221.1568133305357; 
 Tue, 10 Sep 2019 09:35:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190731160719.11396-1-alex.bennee@linaro.org>
 <87a7cty0tv.fsf@dusky.pond.sub.org> <875zm5yzgq.fsf@linaro.org>
In-Reply-To: <875zm5yzgq.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2019 17:34:54 +0100
Message-ID: <CAFEAcA_gHBkBNK9qkWHMuOLqifpJ6MqK+iRfzxw7KRezW7p2WQ@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] [PATCH v4 00/54] plugins for TCG
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
Cc: Aaron Lindsay <aaron@os.amperecomputing.com>,
 Pranith Kumar <bobby.prani@gmail.com>, "Emilio G. Cota" <cota@braap.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Sep 2019 at 20:53, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Markus Armbruster <armbru@redhat.com> writes:
>
> > Please advise why TCG plugins don't undermine the GPL.  Any proposal to
> > add a plugin interface needs to do that.
>
> I'm not sure what we can say about this apart from "ask your lawyer".

I suspect the underlying confusion here is "the term 'plugin'
has a very wide scope and you and Markus are probably not on
the same page about what this API/ABI is actually doing".

Specifically, this is not the 'plugin ABI that lets you write
device models out of tree' that is sometimes mooted, and the ABI
does not (unless it's changed since I last looked) expose arbitrary
bits of QEMU internals to the plugin or let plugins make calls to
random QEMU functions. It's a very limited scope ABI that allows
QEMU users to write code that can do useful introspection on what
running guest code is doing without having to modify QEMU itself
in non-sustainable non-upstreamable ways.
[If it doesn't have that kind of protection against misuse
then we should add it.]

More generally, your cover letter really needs to be much
more descriptive about what we're trying to do here, and
what the purpose, limitations, etc are here. If you say
"plugins" without giving any detail then you're going to
trigger a lot of (reasonable) reactions from people who
associate that word with a much more generalized "provide
arbitrary bits of QEMU functionality as 3rd-party blobs"
concept...

thanks
-- PMM

