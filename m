Return-Path: <SRS0=rME2=S5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE22C43218
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 17:58:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E666204EC
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Apr 2019 17:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E666204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34847 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hKRaP-0007kH-8t
	for qemu-devel@archiver.kernel.org; Sat, 27 Apr 2019 13:58:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKRZb-0007R7-Po
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1hKRZa-000630-QL
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:57:15 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:48320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hKRZa-0005zx-Ix
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 13:57:14 -0400
Received: from localhost (localhost [127.0.0.1])
	by hera.aquilenet.fr (Postfix) with ESMTP id 8BCA83E3C;
	Sat, 27 Apr 2019 19:57:10 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
	by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2xjTdYqlWQMd; Sat, 27 Apr 2019 19:57:10 +0200 (CEST)
Received: from function (105.251.129.77.rev.sfr.net [77.129.251.105])
	by hera.aquilenet.fr (Postfix) with ESMTPSA id 0300F3E35;
	Sat, 27 Apr 2019 19:57:09 +0200 (CEST)
Received: from samy by function with local (Exim 4.92)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1hKRZU-0001bM-Nf; Sat, 27 Apr 2019 19:57:08 +0200
Date: Sat, 27 Apr 2019 19:57:08 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Kamil Rytarowski <n54@gmx.com>
Message-ID: <20190427175708.76nq4w2mdexb4gkp@function>
References: <20190427163007.5113-1-samuel.thibault@ens-lyon.org>
	<20190427163007.5113-3-samuel.thibault@ens-lyon.org>
	<73079d95-cf99-e0e3-c464-4568622f0008@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <73079d95-cf99-e0e3-c464-4568622f0008@gmx.com>
Organization: I am not organized
User-Agent: NeoMutt/20170113 (1.7.2)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a0c:e300::1
Subject: Re: [Qemu-devel] [PATCHv3 1/2] ui/curses: Do not assume wchar_t
 contains unicode
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: kamil@netbsd.org, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190427175708.rsAPQU8kTaVhtmsj44dVdmqgZpVzbJdJ1ivHVOeJxvM@z>

Kamil Rytarowski, le sam. 27 avril 2019 19:36:40 +0200, a ecrit:
> On 27.04.2019 18:30, Samuel Thibault wrote:
> > E.g. BSD and Solaris even use locale-specific encoding there.
> > 
> > We thus have to go through the native multibyte representation and use
> > mbtowc/wctomb to make a proper conversion.
> > 
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> 
> Both patches work for me on NetBSD/amd64 8.99.37 for qemu-system-x86_64.
> Borders are printed correctly.
> 
> Regarding the patch I'm not sure whether to use MB_LEN_MAX or MB_CUR_MAX?

I don't know if qemu can afford VLA?

> I'm also unsure whether to reset conversion state between a multibyte
> character and wide character, with: `mbtowc(NULL, 0, 0);`. It's
> recommended to use in code examples examples. I think it doesn't make
> any harm to use it.

Mmm, better yet, we should actually use mbrtowc and wcrtomb. I have
fixed this in my tree.

> I'm not sure if this is related, but "qemu-system-hppa -curses" is
> broken for me. I didn't use it in the past as it just recently acquired
> NetBSD guest support.
> 
> (lldb) bt
> libcurses.so.7`mvwadd_wchnstr(win=0x0000000000000000, y=<unavailable>,
> x=<unavailable>, wchstr=0x00007f7fffffe020, n=0) at add_wchstr.c:123
>   * frame #2: 0x000000000078629e
> qemu-system-hppa`curses_update(dcl=0x00007f7ff7bd8bc0, x=0, y=0, w=79,
> h=24) at curses.c:86:9
>     frame #3: 0x0000000000753dae
> qemu-system-hppa`dpy_text_update(con=0x00007f7ff7bae580, x=0, y=0, w=79,

> (lldb) p screenpad
> (WINDOW *) $2 = 0x0000000000000000

I don't think this is related at all, screenpad management is another
matter.

Samuel

