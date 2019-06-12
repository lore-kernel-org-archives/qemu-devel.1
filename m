Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009DBC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:26:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C123921019
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 16:26:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XF7PwyRJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C123921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33680 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb65R-0007Xg-Tz
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 12:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51437)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hb630-0006KD-0U
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:24:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hb62y-0007lJ-SH
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:24:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52997)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hb62y-0007kK-IC
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 12:24:24 -0400
Received: by mail-wm1-x341.google.com with SMTP id s3so7216363wms.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 09:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=N+/yIdfU02JHHyPZEYVbXfmmoWd7uhT5Rpe82TIP/Es=;
 b=XF7PwyRJYDAHEyKwMho5COsM4VYd2ZlrDSNFh6nFMkRDe12KmcFPURj2EktTaXq8u1
 8qfMjMRz4m7J2pp6MvzcEiIEqfiA3DYdNaF1LxcwbgAbrcXXKPav3HtiL5DxePpamo3A
 Ue0gsRsFb+QV4sPM/WXNRbLUD/dkojR+cxxpUAc8PYyQQ2sxjbXRDjjHQcDdVY5HEB/4
 8BUl+WcPAzgHlByAe2a/xQp64tnjP6mU5xJgs0RPWzUpwT8SRqmJmCCbyOIMfnhqjw1Z
 Ri9Av1cEGGm91+K9GdKV4ZmPB+wuoQA7A01aBvOcO1DFS9jS/m/L8F18gbJEs3beYbiK
 m9tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=N+/yIdfU02JHHyPZEYVbXfmmoWd7uhT5Rpe82TIP/Es=;
 b=TzarZtPw76soyyQ44FPBb2Hu0xiXreIWlo886Biz843O9BN3cogflTNeP2U4O7meRn
 MNdSRa0eQ2oI/VcQbVFdkAZJrypxJhlNSmHiZE4xqJvE8oZjQ9GBKlhd8mkqjR8YNQ5E
 yVt8d/VHqO9Nin62Fq8SdsqHe5hPr2xRjg78mP0JUwlg9wurzMd2cZtSG6K6Tls2peb6
 6u1ljgNg39gLKXnLk5bBGo7f9+gfL4shlHJwlVeh0iy7TAB8DutJ04slWOBIOv86eHaz
 LVIwydTnAow28DBgFCebDXhDWwABo9YcWu6d3raki+K7nMKHkLtCBQpUf2zaGm15ulwx
 q8tg==
X-Gm-Message-State: APjAAAWDV4zL5DwN+tvL6GV9lrHrQAd8u7YM/po24/gx/S126hqfAC78
 1GdOrgP7Ki81knJgSJuMAzI=
X-Google-Smtp-Source: APXvYqya62wGD+mOzp5kh5kwe6Qplx76aJtZOgibpw6P8eOkPoxkJxrfwL1W3qB5w73HgGdVmBfWiw==
X-Received: by 2002:a1c:345:: with SMTP id 66mr74619wmd.8.1560356663078;
 Wed, 12 Jun 2019 09:24:23 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 128sm256779wme.12.2019.06.12.09.24.21
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 12 Jun 2019 09:24:21 -0700 (PDT)
Date: Wed, 12 Jun 2019 17:24:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Message-ID: <20190612162413.GB1620@stefanha-x1.localdomain>
References: <20190308095036.GC12318@stefanha-x1.localdomain>
 <20190326080822.GC21018@stefanha-x1.localdomain>
 <e5395abf-6b41-46c8-f5af-3210077dfdd5@oracle.com>
 <CAAdtpL4ztcpf-CTx0fc5T_+VQ+8upHa2pEMoiZPcmBXOO6L3Og@mail.gmail.com>
 <c945c950-f6f1-7e2a-a6c4-399c9b728288@oracle.com>
 <20190425154421.GG17806@stefanha-x1.localdomain>
 <fe4b0b42-523d-5877-173c-3e878abd4e32@oracle.com>
 <20190523111130.GF26632@stefanha-x1.localdomain>
 <20190528151820.GA4545@heatpipe>
 <20190530205434.GB2694@flaka.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20190530205434.GB2694@flaka.hsd1.ca.comcast.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
