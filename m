Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00BDC2D0C6
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 13:13:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0AA020748
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 13:13:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="c2xylsTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0AA020748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilYNZ-0003dK-Kc
	for qemu-devel@archiver.kernel.org; Sun, 29 Dec 2019 08:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1ilYJk-0002zJ-Uj
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 08:09:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1ilYJj-0007YN-Hx
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 08:09:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:45113)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1ilYJj-0007SA-4y
 for qemu-devel@nongnu.org; Sun, 29 Dec 2019 08:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1577624933;
 bh=yW8Zh8KXQ5q+9mhDKh69xMNGJNnjule4TMhT/r55EG0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=c2xylsTfdlLMvTy07cHe0+sGUV6/qokHURikCWsp/HKGrCfj8h9O/lctQnh3saXhz
 vX5xKf/vMIPXe0gC9bTORrIjkIzifR26EOcD/mqNLKDXeUDJ3L/J14rIcCltYtwIxf
 REQAezgviW+LDp3+0lmj/0EKZ3c/6LhD6AF/uMW8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.181.234]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNp7-1jSYYq2P5Z-00lmG6; Sun, 29
 Dec 2019 14:08:53 +0100
Subject: Re: [PATCH v5 0/6] HPPA: i82596, PS/2 and graphics emulation
To: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191220211512.3289-1-svens@stackframe.org>
 <5ddcb764-6f39-9bb9-1e3e-83cf6401078d@linaro.org>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <256b5dd4-f92e-5e5e-eead-bef816713fc6@gmx.de>
