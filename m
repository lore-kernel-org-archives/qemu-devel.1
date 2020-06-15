Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8951C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8A562074D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="kcPkMJKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A562074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ciriminna.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkorv-00014d-TN
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 09:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dario@ciriminna.com>)
 id 1jklMx-0007Td-WC
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:25:32 -0400
Received: from smtpcmd01-g.aruba.it ([62.149.158.217]:37953)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dario@ciriminna.com>) id 1jklMv-0003Ge-Eu
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 05:25:31 -0400
Received: from [192.168.0.2] ([93.48.24.41])
 by smtpcmd01.ad.aruba.it with bizsmtp
 id rMRS2200F0tBuBh01MRSaT; Mon, 15 Jun 2020 11:25:26 +0200
Subject: Re: qemu win10 host winxp quest very slow
References: <127ef1aa-bcb3-835d-21ba-0918bb62b0f8@ciriminna.com>
To: qemu-devel@nongnu.org
From: Dario Ciriminna <dario@ciriminna.com>
Message-ID: <7b540837-07d9-e0f3-e285-0e84d610c2b6@ciriminna.com>
Date: Mon, 15 Jun 2020 11:25:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <127ef1aa-bcb3-835d-21ba-0918bb62b0f8@ciriminna.com>
Content-Type: multipart/mixed; boundary="------------4EDF93D9B87261CE2A905D53"
Content-Language: it
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
 t=1592213126; bh=Z3VtQSCzMCYXgpSpebk69Sp5NZrs9m/mmSDn3tbmLfQ=;
 h=Subject:To:From:Date:MIME-Version:Content-Type;
 b=kcPkMJKJW8FaWNgXdFh7rduNpXvEF2bjtqO5CReY0+p9vSM8u/FqPVh9xvmtMra+2
 YA/bg/Xl9K3lqEiQD2gHxndPJfn6fLRNHJSSnuydxN81unij/u1ONBeV0u3nt0gswl
 bEHQG7VgBbaBoaSayiLJWBd2z4RXi1WdACu/q14eVgNSlOZKP0QBGBn5iBnvwZ4ful
 y195JMuss0IrjhrCCaapKHjhpIJajeYlh2Eil21BHsWamneg02F7oohuBLVcGdkkNc
 fKvNS7EU7kbdEwIf8yBoBVkbLdh7BTWubbIfYtZyWhVRR/LGiRazkjzJ+OhQ1FvKhp
 2e9dhqR/LjaXw==
Received-SPF: pass client-ip=62.149.158.217; envelope-from=dario@ciriminna.com;
 helo=smtpcmd01-g.aruba.it
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 04:57:21
X-ACL-Warn: Detected OS   = Linux 2.6.x
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 15 Jun 2020 09:08:41 -0400
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

This is a multi-part message in MIME format.
--------------4EDF93D9B87261CE2A905D53
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

I'm using v5.0.50 from the github repository.

See attached config.status

Il 15/06/2020 11:03, Dario Ciriminna ha scritto:
> Hello folks,
>
> i need to compile and run qemu under Windows 10 host (Pentium G860, 
> very bad)  with a Windows XP guest.
> Precompiled downloaded binary run smoothly, but my compiled version is 
> very very slow (I NEED to compile it).
>
> I start it with :
>
> "C:\Program Files\qemu\qemu-system-x86_64w.exe" .\WindowsXP.img -m 
> 1024M -usb -vga std -netdev user,id=n0 -device rtl8139,netdev=n0 -fda 
> .\ZSK_DSK.img -D .\qemu.log
>
> ah and -D .\qemu.log doesn't log nothing. 0k log file.
>
> What can i try ? 3 min to start Windows XP is unacceptable and after 
> start system run slow!
>
> Thanks for help
>
> Dario
>

--------------4EDF93D9B87261CE2A905D53
Content-Type: text/plain; charset=UTF-8;
 name="config.status"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="config.status"

#!/bin/sh
# Generated by configure.
# Run this file to recreate the current configuration.
# Compiler output produced by configure, useful for debugging
# configure, is in config.log if it exists.
unset AR
unset AS
unset CC
unset CPP
unset CXX
unset INSTALL
unset LD
unset LD_LIBRARY_PATH
unset LIBTOOL
unset MAKE
unset NM
unset OBJCOPY
PATH='/mingw64/bin:/usr/local/bin:/usr/bin:/bin:/c/Windows/System32:/c/Windows:/c/Windows/System32/Wbem:/c/Windows/System32/WindowsPowerShell/v1.0/:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl'
export PATH
unset PKG_CONFIG
unset PKG_CONFIG_LIBDIR
PKG_CONFIG_PATH='/mingw64/lib/pkgconfig:/mingw64/share/pkgconfig'
export PKG_CONFIG_PATH
unset PYTHON
unset SDL2_CONFIG
unset SMBD
unset STRIP
unset WINDRES
exec './configure' '--cross-prefix=x86_64-w64-mingw32-' '--enable-gtk' '--enable-sdl' '--target-list=x86_64-softmmu' '--disable-iconv' '--disable-debug-info' '--disable-docs' '--disable-libssh' '--disable-xen' "$@"

--------------4EDF93D9B87261CE2A905D53--

