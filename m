Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9E5C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:56:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B02221743
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 15:56:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B02221743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgAHF-0007MU-9u
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 11:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50120)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <antonio.ospite@collabora.com>) id 1hgAG2-0006Tc-6Q
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:54:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <antonio.ospite@collabora.com>) id 1hgAG0-0004Gi-8J
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:54:50 -0400
Received: from bhuna.collabora.co.uk ([2a00:1098:0:82:1000:25:2eeb:e3e3]:33486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <antonio.ospite@collabora.com>)
 id 1hgAFy-0004D0-JC
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 11:54:48 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) (Authenticated sender: ao2)
 with ESMTPSA id DFD6B260A1E
To: Laurent Vivier <laurent@vivier.eu>, Antonio Ospite <ao2@ao2.it>,
 qemu-devel@nongnu.org
References: <20190526144747.30019-1-ao2@ao2.it>
 <adce6062-9289-afe8-b26a-949144700656@collabora.com>
 <4d4588e3-b804-7774-756a-3c8092fe732f@vivier.eu>
From: Antonio Ospite <antonio.ospite@collabora.com>
Message-ID: <c6d6da5a-215f-4279-fe6a-c46dab5b31c7@collabora.com>
Date: Wed, 26 Jun 2019 17:54:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <4d4588e3-b804-7774-756a-3c8092fe732f@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1098:0:82:1000:25:2eeb:e3e3
Subject: Re: [Qemu-devel] [PATCH v3 0/2] configure: disallow spaces and
 colons in source path and build path
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
Cc: Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/06/19 17:50, Laurent Vivier wrote:
> Le 26/06/2019 =C3=A0 17:16, Antonio Ospite a =C3=A9crit=C2=A0:
>> On 26/05/19 16:47, Antonio Ospite wrote:
>>> Hi,
>>>
>>> Here is a v3 set to address
>>> https://bugs.launchpad.net/qemu/+bug/1817345
>>>
>>> CCing Laurent Vivier as the patch is going through the trivial-patche=
s
>>> branch.
>>>
>>
>> Ping.
>>
>> I cannot see this in the trivial-patches repository nor in mainline qe=
mu.
>>
>=20
> I missed it because you didn't cc: qemu-trivial ML (I use this list to
> pick up the patches).
>

Ah yes, I had read that on
https://wiki.qemu.org/Contribute/TrivialPatches
but then forgot about it.

> I'm going to add them to the next pull request.
>=20
> Thanks,
> Laurent
>=20

Thank you,
    Antonio

