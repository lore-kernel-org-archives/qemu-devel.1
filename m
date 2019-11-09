Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88700C43331
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 16:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47040207FF
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 16:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CcGDJqP9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47040207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTTHd-0000vm-FU
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 11:08:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iTTGq-0000Hv-4H
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 11:07:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iTTGo-0006TQ-Qw
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 11:07:27 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33783)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iTTGo-0006T5-Li
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 11:07:26 -0500
Received: by mail-oi1-x244.google.com with SMTP id m193so7989561oig.0
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 08:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YRbGCIkG4wRF/q+g8XBLdMA6eZgxQyM4za5xTOEnbCM=;
 b=CcGDJqP9OUl3LIoPF4hQRCCLYI6O2Q6aaD0U0Z5Bqi3xQqFf6aAKGTNYkaM+ENeOaJ
 lcZ42XagzKc5ktfnVCasVR8zUrOy6Pmie1OfaoM/BjjB59SRFZeIb6sJ+kurTu0hV+7M
 e5/OklLtuYWW1XXhSmiSV5zMBY6wkDjDGJCVQvUh/t8V9nbJRzxtOGLyo93i7c7qhxD9
 vGxjTPPQ41eeNcUHlJVnh1R0W6QAXAMS/ZRf7swNSGtwcOMS69zfhNv06jKYZkIDMxSF
 +iST/URd5cZgT6HMvaDT5wwj1bcOJFCD22P6KU6db7qqYWwYZE6yMlvpV4l14Wje3qNm
 PcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YRbGCIkG4wRF/q+g8XBLdMA6eZgxQyM4za5xTOEnbCM=;
 b=jGOVEZz0+Z5eQq74v4BemBReq412aGv6ye4bnhVz+gUzIOzXDc7vvWf6bAeNkkyH6X
 GQCJuWrPkBuzpVSYpdDw/6KI8/B52CBF6lecZbkBbIZoyHavzzFsAWjNS0vHTQmdLIdo
 u0ksm4y2r//dL+2LdfZCN0aogg+nAccc7bSVXu3DWZ4a33J63jXiwU/tL+BrFTjKNgOr
 VvhLj/0qlD2vnuc1vJfYKqCu8Gg09/G28Xg3gO6IQ9w8k1ZufeFdxt9/9OCZqVJGECc8
 KN0UgFosHKFNFaGQkyrj84PuHpB8IF+EuC05SVBEVokN4lI5gmrcQl12Q54wcIH1+zFg
 BGjw==
X-Gm-Message-State: APjAAAWE50eUPi92cGgLkebO+MF+iCRp1snxub1G3hGqJJTbFPvQgKii
 s0vwV9mWMhF00tbzw/Lmx4GN0v73hpFAWegy9w2ODg==
X-Google-Smtp-Source: APXvYqzS6x9Dvpyl+dgh9Pwbh2S5Qm3kLbAQbVh7X7ti1UMGZbzGhL0b6ro8BY/+sApcCBMpZKKn6rW/klpNdN6zmRc=
X-Received: by 2002:aca:cf12:: with SMTP id f18mr15070427oig.48.1573315645842; 
 Sat, 09 Nov 2019 08:07:25 -0800 (PST)
MIME-Version: 1.0
References: <20191108110714.7475-1-david@redhat.com>
 <CAFEAcA-mD3-Zg2JunGpMqbcaT1qboCenhqEFytZD0FmFcL2i9Q@mail.gmail.com>
 <5dd613c0-6d9e-b943-b64d-7ba1791cbefe@redhat.com>
 <CAFEAcA-4r53vM-K24WYr1OFSOufhZ7hDHeZBhnywyaJ0gpMO1g@mail.gmail.com>
 <20191108191057.GZ3812@habkost.net>
In-Reply-To: <20191108191057.GZ3812@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Nov 2019 16:07:14 +0000
Message-ID: <CAFEAcA_No5oAFtULbAOrPDeQE18HHgc0agXbs4m2AGZ+gK_ReQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] s390x/cpumodel: Introduce "best" model variants
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, Michael Mueller <mimu@linux.ibm.com>,
 Jiri Denemark <jdenemar@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 Nov 2019 at 19:11, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Fri, Nov 08, 2019 at 01:02:28PM +0000, Peter Maydell wrote:
> > On Fri, 8 Nov 2019 at 12:46, David Hildenbrand <david@redhat.com> wrote:
> > > There is a small but important difference between "max"/"host" and
> > > "best". Max really means "all features", including deprecated ones.
> > > "best", however, can disable experimental or deprecated features. Or any
> > > other features we don't want to be enabled when somebody selects a model
> > > manually.
>
> On x86, this is implemented by "host".  "max" gives you the full
> set of features that can be enabled by the user.  "host" gives
> you a reasonable set of features you will want to see enabled by
> default when the user says "use the host CPU".

How does "host" work for TCG on x86?

> > Hmm. I see the distinction, but is it one that's sufficiently
> > worth making that we want to expose it to our users, possibly
> > try to add it to the other architectures, etc ? How bad is it
> > if the CPU provides some legacy deprecated feature that the
> > guest just doesn't use ?
> >
>
> "max" isn't something we want to expose to end users.  It is
> something we need to expose to other software components.

We seem to have a disagreement here about what 'max' is intended
for and what its semantics for. That seems unfortunate...

For Arm, "max" is absolutely something we want to expose to
end users. It's the easiest way for a user to say "give me
something that's going to work". "host" doesn't work on TCG,
only with KVM.

> > 'max' already shouldn't include experimental features, at least
> > for Arm -- those should be off by default, because they're
> > experimental and you only want users to get them if they
> > explicitly opt in via '-cpu something,+x-my-feature'.
>
> The whole point of "max" is to tell management software which
> features are valid to be enabled in a host.  If "+x-my-feature"
> works, "x-my-feature" must be included in "max".

No, definitely not. Experimental features should never be
enabled by default -- the user must explicitly opt into them
so they are aware that they're using something that might
change behaviour or go away in a future QEMU version.

Also, from my point of view "max" is not for the benefit
of management software in particular. It's a convenience
for users primarily (and also for management software if
it doesn't want to care whether it's running KVM or TCG).

If management software wants a way to ask "what features
might be valid" we should provide them with one which
doesn't require those features to be enabled-by-default
in the 'max' CPU.

thanks
-- PMM

