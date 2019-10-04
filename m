Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB5DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC896215EA
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KlhT3dJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC896215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48649 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGNUO-0005fE-Se
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGNRh-0003sk-5G
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:16:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGNRf-0000H8-Pe
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:16:32 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42033)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGNRd-0000F0-9B
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:16:31 -0400
Received: by mail-ot1-x341.google.com with SMTP id c10so5234850otd.9
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=DCEP686+8ZtZ6gI6Wmqh2mQEO6m0JHcN34mrWWvrA/s=;
 b=KlhT3dJm4K1nh1iVgqyuuMHYYoJb9KHmmH6XG86VBkM9SEPyws826iNf3Z3PmnMIau
 Fimz6oPTBNsRGi1TMpbKr52n+sFCfgriUhmMb8z9kcAnMd2YHo6D8DkVSwZXrkKxW1Eu
 io7c+OB5z1wE4YAK7dR+Z7oi+49W9GhnKAfQLZQ6sgSN6+hOEaWhtfhq8sbFUpWSOAZb
 Kaeh+c/aDVhi4V7P/i7BHeRZcetfcPE2Hqe+dNLFmD+kWq3USjrlzaG7iXIi9SQy3QYL
 1yZ1287evC1931nUge1j22Trg23frHbonKdaZ1krIshGgoBAPyVZ/gI7apRpc9ihZWoR
 jfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=DCEP686+8ZtZ6gI6Wmqh2mQEO6m0JHcN34mrWWvrA/s=;
 b=d7xKn/CQO4IH9YQSyrmOtEeByX248uIREZ6zcfckbuJU0ZhAKnvvn09sXokxIyjcgs
 ZtqfGATp1m3B4YfKl7YzVD3zgvUjyFIIVKzhMPki11nJyd974lyubPXF3RDO8UIioXwK
 Vn7rtm/oT6+xoABXqsZ8oW1aIbPLMQDgknqNIF6yCLSkeJn89E4kMQ7qm21hI4DKJ+mC
 E7HiJKGZAA4q6Gmr+yHbWbFSv5glFMe6gucuMsX+uwzdyLEBP6ouq4zT7ES+dgXrSSLz
 YA0LQQiPRGzQRn7qAyK5GcQBBlJCe+FL1o3ccE189804a2tceIFeWIGg7NM10boYoTtm
 M/HQ==
X-Gm-Message-State: APjAAAVVeosyMWnijsfB8cVqn2mFpDBlGYgTQ789D2WXAzDOREHwHgjq
 MElRr4aLSMsWGlRJ5sGk7wcLInw5E2easaeed3SQnQ==
X-Google-Smtp-Source: APXvYqxE6v+bHzh3W6MVUTECsHAhMNf7fNartJh3iYnayrs8UBIM+RfkZUuJJrgKI5gwIMu2YZvQHQRoz1sdtFcxQl0=
X-Received: by 2002:a05:6830:1357:: with SMTP id
 r23mr10779215otq.91.1570194987948; 
 Fri, 04 Oct 2019 06:16:27 -0700 (PDT)
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
In-Reply-To: <d194e22c-7125-e558-0a80-131a28a87419@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Oct 2019 14:16:17 +0100
Message-ID: <CAFEAcA-4-ttpQ5S-HuEtv86TeNjBnFzp77D5ML1D9CZMYGR5Ow@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] iotests: remove 'linux' from default supported
 platforms
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 at 13:45, Max Reitz <mreitz@redhat.com> wrote:
> > In the end, I don't care what code these patches touched. I do an
> > innocent git pull, and when I finally see that it's master that breaks
> > iotests and not my patches on top of it, I'm annoyed.
>
> Hm.  Part of my point was that this still happens all the time.
>
> Which is why I=E2=80=99d prefer more tests to run in CI than a handful of=
 not
> very useful ones in make check.
>
> (Of course, running it in a CI won=E2=80=99t prevent iotest failures on y=
our
> machine, but in practice neither does the current model.)

If you want the tree to be defended against problems, then
you need to run tests in 'make check'. Nothing else gets consistently
run and has failures spotted either before code goes into the
tree or quickly afterwards. 'make check' does have the restriction
that we don't want the tests to take too long to run, but in
general the block layer should be running some reasonable subset
of tests in the project's standard "run the tests please" command.
(I have no opinion on exactly what that subset ought to be, beyond
that it would be good if that subset doesn't have known intermittent
failures in it.)

> I still think that I personally would prefer the iotests to not run as
> part of make check, but just as CI.

'make check' *is* our CI gate, to a first approximation. Most of
the various travis and other setups are simply a front-end for
"build QEMU in various configurations and on various hosts
and then run 'make check'". The travis setup at the moment is
a bit odd, because it runs tests but it's not a gate on our
merging changes. Ideally I would like to fix this so that
rather than me personally running "make check" via a bunch
of scripts we have one CI setup that we trust (gitlab seems
the current favoured contender) and that gates changes flowing
into master rather than me doing it manually. We might then turn
travis off if it's not providing anything for us that the gitlab
setup doesn't.

thanks
-- PMM

