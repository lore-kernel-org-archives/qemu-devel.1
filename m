Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29256C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:11:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDC6A20657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="enUc0PUz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDC6A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZenu-0001YY-3D
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 14:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jZenA-0000hD-Vh
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:10:40 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:40367)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jZen9-0003kA-R4
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:10:40 -0400
Received: by mail-lj1-x241.google.com with SMTP id g1so3214201ljk.7
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 11:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UQKT10OmCp49GaESvWKY1wkPwLk2MU4JtXw6/W7KlR4=;
 b=enUc0PUzPSeAoEBw+NWA5SPQPTxQw5TX0rK72aLacLZJbIQwE5eoJ93cQSugL+f0IT
 Q6MQm8iQHPghrfutB9cy129wlA3ZbRLUp1G64sz30e56RbDKVofQkDjjOIsfPiqX2t0e
 lJjZMaZAWTqC7R4E2mXWcjoQaQ5wGM+NqElk1osf5KVZtG3Lo3o+ikSvS4XRiaybygCu
 dVn2TycSE0pqCK7/S+HIj7Bf22N0NgjItxo/Q+qW7OsyNNYzZhAG6S1FwjFIYuzUI0XQ
 D+HOrna8WAFwzDxidPm76bxBjscYBva/ZxlSQjvQxC10cySNsKvmmV29FDO6+odYl8dQ
 ydRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UQKT10OmCp49GaESvWKY1wkPwLk2MU4JtXw6/W7KlR4=;
 b=hs+LqRDvniM5KHjwXM3FT4sWXpjA+1bYrbWnStlzZT1STkXxPUevpep2k7dSsry/y9
 mZCTMnznFxQwortiBPcJ6HHnV220gH9avPCsDDrAAcFJtRmhtlhqVTtnW7obFRYiTdkt
 VfE3+l4gpJX1ss5951WJVMNHCL3Go0Nf7wUjWb2T1t8DkZ92qp+g96aRzhKHio52xqjh
 +GyjT1x6AK4EPzD+GltPeLte1bIeiINiZRtW/+tK9i0MJ64myDRD9jew83bOkH759Oad
 labDUKBfMlRq0ROm6u9TU78cgWVxAt7U+tJqE+Cwd1KxJsaehkGCs6wLoyjIiUNQhvAE
 KcpA==
X-Gm-Message-State: AOAM530ZzCSMGvE/2/fAn2TjhwQPpC7qSx4/7YEFuQZCSmK+CdqSQG1v
 UsGBr2tLvlKJBqaEFYu57BSaM64M2ih+tNBGK2SYiQ==
X-Google-Smtp-Source: ABdhPJyj2IqscjvABU5StUGNC7OwBFC0B0I7KlyPE//f9CyX4/Y8dGX/p5M8skaF/3lA1/o7oiJdXBoMmVPwTcRB3EE=
X-Received: by 2002:a2e:b6d3:: with SMTP id m19mr2894844ljo.43.1589566238013; 
 Fri, 15 May 2020 11:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200512193340.265-1-robert.foley@linaro.org>
 <20200512193340.265-2-robert.foley@linaro.org>
 <87zha9az9h.fsf@linaro.org>
In-Reply-To: <87zha9az9h.fsf@linaro.org>
From: Robert Foley <robert.foley@linaro.org>
Date: Fri, 15 May 2020 14:10:31 -0400
Message-ID: <CAEyhzFuXCL4ZpA1uSdifAYUzVf-ntSe68uW7wkhqhf+6Cv5Ubw@mail.gmail.com>
Subject: Re: [PATCH v6 1/9] tests/vm: Add configuration to basevm.py
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Puhov <peter.puhov@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 15 May 2020 at 13:23, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
>
> Robert Foley <robert.foley@linaro.org> writes:
>
> > Added use of a configuration to tests/vm/basevm.py.
> > The configuration provides parameters used to configure a VM.
> > This allows for providing alternate configurations to the VM being
> > created/launched. cpu, machine, memory, and NUMA configuration are all
> > examples of configuration which we might want to vary on the VM being c=
reated
> > or launched.
> > This will for example allow for creating an aarch64 vm.
> >
> > Signed-off-by: Robert Foley <robert.foley@linaro.org>
> > Reviewed-by: Peter Puhov <peter.puhov@linaro.org>
> <snip>
> > @@ -61,19 +86,30 @@ class BaseVM(object):
> >      # 4 is arbitrary, but greater than 2,
> >      # since we found we need to wait more than twice as long.
> >      tcg_ssh_timeout_multiplier =3D 4
> > -    def __init__(self, debug=3DFalse, vcpus=3DNone):
> > +    def __init__(self, debug=3DFalse, vcpus=3DNone, config=3DNone):
> >          self._guest =3D None
> <snip>
> >                                     else logging.WARN))
> > -        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs)
> > +        vm =3D vmcls(debug=3Dargs.debug, vcpus=3Dargs.jobs, config=3Dc=
onfig)
>
> Given the number of times I've just had to fix merge failures with the
> patches I've just sent I wonder if we should just pass args as a while
> to vmcls and be done with it?

Great point !
I have also noticed the tendency for merge conflicts when changing the
vmcls params.
It makes good sense to pass the args through to vmcls.

Will add this change.

Thanks & Regards,
-Rob
>
> >          if args.build_image:
> >              if os.path.exists(args.image) and not args.force:
> >                  sys.stderr.writelines(["Image file exists: %s\n" % arg=
s.image,
>
>
> --
> Alex Benn=C3=A9e

