Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4B0C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:59:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B94CB206A3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 09:59:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rS3ukRf8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B94CB206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOfq5-0005FH-2t
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 05:59:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hOfou-0004b8-7D
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:58:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hOfot-0003Hu-5p
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:58:32 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:40109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hOfot-0003HM-0n
	for qemu-devel@nongnu.org; Thu, 09 May 2019 05:58:31 -0400
Received: by mail-oi1-x244.google.com with SMTP id r136so1431553oie.7
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 02:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=fH11O2shBeeMxstjuxfOuADvGDxwLD8j5LEKVIlVHtc=;
	b=rS3ukRf8FQpkaLOVoMk38Ovljx125aMvlvdDVIbKclD2pnLHq/1YDmv4pN1OL8Z4WL
	cO2DXlF5dU6ZYdbLw8wBlby9uWstcc4vLL4eyUgF7TnVMJwHr2WopuV1g+b5SmctdzwB
	a3oxi/1fw5FYHZkkR7ePfBBA8AWf9RYFpueLpwdrrzSVX0zu1bbOs0h0aiZaOETti3g1
	LXhNJzfdkyMjv70VyZHDCxcqcHsCUAlWfJB72IeK8WoYsvxOnMvnQnH9ivi/DZVgpSvu
	ApQksroL6AnIJnb4CrRbUbq2iQ+jwwsu6X5jrsDO1XYgdK+v7k8GgbeTsrLWx11BKS2M
	0sIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=fH11O2shBeeMxstjuxfOuADvGDxwLD8j5LEKVIlVHtc=;
	b=DYoEYCUS0haDBUTu2aKCmJHaQwigcH36w3HH6iBzYtU7jOsruqujq4O0Vn2co90yr9
	U8uW/PyyI4nIA+nK/npsWuUUUxUhdht08lOgV5o7Y22Ho5C+BBvUu1vHycTgrN4q82lt
	4/IsukbLAUkeSEtLxNcIHkHvR7y7H9jrPoIAeBo1AuWlpr2vaNXLFWB54k1MappZvxeP
	ebjQ0MGjqYtmgNa731PoLuCAXxwvjDj99welVl2PwEVhhc/QVbHVdBfi9xuG5yB/oeog
	UtROtCBO+QgnrLJC9VrLdg6ZHNgGC9DR8ydbUsgRD2V56L3sus1xhNyvIFcudpGKigLN
	XJMQ==
X-Gm-Message-State: APjAAAWCe49juM/zfwtXoqx9kR+JjbY715Y0WSBregSm7WnCvhg1I9EA
	xeyC4ZrEx1VIAs2qkWrNlkUus12MMROn+y1DHpqiyEN/Wbs=
X-Google-Smtp-Source: APXvYqwKzVK6ZZ8BrY0AZwD7WtzsPdPQViIptYjRDzcY+5C//00lGiYuLsmwig4Sz1KW2ICldV6TbbFaSRmw1Otc01U=
X-Received: by 2002:aca:fd45:: with SMTP id b66mr952643oii.157.1557395909879; 
	Thu, 09 May 2019 02:58:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190424140643.62457-1-liq3ea@163.com>
In-Reply-To: <20190424140643.62457-1-liq3ea@163.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 9 May 2019 17:57:53 +0800
Message-ID: <CAKXe6S+J7OgqJkrDByo3y9M5BGTaCN0Cjb0_WYxDyTvFGg-w8w@mail.gmail.com>
To: Li Qiang <liq3ea@163.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 0/5] fw_cfg_test refactor and add two
 test cases
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Qemu Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping.... this serials.

Thanks,
Li Qiang

Li Qiang <liq3ea@163.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8824=E6=97=A5=E5=91=
=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:07=E5=86=99=E9=81=93=EF=BC=9A

> In the disscuss of adding reboot timeout test case:
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03304.html
>
> Philippe suggested we should uses the only related option for one
> specific test. However currently we uses one QTestState for all the
> test cases. In order to achieve Philippe's idea, I split the test case
> for its own QTestState. As this patchset has changed a lot, I don't bump
> the version.
>
> Change since v1:
> Add a patch to store the reboot_timeout as little endian
> Fix the endian issue per Thomas's review
>
> Li Qiang (5):
>   tests: refactor fw_cfg_test
>   tests: fw_cfg: add a function to get the fw_cfg file
>   fw_cfg: reboot: store reboot-timeout as little endian
>   tests: fw_cfg: add reboot_timeout test case
>   tests: fw_cfg: add splash time test case
>
>  hw/nvram/fw_cfg.c     |   4 +-
>  tests/fw_cfg-test.c   | 125 +++++++++++++++++++++++++++++++++++++++---
>  tests/libqos/fw_cfg.c |  55 +++++++++++++++++++
>  tests/libqos/fw_cfg.h |   9 +++
>  4 files changed, 184 insertions(+), 9 deletions(-)
>
> --
> 2.17.1
>
>
>
