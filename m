Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBEFC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:00:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D858B217D9
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:00:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="salun11U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D858B217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDpr6-00024E-Jd
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bztemail@gmail.com>) id 1iDplH-0003cB-Di
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bztemail@gmail.com>) id 1iDplF-0001j0-Gq
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 08:54:14 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:41878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bztemail@gmail.com>)
 id 1iDplF-0001in-9S; Fri, 27 Sep 2019 08:54:13 -0400
Received: by mail-lf1-x144.google.com with SMTP id r2so1830990lfn.8;
 Fri, 27 Sep 2019 05:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aRoYLQbfJV2BBSaZ7N4Kpoe84Kc4cjRkXjDxOT3gE6U=;
 b=salun11U18x3RD0RMvy4s89lOBcfywhxa7PMMLX6xamFQM+cLQJgp2VvPDYVtKKcr6
 ToogjYPUZFCly+o2DeyKLUl3p+sAm2xwpgMzbXoBdFrzBJ0qojW9cChJ+xPPhi0oGJse
 tTWl1AnFy7YRUA4AFfZGf6CHN4VjMHtTgh+elVbDTp2qS4rRxhlGEfO/+rbVL00Yha2t
 ING6yRMhFg/0uaIS6n3P7sNXrzRd90ocagynk2oKB1akTvI3XDxsX8nDgChHvs8LUbAd
 +CqFAKl48TEWUxcPWfm/ZeA1XIANfwZJ6SsvabfQ1m+o6FteI423d66ZXiiryQDA+obq
 ejmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aRoYLQbfJV2BBSaZ7N4Kpoe84Kc4cjRkXjDxOT3gE6U=;
 b=bITmtKBzLUNN42T3DkqIPfot6x9T2sMO0LvSBFa6N05Owb0DA5z+Yd3eT7yT8deAMo
 ThSBc0Qbz78Z+1u08D8i5sn+9ZHxcK/PURngLH4zbNSCAdMwSME3PdqXkVwOU7VPBHnE
 h8ODDdmEWjWfpr5mXlOakQyVnicM8BAXbWUm/bCuC+jP5p/C0DheJ6Gke+TTEh0Up/Bs
 fAMoqOvE3aBjIhtRNQHgdTr8a8mn8Na/uE4/EVKWcslXTz/6mlVvb3oyVQlFmkQ5NtMY
 DPwtKvaOwsV0wBXE5kT37mApZMfuWsRv9WGMnhU/Xagd1E9dSJ3z7tKHts4GFRV4j4t6
 1giw==
X-Gm-Message-State: APjAAAXUUbOiPyFZLLWhxLrJa4HRVtBn4PlgasyPtkrjMjHx3s3tzCXz
 cc79Cpz3lte6vnDgYqD6105IrvwKSO61kaJ8I8U=
X-Google-Smtp-Source: APXvYqyN9M6XHtxQ07oIJQETrPFKpKtG+hYHL6DdmzAEMTGcZ2tNye1em7DThl9HLYe6ac/IEEKJZB0I10r9d98DSLU=
X-Received: by 2002:a19:c396:: with SMTP id t144mr2801843lff.14.1569588851726; 
 Fri, 27 Sep 2019 05:54:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:98c1:0:0:0:0:0 with HTTP; Fri, 27 Sep 2019 05:54:10
 -0700 (PDT)
In-Reply-To: <20190926173428.10713-15-f4bug@amsat.org>
References: <20190926173428.10713-1-f4bug@amsat.org>
 <20190926173428.10713-15-f4bug@amsat.org>
From: bzt <bztemail@gmail.com>
Date: Fri, 27 Sep 2019 14:54:10 +0200
Message-ID: <CADYoBw11iiK=+O-mGYS5Xp85zVhezOXXXr-wKV_xCg07ZYuzVw@mail.gmail.com>
Subject: Re: [PATCH 14/19] python/qemu/machine: Allow to use other serial
 consoles than default
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Laurent Bonnans <laurent.bonnans@here.com>,
 Esteban Bosse <estebanbosse@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Clement Deschamps <clement.deschamps@antfield.fr>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Pekka Enberg <penberg@iki.fi>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 9/26/19, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> Currently we are limited to use the first serial console available.

I'm not so sure. Right now it works like this:

qemu -serial stdio
Connects the VM's UART0 (PL011) serial console to the host terminal

qemu -serial null -serial stdio
Connects the VM's UART1 (AUX) serial console to the host terminal

I think this is simple and good, please don't remove this option. If
your commit does not influence these cli args, I'm not against it.

bzt

