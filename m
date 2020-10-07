Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7A5C41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:18:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E34E20797
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 15:18:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="mzKx4W0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E34E20797
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=me.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQBCb-0006Jh-Ce
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 11:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1kQB80-0003Gs-QK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:13:18 -0400
Received: from pv34p98im-ztdg02162201.me.com ([17.143.234.141]:34277)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thorpej@me.com>) id 1kQB7w-0001gP-JZ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 11:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1602083590; bh=P2Ih4x04tlN8RHfZIppLVw8tDVZCe1S5CPa4P65vUCA=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=mzKx4W0vlQNa6cyXxHhYn0IBY9uGMc8je+60l/wiRToYeUuqT1f3C5cV1zPvhcyD/
 QK8Gb+zNMlDxa3XygEwElMYOnr4hyYKky1Pd5hBJXYYrYYqNSFo8ah0Y+yQUEMjNy2
 M7e0xPkhSrXdQQydAV0oX3BIUhDeYSY9y8IYacQQ8CBNMc5IiJdyRfiRrrThn4KGqy
 H5+LBBWFoKQ9wX6OL2pSg5fP86AF6xpMSQDS17vI40WUxcJ6S9AiXFkqfaiemnFsRX
 CMNcSLQysSX571vGkGDAyADN8ytgXkGwh4cfEqi+FvRuK9j+N5fNvSgpmEM4t4TDfE
 71kVBXbwQWM9w==
Received: from [17.235.4.111] (unknown [17.235.4.111])
 by pv34p98im-ztdg02162201.me.com (Postfix) with ESMTPSA id 0D5341C0322;
 Wed,  7 Oct 2020 15:13:09 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.1\))
Subject: Re: [PATCH] Changes to support booting NetBSD/alpha
From: Jason Thorpe <thorpej@me.com>
In-Reply-To: <f4d04e98-bd81-aba4-a8e7-5e818b13260c@amsat.org>
Date: Wed, 7 Oct 2020 08:13:08 -0700
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>,
 Sven Schnelle <svens@stackframe.org>, Helge Deller <deller@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <406720D0-D88E-4CBA-9789-11D0D2EA93F5@me.com>
References: <20201007032417.26044-1-thorpej@me.com>
 <f4d04e98-bd81-aba4-a8e7-5e818b13260c@amsat.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
X-Mailer: Apple Mail (2.3608.120.23.2.1)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235, 18.0.687
 definitions=2020-10-07_09:2020-10-06,
 2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=939 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2006250000 definitions=main-2010070098
Received-SPF: pass client-ip=17.143.234.141; envelope-from=thorpej@me.com;
 helo=pv34p98im-ztdg02162201.me.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 11:13:11
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


> On Oct 6, 2020, at 9:42 PM, Philippe Mathieu-Daud=C3=A9 =
<f4bug@amsat.org> wrote:
>=20
> Hi Jason,
>=20
> Well, this is not the correct way to do that, so this patch
> is unlikely to be accepted. We don't want Frankenstein models.
>=20
> What is it you miss from the i82378? Why not implement the cy82c693ub?
>=20
> The code you want to modify is in hw/alpha/dp264.c, see =
clipper_init().

The Clipper emulation *already* implements a Frankenstein model, a =
combination of hardware that DEC never shipped.  While some =
Tsunami-based systems did use the Cypress bridge, none of them, to my =
knowledge, had the CMD646 IDE controller.  The only system I'm aware of =
that shipped with a CMD646 IDE controller was the early version of the =
Miata (EV56 + Pyxis-based Digital Personal Workstation), and that system =
had the Intel i82378 PCI-ISA bridge.

The are a lot of differences in the Cypress PCI-ISA bridge, but most =
importantly, it has a different interrupt controller (the ELCR registers =
are programmed differently), and it has a different built-in IDE =
controller.  As far as I can tell, Qemu does not currently have =
emulation for the Cypress interrupt controller nor the Cypress IDE =
controller.

All Alpha systems that had a PCI-ISA bridge[*] shipped with, as far as =
I'm aware, one of 3 possible chips:

- Intel i82378 SIO
- Cypress 82C693
- Acer Labs M1533

...and the emulation provided by the existing Clipper model implements =
the Intel flavor (including the interrupt controller).  I just want =
software that expects one of those 3 chips to be there to work.  The =
existing emulation seems to assume that system software will just go out =
and probe the peripherals in the ISA space, but some operating systems =
(NetBSD in particular) support Alpha systems that have PCI without any =
ISA/LPC bus at all, and thus only go looking for ISA peripherals if a =
PCI-ISA bridge is present.  That is what my change here is intended to =
do, without changing any of the rest of the hardware configuration.


[*] ...ignoring the weirdo early models that had PCI + EISA + =
oddly-wired-up junk I/O chips.  Also, I don't have any direct experience =
with post-Titan models, so I'm not sure what they have...

-- thorpej


