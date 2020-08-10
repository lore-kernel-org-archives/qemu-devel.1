Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CEA4C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:12:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E04C22BEA
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BgxNlUVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E04C22BEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DDc-0004d7-JV
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DD0-00041x-5T
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:11:46 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DCy-0000ov-Ez
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:11:45 -0400
Received: by mail-oi1-x243.google.com with SMTP id u63so9923956oie.5
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PQ7xmKParNSi03FRmsnjEnM9erMAM2LRksExuOsBcaU=;
 b=BgxNlUVdMbtgJG7itxN8kTP5ug9Qjauyhqp730ht2C2LKke5S8moMLwaM1MqEa93JV
 LMme5N1mo53fAtvtKyRGaCshpP+fzKtPnUFWQLmFUVzDV9qhej2wA0CQMk0jS5MVRZZR
 MM5uXsT5IngMeSXxKMlaZcNaCQPM3EHWeXLXSxxdnRfyVwDuSL89bvsyqhT/a98tqV2x
 GqUrP+HY0t/u/AxFj3jlu+TlbOrI3W4+NFGbSX++xodUtrCLpHlNOXvgBXoqqYMDDip1
 A4NjJHSGwNLcuoP0D5rPRCDj4ivX3+4JfZ4JRA1aooHVNc7XTIp/TZaNjk0yN4/V7geO
 7doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PQ7xmKParNSi03FRmsnjEnM9erMAM2LRksExuOsBcaU=;
 b=dkvGtE+/ZLZ1EmMp+qp4KcEpaltJp8QgTO6mtuCvrVg2PIK3zy2ESfv0Wz3iIZMzeV
 P3av1+WZQgXuLmtJbAULOYwXtN59/JOfA4KaOBVw7XgtA8vPkqVAhyw5SryfcqKdwA9r
 cfV7n8vbG7TDSB+vAyoJi7X2+J78ZyRtwqtZyjrG998hhDr+W1xCZEp2fh4tEG+hE5Vd
 O4xo+PbOMu3r1KzAa1Me15iRwxxUoNw6MqWNN5wXJEWhKbzX+dSOC+y2AjGFLbW0TVMw
 cxKjNBeqBmx8Bc4C3jYz6Q9jWdLhiRK3Frh78bTYcCR6SszOyvKQCIZS99vuksgpN1/p
 jvyA==
X-Gm-Message-State: AOAM532Jddac1BR7gAbYT628yfuE9UwAJcOzPcSiDlm2yiB1HGIEw8AZ
 FZNXMGn/vAFtrQEQW3hDGLc1PFylUVbSclAGgDVTtA==
X-Google-Smtp-Source: ABdhPJzpTtQCnXB44WhOzeuVo1TuGGxQoOkrNfFhA+PmTuhWXyGLocgGvtjK8u6LbUzdB9x4skVLaNDN0Z1FtdpttqU=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr567647oia.163.1597086702889; 
 Mon, 10 Aug 2020 12:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <1597079345-42801-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA_icj94N6eotg9W7FutXTY_6U-Ak6pJMyYH0n9eggunrg@mail.gmail.com>
 <CAFEAcA_cBDHNgNsDMJS+WqX+W-xbo18c1Eno2RqGnwa-iGw3-w@mail.gmail.com>
 <bd576941-5620-f6b8-46d2-f2c73d3813a9@redhat.com>
In-Reply-To: <bd576941-5620-f6b8-46d2-f2c73d3813a9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Aug 2020 20:11:31 +0100
Message-ID: <CAFEAcA9P2XV74AWUcx8CmiPJxxaRgMmiVo9Zd8uFCLD+iUKn+Q@mail.gmail.com>
Subject: Re: [PATCH 000/147] Meson integration for 5.2
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Aug 2020 at 19:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/08/20 20:20, Peter Maydell wrote:
> > (Looks like an error in the version of the system header
> > file on this system, which, unlike my x86 box, defines
> > the prototypes with "inline" (a change that came in upstream
> > in commit
> > https://github.com/sahlberg/libiscsi/commit/7692027d6c11c58948ec3c493abea808af00fdd0
> > ).
>
> What's the version of libiscsi?

libiscsi-devel-1.9.0-7.el7.ppc64

thanks
-- PMM

