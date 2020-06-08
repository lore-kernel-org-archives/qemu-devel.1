Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277BDC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:52:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A3B206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 17:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A3B206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiLwP-0002xu-7Q
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 13:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jiLuj-0001yY-Bn
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:50:25 -0400
Received: from relay64.bu.edu ([128.197.228.104]:43717)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1jiLuh-0002N0-Pl
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 13:50:24 -0400
X-Envelope-From: alxndr@bu.edu
X-BU-AUTH: mozz.bu.edu [128.197.127.33]
Received: from BU-AUTH (localhost.localdomain [127.0.0.1]) (authenticated
 bits=0)
 by relay64.bu.edu (8.14.3/8.14.3) with ESMTP id 058HnFnS012368
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 8 Jun 2020 13:49:19 -0400
Date: Mon, 8 Jun 2020 13:49:15 -0400
From: Alexander Bulekov <alxndr@bu.edu>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH] fuzz: add oss-fuzz build.sh script
Message-ID: <20200608174915.awi6czm3cxqcc6df@mozz.bu.edu>
References: <20200605174036.4527-1-alxndr@bu.edu>
 <83f59cb5-2282-aeba-5116-a3e18be101a7@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <83f59cb5-2282-aeba-5116-a3e18be101a7@amsat.org>
User-Agent: NeoMutt/20180716
Received-SPF: pass client-ip=128.197.228.104; envelope-from=alxndr@bu.edu;
 helo=relay64.bu.edu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 13:50:22
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: darren.kenny@oracle.com, bsd@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 200605 1956, Philippe Mathieu-Daudé wrote:
> On 6/5/20 7:40 PM, Alexander Bulekov wrote:
-cut-
> "make install-datadir"?
I think this just sets up the datadir for subsequent copies:

install-datadir:
    $(INSTALL_DIR) "$(DESTDIR)$(qemu_datadir)"

The actual copy happens in install:

install: all $(if $(BUILD_DOCS),install-doc) \
	install-datadir install-localstatedir install-includedir 
...
ifneq ($(BLOBS),)
	set -e; for x in $(BLOBS); do \
		$(INSTALL_DATA) $(SRC_PATH)/pc-bios/$$x "$(DESTDIR)$(qemu_datadir)"; \
	done
...

> 
> > +
> > +# Copy over the qemu-fuzz-i386, naming it according to each available fuzz
> > +# target (See 05509c8e6d fuzz: select fuzz target using executable name)
> > +for target in $(./i386-softmmu/qemu-fuzz-i386 | awk '$1 ~ /\*/  {print $2}');
> > +do
> > +    cp ./i386-softmmu/qemu-fuzz-i386 $OUT/qemu-fuzz-i386-target-$target
> 
> There seems to be an extra 'target'.
> 
> > +done
> > 
> 
> Or "make install", not sure.

If I can get this to work, hopefully it will also take care of the
datadir.
Thanks
-Alex

