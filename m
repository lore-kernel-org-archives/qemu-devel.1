Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01D3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4BC02074B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 14:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4BC02074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg8Ni-0000rB-Ut
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 10:59:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jg8Mz-0008Rx-Jy; Tue, 02 Jun 2020 10:58:25 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:43084)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jg8Mx-0000te-TY; Tue, 02 Jun 2020 10:58:24 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 8F77874633F;
 Tue,  2 Jun 2020 16:58:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 7126C74633E; Tue,  2 Jun 2020 16:58:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 6FA1874632C;
 Tue,  2 Jun 2020 16:58:19 +0200 (CEST)
Date: Tue, 2 Jun 2020 16:58:19 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Andrea_Palmat=E8?= <andrea.palmate@gmail.com>
Subject: Re: Sam460Ex screen mode, audio and network
In-Reply-To: <alpine.BSF.2.22.395.2006021510140.40694@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2006021647240.70962@zero.eik.bme.hu>
References: <CAD+yzTSr2edTNmzkGOH7todx7uVPbL_BSNSJPb62mJWCUSa8NA@mail.gmail.com>
 <4d64c939-3431-b637-488e-676a5f9171e5@amsat.org>
 <alpine.BSF.2.22.395.2006021510140.40694@zero.eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-816818955-1591109899=:70962"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/02 10:58:19
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-discuss@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-816818955-1591109899=:70962
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 2 Jun 2020, BALATON Zoltan wrote:
> On Tue, 2 Jun 2020, Philippe Mathieu-Daudé wrote:
>> Cc'ing the sam460ex maintainer.
>> On 6/1/20 8:01 PM, Andrea Palmatè wrote:
>>> It is working on an i5 laptop. I've tried to use the native screen mode
>>> 1366x768 but it has some problems. It seems a stride problem and so is
>>> not usable
>
> I'm not sure if it's a problem on AmigaOS side or in emulation. How to 
> reproduce this? Such resolution does not show up for me in ScreenMode prefs 
> so cannot be simply selected.

OK I've got it. I think you've unticked default and set a custom width. 
This seems to set the width of frame buffer in memory but the mode the 
card is programmed to use is still the one selected from the list so this 
won't work. It seems to be either a bug in AmigaOS or the width option 
does not do what you may think. Maybe ask AmigaOS developers or aCube who 
wrote the driver about this. (Another known issue is that 24/32 bit modes 
are not available with the AmigaOS SM502 driver which would be needed for 
optimal performance with QEMU, the 16 bit mode it offers is much slower 
because it has to be converted on every display update.)

Regards,
BALATON Zoltan
--3866299591-816818955-1591109899=:70962--