Date: Sun, 29 Dec 2019 14:08:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5ddcb764-6f39-9bb9-1e3e-83cf6401078d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ynOphfv6jFs7oIQF+OZAWTGOV/lunUIEGwxzeb97DjX1oOfFdCe
 XL3QhN/nr93wTVoRcPfKurQbdScgy4Af6D8Mvkd33JJkPVkYbOTlsMWwdq3eumMwuOjRu3V
 yFCWLKNvU/10IQVlpEmegqOtIyX7rSDk6GTyepgozGjEn0dlHHcsIW6Dtt5u7ODCt8HWcap
 4bwj6Ip2GRjhL9rI4VJnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C22O0SIZAqg=:Gaj5IXcDQG2C9+8Sm5gt14
 fQ9i8/xy03c6r1LQzus3AfqvzFctzXuIM4Op6wxE6aZKY1qpRTpBvM0CxFUKuS7x7pFCGwV65
 qYpIeh6AaOK8lMFceJDBiH6KSqlYkxQzjVqiLI9paklNDXh5ya6Ea/YJXMI8nQ+HeJU5pVdIX
 eCJ+u+kRIPMzRVmmmW1oLZqqNJzlu7G29pVyGQ3SwdwzGeXDFjRvRSMjQWo2LgKi1OV4u5dGT
 TjbYZxpiuk4I+K/Uw9Mrk7IazGYHBiFv29Z1yNBDidxgsMZACdhtQei7NRDIzhmm90US9K0bS
 F8uU8AJ/QOG2IH1J3+771J6SWWOHRyOA8GdtEBJpUiV4kRRLUfHnzkmxRY+iVf3j7GYbe4h+X
 TRCfcz40sAUs3uNBuN0NyP8XvkWWu/9X95a7x9kFmROd2VqeZemkkgd+OXUNi04y2oA0lkhH/
 St8ZSnS44sIxkZ/Gv+FeMvxV82VXBDg0LmvDRPRKINPyUhT6SBPQ6Af3E3h16BJ5kL9uw7tba
 jQv9AUje65H3Qhq/yteqreIM5NIrZ1xp2VAqT8G65zAkOnfeOhCS/e1/znAUMbtiG3zSeDRoa
 o5HUY+X2IBw+mGPG1xJLe9Fow4+R6Y92jnDLxD15mFuap8dLb27FlD6UKQXZQZRy3bNbOkZY0
 Dz4RQDLbzoPairco9RDX8/brKF4jfouKOmnq5Ahepp+VXTqlQhSLyBpiyERR9vEezXKZy7gmC
 zzvwBnmFp6YUE9tvGR87Pn803K7Niz3S1d90LPbJycA0DRANWNg+36CYbBSIV/VDCNCP6agqn
 nXJpdPe8vGGwDPym6ofPVtjQ2/3rUty9hE+rtDzcMFGR8CRAz0bdVpENZILc9SP7xpPEv0zU5
 qjpgLZeFUdevM9DX0GyHuUEjNdLt8YGIBgYPt1V4hrnEQSbjbXLNnw80pjOOXbsY9kH8zPDfM
 n+Xl6gDBc7xOM7xL7uHpTTKqzqpqxRPzGffqqR9WV/03V3/l+Q2A0+fzUia03tYBWgclRD6nV
 L9OJkNn+uNcHp7MO+mutU1HOl7x1QOJpLjHODmHdGNvXDJzeMDntwk0OSxsDX2tMkvkDGRi1T
 YkfIbfNYige7J6AxOpGkzuyV1YgAKe3DZs4xsZcR38w77+QAGDHsEvV1b/TY3Ga7aJzbR6UEa
 vdDtEK/kCxVbMd9XxMl+k/WGHx444nn5/KUVHRRZO7LR7tnhpSGnGMuRgDRN7IwW17E7Izdkj
 sPe4jKKu/D1V5PGcm/nBPxkbxWxYm3WVURO2NbA==
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29.12.19 02:25, Richard Henderson wrote:
> On 12/21/19 8:15 AM, Sven Schnelle wrote:
>> these series adds quite a lot to the HPPA emulation in QEMU:
>> i82596 emulation from Helge, PS/2 and Artist graphics emulation.
>>
>> See https://parisc.wiki.kernel.org/index.php/Qemu for a few screenshots
>> of QEMU running a X11/CDE session in HP-UX.
>>
>> Changes in v5:
>>  - fix a buffer overrun in vram_bit_write()
>>  - improve STI line wraparound
>>
>> Changes in v4:
>>  - introduce Artist-internal address space
>>  - rewrite screen update functions to use the generic framebuffer routi=
nes
>>  - use dirty bitmap code to not always redraw the whole screen
>>
>> Changes in v3:
>>  - use BIT() macro in gsc_to_pci_forwarding()
>>  - fix version id in vm state
>>  - fix an error in the PS/2 KBD_CMD_SET_MAKE_BREAK implementation
>>
>> Changes in v2:
>>  - dropped 'hppa: remove ISA region' as that patch requires some more w=
ork
>>  - added shortlog to seabios update
>>  - use const and MAKE_64BIT_MASK in dino.c
>>
>> Regards,
>> Sven
>>
>> Helge Deller (2):
>>   hw/hppa/dino.c: Improve emulation of Dino PCI chip
>>   hppa: Add support for LASI chip with i82596 NIC
>>
>> Sven Schnelle (4):
>>   ps2: accept 'Set Key Make and Break' commands
>>   hppa: add emulation of LASI PS2 controllers
>>   hppa: Add emulation of Artist graphics
>>   seabios-hppa: update to latest version
>
> Queued these 6.  I squashed Helge's -nographics fix into patch 5.

Thank you Richard!

> I cannot get my debian 8 install to boot to a prompt with the artist gra=
phics
> enabled.  I'm not sure if I need a newer kernel or what.  But it doesn't=
 do
> nothing either, so I'm a bit confused.

I think it should work out of the box and the kernel should be OK,
because stifb has been in there for long time.
Do you maybe have "stifb=3Doff or sticon=3Doff" in the kernel commmand lin=
e?
Did you enabled a getty for tty0 in etc/inittab ?
What does dmesg say?
Is "/proc/fb0" device there ?
I'm happy to look into it, if you can provide me your image for download s=
omewhere...

Helge

