Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DE0C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:54:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CBA020659
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 12:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CEn1O+5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CBA020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKLpt-0007hA-Fz
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 08:54:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jKLp8-0006o6-98
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:53:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jKLp6-0006HS-PS
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:53:25 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41427)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jKLp6-0006Gz-JB
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 08:53:24 -0400
Received: by mail-ot1-x341.google.com with SMTP id f52so7080633otf.8
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 05:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nrlvADXxGbT+s6lAZobU7zynwUwqGGeUpsEGsLb7j8I=;
 b=CEn1O+5eaZ8zjImeCZm8YuxwZnuiygnUjAIhsf2opiY6o+o/93GaxYw/mP09dAgtZI
 THQYxp64FJO6SF1Ct3jz12M6Bz7staXYDOzhHrcI8V70YvHiwkBO38/4hJmkE6Nc3cku
 a8zxGtrDj/U8cm1Yz51vqScKrfFjFulRL7a35IVb3UYPar8P5bFKWtSkufcxWpMHOc9g
 GxPru1tsxQNG/7yOxtAm9uj+iq+enk8T0I0CQyM+ASgBFDL8C+Cyzwnq1lVJlL+Iy8FE
 cxr173jrQPp459/ej2HxX9NYI0wjEfR8OkMAwrspNU9EAHsu0eH3xgFfshH2QxWvnAKr
 qZDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nrlvADXxGbT+s6lAZobU7zynwUwqGGeUpsEGsLb7j8I=;
 b=D1stdFWb5Sp4kLfIxiDiGBtfGSiVTdyNF80HthZdOnsYC71TepGT+O6LeMtaahHNdS
 Iiig56SIUxCS1kPUSygiokcDY38GTZiXfqtj7isjffPV3Q3+Djk/CJWDeQ+rZkv1WHK+
 ubB5DDR8YjzvT3jGFvo0zT4Doj+6NwzsxOkPn1HjZPOzqdiuBKEf3m+lsorOX/8aC79s
 P+oxuhDcA8hYgCWwhAWJfQ9M+tgCL3IB9E4DdIU5lXYFm2hCnAHvsw7hJp5sTHQDybgu
 iPvsGlgh7KE7cdHvFldXL/SKLPY5Cett6KWUgfcLNqlGgAyVNoSh2fKKQVuoe1DdbiFD
 qouQ==
X-Gm-Message-State: AGi0Puaxf05Ib5LndXNMQa5YNyMSpADkECc90vijLBiOMlJhuDIGYTNi
 BqJSUFL5ugC/xhpN2HTbOHXHMVKVUt+cPyTGjXVq9A==
X-Google-Smtp-Source: APiQypLbjH41uZGse9rWQFFa8/m8YD4Q84Sn2aKbNTXszPyT9itlCOYT4RQ8zU1KlhSY310yCgWIjh9wZ8ZWxCyeEZY=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr5886060ota.221.1585918403126; 
 Fri, 03 Apr 2020 05:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200403165657.20566-1-yan.y.zhao@intel.com>
In-Reply-To: <20200403165657.20566-1-yan.y.zhao@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Apr 2020 13:53:12 +0100
Message-ID: <CAFEAcA8F9AUo+2VfbB-YaJxRfE+TPb76fppWfWm6c+XfQV560A@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] drop writes to read-only ram device & vfio regions
To: Yan Zhao <yan.y.zhao@intel.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, xin.zeng@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Apr 2020 at 09:13, Yan Zhao <yan.y.zhao@intel.com> wrote:
>
> patch 1 modifies handler of ram device memory regions to drop guest writes
> to read-only ram device memory regions
>
> patch 2 modifies handler of non-mmap'd read-only vfio regions to drop guest
> writes to those regions
>
> patch 3 let mmap'd read-only vfio regions be able to generate vmexit for
> guest write. so, without patch 1, host qemu would crash on guest write to
> this read-only region. with patch 1, host qemu would drop the writes.

Just FYI, there seems to be a minor clock or timezone issue with
however you're sending these emails: the Date header you
sent reads "Date: Fri, 3 Apr 2020 16:56:57 +0000" but that
time in the UTC +0000 timezone is (as I write this) still several
hours in the future. This isn't a big deal but you probably want
to look into fixing it.

(Noticed because the wrong-date makes your patches stick to
the top of the https://patchew.org/QEMU/ list even after other
patches arrive after them.)

thanks
-- PMM

