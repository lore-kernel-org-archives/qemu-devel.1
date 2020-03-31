Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2FFC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:13:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A122206CC
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 16:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uv6oFycb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A122206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJJW4-00062T-LI
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 12:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJJVR-0005WV-GO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:12:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJJVQ-0004BH-BW
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:12:49 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJJVQ-0004B8-3R
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 12:12:48 -0400
Received: by mail-oi1-x241.google.com with SMTP id t25so19407019oij.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 09:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xYxjFC05Y9IzMuow2NY7UJHZmguN7TRUgsgEOkh1MXA=;
 b=uv6oFycbUMJjWYqPqV3cSHFSRjnHnRS4gMsx71exqC3/NZ/i6tJVJ1TgTcHU1SyKwz
 ca7dHOlOZlcA9vOBL8Rr3ppO8UXuD86LghoRBYM2yAPgef2D6vAsw96Jg0zXcZ/N8grC
 q7WL6jcZ7cyHDTC4mMqD1WkidyXNxSiDBUjEV4+CaOoLpGhjaekmix58OW8pb46RbCB8
 wkZ4WgC7oLdkm2asJ5K3Jk0zDapdlLHvxy1oMaqszynt1uhVsKIsCC+iiKgAj2CksY53
 8lnmrJ+YGWdcsKbQCfoIZr8CcXgQaeBWEOCCQUzwza9DpqLQbXbkHJgwUw9X98tE1FCO
 nb+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xYxjFC05Y9IzMuow2NY7UJHZmguN7TRUgsgEOkh1MXA=;
 b=lNvrjbcfdS2tdokWe54OwtUF9zsgQnXTPCemaqSjTjAl2SQvMfzu3hcLJ47hWklqdH
 LPwoTsDuLpuXSeTcn4J8WrHaRAO+Rnl/x36XJMzl/k9drLDjZKiXb2hz1lQM7kr+fYzn
 tW7EDiwkSFihLfbFFmJ7To02uxwsA4fOWxQSUbkfQRVE3aRSaskx8C9bWpw/9OW3ZDH2
 exKTmaLs/dQ8WKEhk9IhmAOe3riIlnf1o3TxxNSJw6gFZzGkmBXEr/LeL8gE0Jr9/nLE
 orpdUxHtEnJUWR7Pr/IPEg5+KwIpOsSlqRS3d7wc4kkDsbakYNr7TwR6ZNXH9EnyGqUJ
 jwpA==
X-Gm-Message-State: ANhLgQ3UtdhYGu06HcsMMgEmhcnNRlVAabPqneVl+B1mLnJvK1BIi+xo
 jWak8Zs9k55VKx0ik79Q5vgCzAGy3TwdrVC9KFu05A==
X-Google-Smtp-Source: ADFU+vsi5Elde7e20W42PjyP8pP5y1iIhjWoj954WBn4XWlqx05pD6ntm8nRlRZ6Mr4d3d5IwKTYfp1izKlM9RL7AP4=
X-Received: by 2002:a05:6808:64c:: with SMTP id
 z12mr2537244oih.146.1585671167355; 
 Tue, 31 Mar 2020 09:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200331155158.381585-1-berrange@redhat.com>
 <1450d802-4df8-117b-e58d-da8bf2334010@redhat.com>
In-Reply-To: <1450d802-4df8-117b-e58d-da8bf2334010@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2020 17:12:35 +0100
Message-ID: <CAFEAcA-MNMK3O-iyP-wR4YGpTYua+vKHv=jAtmcC6U=_Gz4Fag@mail.gmail.com>
Subject: Re: [PATCH v2] configure: warn if not using a separate build directory
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 at 17:05, Eric Blake <eblake@redhat.com> wrote:
>
> On 3/31/20 10:51 AM, Daniel P. Berrang=C3=A9 wrote:
> > +if test "$in_srcdir" =3D "yes"; then
> > +    echo
> > +    echo "WARNING: SUPPORT FOR IN SOURCE DIR BUILDS IS DEPRECATED"
> > +    echo
> > +    echo "Support for running the 'configure' script directly from the=
"
> > +    echo "source directory is deprecated and will go away in a future"
> > +    echo "release. In source dir builds are not covered by automated"
> > +    echo "testing and are liable to break without warning. Users are"
> > +    echo "strongly recommended to switch to a separate build directory=
:"
>
> Per Kevin's response, we may want to tweak this wording slightly; maybe:
>
> Support for running the 'configure' script directly from the source
> directory is deprecated.  In-tree builds are not covered by automated
> testing and are liable to break without warning.  Future releases may
> change the default location of built executables for an in-tree build,
> or drop in-tree build support altogether.  Users are strongly
> recommended to switch to a separate build directory:

I now feel that, given that we've had various people say they
want to retain at least the basic in-tree build commands and are
willing to put in a wrapper to make it keep working, that this
deprecation wording is a bit strong. I don't think that it
much serves our users to say "this will go away" and then
implement the compatibility wrapper -- we've caused them
to unnecessarily change what they're doing, and then reduced
the value of the compat-wrapper work we do. A more gently
phrased note that we recommend use of out-of-tree builds
would be sufficient I think.

(That is, the idea of notes in the release notes and configure
is to signpost to our users the direction we think the
project is going in, so they are not unpleasantly surprised
in future. For this to work the signpost should be pointing
reasonably in the direction we plan to head, rather than somewhat
askew from it :-))

thanks
-- PMM

