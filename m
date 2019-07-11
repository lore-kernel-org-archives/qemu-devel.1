Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E449C74A5B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 16:12:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32F02084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 16:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="atQedqAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32F02084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlbfy-0000ay-AU
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 12:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37973)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groeck7@gmail.com>) id 1hlbfm-0008Pu-RK
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:11:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1hlbfl-0007GD-LJ
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:11:54 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46032)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>) id 1hlbfl-0007DU-Ex
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:11:53 -0400
Received: by mail-pf1-x444.google.com with SMTP id r1so2963829pfq.12
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 09:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=veWhRNOP9xuOxD8dmfDoM+09ZSbSbVcmbtMZrrxa3/k=;
 b=atQedqAP4X1/VhnJlTHodoG8rtrKakGy32YKolNExfiTfAuvy+2M6iRTT0Ta1Se6wD
 SGUN/nKOCpHOE0crF62sWg/sVti+cNJ7TwyVikZEgMCZ+8IHqLodnInlyosvweUBt5if
 dKEaPgVpzD3OM7fmOU38KtUqtzPQzZWL7opDmV3xVaOlhHJjZ79FykwWUAiuD9v7HSdz
 DyRpF+qWj5SA0l9ro9JPeF1DaSLkCcSS/GAxjDTOmhPqiV3/NG0JMn1iVDpWYv5iU9wx
 fRl+/XDtcNdODV/l+lVYDBeU11KNXlH3APABFbGgETN6BHoP/yac8K/pMb4FCfuT3Uzq
 2Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=veWhRNOP9xuOxD8dmfDoM+09ZSbSbVcmbtMZrrxa3/k=;
 b=mCL8HOjiqIgVVnTIRkuLsCIWCuDnXC3Kri+a0z5UCBhugUtbGp5D0Udrb+2qtXwubc
 bDr/tiCp5VuhS75QF7k+W2yG+TFfuUGLHgJz0cLvwHEBv50bw1nIbsUsXPKLCBCp2IdO
 fBq9P1Ia4V33sqgBylCHxSnihmo/lSFZLCw8XJsj0LCCidsP15rW6ubMNBUzNU9UT/nY
 IBbMbYFGtXEHTEK8wDJt3M+VO6xLI8ghN7YQ/ww30bktT921pY8pwpSCJyMC30CS7ujH
 F0svNkiJmtVrkEmlKA+60DsP/js28ysC+nX/mFlCLPzkycWNqYk3OCtY6nGhseaXv5F5
 u4Zg==
X-Gm-Message-State: APjAAAWosv1ZvMq99A3lMAKu7Fg1gNZITRKVw+q39E0oPiJykAHEEldQ
 8wc28hNpyYcZeYpp5HBTy5RyVMnq
X-Google-Smtp-Source: APXvYqzBXQfvIpnlOzhsLTtBYqhs4+8lv844plpyRjLGe7Uoh+tIU/y1aS0l7WnzKqcWmGQmlunzTQ==
X-Received: by 2002:a63:30c6:: with SMTP id w189mr5050038pgw.398.1562861511656; 
 Thu, 11 Jul 2019 09:11:51 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id r15sm6952585pfh.121.2019.07.11.09.11.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 09:11:50 -0700 (PDT)
Date: Thu, 11 Jul 2019 09:11:48 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190711161148.GA895@roeck-us.net>
References: <20190710220153.GA10826@roeck-us.net>
 <20190711010742.GA810@roeck-us.net>
 <dc31e591-3b22-8626-10b2-48597f56ee0a@redhat.com>
 <11bd13d0-e5c0-76fc-2f75-e01588a9103b@roeck-us.net>
 <874l3swpht.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874l3swpht.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] Problems building and installing qemu v4.1.0-rc1
 in single step
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 11, 2019 at 05:38:22PM +0200, Markus Armbruster wrote:
> Guenter Roeck <linux@roeck-us.net> writes:
> 
> > Hi,
> >
> > On 7/11/19 12:48 AM, Philippe Mathieu-Daudé wrote:
> >> Hi Guenter,
> >>
> >> Cc'ing Markus/Dan/Alex
> >>
> >> On 7/11/19 3:07 AM, Guenter Roeck wrote:
> >>> On Wed, Jul 10, 2019 at 03:01:53PM -0700, Guenter Roeck wrote:
> >>>> Hi,
> >>>>
> >>>> when trying to run "make -j30 install" from a clean tree on v4.1.0-rc0, I get
> >>>> _lots_ of undefined symbol errors.
> >>>>
> >>>> If I run "make -j30" followed by "make -j30 install", make succeeds, but then
> >>>> I get linker errors such as the following when running "make -j30 install".
> >>
> >> Seems similar to this report:
> >> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg01860.html
> >>
> > Yes, that looks like the same problem.
> >
> > Reverting the following commits fixes the problem for me.
> >
> > 8d358a5 Makefile: Fix "make clean" in "unconfigured" source directory
> > 	(possibly for context to be able to revert the next patch)
> > 1338a4b Makefile: Reuse all's recursion machinery for clean and install
> 
> Hmm.
> 
> Target install depends on all.
> 
> Before commit 1338a4b, the recursion into target directories was in
> install's recipe: it ran make install in a for-loop.  This trivially
> ensured we run the sub-make install only after completing target all.
> 
> Since commit 1338a4b, the target recursion is in the dependencies, just
> like for target all.  That's good, but I forgot to add dependencies to
> ensure make runs the sub-make install only after completing target all.
> 
> Can you try the appended patch for me?  I'm having difficulties
> reproducing the bug locally.
> 

That fixes the problem for me. I cross-checked several times: Without the
patch below, "make -j30 install" fails every time, with the patch applied
it passes every time.

Please feel free to add

Tested-by: Guenter Roeck <linux@roeck-us.net>

when you formally submit the patch.

Thanks,
Guenter

> [...]
> 
> diff --git a/Makefile b/Makefile
> index 1fcbaed62c..09b77e8a7b 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -522,6 +522,7 @@ $(ROM_DIRS_RULES):
>  recurse-all: $(addsuffix /all, $(TARGET_DIRS) $(ROM_DIRS))
>  recurse-clean: $(addsuffix /clean, $(TARGET_DIRS) $(ROM_DIRS))
>  recurse-install: $(addsuffix /install, $(TARGET_DIRS))
> +$(addsuffix /install, $(TARGET_DIRS)): all
>  
>  $(BUILD_DIR)/version.o: $(SRC_PATH)/version.rc config-host.h
>  	$(call quiet-command,$(WINDRES) -I$(BUILD_DIR) -o $@ $<,"RC","version.o")

