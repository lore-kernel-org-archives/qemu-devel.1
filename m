Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2702C33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:33:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2D952082F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 19:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecWWskB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2D952082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isXMt-0000h9-GY
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 14:33:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40194)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jkz@google.com>) id 1isXIa-00057i-G3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jkz@google.com>) id 1isXIZ-0004NS-Gv
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:52 -0500
Received: from mail-ua1-x941.google.com ([2607:f8b0:4864:20::941]:44616)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jkz@google.com>) id 1isXIZ-0004NA-Cy
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:28:51 -0500
Received: by mail-ua1-x941.google.com with SMTP id c14so9338871uaq.11
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 11:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=1UFY4KRF0EeTpwqH4bNWZhTNuTUBQAVMlcxsvbRSmw8=;
 b=ecWWskB5Km0szjoNTjNN2Ay8C2aLj3uERFEJlTBxejpsuU0DX+mRD2m/fi9bBZhxH1
 K2DQs1tLZoDjRMYPGwCGNR0DuN1LBUy0JqaUO2CF4QMx7lSJpPbYUQRCNG6Av0xWmaGR
 ap+YildLBtFPzaZY8DECcs60Q4IFJ7gYoHO0YH9UIbJnqj93/yjNgzm0NpezANeIq2B+
 5pbAsZQWM8aRCpOIZx44+dSCb/QUVEOVy0DQpKv19Xq2sK693Ih+Lx6FtFc10mvEtlwr
 YFcs3ko/kNXrM94IQue63kUm9DtA+UFMkc/zm+N4usZUUN6glLE3qTNMeGFf2PWXGthy
 M5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1UFY4KRF0EeTpwqH4bNWZhTNuTUBQAVMlcxsvbRSmw8=;
 b=pSjRK1kWymTrpfw9n1IvGJsNcUDMILFxDj8NSF/mfeW1aG0bnBbC+0AVHBrA31RHkG
 6y2C86cHx9s8v6S4mZFIlozzLsF3zANxFyHIxpgTIU6cjUekKQ7HkwZbuLYUz9yKzgYn
 3zbK8aURLp0wQV/ugp4SX5t/jbbvljQb6e2jk389qVcOzRqwUbfVvUSGlNZuGS8apreX
 UzqwlRsYbfzB/0oPEMAWDp5x/jDHZ7Aofp7qpTAGzID6/xuyPHWKFBueflQGOiHRbp5n
 0RPZO+5pNYS/JEQ38C85oM/+xlFzl4H3UD6Nmcv+EgjG8Cl3PYetsBOVE2K+ppXgaUQS
 RxEg==
X-Gm-Message-State: APjAAAVbjRITa7DIG6ciBqgZ2G0iONOshWCX0Tmgsnakc94uf6BvuyWJ
 Zs5CfCNIWd/J/VVUGBTq3ExdueiTDrLLJt5exjiUh2Tk
X-Google-Smtp-Source: APXvYqyZBdqeGUFQgD0L5JKZXIjSDC20nOkU4SKcTLAXwMP/mk61p8rWqEXPGu6eTWgKI/roIZB+S5LxUtjbUKvG6ho=
X-Received: by 2002:ab0:4ea0:: with SMTP id l32mr22162312uah.69.1579289330443; 
 Fri, 17 Jan 2020 11:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20200114030138.260347-1-jkz@google.com>
 <20200114030138.260347-2-jkz@google.com>
 <87pnfmmi8c.fsf@linaro.org>
In-Reply-To: <87pnfmmi8c.fsf@linaro.org>
From: Josh Kunz <jkz@google.com>
Date: Fri, 17 Jan 2020 11:28:39 -0800
Message-ID: <CADgy-2uAkXj5b5gh_mgUGKFBUJovmngG0s1OG+Fpqmhoawm97g@mail.gmail.com>
Subject: Re: [PATCH 1/4] linux-user: Use `qemu_log' for non-strace logging
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, 
 Laurent Vivier <laurent@vivier.eu>, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::941
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 14, 2020 at 2:43 AM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> As Laurent said I think LOG_UNIMP is perfectly fine for stuff we haven't
> done. I don't think any of the cases warrant LOG_GUEST_ERROR.

I've replaced `LOG_USER` with `LOG_UNIMP`. Didn't catch that mask at
first, LOG_UNIMP is indeed a better fit for most of these.

> I'm not sure want to bother with this. I know we like to avoid
> regression but isn't this all debug log stuff? If we must keep it can we
> invert the variable to save the initialisation.

I'm all for removing it. I agree that it would be pretty odd for
someone to depend on debug log output in this way. I've removed this
in v2. It is a backwards incompatibility though, so I'm happy to
re-add the fix if people want it.

> I mean we jumped through hoops to maintain backwards compatibility and
> then added new output? Also LOG_STRACE doesn't exist yet.

This is leftover debug statements. I've removed it.

> I'm not sure we shouldn't just be asserting this case above. The
> comments imply it is a bug on our part. The rest look like good cases
> for LOG_UNIMP.

Switched to an assert in v2.

