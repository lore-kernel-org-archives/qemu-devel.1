Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4084C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:47:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB315206DC
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 09:47:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fu4n/6jn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB315206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUoEY-0004Wy-BL
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 05:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUoC1-0003Nf-Bn
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:44:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23057)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kUoBz-0000hm-7k
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 05:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603187070;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UaPNMwI0WJHq1R5oa5wdT1YwKbqUKyyfRvBuStGv30s=;
 b=fu4n/6jn8X/MGrnUA/QNFaJStyyckoQkVDq2qWtdwrWdbj+zcdQrbO3zcmyJZKlXyxXYXo
 +HAG+Vtob+TnIK77L0T1AXe4McrBLu7KBWKTzo+c0/AAI3kpx9Ort4Bp2LqB3silxTA1Cf
 7SVQR2KoVjjqwYExWs9O45JsGC23tGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-rRe9JuuoOXa1dPkKz1Uvmw-1; Tue, 20 Oct 2020 05:44:25 -0400
X-MC-Unique: rRe9JuuoOXa1dPkKz1Uvmw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83513803F48;
 Tue, 20 Oct 2020 09:44:24 +0000 (UTC)
Received: from redhat.com (ovpn-114-206.ams2.redhat.com [10.36.114.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C279282EE;
 Tue, 20 Oct 2020 09:44:21 +0000 (UTC)
Date: Tue, 20 Oct 2020 10:44:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: roms/efirom, tests/uefi-test-tools: update edk2's own submodules
 first
Message-ID: <20201020094419.GF287149@redhat.com>
References: <20201020091605.GA2301@aepfle.de>
 <3fc07eb7-f99a-516b-9bb9-e48049547928@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3fc07eb7-f99a-516b-9bb9-e48049547928@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Olaf Hering <olaf@aepfle.de>, Laszlo Ersek <lersek@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 20, 2020 at 11:29:01AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Olaf,
> 
> On 10/20/20 11:16 AM, Olaf Hering wrote:
> > This is about qemu.git#ec87b5daca761039bbcf781eedbe4987f790836f
> > 
> > On Mon, Sep 07, Laszlo Ersek wrote:
> > 
> > > In edk2 commit 06033f5abad3 ("BaseTools: Make brotli a submodule",
> > > 2020-04-16), part of edk2-stable202005, the Brotli compressor /
> > > decompressor source code that edk2 had flattened into BaseTools was
> > > replaced with a git submodule.
> > > 
> > > This means we have to initialize edk2's own submodules before building
> > > BaseTools not just in "roms/Makefile.edk2", but in "roms/Makefile" (for
> > > the sake of the "efirom" target) and "tests/uefi-test-tools/Makefile" as
> > > well.
> > 
> > > +++ b/roms/Makefile
> > >   edk2-basetools:
> > > +	cd edk2/BaseTools && git submodule update --init --force
> > >   build-edk2-tools:
> > > +	cd $(edk2_dir)/BaseTools && git submodule update --init --force
> > 
> > 
> > This change can not possibly be correct.
> > 
> > With current qemu.git#master one is forced to have network access to
> > build the roms. This fails with exported (and complete) sources in an
> > offline environment.
> 
> The EDK2 roms are only used for testing, we certainly don't want them
> to be used by distributions. I suppose the question is "why is this
> rule called if tests are not built?".

I don't believe that is correct - the pc-bios/edk*  ROMs and the
corresponding  pc-bios/descriptor files are there for real world
end user consumption.   roms/edk2 should (must) match / reflect
the content used to build the pci-bios/edk* blobs.

Many distros have a policy requiring them to build everything
from source, so they will ignore the pre-built edk2 ROMs, but
regular end users taking QEMU directly from upstream can certainly
use our edk2 ROMs.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


