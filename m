Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C7FAC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE38B207FC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 14:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b6q17ZiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE38B207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBKN0-0006aw-Sk
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 10:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBKJb-00035w-A1
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:55:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBKJZ-0005qt-Ub
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:55:18 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:35254)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBKJZ-0005pZ-M5
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 10:55:17 -0400
Received: by mail-oi1-x22b.google.com with SMTP id x3so2000872oig.2
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 07:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Y9FKcspW8AA+Sguyz9oliXeiHN9biuqloItbBmO4zQc=;
 b=b6q17ZiL+cRd2zO/M+YLfrOZ6AesD2zpM191rdoBTfiK9hOy9oQ4WPBlfUTv+l7sBp
 DcQM4ik4a6PLjS251EM8Ewqk8zfj/ITTdJXXY84d/1eleIsdRYS8BHeMmA2WNVWNOYkm
 lNpPJ/5X/2ZkEblEpfBL92qBpvS57W0uW8nsmvTU94jUv6OVxrn1R8+wLR0hHgUP2+z3
 Ttf/oi3kJqSUOdPIFJzKZCu+WzAotoyQUAf76BBEvqngKTNjZQnLDmUJG2AD0RVJ/xyw
 xhsoFpu5fusK81wMDNpqZdyJFecqRgfoAJYMdZJVqCNtDSviCazMyvjxoVweGSDzxAH9
 k4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Y9FKcspW8AA+Sguyz9oliXeiHN9biuqloItbBmO4zQc=;
 b=iNKnPLwNIYPqvk7cHC3fzcNZ/UAdtM9bjfsj2iTluUIudxxqsw8HiIzs/QSoMdIWMH
 xWbbyscR57822jHLPqP+ifHbD8+aGFoTt60hV59ZrifvbcqscMRD9SSOdStXiJGnITrh
 mR5qkpEQRkntd7jMX4TEZAPn0iW2aHqGVKKjSFO6ZlEH26BsxiK2NyO78z1dEvuE1x8O
 XTaiKskKebzy+AMuTF0OSWro0FH5aAm2KPOfgHURiHXe1W0+zUkZICIUGkE4sXVwe6+U
 OMN256duqETh7ryWkZbK9sD9+GiC/WT4A1OVmoUxegE9uJn/6eJM39GHy6Me2bi8Ey4d
 F1YQ==
X-Gm-Message-State: APjAAAULTM/79Rj1uUv42QeXypBQuCYirE6OJ7ZsaVOeI/SWoKe9M8Q8
 TSJhBC5RO4jqmfpG3c/PEF7YRJzG8n/jSCu3niEkIA==
X-Google-Smtp-Source: APXvYqz21CZTpCbsqHV48a6wWBi/vki3tZwc1JdFp9rLJzwfKZWe6l/mKYfDwnlZYyADg6r8WTSKp8sD7xHsa8tjPoc=
X-Received: by 2002:aca:53d4:: with SMTP id h203mr3142040oib.146.1568991313146; 
 Fri, 20 Sep 2019 07:55:13 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7BDD949D4C752E2A291A6A02@qq.com>
 <CAFEAcA9QDrwUAdZWX7n_gO9afnT4n9+i8ZdqOcxrNbvi6n9=sw@mail.gmail.com>
 <tencent_5378456F7A2F471F74C049FC@qq.com>
In-Reply-To: <tencent_5378456F7A2F471F74C049FC@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 15:55:02 +0100
Message-ID: <CAFEAcA87Pb4Mk8McdaZHe41s=Cc1EeCknKfikRm6F+QoxKsdgg@mail.gmail.com>
Subject: Re: Initialize data memory in user space emulation
To: Libo Zhou <zhlb29@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 15:49, Libo Zhou <zhlb29@foxmail.com> wrote:
> I need to emulate a Digital Signal Processor. The DSP essentially has onl=
y basic MIPS ISA, and it manipulates the data stored in a "data memory". I =
can run an ELF with user space emulation, what I need to additionally do is=
 to initialize the "data memory" first, then run an ELF that manipulates th=
e data in the "data memory", and finally see if the resulting data are corr=
ect or not.

QEMU doesn't really support doing that kind of thing, because
actual Linux binaries don't execute in an environment like that.
You could probably hack QEMU to mmap a file into the guest's
memory before we start to run the userspace process, but there's
nothing that will do what you want out of the box.

thanks
-- PMM

