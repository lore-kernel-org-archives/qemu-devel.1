Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56886C04E84
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 06:50:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32558214D8
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 06:50:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32558214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58214 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVVwA-0004uY-W8
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 02:50:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hVVvP-0004db-Kx
	for qemu-devel@nongnu.org; Tue, 28 May 2019 02:49:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1hVVvO-0000X4-IP
	for qemu-devel@nongnu.org; Tue, 28 May 2019 02:49:31 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hVVvO-0000Wa-DG
	for qemu-devel@nongnu.org; Tue, 28 May 2019 02:49:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id d17so1487494wmb.3
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 23:49:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=qnZUS7LoIw1wtUXSX4K16ySslDwu8VfwolSPr88xTFg=;
	b=NFOKBQ3pkIL7K9u6rgXZVf4oRdJHFFMqZJxniz5pdISP5SJLc7b/wH0wVHd+Akuw+d
	QLAqaA+DINSq2wDJlhVzCbPd6/6so+wTr9ic7dZMDTm6qsIODpU5wiMTPXsG8+sPIeoe
	v78XIqq4z+yDSdwsMFbyUeoFN7YKjzuuMpQsw1st7pFuUJFqZm3LwEibbaT3abKA1HAo
	3Nu+1pg5C9a3mB+99ZJW3NFK50wxtYC9+VfDtQ7FSEuXleIaZjy02SrSE5AVBq5Ai5zt
	6PPD0y+tQSd1HW3nKKP/FZeXsKnWYE5x+fl/S4O95VNkbBCWQ0hcKge41l/YQYioXPeg
	216g==
X-Gm-Message-State: APjAAAXX1uPtQbnng6agIHtHzNmljHxKR663FE9LckSk8HFn/yTt6ULI
	agWxIIkoJoZ0Gcj6Oa4dQtYC+PdpmmxCShi2DF6I7w==
X-Google-Smtp-Source: APXvYqzOBMzSWpBx3UbrKpeLa7h4/71rMox7snAb0zcsaM/Gdy3S2Kp1zPz50PpyCK0G+U/adTTH8XQIpXEp2K757XM=
X-Received: by 2002:a1c:407:: with SMTP id 7mr1248369wme.113.1559026169151;
	Mon, 27 May 2019 23:49:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190311005618.19007-1-philmd@redhat.com>
	<CAL1e-=hJVsaMDFyB5O-7JWtNEZ8JE7hbe8-n35yDxKD=znT=XA@mail.gmail.com>
	<6781ecbf-27b8-8925-11f9-6b746f14ef9d@redhat.com>
In-Reply-To: <6781ecbf-27b8-8925-11f9-6b746f14ef9d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 28 May 2019 08:49:18 +0200
Message-ID: <CAP+75-W5TEV1i+qAkQCg2pwgeGLN18vbaHpsin+cGFNJywTAcQ@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Kconfig dependencies for MIPS
 machines (but Malta)
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
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>,
	Thomas Huth <thuth@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
	James Hogan <jhogan@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>,
	=?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> On 5/27/19 8:31 PM, Aleksandar Markovic wrote:
> > What would be the status of this series? I am willing to integrate all
> > this, including all followups, but have hard time sorting out what
> > happend after this submission, what is the most complete version etc.
> > Can you enlighten me please?
>
> Thanks for your interest in this series :)
>
> I was chatting with Thomas about this series earlier today!
> I addressed your comment about the ITU/CPS devices, then wanted to join
> all the Malta patches in the same series, but there are too many for a
> single series so I'll keep them separate.

After some sleep I could remember why I postponed this series:

1/ making the ITU selectable gives:

  /usr/bin/ld: target/mips/op_helper.o: in function `helper_mtc0_saar':
  ./target/mips/op_helper.c:1614: undefined reference to `itc_reconfigure'
  /usr/bin/ld: target/mips/op_helper.o: in function `helper_mthc0_saar':
  ./target/mips/op_helper.c:1631: undefined reference to `itc_reconfigure'
  collect2: error: ld returned 1 exit status

Anyway it is now selectable but has to be always selected.

2/ I thought only the Malta board was deeply mixed with the X86 ACPI
code, but I later noticed the Fulong is too.

  /usr/bin/ld: ../hw/isa/vt82c686.o: in function `vt82c686b_pm_realize':
  ./hw/isa/vt82c686.c:381: undefined reference to `acpi_pm_tmr_init'
  /usr/bin/ld: ./hw/isa/vt82c686.c:382: undefined reference to
`acpi_pm1_evt_init'
  /usr/bin/ld: ../hw/isa/vt82c686.o: in function `pm_update_sci':
  ./hw/isa/vt82c686.c:195: undefined reference to `acpi_pm1_evt_get_sts'
  collect2: error: ld returned 1 exit status

Both VT82C686B/PIIX4 southbridges require considerable cleanup.
I think I now have something workable, but I have to sell my patches
correctly to the different subsystem maintainers ;)

Regards,

Phil.

