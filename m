Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D4CC282CE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54E702175B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 23:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54E702175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48089 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCY71-0008Ap-H2
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 19:19:07 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY5d-0007Yy-MS
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:17:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1hCY5c-0004Di-NK
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:17:41 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1hCY5b-00045k-SE
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 19:17:40 -0400
Received: by mail-qt1-f196.google.com with SMTP id z16so9389438qtn.4
	for <qemu-devel@nongnu.org>; Fri, 05 Apr 2019 16:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:content-transfer-encoding
	:in-reply-to;
	bh=FHgP+2QnEZCGLVDZ4eJvyGAas4nuH4mKdia9DSK/NaU=;
	b=KSrcNqre56J7TmgSV2RC/lesrhqy3D32uu15ZutDVAXl3wLE+JmXxcFGvFgRh9DAZf
	750rYpZHj2MGM077pwnvM9klO4/nM41DHLKOd0FCTBLWF0b/hErmvqlc8pVlylBw7dam
	x1ZGSXcGqRkhL0zv96taQJfJgyYa8x9vARj/iGXuBa5ao0prtWi6PsJbmpWJeX1eHcwy
	vxcja3CQKSzlGronIpDRBBdW68BJONypafvPSv1E2GHvUilWY///6CFQQ1pwoqopDsz7
	QultjT8fRst4dHq/N9TE7H1EkzA9ZPcAT+OD7tvs6X/qitWOYbMdu4HCIZCOcl2Z2hIs
	TuaQ==
X-Gm-Message-State: APjAAAWA6WIICuA46LVYRthqdmY5kS3xD/pHMfBh64EXQJblXnf8xn+V
	5F4Dy4T0L7ZOQi1hXmMXG6/ZcA==
X-Google-Smtp-Source: APXvYqzIsmIOXvO1Z/wsttWmDfmUkff3znEj745o+20MZTsxM/CsvaqRZ9ATVBHBZ6bCVNIrv3dnGw==
X-Received: by 2002:ac8:234e:: with SMTP id b14mr13511076qtb.271.1554506257957;
	Fri, 05 Apr 2019 16:17:37 -0700 (PDT)
Received: from redhat.com (pool-173-76-246-42.bstnma.fios.verizon.net.
	[173.76.246.42]) by smtp.gmail.com with ESMTPSA id
	y10sm13404225qki.62.2019.04.05.16.17.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 05 Apr 2019 16:17:37 -0700 (PDT)
Date: Fri, 5 Apr 2019 19:17:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190405191703-mutt-send-email-mst@kernel.org>
References: <20190405115529.11590-1-philmd@redhat.com>
	<20190405140917.3af9b91d.olaf@aepfle.de>
	<6bdd3c91-1e65-db2d-8ff2-fa667a819a1f@redhat.com>
	<20190405150438.48c1cc84.olaf@aepfle.de>
	<3c212c03-80a3-a8bb-fbe0-0071ebfb6936@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3c212c03-80a3-a8bb-fbe0-0071ebfb6936@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.160.196
Subject: Re: [Qemu-devel] [PATCH for-4.0] roms: Allow the EFIROM variable to
 be overridden
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
Cc: ipxe-devel@lists.ipxe.org, Olaf Hering <olaf@aepfle.de>,
	qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405231735.A5AoqCmwiSmUn9ktAj1JXvkOJWtDn_Y7aGV2UDPg8zA@z>

On Fri, Apr 05, 2019 at 03:14:30PM +0200, Philippe Mathieu-Daudé wrote:
> On 4/5/19 3:04 PM, Olaf Hering wrote:
> > Am Fri, 5 Apr 2019 14:59:16 +0200
> > schrieb Philippe Mathieu-Daudé <philmd@redhat.com>:
> >> On 4/5/19 2:09 PM, Olaf Hering wrote:
> >>> Am Fri,  5 Apr 2019 13:55:29 +0200
> >>> schrieb Philippe Mathieu-Daudé <philmd@redhat.com>:
> >>>   
> >>>> +EFIROM ?= edk2/BaseTools/Source/C/bin/EfiRom  
> >>>
> >>> This name is too generic and will conflict with ipxe.git if any of "bios seavgabios pxerom" is used for 'make -C roms'.  
> >>
> >> This is similar to commit c9d18c1c150c84e where you said "it used to
> >> work", what is the difference?
> > 
> > Before there was no need to pass EFIROM= to make, so ipxe.git was happy.
> > Now it is required, and ipxe.git gets an unexpected value.
> > 
> >> IPXE override the EFIROM variable, so there is no change there.
> > 
> > For me ipxe tries to rm $(type -P EfiRom). Let me double check.
> 
> Eh you are right...
> 
> $ make -C roms EFIROM=/bin/true clean
> [...]
> make -C ipxe/src veryclean
> make[1]: Entering directory '/home/phil/source/qemu/roms/ipxe/src'
> rm -f bin{,-*}/*.* bin{,-*}/.certificate.* bin{,-*}/.certificates.*
> bin{,-*}/.private_key.* bin{,-*}/errors bin{,-*}/NIC ./util/zbin
> ./util/elf2efi32 ./util/elf2efi64 /bin/true ./util/efifatbin
> ./util/iccfix ./util/einfo TAGS bin{,-*}/symtab
> rm: cannot remove '/bin/true': Permission denied
> make[1]: *** [Makefile.housekeeping:1564: clean] Error 1
> 
> This seems to be a pre-existent IPXE bug:
> 
> $ git checkout c9d18c1c150c84e7a976df989ad04ddf01083f46
> $ make -C roms EFIROM=/bin/true clean
> [...]
> rm: cannot remove '/bin/true': Permission denied
> make[1]: *** [Makefile.housekeeping:1564: clean] Error 1
> 
> >> How can I trigger a SUSE package build with this patch?
> > 
> > Not so easy without a VM.
> 
> Oh, unfortunate :(
> 
> > 
> > Olaf
> > 
> 

Let's keep it simple: set a config variable, then
check it here.

-- 
MST

