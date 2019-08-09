Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F5DC31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:31:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55C11214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 13:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55C11214C6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4zX-00021M-FE
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 09:31:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59535)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mjt@tls.msk.ru>) id 1hw4yx-0001ap-2j
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mjt@tls.msk.ru>) id 1hw4yv-0008DR-PW
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:30:59 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:58347)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mjt@tls.msk.ru>) id 1hw4yv-00088t-IW
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 09:30:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 872CE40A07;
 Fri,  9 Aug 2019 16:30:45 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5B5413B2;
 Fri,  9 Aug 2019 16:30:45 +0300 (MSK)
To: Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <87r25vd5y1.fsf@dusky.pond.sub.org>
 <CAFEAcA-3X0s-mxaD27HWQa7ysiEb6Uo-BD+Yxo0QhBV_yb9WLA@mail.gmail.com>
 <CAFEAcA-e2aW33GeuganVSnu9epuqt57rnZ_KgEHwDNqrWrTHuA@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <e72a4fab-aefb-a1e5-9c91-27c6aa0fe893@msgid.tls.msk.ru>
Date: Fri, 9 Aug 2019 16:30:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-e2aW33GeuganVSnu9epuqt57rnZ_KgEHwDNqrWrTHuA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 86.62.121.231
Subject: Re: [Qemu-devel] Does i386-linux-user build on an i686 host?
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <Laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

09.08.2019 15:49, Peter Maydell wrote:
>>>   CC      i386-linux-user/linux-user/syscall.o
>>> /home/armbru/qemu/linux-user/ioctls.h:306:9: error: =E2=80=98SNDCTL_D=
SP_MAPINBUF=E2=80=99 undeclared here (not in a function)
>>>    IOCTL(SNDCTL_DSP_MAPINBUF, IOC_R, MK_PTR(MK_STRUCT(STRUCT_buffmem_=
desc)))
[]
> Further investigation shows that this is because the system has
> the 'oss4-dev' package installed, which diverts /usr/include/linux/soun=
dcard.h
> and installs its own version which doesn't provide all the symbols
> that the kernel one does.
>=20
> Easy fix: uninstall oss4-dev.

On debian we have qemu build-conflict with oss4-dev, exactly for this
very reason, - installing oss4-dev breaks qemu build.

Thanks,

/mjt

> Better fix: patch QEMU to provide its own versions of these constants
> if the system headers don't.
[]


