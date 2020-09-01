Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C59DC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:19:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC4B214F1
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 15:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC4B214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD849-0000S8-TV
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 11:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47480)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kD839-00076J-Vm
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:20 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:59545)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kD836-000681-Ow
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 11:18:19 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.141])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id BAB76564BCFF;
 Tue,  1 Sep 2020 17:18:12 +0200 (CEST)
Received: from kaod.org (37.59.142.104) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 1 Sep 2020
 17:18:12 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00546fa60f4-8e55-43ad-81e8-3e7074f0d660,
 DF2AD85881EC9B15757C33AEE529973A5D0472CE) smtp.auth=groug@kaod.org
Date: Tue, 1 Sep 2020 17:18:11 +0200
From: Greg Kurz <groug@kaod.org>
To: Connor Kuehl <ckuehl@redhat.com>
Subject: Re: [PATCH 1/2] Makefile: Add back TAGS/ctags/cscope rules
Message-ID: <20200901171811.24debd1d@bahia.lan>
In-Reply-To: <f31b9650-9db4-e038-9e4d-bd5faf1f5b96@redhat.com>
References: <159896923655.442705.11922948674073863022.stgit@bahia.lan>
 <159897001005.442705.16516671603870288336.stgit@bahia.lan>
 <f31b9650-9db4-e038-9e4d-bd5faf1f5b96@redhat.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [37.59.142.104]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 8a8e3064-4186-405e-9b4d-ca12c443fb37
X-Ovh-Tracer-Id: 7364511290961598941
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgkeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehgeegvddvtefhtddtvdfhiedutedvgfejtddutefgveehieejieelveffgeekheenucffohhmrghinhepqhgvmhhurdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehpsghonhiiihhnihesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 08:45:33
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 1 Sep 2020 09:59:23 -0500
Connor Kuehl <ckuehl@redhat.com> wrote:

> On 9/1/20 9:20 AM, Greg Kurz wrote:
> > It is a bit of a pain to be forced to run configure before being able
> > to use cscope and friends. Add back the rules to build them in-tree
> > as before commit a56650518f5b.
> > 
> > Fixes: a56650518f5b ("configure: integrate Meson in the build system")
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> This might be a user error on my part, but the way I read this it sounds 
> like I could do this:
> 
> 	$ rm -rf build
> 	$ make cscope
> 
> and have it emit a cscope file,  but when I do so it complains about the 
> build dir not existing. As I understand it, running ./configure (or 
> meson build) is what generates that build dir. Here's the error for 
> posterity:
> 
> changing dir to build for make "cscope"...
> make[1]: *** build: No such file or directory.  Stop.
> make: *** [GNUmakefile:11: cscope] Error 2
> 

My use case is :

$ git clone git://git.qemu.org/qemu.git && cd qemu && make cscope
Cloning into 'qemu'...
remote: Counting objects: 510519, done.
remote: Compressing objects: 100% (91407/91407), done.
remote: Total 510519 (delta 420069), reused 507399 (delta 417643)
Receiving objects: 100% (510519/510519), 180.42 MiB | 29.30 MiB/s, done.
Resolving deltas: 100% (420069/420069), done.
make: Nothing to be done for 'cscope'.

> One comment inline
> 
> > ---
> >   Makefile |   17 ++++++++++++++++-
> >   1 file changed, 16 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 81794d5c34a2..8ffe2872915d 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -62,7 +62,7 @@ ninja-distclean::
> >   build.ninja: config-host.mak
> >   
> >   Makefile.ninja: build.ninja ninjatool
> > -	./ninjatool -t ninja2make --omit clean dist uninstall < $< > $@
> > +	./ninjatool -t ninja2make --omit clean dist uninstall cscope TAGS ctags < $< > $@
> >   -include Makefile.ninja
> >   
> >   ${ninja-targets-c_COMPILER} ${ninja-targets-cpp_COMPILER}: .var.command += -MP
> > @@ -229,6 +229,21 @@ distclean: clean ninja-distclean
> >   	rm -f linux-headers/asm
> >   	rm -Rf .sdk
> >   
> > +.PHONY: ctags
> > +ctags:
> > +	rm -f tags
> > +	find "$(SRC_PATH)" -name '*.[hc]' -exec ctags --append {} +
> > +
> > +.PHONY: TAGS
> > +TAGS:
> > +	rm -f TAGS
> > +	find "$(SRC_PATH)" -name '*.[hc]' -exec etags --append {} +
> > +
> > +cscope:
> 
> Since this recipe doesn't output an artifact called "cscope" I wonder if 
> this should be:
> 
> .PHONY: cscope

We already have it somewhere else in the makefile:

.PHONY: all clean cscope distclean install \

Since this patch is a partial revert of a56650518f5b, I didn't consider
moving it here.


Cheers,

--
Greg

> cscope:
> 	...
> 
> or alternatively:
> 
> cscope.out:
> 	...
> 
> 
> > +	rm -f "$(SRC_PATH)"/cscope.*
> > +	find "$(SRC_PATH)/" -name "*.[chsS]" -print | sed -e 's,^\./,,' > "$(SRC_PATH)/cscope.files"
> > +	cscope -b -i"$(SRC_PATH)/cscope.files"
> > +
> >   ifdef INSTALL_BLOBS
> >   BLOBS=bios.bin bios-256k.bin bios-microvm.bin sgabios.bin vgabios.bin vgabios-cirrus.bin \
> >   vgabios-stdvga.bin vgabios-vmware.bin vgabios-qxl.bin vgabios-virtio.bin \
> > 
> > 
> > 
> 
> Connor
> 

