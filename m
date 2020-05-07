Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5714DC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:55:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2304020575
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2304020575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWlfm-0001d0-AU
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 14:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49540)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jWlfA-0001Dx-Ni
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:54:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:48090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jWlf7-0001Sm-Vk
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:54:27 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 7559C74633E;
 Thu,  7 May 2020 20:54:14 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 57C95746331; Thu,  7 May 2020 20:54:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 565BA74632C;
 Thu,  7 May 2020 20:54:14 +0200 (CEST)
Date: Thu, 7 May 2020 20:54:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: jasper.lowell@bt.com
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u
In-Reply-To: <f833edcfed7dd58a6bb27269de66acfed0e550eb.camel@bt.com>
Message-ID: <alpine.BSF.2.22.395.2005072048510.5891@zero.eik.bme.hu>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
 <f833edcfed7dd58a6bb27269de66acfed0e550eb.camel@bt.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 14:54:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: tony.nguyen@bt.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 atar4qemu@gmail.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 May 2020, jasper.lowell@bt.com wrote:
> I've started work on emulating the SAB 82532 ESSC2 but it's
> unfortunately way more complex than than the 16550A. For instance, it's

I don't know anything about this chip so don't know if it helps but if 
it's any way similar to ESCC (and the ESCC2 name is not just marketing) 
then there's some emulation of that in hw/char/escc.c that you may want to 
look at.

> possible to configure different baudrates for receiving and
> transmitting. QEMU's chardev interface doesn't appear to handle that.
> QEMUSerialSetParams has a single speed value that is passed to
> cfsetispeed and cfsetospeed. The chip also has support for stick parity
> , which aren't valid options right now either. If I'm wrong on either
> of those points please correct me. Unless there is an alternative,
> changes to the interface may need to be made if adding this device is
> to be considered.

Maybe you can get away with setting these to the values the driver would 
set and hard coding it for now just to get some output. Then you can 
ignore the corresponding registers which could simplify initial device 
model.

Regards,
BALATON Zoltan

