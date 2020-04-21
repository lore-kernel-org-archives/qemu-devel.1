Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE4BC54FC9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:57:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F9C72076C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 12:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F9C72076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tls.msk.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQsT2-0004sa-CF
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 08:57:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43126)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mjt@tls.msk.ru>) id 1jQsST-0004JJ-CO
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:57:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <mjt@tls.msk.ru>) id 1jQsSS-0004eE-Ci
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:57:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231]:54461)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1jQsSR-0004XA-TB
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 08:57:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C791240230;
 Tue, 21 Apr 2020 15:56:48 +0300 (MSK)
Received: from [192.168.177.99] (mjt.vpn.tls.msk.ru [192.168.177.99])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7559C28E;
 Tue, 21 Apr 2020 15:53:27 +0300 (MSK)
Subject: Re: SLiRP: use-afte-free in ip_reass() [CVE-2020-1983]
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
References: <CAP+75-UisNwFqedDPfuGt=HFEEnPSO7sNq9JxpUuLPVdYDryuw@mail.gmail.com>
 <CAJ+F1C+YnbgCkYN1+7zpq0XvZYb2LWL6kbQXRSybJew1JnBgQQ@mail.gmail.com>
 <20200421103307.GB479771@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <7d5f9b13-0181-bd82-a643-a62f19f4c9d0@msgid.tls.msk.ru>
Date: Tue, 21 Apr 2020 15:56:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421103307.GB479771@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 08:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 86.62.121.231
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.04.2020 13:33, Daniel P. Berrangé wrote:
[]
> Admittedly this may be troublesome for Debian which, AFAICT, does not
> add new packages to pre-existing stable releases. Presumably someone
> can add it to the "backports" release archive if this is too hard to
> get into a stable release ? Failing that, users would have to build
> slirp themselves.

This wont be a problem for Debian really, exactly due to the reason you
mentioned - backports.  I'm backporting libslirp and current qemu right
now.

Thanks!

/mjt

