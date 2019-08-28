Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5C4C3A5A3
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 00:27:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D64AC20856
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 00:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D64AC20856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2loT-00020J-0e
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 20:27:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i2lnk-0001ZH-9A
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 20:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i2lni-0006An-LL
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 20:27:03 -0400
Received: from esa2.mentor.iphmx.com ([68.232.141.98]:42402)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i2lni-00068s-9t
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 20:27:02 -0400
IronPort-SDR: T+hjhpdWbTMjEV61ZewG7aTBxyqsLSXlhGhCx97T1FbyfC4B8ozGhik2Mu8Y4iAwjKDSI9VBmb
 yedei7gjeNgHA2XmpDuULJ/gbvPmf0sHY5pLRA6Y1VhxjhfyOForIhWWPHREgvvPBOb0GuRLBk
 eU7I+6c/8CZOmj/E7NBKMqnaEQCwfJV7d9q8Tc03xWkceMzY7aGl0+qZVX0GUmpmy7KmD2Bv40
 IanVVsbhw9E+I0lvQvSZ0pzObKWilmt4suUVIdZSF9cgp0Te4vNn2ozgCEjijX8JHdAsjqlTAY
 byE=
X-IronPort-AV: E=Sophos;i="5.64,439,1559548800"; d="scan'208";a="40787713"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa2.mentor.iphmx.com with ESMTP; 27 Aug 2019 16:26:59 -0800
IronPort-SDR: GWnyFRCs7PNLSoQuOGByVK7R8MlTkoXNtXgQbW6dVbQkv6+OM2sPQpm4SvB8vA/2M0XrqVv1DA
 zyfEX9qrs+3nY3cHRP+yzCkYz+lPEMDjQo4dm2ogDS21zJD0YuYYBs/lDxFH+/IPHt7eXTAKtC
 dsoQsc3eYZB1YzKhLpnn41lDP49sITa+0Hc8dQOGBMTsaL6uTDqcu871Q0avu/RaAomA226FZg
 QdI6MYVpodNoAJJbCj1LcFS4Q9K5dJyyPmcbIxxGhjBbs2yNMjXoGCT72ec419JnKt3IXhBfYG
 0Oo=
To: QEMU Developers <qemu-devel@nongnu.org>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <81a8c0ca-c5fb-fc3d-cc7b-00c4da31d621@codesourcery.com>
Date: Tue, 27 Aug 2019 18:26:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: svr-orw-mbx-02.mgc.mentorg.com (147.34.90.202) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.141.98
Subject: [Qemu-devel] libvhost-user: undefined reference to MADV_NOHUGEPAGE
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

Yesterday I tried to build the recent 4.1 release system-mode QEMU for 
aarch64-none-elf and ran into a compilation error in 
./contrib/libvhost-user/libvhost-user.c.  It's complaining about 
MADV_NOHUGEPAGE not being defined.  I'm not familiar with that code or 
even what it does; should that bit of logic be made conditional on 
MADV_NOHUGEPAGE being defined, or is this indicative of a configuration 
error for this target?  I see the unguarded reference was also present 
in the 3.0 release so it seems like whatever changed is somewhere else, 
and I don't know where to look for it or what I should be looking for. 
:-S  Does this sound familiar to anyone else?

-Sandra


