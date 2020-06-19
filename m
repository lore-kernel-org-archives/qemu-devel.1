Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF41C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4CC206B7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 19:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="adiTBYmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD4CC206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmMPS-0006pw-4d
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 15:10:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmMOn-0006KG-5S
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:10:01 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:43175)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jmMOl-0008UK-C2
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 15:10:00 -0400
Received: by mail-ot1-x32f.google.com with SMTP id u23so8097680otq.10
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 12:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JcbBnKCCztuehHJQ74WdPifS0ZnGtaTqUaDTbeyFR1A=;
 b=adiTBYmgziQgnzGBshKithr7ZykSvF/eFEHOTYUKAi/Qo1lapjc2qPy+m2076EArsg
 F2HflqKQJF1nRieb+/z15mM5DzXL9xFlz3EYI9KChLwkJOLWmVXePbHNlV1oZ505ZpOG
 zqyhdXSM+6tqBZSf32VvlWEP0AeNMeKS7a8v9o9DQ2r658t5e/OecOjrmvZZt38vjVoK
 Fvym3s8W3e50foLn4iatljI8goPNEx94jSI4j9zbMuAYYu6tWyWkBtOo5c6dOcAweGKg
 vsuu0Vo0bh0CCSdt3HQna9YZBlfCLjCVay/xl5NW9xAorFnwmiJdcbioL9uEiVofFxEP
 SghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JcbBnKCCztuehHJQ74WdPifS0ZnGtaTqUaDTbeyFR1A=;
 b=iG1WUnHA2DTzcSIHrH9kTF5jCGVYPegob3Equr/xwpoorK1JvC1KCu7Pgy7Tlc/M1m
 I6sw13VZDrEc3c23LIDDuJ7slwa3b2/83Vy4hHyFlDvrEwtakj6kUP4rsovNkb3jQDTD
 UZKXPQuYMnk42oSyks7XaPH8oZtUoeRCGm/eSBfUYbtlA4Sd+C05aZoLDxDIvomClL4O
 hDRnm6C9dnncXsbTuT9+0x32ePXRR/o7ew43dnKKe8wZ8aDTOQvqohBIDBIQmCK4LrNI
 i3H6OPUtgKUdJH1Cx9QEbFyozZXRyVCg1Q694P6X10TMZS6IOL3UuLvTW235sCPD+Lx8
 2U6Q==
X-Gm-Message-State: AOAM533ROK97t7xEyYSb1hRiM5ukCVEw8aTwdcqZ7DJfmgxKeKq6+h9h
 YFW/sqxlJe4k9FDVhF4921663iIPZvgsuwGgdDdfzg==
X-Google-Smtp-Source: ABdhPJzF29co78dPMwgecdjzEx9oo8BLUPsehtbnnOHfwU9TP2Mn9bbfFQaWkI2CRdTGdKV6YqS2xxQOlrjWU7Rk8I0=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr4244605oto.91.1592593797908; 
 Fri, 19 Jun 2020 12:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200616190942.24624-1-jsnow@redhat.com>
 <20200616190942.24624-2-jsnow@redhat.com>
 <CAFEAcA_ZW+3jUrWKhF564j+DaPcKGKTct31cBoU0ZEnx2V7_xA@mail.gmail.com>
 <5c3dbf4f-dea1-7c7f-3ccb-e8f2d784145d@redhat.com>
In-Reply-To: <5c3dbf4f-dea1-7c7f-3ccb-e8f2d784145d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 19 Jun 2020 20:09:46 +0100
Message-ID: <CAFEAcA_=B9ueii_WLFffkgDy0pLEhc8HGzAeoCfycMQnFBb0+g@mail.gmail.com>
Subject: Re: [PATCH 1/1] configure: prefer python's sphinx module
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x32f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Libvirt <libvir-list@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 at 18:57, John Snow <jsnow@redhat.com> wrote:
> On 6/18/20 5:56 AM, Peter Maydell wrote:
> > How do I use the system python but a venv sphinx-build? At the
>
> > python3 -m venv myvenv
> > cd myvenv/bin
> > ls -l python*
>
> lrwxrwxrwx. 1 jsnow jsnow  7 Jun 19 13:23 python -> python3*
> lrwxrwxrwx. 1 jsnow jsnow 16 Jun 19 13:23 python3 -> /usr/bin/python3*
>
> The venv uses symlinks, so it will continue to use your system version,
> but you can install sphinx here.
>
> I'm proposing you do either one of:
>
> A) ./configure --python=/home/petmay01/python-env/bin/python3
>
> B) source ~/python-env/bin/activate
>    ./configure

This seems strictly worse than what we have now (where I can
just tell configure to use the sphinx-build I want it to).
I don't want to do A because I'd rather just use the system
python, and I don't want to use B because it requires an
entire extra step (and also I think it will end up using the
python from the venv rather than the one from the system).

> > moment I can easily do that with
> >   --sphinx-build=/home/petmay01/python-env/bin/sphinx-build
> > because scripts inside a venv have #! lines that make them
> > work without having to manually activate the venv. I don't
> > want to have to use some random non-system Python just
> > because I have a newer Sphinx.
> >
>
> I was under the impression that it would be best if sphinx was executed
> using the user's specified python binary instead of allowing
> scripts/qapi to run under the user's python but sphinx to run under a
> different python.

I'm not sure that's right. We should run sphinx with whatever
python it wants to run as, not feed it something different
it doesn't expect.

> One of the reasons I came to this belief was to ensure that when
> operating inside of a venv that QEMU was always using that venv's python
> and sphinx instead of "leaking" out to the system's installation. It
> felt more explicit.

Well, if we're in a venv then by default it makes sense for us
to be using the venv's setup.

> A problem with looking for 'sphinx-build-3' and 'sphinx-build' entry
> scripts is that the /usr/bin/xxx namespace is shared between python2 and
> python3 packages and we may wind up selecting a sphinx for the wrong
> python version entirely -- and from what I could tell, there wasn't a
> way to interrogate sphinx to get it to tell us what python it was using,
> or any other way to force this kind of scripted entrypoint to use *my*
> python.

configure's checks should mean we reject a sphinx-build
that uses a too-old python, though.

> Fedora gets into trouble here because we want 'sphinx-build-3', but this
> ignores our venv version because the script entrypoint in a venv is
> 'sphinx-build' -- which might be the system's python2 version.

Mmm. That seems to me like it's basically Fedora having made a
mistake :-) Maybe we should say "try sphinx-build, if that
exists and works then great, otherwise try sphinx-build-3 next" ?

thanks
-- PMM

