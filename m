Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADDCC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:39:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32FC2205F4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 12:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ed3jLDbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32FC2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHSIO-0001yg-9M
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 08:39:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHSHQ-00012k-2G
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHSHO-0007uX-85
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:38:23 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40262)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHSHN-0007u4-1h
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 08:38:22 -0400
Received: by mail-ot1-x344.google.com with SMTP id y39so10782546ota.7
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 05:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Eitmdur7IFclm5OmiXUKql+34LRIF1lT1xgTvve69ts=;
 b=ed3jLDbUAmrtGYFsu8M8Avqmtxo3QrYokXKJp/mvGdzrN9fY0DiqKKKErWKS5ev/vv
 czFe8MsctlO8/5cN2sMYiWwHa0B1/rnQCsQqPMn1VLQpkuB/GySdW9A569rN8goUwuEo
 0zbkdrIVSNicnj3bw+cETwRAgPTsVllwuTSdF54CNbJJnhIhoSAnRCeJN6qReNdRGyDb
 y0tDOywY/pzLB++4WLe7wKISlOjW5UdRe3jG4LKbUs2Flm8ceS5Lio0OqYfuaYwHaRng
 OpbHL9fRManjh5WaqPNUMCFCL8nPEZBY9XYvlEN74BbOT6QMET+03Zvb71l4th9975SJ
 R2yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Eitmdur7IFclm5OmiXUKql+34LRIF1lT1xgTvve69ts=;
 b=hAS6ABTauZz65ZTDy6FNhpj0157gOOFjCl/LpoE2oh3cMsspk7BsZSGdZkB08U2YfJ
 1BP1pE849/V7KN6fO8Xzc3BNvwDftU0Ky8aZQ/KtHOop0NkYQqBIakuUqo6SRr8HrtK+
 +sGuKJg1TL29U3rv71xMYGrd+1GEnbBpi1rXTTSZqSsDjBXDA+YdW6yS0X/VU6diN3J4
 XNqKLwOfrUX9zH9hp5jZXBJ14r15uIwP06P5SHHBV46dzoA/+qqzHRuxt8TPaSBm+oOv
 8g2D3hFoSwnJCp65RI06/9p5FE+z+/ez0+btFkWLr8gGzsSjrbU69TzSUrtFwUk4l2QV
 U0Ew==
X-Gm-Message-State: APjAAAWEQWEL2cjJJemKYv12B84LVnkwBjN5+jSB+KoJnkmH+Smx+iuJ
 +zBUysWBRJ0hLtGROhRMNxzTxYlcN7eql7qgEQM/2OL+Xvw=
X-Google-Smtp-Source: APXvYqz43s/hk3CKx3en2NHRlqUEpBwheUz7q4AlYtcn+cq2YaaD9u60x9ha1rjY6xf9tJaIg2J4dgPHkpxv8fuiGYk=
X-Received: by 2002:a9d:6d0a:: with SMTP id o10mr19552790otp.221.1570451899897; 
 Mon, 07 Oct 2019 05:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190917234549.22910-1-jsnow@redhat.com>
 <20190917234549.22910-2-jsnow@redhat.com>
 <a252472e-842a-8401-2743-e4ed948b066b@redhat.com>
 <450a1f52-9589-cb98-88cb-1d3fcd5f506a@redhat.com>
 <778487c5-566e-d133-6395-d3908db66adc@redhat.com>
 <62cf912a-8ee9-d023-84c2-1ad6ea94e3b8@redhat.com>
 <16eef993-c16e-3fd7-c60d-6d3c7bfb5148@redhat.com>
 <20191002164438.GD5819@localhost.localdomain>
 <a7f532cc-68cb-175e-6c8f-930401221ef9@redhat.com>
 <20191004101952.GC5491@linux.fritz.box>
 <d194e22c-7125-e558-0a80-131a28a87419@redhat.com>
 <e7d5cc8a-7a61-70a2-7efc-8f1af8e7a41f@redhat.com>
In-Reply-To: <e7d5cc8a-7a61-70a2-7efc-8f1af8e7a41f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 7 Oct 2019 13:38:08 +0100
Message-ID: <CAFEAcA8iPnom=M+jTAmeynzTvOmC78xK42B+hb_oFv0m6k9jKw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Oct 2019 at 13:32, Thomas Huth <thuth@redhat.com> wrote:
> On 04/10/2019 14.44, Max Reitz wrote:
> > Whenever make check fails, it=E2=80=99s urgent.  Without iotests runnin=
g in make
> > check, we had some time to sort the situation out.  That=E2=80=99s no l=
onger the
> > case.
> >
> > That means we need to take care of everything immediately.  And I purel=
y
> > want help with that.
>
> While that sounds noble at a first glance, I think you've maybe got too
> high expectations at yourself here? I mean, all other maintainers of
> other subsystems with tests have the same "problem" if the tests for
> their subsystem run in "make check". The "normal" behavior that I've
> seen so far (and which I think is the right way to deal with it):
>
> 1) If a pull request gets rejected due to a "make check" failure, simply
> drop the offending patches from the pull request, send a v2 pull req
> without them, and tell the author of the offending patches to fix the
> problem (unless the fix is completely trivial and could immediately be
> applied to the v2 pull req). You really don't have to fix each and every
> issue on your own as a maintainer and can redirect this to the patch
> authors again.
>
> 2) If a test fails occasionally during "make check" (due to race
> conditions or whatever), it gets disabled from "make check" if it can't
> be fixed easily (e.g. in the qtests it gets moved to the "SPEED=3Dslow"
> category, or in iotests it would get removed from the "auto" group).

I would agree with this and would also suggest that things tested
in 'make check' should ideally be reducing work for the maintainer:
if something fails 'make check' then that change won't get into
the tree and the task of getting it to work is pushed back to the
original patch submitter. If something causes failures but they're
not caught by 'make check' then the patch will get into the tree and
now it's likely the subsystem maintainer's job to track down and
fix the bug after the fact.

> So if you like, I can send a patch to remove 130 from the "auto" group
> (personally, I'd rather wait to see if it fails anytime soon again, or
> if this was maybe rather a one-time issue due to a non-clean test system
> ...)

FWIW I haven't seen that iotest 130 failure again...

thanks
-- PMM

