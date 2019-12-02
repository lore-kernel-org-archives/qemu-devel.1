Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25F5C432C3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC34C215E5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 10:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMWCa1UI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC34C215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibioA-0002ZV-Ub
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 05:19:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60352)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ibihD-0004Dd-2P
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ibihB-0005hN-0D
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:12:46 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ibihA-0005gx-Lv
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 05:12:44 -0500
Received: by mail-oi1-x243.google.com with SMTP id a124so8208369oii.13
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 02:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AZd14AeMUAM7R82pCYET5klBzQsEMY1lQev8JjlsVqs=;
 b=jMWCa1UIx7MwUCrhapU/0oMv/lD58OGqcO0Wg2UOxyH7lGA3KYIO3YTqXDH4asfRRu
 Qn5vicp+fXM8o7+MEQ+TJUUkMKZRx6yO2goGGernLv4pSQuHGg9ObwRWZycilmozhJKj
 0LtstdwS6grbEQXIRoEbr0H4EncLyX3PYlV69Ao8Me6CMT3Zld9Tm9AsbzU0+EXa94Y0
 uMpBq7izudeXTuyM1YCY6gTZ03ymVKhaYqD9NIx0OzHoVK1XdosE2EUS2aGyv3eFJnUa
 BB4IsGe65FC6Eq3sxVqWFyPzc5q9aRaYVgGjESMClSCzxRZoDX7NKKQzvoBXCebMYEAX
 iqiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AZd14AeMUAM7R82pCYET5klBzQsEMY1lQev8JjlsVqs=;
 b=BAtcJxi76Dy2K6kHr0u6MarOcGsh7sxV0+XNWABGDd9U4GY5x64J39+g/VdknLxvdx
 lfW4/cxAZRVHtT0IrXcUhDnxhqRXsLxgWAuXG61+MtbJaV3dg0GtkJ/RGf8YqCwpUliN
 p5BtBpAuFiEOacsG1sZL1/XeAFPq79redGhI1Tv4jc4orkpYEinvDAhrX4p/7efOqjNv
 AbgnmqV1CwwXzeV8Py0q02zu5GGQP5+Rba0gCon6yeNb6DTJFbCenV++jZBEK0SUHXn6
 6N6Zhkma1Rp52+i5EuybeMfo3SnZ2ApCPFXpmlHAerRssFDN98W1ebJmeNeF3yJZOJt0
 TYcg==
X-Gm-Message-State: APjAAAXME5QZE4Ag3VOl5xVrraLkjzzExpIfyENH7fbvvmaYP232GXq7
 LcqdAC122pUTa0bfdCBIDdbNepEBXo6JcLZIRX/swQ==
X-Google-Smtp-Source: APXvYqztQ88dbCNeEKqt5lKfd2uWjOrbjfmloxMH6sZ9TIfRUwFNfVN4uZi5XdwBb7fug6OKvQfsoDneJ6G7gdVBmpQ=
X-Received: by 2002:aca:f5cc:: with SMTP id
 t195mr20136940oih.163.1575281563905; 
 Mon, 02 Dec 2019 02:12:43 -0800 (PST)
MIME-Version: 1.0
References: <20191125185021.GB3767@work-vm>
 <20191126102600.GG556568@redhat.com>
 <20191126121416.GE2928@work-vm>
In-Reply-To: <20191126121416.GE2928@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Dec 2019 10:12:33 +0000
Message-ID: <CAFEAcA9Ln2uwg4f4s8oS6VeQk83W3BErmH9cHeyDJy7v-4gNxw@mail.gmail.com>
Subject: Re: virtiofsd: Where should it live?
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: mszeredi@redhat.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 26 Nov 2019 at 12:15, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote:
> > My main objection to 'contrib/' is actually the perceived notions
> > about what the contrib directory is for. When I see 'contrib/'
> > code in either QEMU, or other open source projects, my general
> > impression is that this is largely unsupported code which is just
> > there as it might be interesting to someone, and doesn't typically
> > get much ongoing dev attention.

> > virtiofsd is definitely different as it is intended to be a
> > fully production quality supported tool with active dev into
> > the future IIUC.
> >
> > IOW, if we did decide we want it in QEMU, then instead of
> > '$GIT/contrib/virtiofsd', I'd prefer to see '$GIT/virtiofsd'.
>
> I'm not sure it deserves a new top level for such a specific tool.

Maybe, but I think I agree with Daniel that 'contrib/' is
probably not the right place for it if it's something that
we care about supporting. 'contrib' to me is "bucket of stuff
that we didn't really feel strongly we wanted to reject but
which is probably random special-cases or other obscure
stuff, don't bother looking in here and don't assume it's
going to work either".

thanks
-- PMM

