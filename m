Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D7B2C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:40:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE42620679
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:40:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGEZ6Hr0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE42620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnfPf-00066B-3B
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:40:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnfLM-0007b9-R0
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:35:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jnfLK-0002z0-PI
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:35:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id 22so1469683wmg.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=i0cdc4gxmc7qXsxd2sWD8X36uiHVHiQMeSYFiEJpQ3c=;
 b=iGEZ6Hr0H5VL3s14jERgHqyEuqzzrbT3lUZd9hpHP3UVScLZsRnMWvxgckw7yU4SPH
 f77IgJ+nffjzJ2v5aUtHDYgPODkhtQ+8G7RSzHHD1PALRrmTH0w2QXw7mgomDI0zkqGh
 ManwoxRb2AF67nKqrziDrQLv8AoTAXvIhO1AAT0GrC/ndq0yU27/srUFjFb7EiiRhY8G
 qYeyEAmePoy9qHiOHxOcBcKp7VkMosVpiJgl7KRGKc806JcCXVkWyqogteqcrQ0H/RiH
 /xpYpkRlJ0g7N/O04iLD2PW/y8edYlbkbHhPsoK9N+yR7BTIW4viQT2QZ6kmvyoXDmYR
 hnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=i0cdc4gxmc7qXsxd2sWD8X36uiHVHiQMeSYFiEJpQ3c=;
 b=k7fXZVAp4PAUaGFRbs8ambBHVEPdpID9faxUKkxP3biuUwTy/3/C27zqB7CdxM46vC
 /8Rh5RhYH3eg2EGcxQBD0pTBYD2w5Ru7o8Y20eBjN4C30a/H3wbSyEvJNEk1DUl2425R
 TlUHTJFTQqJwjvp8VrDZWqDsyUtkXChJKwByW4JBWRKcEUrnNJCiC5k6By2Z6D+jBEik
 Rh2AYnBG7agnM4M4ozoIHpPtlPVDnfr02NANTUOU1yjScNhTMjaM6wYzq6Z8CnWF2Lhw
 sBtTg20mokrBiTYxnxB8gdkC/qq7FOWTn27NzCoiaGjzzWJensgYsnYKY7xvSpkAGoGc
 eKrw==
X-Gm-Message-State: AOAM531rmC4l0+uKymhJ5ZrTxToPWbLy2INzAwtRNs4VhYGLQ3CD7aJ/
 l6J1mNED8c5L1lnM5LgAJm3nnb1OzI0=
X-Google-Smtp-Source: ABdhPJz+97PyIraxxMlC61mLiaE9WfxQoT5q30r+9TKe5yzZQNicmoXdXqzR3P5q/lEz1dWc5u/jAA==
X-Received: by 2002:a7b:c348:: with SMTP id l8mr24840923wmj.54.1592904948369; 
 Tue, 23 Jun 2020 02:35:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j41sm22702518wre.12.2020.06.23.02.35.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 02:35:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A22611FF7E;
 Tue, 23 Jun 2020 10:35:43 +0100 (BST)
References: <20200622153318.751107-1-berrange@redhat.com>
 <20200622153318.751107-3-berrange@redhat.com> <87a70v9ctc.fsf@linaro.org>
 <20200623084759.GB751477@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH RFC 2/3] gitlab: build all container images during CI
In-reply-to: <20200623084759.GB751477@redhat.com>
Date: Tue, 23 Jun 2020 10:35:43 +0100
Message-ID: <87sgem86q8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jun 22, 2020 at 07:26:39PM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > We have a number of container images in tests/docker/dockerfiles
>> > that are intended to provide well defined environments for doing
>> > test builds. We want our CI system to use these containers too.
>> >
>> > This introduces builds of all of them as the first stage in the
>> > CI, so that the built containers are available for later build
>> > jobs. The containers are setup to use the GitLab container
>> > registry as the cache, so we only pay the penalty of the full
>> > build when the dockerfiles change. The main qemu-project/qemu
>> > repo is used as a second cache, so that users forking QEMU will
>> > see a fast turnaround time on their CI jobs.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  .gitlab-ci.d/containers.yml | 248 ++++++++++++++++++++++++++++++++++++
>> >  .gitlab-ci.yml              |   3 +
>> >  2 files changed, 251 insertions(+)
>> >  create mode 100644 .gitlab-ci.d/containers.yml
>> >
>> > diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
>> > new file mode 100644
>> > index 0000000000..ea1edbb196
>> > --- /dev/null
>> > +++ b/.gitlab-ci.d/containers.yml
>> > @@ -0,0 +1,248 @@
>> > +
>> > +
>> > +.container_job_template: &container_job_definition
>> > +  image: docker:stable
>> > +  stage: containers
>> > +  services:
>> > +    - docker:dind
>> > +  before_script:
>> > +    - export TAG=3D"$CI_REGISTRY_IMAGE/ci-$NAME:latest"
>> > +    - export
>> > COMMON_TAG=3D"$CI_REGISTRY/qemu-project/qemu/ci-$NAME:latest"
>>=20
>> It would be nice if we could keep the same form as they have in the
>> local registry which would make it easier to integrate with the rest of
>> the tooling, e.g. "$CI_REGISTRY/qemu-project/qemu:$NAME"
>
> Every time I re-discover it, I find the QEMU container naming really
> surprising. It is not following the normal best practice for naming
> containers. Expected container naming convention is that the image
> name reflects the general content set, and the tag reflects a version
> number. QEMU has shifted it along, so container name is just a fixed
> string, and the tag reflects the contenet set, and there is no version.
>
> QEMU's naming will cause problems with caching in GitLab. As GitLab
> expects the normal container naming scheme, it has a job which expires
> old versions of an image once there are more than 10 tags. So we have
> to use the normal naming scheme. Ideally we would change rest of QEMU
> to use the normal scheme too.

Fair enough.. I'll look into it.

>
> Regards,
> Daniel


--=20
Alex Benn=C3=A9e

