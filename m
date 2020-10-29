Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074FFC2D0A3
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 484AE2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YauNoZL5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 484AE2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY7tX-0002Uh-9h
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:23:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY7qt-0000i1-12
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:20:27 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d]:43845)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kY7qq-0005MV-9U
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:20:26 -0400
Received: by mail-ej1-x62d.google.com with SMTP id k3so3750204ejj.10
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 06:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yOnhe3fXcO38C5XIbFepJu+iZD09cLCuOTLzi5l6r+E=;
 b=YauNoZL55US+oJrzVR7J9G2fS1BkA0QRC5S7qXcbP+V4Ztzfj9XSigLColh0EhSwPG
 env+nqQKQz4+QPnzQG6wCGwQ70KjpVCl2ZHEe54oQR5qCXJyH5aIqsJefJhr+Euh6PNE
 d6m64L7G2e6oXQVqPFI4gkd72KwCK4fWxXSzyfgyidcylXi4/5iBjIzcTIM9JCiAE6Am
 ggCkZ6Dq3cnkT7zUc+Sqkev/M2XosDdjeo4VPPphpqSQwOEUUh/zkIINeDSabMkSDWXP
 3dBbh9zQo8ORTzevkq0cE6M/Dzori6HEQAwLyJI+dR91wZqWL0pw54HMuKnJxkNGbc2o
 eKSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yOnhe3fXcO38C5XIbFepJu+iZD09cLCuOTLzi5l6r+E=;
 b=EiK7znJUlfKlZL3C2VztI4IQaPEZZFI+NP/aYU+BEnwomkq9aiVs7u8ROq8FQXB9SB
 8p5hTTU5zg9jrSwItBe42QekhNKgj0FYBIPvY8nkRYDeHaM3uEi0Q+of9TkHhAxee9q9
 QiqlZAnDpuiMn2+bQ9XTNKEHvC1tcCvMoET9uVjwqNgXNlAk89ISk7GNBns5ky01y2m6
 c7BA8MIGZTKNspAM4J0gvAlSBDwERGjTX7F/6YqhHE4l6KAtwGApDdJORM0zgnWKaRtx
 CsmyKUlPirlk4mg/ICRTn6q4ljYVV6j6q9Pzi38hmdTtXulF+aodgjU/qkNKy/uMFZIk
 +veg==
X-Gm-Message-State: AOAM530hRZWuESSnw5gIJrHfqq0ObOc/j+Ukkn6sqxiCl+kMmcku0sV3
 jkam30LX8nqo59XeOX4XziTXSn2UmGrkwZK10bZ69w==
X-Google-Smtp-Source: ABdhPJz2xbWlUEBXParyw7WFlk6nLRlx2TntQ3djsdzMGmOouHpBWCIBaDKv+0nFumDYJYaVyWR3gBR7f4NiaTXwnDg=
X-Received: by 2002:a17:906:7254:: with SMTP id
 n20mr3824939ejk.382.1603977622687; 
 Thu, 29 Oct 2020 06:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1603452058.git.qemu_oss@crudebyte.com>
 <CAFEAcA_Pd2PQd097tSHABR=jFK-Rq6odkZXEC2V2DBHrh8pSXg@mail.gmail.com>
 <2016477.jJ6Bm08OSA@silver>
In-Reply-To: <2016477.jJ6Bm08OSA@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Oct 2020 13:20:11 +0000
Message-ID: <CAFEAcA_qsZ1ZT-hk5wJc1Mz97vzo3N+UisK7XBagG5S1GtjqoA@mail.gmail.com>
Subject: Re: [PULL 00/13] 9p queue 2020-10-23
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62d.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 at 12:48, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Montag, 26. Oktober 2020 11:33:42 CET Peter Maydell wrote:
> > I get a 'make check' failure on x86-64 Linux host:
> >
> > PASS 54 qtest-x86_64: qos-test
> > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > 9p-tests/local/config PASS 55 qtest-x86_64: qos-test
> > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > 9p-tests/local/create_dir PASS 56 qtest-x86_64: qos-test
> > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > 9p-tests/local/unlinkat_dir PASS 57 qtest-x86_64: qos-test
> > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > 9p-tests/local/create_file PASS 58 qtest-x86_64: qos-test
> > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > 9p-tests/local/unlinkat_file PASS 59 qtest-x86_64: qos-test
> > /x86_64/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-
> > 9p-tests/local/symlink_file Received response 7 (RLERROR) instead of 73
> > (RMKDIR)
> > Rlerror has errno 2 (No such file or directory)
> > **
> > ERROR:../../tests/qtest/virtio-9p-test.c:300:v9fs_req_recv: assertion
> > failed (hdr.id == id): (7 == 73)
> > ERROR qtest-x86_64: qos-test - Bail out!
> > ERROR:../../tests/qtest/virtio-9ptest.c:300:v9fs_req_recv: assertion
> > failed (hdr.id == id): (7 == 73)
> > Makefile.mtest:3953: recipe for target 'run-test-492' failed

I just got this again on an entirely different pullreq so that
suggests that this is indeed an intermittent currently in master:

PASS 49 qtest-i386/qos-test
/i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/synth/flush/ignored
PASS 50 qtest-i386/qos-test
/i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/synth/readdir/basic
PASS 51 qtest-i386/qos-test
/i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/synth/readdir/split_512
PASS 52 qtest-i386/qos-test
/i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/synth/readdir/split_256
PASS 53 qtest-i386/qos-test
/i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/synth/readdir/split_128
PASS 54 qtest-i386/qos-test
/i386/pc/i440FX-pcihost/pci-bus-pc/pci-bus/virtio-9p-pci/virtio-9p/virtio-9p-tests/local/config
Received response 7 (RLERROR) instead of 73 (RMKDIR)
Rlerror has errno 2 (No such file or directory)
**
ERROR:../../tests/qtest/virtio-9p-test.c:296:v9fs_req_recv: assertion
failed (hdr.id == id): (7 == 73)
ERROR qtest-i386/qos-test - Bail out!
ERROR:../../tests/qtest/virtio-9p-test.c:296:v9fs_req_recv: assertion
failed (hdr.id == id): (7 == 73)
Makefile.mtest:1857: recipe for target 'run-test-230' failed

> So the 9p server is already failing to create the test case directory
> "./qtest-9p-local/05/" relative to your current working directory.

This sounds suspicious, because there's nothing in that filename
that's specific to the test case being qtest-i386 and not
qtest-something-else. How does the test harness deal with the
possibility of the same virtio-9p-pci test being run in parallel
for multiple guest architectures under a make -jN setup ?

> What puzzles me is that the previous test cases succeeded there, which all
> create their own test directory in the same way:
>
>         ./qtest-9p-local/01/
>         ./qtest-9p-local/02/  (<-- dir vanishes after that test completed)
>         ./qtest-9p-local/03/
>         ./qtest-9p-local/04/
>         ...

After the build failed, the qtest-9p-local directory was empty.

thanks
-- PMM

