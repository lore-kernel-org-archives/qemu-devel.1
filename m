Return-Path: <SRS0=YGca=2Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C75C32767
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 09:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D71B2464E
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2020 09:03:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D71B2464E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1infL5-0006iJ-D7
	for qemu-devel@archiver.kernel.org; Sat, 04 Jan 2020 04:03:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1infKL-000675-FY
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:02:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1infKK-0006vX-Dc
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:02:33 -0500
Received: from mailout09.t-online.de ([194.25.134.84]:39890)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1infKK-0006fP-5n
 for qemu-devel@nongnu.org; Sat, 04 Jan 2020 04:02:32 -0500
Received: from fwd34.aul.t-online.de (fwd34.aul.t-online.de [172.20.26.145])
 by mailout09.t-online.de (Postfix) with SMTP id CDCDE42FED2E;
 Sat,  4 Jan 2020 10:02:28 +0100 (CET)
Received: from [192.168.211.200]
 (EwIONrZFwhHRms8ebdvUXpMtOArxMVBUynFyvlBpnpIRYOvus054pa7U7MzCeTlgGQ@[46.86.52.107])
 by fwd34.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1infKF-1HBG8u0; Sat, 4 Jan 2020 10:02:27 +0100
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH 2/5] hda-codec: fix recording rate control
To: Gerd Hoffmann <kraxel@redhat.com>
References: <fe427705-ef37-d48e-526c-7dc8025425b6@t-online.de>
 <08ea1c13-aa53-31f4-4495-ff4e455ae3ad@t-online.de>
 <20200103131042.qjqftjls2yhf5hd2@sirius.home.kraxel.org>
Message-ID: <5459f635-3c2b-33aa-46b0-4f8e458e7571@t-online.de>
Date: Sat, 4 Jan 2020 10:02:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200103131042.qjqftjls2yhf5hd2@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ID: EwIONrZFwhHRms8ebdvUXpMtOArxMVBUynFyvlBpnpIRYOvus054pa7U7MzCeTlgGQ
X-TOI-MSGID: 0cc22d81-157d-4431-9904-6155564d3026
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.84
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
Cc: QEMU <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> This mail is multipart text+html and "git am" can't process it (the
> others are text only).  Can you please resend the patches, preferably
> with "git send-email" to avoid them being sent as multipart?  They all
> look good to me (this series and the 6th patch sent as separate mail).
>
>
Sorry, I made a mistake here. I will send a version 2 patch series with
git send-email.

With best regards,
Volker


