Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D9FC3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:31:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18D49206B8
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 14:31:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFXq1MOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18D49206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5WJz-0003eJ-7t
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 10:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5WIo-0003C0-H3
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:30:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5WIn-0007mK-CL
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:30:30 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:36678)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5WIn-0007kY-6L
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 10:30:29 -0400
Received: by mail-oi1-x230.google.com with SMTP id k20so9560086oih.3
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 07:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=7FJcFskP6edwP+8yYUSQ515QB9NmEd0rx7CjKUECjRM=;
 b=dFXq1MOyTEkv6LQinsHTK3N26MxEEhnn2zZev17DtEzl0V6YSOX6RMbSK8ryf22K5h
 B5qBoiL2grLFTKYo+N2LCXFdkABaJcgahVM2Je+uo3D4MgYwzxcghG4cH8Z1cTMTRlbM
 5UeW/jFYlcEE8Pz+6S0KnDUhKB7mLUbn3xrkEkb1mBxrgop2duoHDPaHMZwJkN/MtWW9
 V2/D1wiuwFivEDgxAvOYi9BCu4yCzNPmK9JIUUnWkpz19o2AGUe714E2sNJo5tgkgO+h
 m7yxJgyJ3wBa5Rhxr7mKloZgvwVJFlRqMY33Eds33fVOy2pGzjSmXsHVAMMjN7nTEoug
 AsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=7FJcFskP6edwP+8yYUSQ515QB9NmEd0rx7CjKUECjRM=;
 b=jYFvgVF//4E3xt4Gi22KAJxYkvfHnfz54dVuV11Y4ONntfByJlY34Kr5Z+v2m+SIGu
 vQ09fxBc3I7eeEkvUwxp53jVd1zNNh8jgrpDlZvWz8zgfL86eW8GWVCq66ltcT23zocs
 ZAcca1kyb/BQzo6DYfvMH2yB23InkER5znwrG3W2+OXpsvMfvnN9m5qhl3xtGEo2UQLu
 tz7RNVV/EYTBNqnqPNI7qXuynfVNmWCwHv1zE4nPM2u1qq7+s80AvhfwWuxjBMbqMMeh
 fTkroDesSbXMwtEjlCJQN3VjJK4MZvZGVZlGSuZFT9NpkQdv8XGNpwT2HJArPKgsZZyu
 7w2w==
X-Gm-Message-State: APjAAAWcx1Vk/nH3ia1gQVm0OcqXsjOGQx5DlEmYiTjO0b0GTIaxAMym
 yqkyMLvD3l0CO8/ayu4S1HQznE6kQ0RlDryjnPi+hA==
X-Google-Smtp-Source: APXvYqyb4N7tTXtuq+EIBa3H1SISbIf/G52zcPjsrus8EcpsO8RmRVSuFeqEZt5omwnDJEX78WyHZfsBESovj3lq+J0=
X-Received: by 2002:aca:4814:: with SMTP id v20mr3567514oia.98.1567607427540; 
 Wed, 04 Sep 2019 07:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1566503584.git.qemu_oss@crudebyte.com>
 <21182000.2zn5IIMESL@silver>
 <20190902173432.20f2637b@bahia.lan> <2734436.Mu773bgsdE@silver>
 <87r24xqjoz.fsf@fsf.org>
In-Reply-To: <87r24xqjoz.fsf@fsf.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Sep 2019 15:30:16 +0100
Message-ID: <CAFEAcA8yfdJk74rybVCdc0gJDoAHO99LWHwvGVfh6CgueH6cfA@mail.gmail.com>
To: Ian Kelling <iank@fsf.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::230
Subject: Re: [Qemu-devel] DMARC/DKIM and qemu-devel list settings
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>, antonios.motakis@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Sep 2019 at 20:11, Ian Kelling <iank@fsf.org> wrote:
> I don't know who has the Qemu-devel list admin password, but whoever has
> it can adopt the unmodified message fix by changing
> dmarc_moderation_action to Accept here:
> https://lists.nongnu.org/mailman/admin/qemu-devel/privacy/sender and
> remove subject_prefix here
> https://lists.nongnu.org/mailman/admin/qemu-devel/general

I'm one of the list admins, at least for the main qemu-devel
list; some of the sublists have different admins (and
perhaps different settings -- there's no way to conveniently
say "manage all 5 of these lists with the same policies,
so it's easy for them to get out of sync, deliberately
or accidentally).

I have been considering whether we change how we're handling
the DMARC problem for the list. I picked munge-the-email
initially because I think we didn't really understand the
consequences in terms of patchmail, and also because there
was a group of subscribers who complained that they liked
the [qemu-devel] tag, used it for filtering email, etc.
I think overall my opinion has shifted to thinking that
the downsides of munge-the-email are too great and we should
indeed switch to not modifying the message at all.

thanks
-- PMM

