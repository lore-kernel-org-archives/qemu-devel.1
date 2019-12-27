Return-Path: <SRS0=GTQb=2R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE3CC2D0C3
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 21:08:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0437F20838
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Dec 2019 21:08:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jDREVuoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0437F20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ikwq9-0005FW-Vl
	for qemu-devel@archiver.kernel.org; Fri, 27 Dec 2019 16:08:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50636)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1ikwh7-0003E5-RU
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 15:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1ikwgw-0007tr-PN
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 15:58:40 -0500
Received: from mout.gmx.net ([212.227.17.21]:56873)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1ikwgn-0007aB-C2
 for qemu-devel@nongnu.org; Fri, 27 Dec 2019 15:58:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1577480275;
 bh=MdoBDSIrZM41gj2TJJjAl8zxvcQX2GLHX081kP1vzPE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=jDREVuoD3yiKMYYwtb5fMvxuf8nTha5Ju/4oJWddKq0wdn36zSyGMNKReD/MDKruL
 lThRpjClk7zOWiek6Rcv4iHHTviS0QxWsqDRP7ciuV6ovv8YxeqAK9udlF3AWqvOxe
 juAK8znw4LMzfipEXQEPR0gT0wJfe6aWvzQ2xzBI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.178.87]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mg6dy-1jPEFB08lS-00hhSy; Fri, 27
 Dec 2019 21:57:55 +0100
Subject: Re: [PATCH v5 5/6] hppa: Add emulation of Artist graphics
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20191220211512.3289-1-svens@stackframe.org>
 <20191220211512.3289-6-svens@stackframe.org>
 <8e0f79d6-46ba-a121-b6cc-8c0a5cc4ea14@amsat.org>
 <20191223175006.GA17323@t470p.stackframe.org>
 <37033554-7247-8301-a527-c48f6d74b91a@redhat.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <851902ba-8b89-09ac-b16f-bd6a99cb2c30@gmx.de>