Subject: Re: [Qemu-devel] [multiprocess RFC PATCH 36/37] multi-process: add
 the concept description to docs/devel/qemu-multiprocess
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
Cc: John G Johnson <john.g.johnson@oracle.com>, sstabellini@kernel.org,
 Jag Raman <jag.raman@oracle.com>, konrad.wilk@oracle.com,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, ross.lagerwall@citrix.com, liran.alon@oracle.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 kanth.ghatraju@oracle.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2019 at 01:54:35PM -0700, Elena Ufimtseva wrote:
> On Tue, May 28, 2019 at 08:18:20AM -0700, Elena Ufimtseva wrote:
> > On Thu, May 23, 2019 at 12:11:30PM +0100, Stefan Hajnoczi wrote:
> > > Hi Jag and Elena,
> > > Do you think a call would help to move discussion along more quickly?
> > >
> >=20
> > Hi Stefan,
> >=20
> > We would like to join this call.
> > And thank you inviting us!
> >=20
> > Elena
> > > We could use the next KVM Community Call on June 4th to discuss
> > > remaining concerns and the next steps:
> > > https://calendar.google.com/calendar/embed?src=3DdG9iMXRqcXAzN3Y4ZXZw=
NzRoMHE4a3BqcXNAZ3JvdXAuY2FsZW5kYXIuZ29vZ2xlLmNvbQ
> > >
> > > I also hope to include other core QEMU developers.  As you know, I'm
> > > skeptical, but it could be just me and I don't want to block you
> > > unnecessarily if others are more enthusiastic about this approach.
> > >
>=20
> Hi Stefan
>=20
> A few questions we have are about the call.
> What is the format of the call usually? Should we provide some kind of th=
e project outline for 5 minutes?
> We are planning to address some of the concerns you have voiced in regard=
s to amount of changes, usability,
> security and performance. I assume there will be other questions as well.=
 Is there any time limit per topic?
>=20
> And would you mind sharing the call details with us?

Hi Elena and Jag,
Sorry, I was away on sick leave.  The KVM Community Call is informal.
The goal is to get people together in a teleconference where we can
discuss topics much more quickly than on the mailing list.  This can
help make progress in areas where the mailing list discussion seems to
be making slow progress.

I would suggest starting with a status update the describes your
current approach (without assuming the audience has familiarity).  Then
you could touch on any issues where you'd like input from the community
and you could take questions.

Our goal should be to get a consensus on whether disaggregated QEMU can
be merged or not.

Here are the calendar details (Tuesday, June 18th at 8:00 UTC):
https://calendar.google.com/calendar/ical/tob1tjqp37v8evp74h0q8kpjqs%40grou=
p.calendar.google.com/public/basic.ics

Is this time okay for you?

Stefan

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0BJy0ACgkQnKSrs4Gr
c8j+4Af/adGqjEFMi3fSSczfv0dvywDPVkPkmVpCCz3THIsSYTLGQP3ywJ0bpNn3
zc0cNu4iNa3cTOZBvpRNe68/mFEfeIEoAUBoQ6lNwQe79g/yLahsVks0a7GzRexw
kOvZuIkLN8/1xtjV1HpilAuDNL6TjXK3K8zro8imLe/RDhXv+uBUFTv/iguQO5IK
y33FJg7A6VBVMGZuoDNFpzwJ3JJQLJIy+MzbnuFU/RNcAQM1pS0H944hZWav/6A2
GR2JOh/YqLiVTpicuNTsZAnTsfwO96Q0qoGMoyDu6h7Paj6Bet0hOvAlZEYI7uvn
mqtWgE+uheIQ1oYWJXpayHAnR6MxMQ==
=QhLX
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--

