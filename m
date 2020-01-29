Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4290CC35240
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E03220720
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 07:10:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E03220720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwhU8-0005SN-6N
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 02:10:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vr_qemu@t-online.de>) id 1iwhTb-00053l-Rn
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:09:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vr_qemu@t-online.de>) id 1iwhTa-0003YX-PT
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:09:27 -0500
Received: from mailout01.t-online.de ([194.25.134.80]:38430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vr_qemu@t-online.de>) id 1iwhTa-0003Y2-Jp
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 02:09:26 -0500
Received: from fwd21.aul.t-online.de (fwd21.aul.t-online.de [172.20.27.66])
 by mailout01.t-online.de (Postfix) with SMTP id 81DBC42719F7;
 Wed, 29 Jan 2020 08:09:23 +0100 (CET)
Received: from [192.168.211.200]
 (GQZNNyZBQhXJwA3LQV9nDSTWG7wCPtiaTRAXA5q+Y0oxw+x5UT6Nm39MNLyMsyjZqA@[93.236.147.123])
 by fwd21.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1iwhTU-4TcWMC0; Wed, 29 Jan 2020 08:09:20 +0100
From: =?UTF-8?Q?Volker_R=c3=bcmelin?= <vr_qemu@t-online.de>
Subject: Re: [PATCH v2] Implement the Screamer sound chip for the mac99
 machine type
To: Howard Spoelstra <hsp.cat7@gmail.com>
References: <43D423C6-78D4-4DCE-B97C-0658D3D2E3BD@gmail.com>
 <4021690b-2380-3925-209e-d4cc66928773@gmail.com>
 <5314e860-dffe-3bc0-209f-bd2b937cd0c6@t-online.de>
 <CABLmASGcUVyASudNizcgPshEqahwYt-4m9Z1DXEhVe2vdko9cQ@mail.gmail.com>
Message-ID: <54f5ddf3-5ea9-bd6d-8c71-edf4db527463@t-online.de>
Date: Wed, 29 Jan 2020 08:09:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CABLmASGcUVyASudNizcgPshEqahwYt-4m9Z1DXEhVe2vdko9cQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-ID: GQZNNyZBQhXJwA3LQV9nDSTWG7wCPtiaTRAXA5q+Y0oxw+x5UT6Nm39MNLyMsyjZqA
X-TOI-MSGID: ada3df10-9e34-4789-89c8-9dfa6ce437e7
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 194.25.134.80
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
> Hi Volker,
>
> I can test for coreaudio. Can you let us know exactly what you fixed in=
 the patch?

Hi Howard,

I wrote a patch that tries to fix the problems in Zolt=C3=A1n's patch. Th=
e changes in coreaudio.c are untested. I'll send it as a reply to this ma=
il. Please apply Zoltan's patch and then my patch to qemu master.

> While cross compiling for windows, I saw these errors (besides some cas=
ting issues):
> line 56: buffer2=C2=A0 (should be *buffer2?)
> line 455: ret=C2=A0 (should be ret2?)
>
> audio/dsoundaudio.c:56:20: error: variable or field 'buffer2' declared =
void
> =C2=A0 =C2=A056 | =C2=A0 =C2=A0 void *buffer1, buffer2;
> =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0^~~~~~~
> audio/dsoundaudio.c: In function 'dsound_get_buffer_out':

I'm sorry, but I can't build and test on Windows.

With best regards,
Volker

