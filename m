Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FCAC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:32:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E95C8206F1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 10:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tx5BeMZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E95C8206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaG5j-0003g4-VR
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 05:32:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaG1h-0001Jg-N6
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:28:25 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531]:43397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaG1f-0002zE-US
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 05:28:25 -0500
Received: by mail-ed1-x531.google.com with SMTP id b9so11681174edu.10
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 02:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UQw0xIJ3j4vC9P62Fi73cBepSGsDHmSGkxBaz7gujs8=;
 b=tx5BeMZGu/qLwZMZvrHw9FogWWUz8QuPOBMiztC5BsLTjsvdCmSU1K3zqV7Sx0uPQI
 w2+f1/IDeDL0mbStWrc8Wym+qYX6ecb25gUzpjFeRz7sbBxdij3Xsf9oCuTvti2mg3If
 0c4iCY36vsnc6nKdOvJ9u43OPPFN5BwOMqFiwBDjNU4ts5PrLL54P01lqmAGPaD4leEu
 1e3ys+3mcCGHJEvOoAP3LJLkCDzlfEl7YMAzU1d474T6V7/iebaLGracVWBFgkRVSat1
 tWbXvmL/8qAR1XTBbmeMERqRGciz9Pl6glJdnZ3qjWjfC4UKZsV+r0dtUEjgBC7XBbPS
 2J3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UQw0xIJ3j4vC9P62Fi73cBepSGsDHmSGkxBaz7gujs8=;
 b=EsdCzgQB8SZl+dvZqsDZytkg6rWUZzVD8oYTFMmrnL9q25rae+OHR1rM7T7FVusQXz
 tSVU/y+Sr+0WA++h5bR7/ELN6NabSJAKTlBpmRiDru/r3qu60pgCmMBmidDT41t349lJ
 xYIGYwrdheRLaOvJMK2HOwmHbomC4RyJw36pUwID5w09tO5HdR2I5p2Lu9qIBpaq0Vlr
 s2YoBEjTws7LBCQZ9eErJoKW+fM1TMafqld7BL+wnDLAnXvFmCxio7RMEMUMem0nkZSP
 Xd/p/8a2PCxr/neMhqwwAnb2tJrI8+Pewfc14a4j+q0FJUvweILsSQ5b4BJhtRTqm8Vq
 YBNA==
X-Gm-Message-State: AOAM530natT0wSiGloY47IRPLLE2IDXGj8xwt8T8Y5ak/FGDbIiWQKuc
 wz9ubHuWiSyMsbm1qXFPo/LAbQEkWKC9ilC5Nbpqdw==
X-Google-Smtp-Source: ABdhPJyegAwcnXFmZP4h9vNut0MuxcVItueDD7V0zlyCRC6jVdRH4dIujrfX8zwtUs73iqXWHmn/T6hG6ELnoPBmYyk=
X-Received: by 2002:a50:fc87:: with SMTP id f7mr15022662edq.36.1604485701792; 
 Wed, 04 Nov 2020 02:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20201104044937.226370-1-mst@redhat.com>
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2020 10:28:09 +0000
Message-ID: <CAFEAcA8fUEq6jG5pbVwcaLFkkswsR86Ly5XOSUUYrnEu=sAeiA@mail.gmail.com>
Subject: Re: [PULL v2 00/38] pc,pci,vhost,virtio: fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Nov 2020 at 04:50, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Sending v2 since v1 was borken on 32 bit.
>
> The following changes since commit c7a7a877b716cf14848f1fd5c754d293e2f8d852:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201102' into staging (2020-11-03 10:38:05 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 5676edd6d984b0696d206faa230c8da15e271044:
>
>   vhost-user-blk-test: fix races by using fd passing (2020-11-03 16:39:06 -0500)
>
> ----------------------------------------------------------------
> pc,pci,vhost,virtio: fixes
>
> Lots of fixes all over the place.
> virtio-mem and virtio-iommu patches are kind of fixes but
> it seems better to just make them behave sanely than
> try to educate users about the limitations ...
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Fails 'make check' on ppc64be and s390x, ie the big-endian hosts:

**
ERROR:../../tests/qtest/libqos/virtio.c:228:qvirtio_wait_used_elem:
assertion failed: (g_get_monotonic_time() - start_time <= timeout_us)
ERROR qtest-i386/qos-test - Bail out!
ERROR:../../tests/qtest/libqos/virtio.c:228:qvirtio_wait_used_elem:
assertion failed: (g_get_monotonic_time() - start_time <= timeout_us)

thanks
-- PMM

