Return-Path: <SRS0=ZS6r=2E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19CAC43603
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7D1207FD
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2019 21:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlOUriSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7D1207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igFIx-0004KE-L2
	for qemu-devel@archiver.kernel.org; Sat, 14 Dec 2019 16:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56841)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1igFHp-0003Os-GV
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1igFHm-0002YT-5G
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:49:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49985
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1igFHl-0002Tv-D3
 for qemu-devel@nongnu.org; Sat, 14 Dec 2019 16:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576360150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NDnGu7MH1eazR7aSbLsFxM1nr0iH1ef2xF6tB7Dw+dM=;
 b=DlOUriSAi3B23YQstLvdEVMz56FGoSG5EhCuyZqZXCEnS/P3dhth4JnzLkMP1VFaX9/qoK
 L6D56bF8SuC5FKPZYsKREnUo17cgE6KYABnAqcIsCTO4WAFgSVC44xRZNCiwxMpzenTsKp
 sC/08Xk7tfK+t8sLdGWXACkUx73SuvU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-kBFTSTr3P_m9Yb1UDrtp8A-1; Sat, 14 Dec 2019 08:46:11 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA0B2107ACC4;
 Sat, 14 Dec 2019 13:46:08 +0000 (UTC)
Received: from [10.3.116.171] (ovpn-116-171.phx2.redhat.com [10.3.116.171])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 518245D9CA;
 Sat, 14 Dec 2019 13:46:00 +0000 (UTC)
Subject: Re: [PATCH 00/10] Fixes for DP8393X SONIC device emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Finn Thain <fthain@telegraphics.com.au>, qemu-devel@nongnu.org
References: <157628778601.20418.17236421597625110152@37313f22b938>
 <alpine.LNX.2.21.1.1912141345460.18@nippy.intranet>
 <b8c42c79-ed61-031d-a7f7-0af82992bd85@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <b73284e3-b6e7-1e4d-0d93-6cdcdd0f2ae9@redhat.com>
Date: Sat, 14 Dec 2019 07:45:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b8c42c79-ed61-031d-a7f7-0af82992bd85@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: kBFTSTr3P_m9Yb1UDrtp8A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: jasowang@redhat.com, qemu-stable@nongnu.org, laurent@vivier.eu,
 hpoussin@reactos.org, Paolo Bonzini <pbonzini@redhat.com>,
 aleksandar.rikalo@rt-rk.com,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/14/19 7:38 AM, Philippe Mathieu-Daud=E9 wrote:
> On 12/14/19 3:52 AM, Finn Thain wrote:
>> On Fri, 13 Dec 2019, no-reply@patchew.org wrote:
>>
>>> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
>>> 1/10 Checking commit 9c9ffc38e9b9 (dp8393x: Mask EOL bit from=20
>>> descriptor addresses)
>>> ERROR: return is not a function, parentheses are not required
>>> #24: FILE: hw/net/dp8393x.c:200:
>>> +=A0=A0=A0 return (s->regs[SONIC_URDA] << 16) | (s->regs[SONIC_CRDA] &=
=20
>>> 0xfffe);
>>>
>>> ERROR: return is not a function, parentheses are not required
>>> #33: FILE: hw/net/dp8393x.c:220:
>>> +=A0=A0=A0 return (s->regs[SONIC_UTDA] << 16) | (s->regs[SONIC_TTDA] &=
=20
>>> 0xfffe);
>>>
>>
>> I expect that checkpatch.pl has no idea about operator precedence, but
>> these parentheses could actually be omitted.

You are correct: It's a false positive; you can safely ignore it.

>>
>> I kept them because I don't want readers to have to remember that bit
>> shift operator has higher precedence than bitwise OR operator, or look i=
t
>> up if they don't.
>>
>> The existing code also has those unnecessary parentheses.
>>
>> Please let me know if this patch should include a code style change.
>=20
> This is a bug in checkpatch. Since this script doesn't have dedicated=20
> maintainer, I Cc'ed the recent contributors:

However, it's complex enough, and the false positive occurs infrequently=20
enough, that just ignoring it (instead of trying to patch checkpatch) is=20
also fine, and probably what will happen.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


