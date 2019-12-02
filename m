Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B591C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:26:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6714D2070A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 12:26:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E5FilmSP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6714D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibkmM-0007KV-Ja
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 07:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50229)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ibkkq-0006Ir-0h
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:24:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ibkko-0000Zt-UA
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:24:39 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55324
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ibkko-0000Zh-Ox
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 07:24:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575289478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=dJqesagg6FULKKG5MoD3l4XrwKOA75C+QjFtvY5P9a4=;
 b=E5FilmSP0ZyRC5WwWzBIvHNDk2Cn9h4lfO/JPII9G//6IejAnHnvEw1TKZ6G+FOPq+5Pvo
 0dICUyY30qCSUmBfg+XcJ4OxX1uB3DrhwrznBlQTnF5IOMK89tHUJode007+vj39R5mDy1
 Z3pjY8K9cxcrA8QJN7pTD/TkBzDkn5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-TYljiNh_PpGdE1ikPwWynQ-1; Mon, 02 Dec 2019 07:24:35 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19E63107ACC5;
 Mon,  2 Dec 2019 12:24:34 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-196.ams2.redhat.com [10.36.117.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E1D7867E56;
 Mon,  2 Dec 2019 12:24:27 +0000 (UTC)
Subject: Re: iPXE: update submodule
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <d33644db-ec7e-0b51-b6e6-b5fc15f37665@redhat.com>
 <20191202121853.shigtyrko725vmmg@sirius.home.kraxel.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <18fec111-73cd-5d32-3681-b3dd76be7661@redhat.com>
Date: Mon, 2 Dec 2019 13:24:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191202121853.shigtyrko725vmmg@sirius.home.kraxel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: TYljiNh_PpGdE1ikPwWynQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02/12/2019 13.18, Gerd Hoffmann wrote:
> On Mon, Dec 02, 2019 at 12:19:50PM +0100, Philippe Mathieu-Daud=C3=A9 wro=
te:
>> Hi Gerd,
>>
>> 'make -C roms efirom' is failing on Fedora 30.
>>
>> Can you update the iPXE submodule so we get these buildsys commits:
>>
>> c742c576 [build] Move predefined all-drivers build shortcut to Makefile
>> a4f8c6e3 [build] Do not apply WORKAROUND_CFLAGS for host compiler
>> 1dd56dbd [build] Workaround compilation error with gcc 9.1
>> 412acd78 [build] Fix "'%s' directive argument is null" error
>=20
> Hmm.  Sure, can do that, but the question is for 4.2 or 5.0.  Updating
> ipxe that close to the release makes me nervous, but shipping a ipxe
> version which doesn't build with recent compilers in the release tarball
> isn't great either.
>=20
> I'd tend to go the 5.0 route.
> Comments?
> Suggestions?

I think the average users don't rebuild the rom binaries on their own
from the release tarballs ... so IMHO this should rather go into 5.0.
Just my 0.02 =E2=82=AC of course.

 Thomas


