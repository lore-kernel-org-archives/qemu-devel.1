Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7104BC04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:06:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4256521479
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 23:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4256521479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43282 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSrMB-0005cS-F7
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 19:06:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43823)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrKn-0004xS-LP
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hSrKf-00057w-88
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:04:40 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hSrKb-00055r-Hg
	for qemu-devel@nongnu.org; Mon, 20 May 2019 19:04:35 -0400
Received: by mail-qk1-f195.google.com with SMTP id q197so9905772qke.7
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:04:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=/FpleUe2HMMNa9Jbdwt1FroyJe/Y2dPsv4pkqvdEldk=;
	b=Y2i/bXBjPmROaRHj3I/fHVe2SSxaYq193TQIWCRhSl2irU0Hz+cpqBrqZV094/BFfv
	F4ELzhtSNEqEZMaG6LAJZlj8c0WAKfYVREyb0xYs4n/27ylP5GBYt9CnlhTpPuaG0QW2
	2qpKDWv9aIxOYRMOU37enj+WoMBl09CvsvhS6YhHGjGIEQjz4QbC9oz+ZsFAHWyIWZ0n
	wh3ynXfDTsBroXgGtOY6zhCr4sMOdz6cI4XSXHkn6qJIBxS2A1ccAnFV6O8aWnvKy+E1
	QeonCjbX4aS6yW5kidRCARIGJkrJ8Kbc7KZsGccAVjc59m9vONmrnv676zPiwU8NoyHm
	6h0Q==
X-Gm-Message-State: APjAAAXK4WLEXZwcsF8unVzbMH4+AgwgQJ39C6iB1oloE8JQYrUKt0oF
	Kcaurp5XwK1qX/AVgpgeq0QPNg==
X-Google-Smtp-Source: APXvYqx4XGYn8Ckfj12PGpW5nClx2OoZOfWQm4kNVwZHm5PMdavXJdRpfK1uHSoO1oZRL2mtoDstbg==
X-Received: by 2002:a05:620a:1116:: with SMTP id
	o22mr59569418qkk.23.1558393472000; 
	Mon, 20 May 2019 16:04:32 -0700 (PDT)
Received: from redhat.com (pool-173-76-105-71.bstnma.fios.verizon.net.
	[173.76.105.71]) by smtp.gmail.com with ESMTPSA id
	r16sm6502126qkk.36.2019.05.20.16.04.30
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Mon, 20 May 2019 16:04:30 -0700 (PDT)
Date: Mon, 20 May 2019 19:04:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190520185944-mutt-send-email-mst@kernel.org>
References: <20190419003053.8260-1-richardw.yang@linux.intel.com>
	<20190419003053.8260-7-richardw.yang@linux.intel.com>
	<20190514211015-mutt-send-email-mst@kernel.org>
	<d9d265e1-1052-9d8d-c749-5d1e5901f567@redhat.com>
	<20190516074110.GA11938@richard>
	<CAP+75-XHpLkekrmSxK8FFGkpPJQH=V0+2d6RonQTyJNcSHGaEg@mail.gmail.com>
	<20190516190033.6c8d382f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190516190033.6c8d382f@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [PATCH v4 6/6] acpi: pci: use build_append_foo()
 API to construct MCFG
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
Cc: Yang Zhong <yang.zhong@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 07:00:33PM +0200, Igor Mammedov wrote:
> On Thu, 16 May 2019 13:01:31 +0200
> Philippe Mathieu-Daudé <philmd@redhat.com> wrote:
> 
> > On Thu, May 16, 2019 at 9:41 AM Wei Yang <richardw.yang@linux.intel.com> wrote:
> > >
> > > On Wed, May 15, 2019 at 07:29:17AM +0200, Philippe Mathieu-Daudé wrote:  
> > > >
> > > >Thanks Michael for testing...
> > > >
> > > >Wei, can you add a MCFG test in tests/bios-tables-test.c?
> > > >  
> > >
> > > I took a look into the test, current q35 has already has a reference MCFG in
> > > tests/data/acpi/q35/MCFG.
> > >
> > > And there would be a warning message when reserved[8] is missed.
> > >
> > >     /x86_64/acpi/q35/bridge: acpi-test: Warning! MCFG mismatch.
> > >
> > > Is this enough? Or what more information prefer to add?  
> > 
> > Well, the test has to fail for any mismatch (not a simple warning).
> > 
> > A mismatch failure seems to be enough IMHO.
> Warning is sufficient, we do not fail ACPI tests on mismatch.
> It was a policy decision for APCI tests as far as I remember.
> We might reconsider it in the future but it shouldn't affect this patch.

Yes. And the reason is that conflicts in binary expected files are
impossible to resolve. So it's important that we can
fix expected files after a patch that changes them.

I actually have an idea for a better way to fix this:
a special list of "warn on mismatch" files.

A patch changing tables will add the changed tables to the list.
Then maintainer knows to inspec the diff manually
and re-generate expected files, and remove the
changed tables from the list.



Another thing we should do is drop dependency on IASL:

if IASL is present we should use it to show diff to simplify debugging
but at this point a verbatim difference is good enough if IASL is not
installed.


And I agree 100%: all this is a subject for a separate patch(set).



> 
> > 
> > > >>> -    AcpiMcfgAllocation allocation[0];
> > > >>> -} QEMU_PACKED;
> > > >>> -typedef struct AcpiTableMcfg AcpiTableMcfg;
> > > >>> -
> > > >>>  /*
> > > >>>   * TCPA Description Table
> > > >>>   *
> > > >>> --
> > > >>> 2.19.1  
> > >
> > > --
> > > Wei Yang
> > > Help you, Help me  
> > 

