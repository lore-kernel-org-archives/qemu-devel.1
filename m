Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7790C33CB2
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 07:38:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 924D220705
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 07:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924D220705
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixQt1-0000xk-Nh
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 02:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1ixQsQ-0000WH-HV
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:38:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1ixQsP-0000BK-Kh
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:38:06 -0500
Received: from mailout08.t-online.de ([194.25.134.20]:50848)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1ixQsP-00007a-Ey
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 02:38:05 -0500
Received: from fwd09.aul.t-online.de (fwd09.aul.t-online.de [172.20.27.151])
 by mailout08.t-online.de (Postfix) with SMTP id 7AABE41A7B96;
 Fri, 31 Jan 2020 08:38:02 +0100 (CET)
Received: from [192.168.211.200]
 (XpPxHGZ6rhDPqUKNRkmr2cxxq1EwGBU7-IM2hU80QAXm0hZSSpxiDmKdH0OvoGwwWw@[93.236.154.40])
 by fwd09.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1ixQsB-0UK3NY0; Fri, 31 Jan 2020 08:37:51 +0100
Subject: Re: [RFC] coreaudio: fix coreaudio_test.diff
To: Howard Spoelstra <hsp.cat7@gmail.com>
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
 <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
 <5314e860-dffe-3bc0-209f-bd2b937cd0c6@t-online.de>
 <CABLmASGcUVyASudNizcgPshEqahwYt-4m9Z1DXEhVe2vdko9cQ@mail.gmail.com>
 <54f5ddf3-5ea9-bd6d-8c71-edf4db527463@t-online.de>
 <f03b7ae9-344c-5a7f-414c-6250a9c5ec2f@t-online.de>
 <CABLmASGkSnG4+vfykBnEznX=kCAcSaiW20nf-wT9Cne4Cj9+LQ@mail.gmail.com>
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Message-ID: <3e4f565a-07d7-c1cc-b49c-0a8c504ae07c@t-online.de>
Date: Fri, 31 Jan 2020 08:37:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CABLmASGkSnG4+vfykBnEznX=kCAcSaiW20nf-wT9Cne4Cj9+LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-ID: XpPxHGZ6rhDPqUKNRkmr2cxxq1EwGBU7-IM2hU80QAXm0hZSSpxiDmKdH0OvoGwwWw
X-TOI-MSGID: 8b1a8292-d4f3-4823-a1a9-8a685b6163f0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.20
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
Cc: Programmingkid <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu Developers <qemu-devel@nongnu.org>,
 =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

>
> Hi all,
>
> Thanks to the generous help from Mark, I can now report that it is good=
 to hear coreaudio has been restored into a working state with this patch=
! I tested qemu-system-ppc running MacOS and OSX.
>
> Best,
> Howard

Thank you for testing the two patches. I will wait a few days to see if Z=
olt=C3=A1n wants to write a cleaned up patch. Otherwise I'll try to write=
 a patch that's acceptable for submission.

With best regards
Volker

