Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586CCC2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:57:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 005962076C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 10:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fau.de header.i=@fau.de header.b="R/PpYYd7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005962076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fau.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRZXw-0000We-NP
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 06:57:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <janine.schneider@fau.de>) id 1jRZUm-0006Jk-28
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:54:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <janine.schneider@fau.de>) id 1jRZUl-0001IY-Lz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 06:54:15 -0400
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:46257)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <janine.schneider@fau.de>)
 id 1jRZUa-0000ll-6s; Thu, 23 Apr 2020 06:54:05 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de
 (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 497Dgg1mp7z227q;
 Thu, 23 Apr 2020 12:53:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
 t=1587639231; bh=80yvMBzm+k1JH1PR4i4rzXWytVH8UF2lxv528z/d04g=;
 h=From:To:Cc:References:In-Reply-To:Subject:Date:From:To:CC:
 Subject;
 b=R/PpYYd7qavmn99GNvhIwUSRYn2bwMYbpvNKZ36g9V+DHQSdqz5iAZpgZtSSxxP5U
 3GRL0txLW8okkYnTmH5odFShuVCmENoh8aUV6vW35z/Ohk2CHt7Iniung22b2L4ZKK
 AyeI9f0yktSaL7OA53+ZiuKsusTzMMd9gm7nk67Bv6yLMHRJ/iC5G18hqnAmv+PFdc
 ExeyCo47JJipsfJuF96fxgJZg7NMsx1RaxKG/Ns5/+DDrasImLt8pq1SPs8KFDoFuF
 ZsHOxjw/qEINdRkuQ3uYnGj3DAIqJdR2anfMNgURBI1krdPAwGhAlpbVbcmftLXq1F
 Gd08e0dstigog==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 92.217.240.192
Received: from LenovoJS
 (ipservice-092-217-240-192.092.217.pools.vodafone-ip.de [92.217.240.192])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: U2FsdGVkX18MGA1a2VGN+6RwvpclN89y1eY2CVg5O6I=)
 by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 497Dgc6JHYz22PS;
 Thu, 23 Apr 2020 12:53:48 +0200 (CEST)
From: <janine.schneider@fau.de>
To: "'Stefan Hajnoczi'" <stefanha@gmail.com>
References: <00fc01d61256$35f849c0$a1e8dd40$@fau.de>
 <877dyfc1if.fsf@dusky.pond.sub.org>
 <20200422161813.GI47385@stefanha-x1.localdomain>
 <006e01d61958$de787120$9b695360$@fau.de>
 <CAJSP0QVeEZmSps3R8Hg+j=-BZR7_+FeOkm+m12A=gMULosP3Sg@mail.gmail.com>
In-Reply-To: <CAJSP0QVeEZmSps3R8Hg+j=-BZR7_+FeOkm+m12A=gMULosP3Sg@mail.gmail.com>
Subject: AW: Integration of qemu-img
Date: Thu, 23 Apr 2020 12:53:48 +0200
Message-ID: <008a01d6195d$78280570$68781050$@fau.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHDddkxkHGERaxncwHCyGp4w9+XRwMkfrCZALzzFn0CayhedAJd3rlzqGZ50BA=
Content-Language: de
Received-SPF: pass client-ip=131.188.11.22;
 envelope-from=janine.schneider@fau.de; helo=mx-rz-3.rrze.uni-erlangen.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 06:53:51
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 131.188.11.22
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
Cc: 'qemu-devel' <qemu-devel@nongnu.org>, 'qemu block' <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hy again,

okay so now we have an easy way out just in case.
But I still want to build an DLL and/or a shared library for integration =
into the tool. I want the tool to be platform independent and I was =
already able to build qemu-img as cross build with mingw64. Does anybody =
have experience in building a qemu library or tried it already?
The tool I want to integrate qemu in is published under GPL itself. And =
if I am able to build qemu as library I will share it with the community =
and everybody interested in having it.

Best,
Janine

-----Urspr=C3=BCngliche Nachricht-----
Von: Stefan Hajnoczi <stefanha@gmail.com>=20
Gesendet: Donnerstag, 23. April 2020 12:41
An: janine.schneider@fau.de
Cc: qemu-devel <qemu-devel@nongnu.org>; qemu block =
<qemu-block@nongnu.org>
Betreff: Re: Integration of qemu-img

On Thu, Apr 23, 2020 at 11:20 AM <janine.schneider@fau.de> wrote:
> this requires the user of the application to install qemu first right?
> If this is the case then this is unfortunately not an option. The user =

> shall not be bothered with installing anything else then the tool.

Hi Janine,
Please use Reply-All to keep the email CC list in tact.  That way =
qemu-devel@nongnu.org will receive our replies and the discussion will =
stay on the mailing list.  Thanks!

It's common for applications to consist of more than a single executable =
file.  They could have shared libraries, data files, or other =
executables like qemu-img.exe.  You can distribute qemu-img.exe together =
with your application as part of a zip file or installer.

Regardless of whether you ship qemu-img.exe or build a library, please =
check QEMU's software license so that you can follow the terms of the =
GPL open source license.

Stefan


