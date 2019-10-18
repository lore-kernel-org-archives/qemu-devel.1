Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE32CCA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CDE1222C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="m7olLemc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CDE1222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTAD-0000oW-NQ
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iLSys-0006vW-BQ
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iLSyn-00083m-7Q
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:11:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:58755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iLSym-00083D-Oi
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=p58HUA3l887kCAAF8DseaeTyAUGahfHCez3S/Jdf0a4=; b=m7olLemczp87drnw8HLHPfY0wE
 D8HKfsOHDdRs0IpK/BkSMbFBv8TrO470qfnlpq4lnZ7NfZqX4GNL4wnh0O1jDxPB4Fg9AzEZ1CBSn
 ccacJeZBgE3dBAD2jaqAEOoJFlws5xmmWQMQrVsWJFYXJfRy99FIGrKdGYTkR3HWnRXmjORbggMRE
 Wxgd8UX28B0ZluVm1kjDtWTwA1NLfJwmPPBcZNtBm8zmRzyuqgyGybSr6pEYGBt9FMJNatvmD+v5y
 sp8w88wZrKH+cAMtJgNRnq7f0tXb2TP+qs7TbEPcQHIMCOoyqkt/nGYS8s19ae6U0M0v58uV5TP+e
 YPdFrbVC23Rl1akb4ecccsbNt0eo6pbzk14a8s0c3aqN2OLt5KgjcI796QlzlbDT8t6MMK83ndXf1
 mZowzCNR4xHplJgsmz6q4OhXRbypVTcNQtca7bBAXVtLL5U0tAG0q1tu5NLArJ9dmB6BZwVeCCsm0
 2BMDUHmehwSbFTmGsBIKChdeCeGXqHz19DwkyNxHYn1D2okwaPKOdNWbLOpAMFn/TFXxVO1igemkk
 etAzy7IuiMMXleHpFN16MXhUUnBEg/uRIFNmqkg5+n66RuYIheU1S202AvUMg8NXM67jWaS59u/xF
 okkqNHW9c5MYMlu2fKHkBMuDkGsoV/JxgxC6IQy14=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Hikaru Nishida <hikarupsp@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PULL 1/4] ui: Fix hanging up Cocoa display on macOS 10.15
 (Catalina)
Date: Fri, 18 Oct 2019 16:11:41 +0200
Message-ID: <3144589.IvpWr2AZiN@silver>
In-Reply-To: <CAFEAcA8AP7hjSz9QoF78uhYtc3nf7DtijvsCHh6BXt4udzUjtA@mail.gmail.com>
References: <20191018101711.24105-1-kraxel@redhat.com>
 <2488172.SrBWvpgbjs@silver>
 <CAFEAcA8AP7hjSz9QoF78uhYtc3nf7DtijvsCHh6BXt4udzUjtA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Freitag, 18. Oktober 2019 15:02:49 CEST Peter Maydell wrote:
> On Fri, 18 Oct 2019 at 14:01, Christian Schoenebeck
> 
> <qemu_oss@crudebyte.com> wrote:
> > On Freitag, 18. Oktober 2019 12:17:08 CEST Gerd Hoffmann wrote:
> > > From: Hikaru Nishida <hikarupsp@gmail.com>
> > > 
> > > macOS API documentation says that before applicationDidFinishLaunching
> > > is called, any events will not be processed. However, some events are
> > > fired before it is called in macOS Catalina.
> > 
> > Even though fixed now on qemu side, I filed a bug report with Apple to let
> > them know, since this indeed looks like unintended behaviour change a.k.a.
> > bug in Catalina.
> 
> Thanks -- do you have an apple bug number or something for that?

It's filed as FB7380815 (on October 15th).

As of May this year they changed the way how externals may report bugs. You 
now have to use "Feedback Assistant" (requires a developer account):

	https://developer.apple.com/bug-reporting/

Before that change, registered developers could use bugreport.apple.com for 
many years, which was more tightly coupled with their actual internal bug 
tracker called "Radar" (e.g. you saw their internal rdar number, internal bug 
status, duplicates) than this new Feedback Assistant.

Best regards,
Christian Schoenebeck



