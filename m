Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABF1C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:31:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 515C124685
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 515C124685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwMHp-0002KJ-IA
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 03:31:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1iwMGs-0001t8-Oc
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:30:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1iwMGr-0004SA-NQ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:30:54 -0500
Received: from mailout06.t-online.de ([194.25.134.19]:33800)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1iwMGr-0004N0-H4
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:30:53 -0500
Received: from fwd37.aul.t-online.de (fwd37.aul.t-online.de [172.20.27.137])
 by mailout06.t-online.de (Postfix) with SMTP id 4A3D840C33D3;
 Tue, 28 Jan 2020 09:30:51 +0100 (CET)
Received: from [192.168.211.200]
 (XNFcgOZCYhZubjZfJpllEZpnkKYCFJj-hieUG66izl5hg2WMThNXlKMeGefmMAXgnX@[93.236.147.123])
 by fwd37.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1iwMGo-3KA0MS0; Tue, 28 Jan 2020 09:30:50 +0100
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH v2] Implement the Screamer sound chip for the mac99
 machine type
To: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>,
 Programmingkid <programmingkidx@gmail.com>,
 qemu Developers <qemu-devel@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
 <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
Message-ID: <5314e860-dffe-3bc0-209f-bd2b937cd0c6@t-online.de>
Date: Tue, 28 Jan 2020 09:30:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-ID: XNFcgOZCYhZubjZfJpllEZpnkKYCFJj-hieUG66izl5hg2WMThNXlKMeGefmMAXgnX
X-TOI-MSGID: df9baa60-c1fe-41b7-9cb2-e3f926764a0f
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 194.25.134.19
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> Hi,
>
> Unfortunately it's not that simple to simply revert the patch since the=
 old backend api no longer exists.=C2=A0 Also I don't have a Mac so it's =
almost impossible for me to test the results.=C2=A0 I looked at the speci=
fied commit and I think I found a problem, could you please apply the att=
ached patch on the current git master and check whether it solves the pro=
blem?=C2=A0 If yes I'll turn it into a proper patch.
>
> Regards,
> Zoltan
>

Hi Zolt=C3=A1n,

I also don't have a Mac so I tested your patch with a slightly modified s=
dlaudio version. I found two bugs in your patch. With the bugs fixed I ha=
ve working SDL2 audio playback with float type samples. Now I wonder if t=
he fixed patch also fixes coreaudio playback. Depending on how busy you a=
re I can just write a review for your patch and let you handle the rest, =
or may I send a modified version of your patch to the mailing list for te=
sting?

With best regards
Volker

