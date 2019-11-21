Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E2CC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 20:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2879F20672
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 20:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vAAOlVtq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2879F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXtWJ-0008A8-88
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 15:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXtUo-0007bC-Jc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 15:56:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iXtUn-0002M8-HE
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 15:56:10 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45298)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iXtUn-0002LJ-D3
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 15:56:09 -0500
Received: by mail-oi1-x244.google.com with SMTP id 14so4468043oir.12
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 12:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1SXQOsiiHzIpBIGdV1fr+9xBjVoGA0TfzomZM1f3gY4=;
 b=vAAOlVtqR9D9rsFKAl3JE0c1ymMKJ3hpdut7gNU07lp75EsFEhr1bCWlQ5kAvxhIao
 ZMfbHCvEjLXtiEd4qYE7dBefkeCu/8dGcP30r+4MFbHRJbPJHjYyTjRCYKJwZHKS8S4R
 12lLvkJGKHZXyBnVcrC8dvDi6RkYkSO5wmS1fXjLG7dRU9Jq3thuUsYTBlzZXlGb0sJF
 RlU6dMj/GGJZfdWoUdtbcn3CqbO5HmCQjp+pQAJnV4E0/y8w8ahHUcPCalwIigp4MmhB
 hCm+xg8YvXmmdSegTQGqjQs/J0BwhSQqfaiUD300/iJvIbeBtD51/hgH6RzyIrmVeKST
 OcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1SXQOsiiHzIpBIGdV1fr+9xBjVoGA0TfzomZM1f3gY4=;
 b=BLKYQVIXsVzAMLaicNzMctmj0abmNJhVOBW4+BxQKqtcSmdcFvq0txHjO+NUrF0Jue
 Ik3aHgrRS2VepTLc/ENCbzY8xiSmzf//ztSlptVm8fD6rCp4oPOb9tD/NHmt9dD4iUET
 CrssSQp95O9sDBtAarG76YFDzdU9RpHxkkgkriXJjBHKH3lnXB2R3Q3RU3bmJQIZk4nk
 QuhDtnMYvmjXKOvWmFKJKQ/8gExCttwVdmOkWGgQmfHBn0XOZazr3kRKpWubocobyaDA
 HKVV1PcSQTr6hnmnbNTVQKmpCabNc0v4qgADhV+dVv1KqQGvgU5ynhS9KTrOKU971acJ
 75+w==
X-Gm-Message-State: APjAAAWDxMd3JH+uISJnQ/CU+SlU/u7FvCnqx9aIh0Q8VgMwZ4HQsVnx
 xayFOhX/zZDXes5ktWj01OeDkJvNDbnI3neuyRM=
X-Google-Smtp-Source: APXvYqxhQxYznZPH6BbLg2hqe7D4ERaCkhvxhWCS8eP0QJrncr1+8WVsKCd1E+LCcPCe2ZOEpjw555gygTD3C8vFhMY=
X-Received: by 2002:aca:d17:: with SMTP id 23mr9528348oin.136.1574369767889;
 Thu, 21 Nov 2019 12:56:07 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-2-mrolnik@gmail.com>
 <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
In-Reply-To: <750745b9-e51c-3757-3eb6-ffce51042d9c@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Thu, 21 Nov 2019 21:55:56 +0100
Message-ID: <CAL1e-=gHukqViBf8hXMnCJDPB36yzanrWPF6cz26W3ebwXGkLA@mail.gmail.com>
Subject: Re: [PATCH v35 01/13] target/avr: Add outward facing interfaces and
 core CPU logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Thomas Huth <thuth@redhat.com>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Rolnik <mrolnik@gmail.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Why not implement the dump_ASM code? This is very useful...
>

... and time-consuming to implement, unless Michael have some
ready off-shelf code.

It is great that you have lots of ideas, Philippe, however I think
that it is counterproductive to suggest Michael to work on this
at this moment. Disassembler is just a debugging tool,
non-essential to core functionality, and Michael should remain
focused on completing core bits and pieces of AVR emulation.

My 2 cents,
Aleksandar

> Richard what is your position on this? I'd rather enforce this as a
> requirement for each ports.
>
> > +}
> > +
> [...]
>

