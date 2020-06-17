Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA7CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BB6208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 06:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="eLZ3n0bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BB6208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlRLE-0007qn-GE
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 02:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jlRKA-0007Ji-Nr
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:13:27 -0400
Received: from collins.uni-paderborn.de ([2001:638:502:c003::14]:48094)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jlRK8-0007nF-Iq
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 02:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=emQQTc4CgqfRS2zIlkLgrK0N50n6qovrMZQ/rawlmE8=; b=eLZ3n0bFezWqil4D6uWgy/4PtW
 LzCnm6U3L1l4PWCfYi0qeDC8RfTZRlZjkChc1Swegk5vFQQnH4+AHslWA7+jyKivBTWSRyx0hr76V
 t7VUb11IWShHZweQYk6+ztGpVFOmSpI+Odkanb9PSk7Y5lYmTtOOCWOKcVKrDKczy8sM=;
Date: Wed, 17 Jun 2020 08:13:13 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 03/15] tests/tcg: Run timeout cmds using --foreground
Message-ID: <20200617061313.uaru24twuzqgml5j@schnipp-desktop>
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
 <20200604085441.103087-4-kbastian@mail.uni-paderborn.de>
 <87blljyo8d.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87blljyo8d.fsf@linaro.org>
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.6.17.60316, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.6.17.5740000
X-Sophos-SenderHistory: ip=2a02:908:2214:e5bc::95d, fs=8011779, da=79983460,
 mc=197, sc=3, hc=194, sp=1, fso=8011779, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::14;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=collins.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 16, 2020 at 05:22:42PM +0100, Alex Bennée wrote:
> 
> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
> 
> > when trying to run successful short tests from the Makefile timeout would no
> > terminate. Rather it would wait until the time runs out. Excerpt from the
> > manpage:
> 
> Which tests hang without this change?

The TriCore tests ;). 

> 
> >
> > --foreground
> >     when not running timeout directly from a shell prompt,
> >     allow COMMAND to read from the TTY and get TTY signals; in this mode, chil‐
> >     dren of COMMAND will not be timed out
> >
> > Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> > ---
> >  tests/tcg/Makefile.target | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/tcg/Makefile.target b/tests/tcg/Makefile.target
> > index b3cff3cad1..423caffa56 100644
> > --- a/tests/tcg/Makefile.target
> > +++ b/tests/tcg/Makefile.target
> > @@ -40,9 +40,10 @@ quiet-command = $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 && $1, @$1))
> >  
> >  # $1 = test name, $2 = cmd, $3 = desc
> >  ifdef CONFIG_USER_ONLY
> > -run-test = $(call quiet-command, timeout $(TIMEOUT) $2 > $1.out,"TEST",$3)
> > +run-test = $(call quiet-command, timeout --foreground $(TIMEOUT) $2 > $1.out \
> > +	"TEST",$3)
> 
> This breaks make check-tcg due to a dropped ,

Whoops

Cheers,
Bastian

