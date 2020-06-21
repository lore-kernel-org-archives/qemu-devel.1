Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6A4C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 11:21:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E9D7248C0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 11:21:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E9D7248C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmy2u-000692-F8
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 07:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmy22-0005Lw-8V
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 07:21:02 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:56899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmy20-0008GK-9Y
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 07:21:01 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 762AC746307;
 Sun, 21 Jun 2020 13:20:58 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 569BA74594E; Sun, 21 Jun 2020 13:20:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 547987456F8;
 Sun, 21 Jun 2020 13:20:58 +0200 (CEST)
Date: Sun, 21 Jun 2020 13:20:58 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: Is roms/vgabios/config.mak still needed?
In-Reply-To: <7f64c36d-08f5-95a5-54f7-733578734c87@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2006211319550.23351@zero.eik.bme.hu>
References: <alpine.BSF.2.22.395.2006172005060.14527@zero.eik.bme.hu>
 <7f64c36d-08f5-95a5-54f7-733578734c87@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1712469412-1592738458=:23351"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/21 07:17:37
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1712469412-1592738458=:23351
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 17 Jun 2020, Philippe Mathieu-Daudé wrote:
> On 6/17/20 8:08 PM, BALATON Zoltan wrote:
>> Hello,
>>
>> I've noticed that configure creates roms/vgabios/config.mak but commit
>> 91b8eba9ec3f5af7dd48927811eb7ff69fc4617f seems to have removed vgabios
>> so should this be dropped from configure now as well? If it's still
>> needed it should be added to .gitignore.
>
> You are right, it is a left-over from 91b8eba9ec3f and should be dropped
> from configure.

Will you or Gerd do something about it? I'd rather not touch configure 
without completely understading it.

Regards,
BALATON Zoltan
--3866299591-1712469412-1592738458=:23351--