Date: Fri, 27 Dec 2019 21:57:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <37033554-7247-8301-a527-c48f6d74b91a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6/59/bOvIPA7AYogUyOesUq9d1XkUh+7hmDTlqlhsKwdQF9/X4i
 Gnp8E72dXPRUZz9a5qufgEsncxTIcqmfpv/ftVehTa9T9ca3/2UpgyzZWoM+P0MPyHeSYzi
 piKVuHJFpiFNBbIfQqdtaLlIfuaYZmKQqNq7MjILpComxNIyTLL+qRIT2HWIpWTFVCFZKMd
 QrkUGhMbiAcMVjWuGAxCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CaIwh+cvnrs=:YajvKoAOLOVNeUG8h4AY5u
 6vDzUJpMs6yhMeosOWaEkTMOdBelWwR5N+7fU8Oabirucc90RPXgh8Smkfo9DDwJKycdXuCIS
 ZocFMF6W/et5Jd4zt2VnVedbAc5gNzJszf8XLRgn5s2sFHEg3XYhS8hq99/OBz/Wg0t+4W2D6
 O1lwFBmKuP8+i6YHy/85PKIsyoG0Jm2UfV5Z3suZmvaSYQx8VkiEUVZaN44AfZUz4HIt5VYuD
 HqMGT8vQm9dq8fx34PUqWKJ5qsQ14B0Z1O8RT00i3kk+mAaN3f/HfEAWbyEf7Ic+Cpdz9hEOY
 SihYtRjMs16Rguv7Ym7Qn1kA1AqJloIF2IqzTgeB81iTR+AYIMGlVo+I79WxvzX1smE325BpE
 cBvGJLaE2yxFC8j5n+n2bx+7rWuzycahyaMMAvD2H16wR0JkR90NNS3Ipy5r+gs6F8s0JgF4u
 j3ItkA+gMdJCkNWiD4IhQovY2ipTd0imVs3iqcu9lWeiAIAZrH010sThcr7558avBhKNrTVFS
 rpQF9OmJdEZdH6ou32O6A93pGM+GhqtyHWip5Wo7OUo0EqbJ+SZXxFPx1zDVwfznEsrFpu3bc
 IndBB166tx2eXzjAYdInYF3xI34iX/K/jfa0Drr/3csFmtjQtUX3pa0iKRkQ233GBA9dYFR7w
 t5K7WiysaYhuM0C/cmJrxSg2gLGftBDLxS6PypAAWEB/RSsXROJCMcNLjMYtuC04b3WObuzJU
 iQ0yuZazu8XUTvH5JTkzgRYGYCsXHKhkVQd0A+yP/ZK7C4+n5dFbsIaTmTfLsW6Kf/b+HHr+J
 hMlKXhdQyIbF4ofHfOVAlxzQgCdHIefaSW0IKDAGamuFRKtYSGk4XE7iuLHD+6m4OKRbZq76e
 QvIlfPrnmuZ7mxzlxwtDIcNeLDU28sB7rkVZM6YPWSQsPGB07vzmIZX7uyXP+yL3H7vOAbXLN
 R5GAhttlCVR7xbUeDX9X91w8wzDAIDMNcbNm2LaKBxf2QrlggvCos178d0ozCZkWHolG238s0
 15JFxstrmRQRePo530MgZsiqEM8QLLlXId/turl5QI9Gy7nwRtZ5Kg9wSQQ1ctm/2tbGRROMY
 OhD6AKuW6iOzIlltRcCjaJ/LgoormzCrIqq0Vf3zXCSvwdnvKX63wlz1Kpz8aNWjohu7CKuZN
 7IS0mJjsduMdViAjVnR6G5CgVWvPbh8xvd0xM4LmGxNWNK1XMEfLKMe2Lr++vUH8kxqqxEgpx
 WBovglmfAxx9bUQO/5dkP2xyEqM6fW8Dh9OZ9rw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.21
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24.12.19 01:18, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/23/19 6:50 PM, Sven Schnelle wrote:
>> Hi Philippe,
>>
>> On Sun, Dec 22, 2019 at 01:37:48PM +0100, Philippe Mathieu-Daud=C3=A9 w=
rote:
>>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 if (vga_interface_type !=3D VGA_NONE) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev =3D qdev_create(NULL,=
 "artist");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdev_init_nofail(dev);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s =3D SYS_BUS_DEVICE(dev)=
;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(s, 0, LAS=
I_GFX_HPA);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sysbus_mmio_map(s, 1, ART=
IST_FB_ADDR);
>>>
>>> How is this chipset connected on the board?
>>> If it is a card you can plug on a bus, you can use a condition.
>>> If it is soldered or part of another chipset, then it has to be mapped
>>> unconditionally.
>>
>> Depends on the Model. Hp 9000 712 and 715 had it onboard, for the B160L
>> we're emulating and others it was a GSC add-on card.
>
> The B160L case is unclear, do you mean this is not the chipset on the ma=
chine, but the software is happy if another chipset is available?
>
> Looking at hw/hppa/ I only see one machine:
>
> =C2=A0 static void machine_hppa_machine_init(MachineClass *mc)
> =C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mc->desc =3D "HPPA generic machine";
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0 }
> =C2=A0 DEFINE_MACHINE("hppa", machine_hppa_machine_init)
>
> Are you saying this generic machine is able to run different physical hw=
? Why not add them? This shouldn't take long and it would be clearer, what=
 do you think?
>
> Adding different machines here in QEMU mostly mean add a class which dec=
lare the different properties used by each machine. Igor Mammedov recently=
 suggested to follow the example of aspeed_machine_types[] in hw/arm/aspee=
d.c.

Yes, we plan to add specific machines like 712 (or 715), and maybe a
C3000 or B2000 over time, as needed device emulations (e.g. tulip, artist)
gets accepted.
But for that it would be very beneficial if changes (like the Artist emula=
tion
here in this thread) would be accepted faster upstream....

Helge

