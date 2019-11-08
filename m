Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FEC3FC6198
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:58:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34F4B21924
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J8M/yhfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34F4B21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT2uc-00048v-3q
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:58:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iT2tc-00031f-Ls
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:57:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iT2tb-0001i8-1A
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:57:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iT2ta-0001hT-Ge
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573214262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+CH2HLhz6DBRWMYnJPD/YsNushQ4vNHkoF8e19i+C38=;
 b=J8M/yhfU/3jfOQMQj0E9rzw+PDoGx4Qu+xB4B/CFWYZ+buj31scSGwMQYJzpB5p7GucKeJ
 z70cl8zcqNwj0pTs0cGBfMQ1LXVYshYDKpllwoq9bCKrYvUXJhrzslxD5uUr9JJbD1fpri
 9EeWMoUP/Bv75WV1r1VMNvwvcIRXDTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-Y_-SDIisORe-68iP8-cUcQ-1; Fri, 08 Nov 2019 06:57:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8D18B477;
 Fri,  8 Nov 2019 11:57:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-167.ams2.redhat.com
 [10.36.116.167])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B76BC6084E;
 Fri,  8 Nov 2019 11:57:33 +0000 (UTC)
Subject: Re: [PATCH] configure: Check bzip2 is available
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
References: <20191108102805.8258-1-philmd@redhat.com>
 <862eb773-609d-4250-b46b-d922fc5a86a7@redhat.com>
 <7bfff1ec-927e-fb75-645f-7b0bb0ffd916@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7a712518-2447-271d-cd30-bed0aaffc53c@redhat.com>
Date: Fri, 8 Nov 2019 12:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <7bfff1ec-927e-fb75-645f-7b0bb0ffd916@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Y_-SDIisORe-68iP8-cUcQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-trivial@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 08/11/2019 12.54, Philippe Mathieu-Daud=C3=A9 wrote:
> On 11/8/19 12:01 PM, Laszlo Ersek wrote:
>> On 11/08/19 11:28, Philippe Mathieu-Daud=C3=A9 wrote:
>>> The bzip2 tool is not included in default installations.
>>> On freshly installed systems, ./configure succeeds but 'make'
>>> might fail later:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 BUNZIP2 pc-bios/edk2-i386-secure-code.fd.bz2
>>> =C2=A0=C2=A0 /bin/sh: bzip2: command not found
>>> =C2=A0=C2=A0 make: *** [Makefile:305: pc-bios/edk2-i386-secure-code.fd]=
 Error 127
>>> =C2=A0=C2=A0 make: *** Deleting file 'pc-bios/edk2-i386-secure-code.fd'
>>> =C2=A0=C2=A0 make: *** Waiting for unfinished jobs....
>>>
>>> Add a check in ./configure to warn the user if bzip2 is missing.
>>
>> We've come full circle. Let me explain:
>>
>>>
>>> Fixes: 536d2173b2b
>>
>> So this makes me kinda grumpy. If you look at the v3 posting of the=20
>> patch that would later become commit 536d2173b2b:
>>
>> =C2=A0=C2=A0 http://mid.mail-archive.com/20190321113408.19929-8-lersek@r=
edhat.com
>>
>> you see the following note in the changelog:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0 - compress FD files with bzip2 rather than xz, =
so that=20
>> decompression at
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "make install" time succeed on olde=
r build OSes too [Peter]
>>
>> So I couldn't use xz because that was "too new" for some build OSes,=20
>> but now we also can't take bzip2 for granted because that's "too old"=20
>> for some other build OSes? This is ridiculous.
>>
>> To be clear, my disagreement is only with the "Fixes" tag. For me,=20
>> "Fixes" stands for something that, in retrospect, can be proven to=20
>> have been a bug at the time the code was *originally* committed. But,=20
>> at the time, taking "bzip2" for granted was *not* a bug. The=20
>> conditions / circumstances have changed more recently, and the=20
>> assumption about bzip2 has been invalidated *after* adding a=20
>> dependency on bzip2.
>>
>> Nonetheless, thank you for adapting the code to the potential absence=20
>> of bzip2. Can you perhaps go in some details in the commit message,=20
>> near "not included in default installations" and "freshly installed=20
>> systems"? If we can, we should identify the exact distro release where=
=20
>> this problem has been encountered (and I wouldn't mind a link to the=20
>> BZ or ticket under which people agreed to remove bzip2 from the=20
>> default package set).
>=20
> I am just reading this and already sent a v2.
>=20
> I can amend these details. Thomas, what distro release were you using?

I encountered this problem with a freshly installed Fedora 31.

  Thomas


