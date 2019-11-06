Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC93C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B96F2178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 16:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B96F2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSO3N-0007Ls-Ik
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 11:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iSO1L-0005n9-1k
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iSO1J-0004tu-Od
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 11:18:58 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:60583)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iSO16-0004eV-F6; Wed, 06 Nov 2019 11:18:44 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MlbPO-1i1GRu0zdy-00io0J; Wed, 06 Nov 2019 17:18:00 +0100
Subject: Re: [Xen-devel] [PULL v2 0/3] Trivial branch patches
To: Peter Maydell <peter.maydell@linaro.org>
References: <157298160814.27285.16893877491189017648@37313f22b938>
 <73852c81-87b7-e5f5-4041-d24f078cc7fa@vivier.eu>
 <CAFEAcA8SvSGCZsYT1LmN1cP1BjVDPqLP90yW9TCbvVA=kmyqBw@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <98bf5ee2-7897-0b42-c88e-f71e6623cb50@vivier.eu>
Date: Wed, 6 Nov 2019 17:17:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8SvSGCZsYT1LmN1cP1BjVDPqLP90yW9TCbvVA=kmyqBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qtbzbGDMbOiX07//Csg2bwvslFqpUcHtBOnifLrjl6D5ZjvpYN/
 BEo/MB6k1/UHjQf10F3oyBj0+nQR0S92+dC3WtK426o2Gweuhj292GOgx3P//zJkB54a2CY
 spIW/HS6fdps62Y2taYht2R8R7zZWiAKxs7VueyoXckGI8/h3kcq8H5BnYuPj993VpqNJOI
 +Bhf6Vpkq8ULz9GriCYog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mXe145y9FDM=:+dJcVURXF2BN/wYb9jAvmt
 RuDAV/IFZzQ+vUPzvqhWWA7Vu3hI/Sbp82KBAS8yLBzUyhY6qnC2o9izTsPgI3V7OkPbvQB0U
 b/a4czyZurXxxbd7Iu5afwnGwU1gu8IbVA1qG5gV//FB+jfTOH00trbiXpihg5eiC7DMIdmIY
 7DwqMTbBHhbj20cv/pCHci5hLoUEuhmdhhvVneTM898vvHebq1MftGr0E/szVZY5iYNcK8q1g
 +Rp8/QZvqu8BODtiKfXoz9IuDDoHMZcrjomv4YgEAK8E4iJ4Pj0CeoZMsj0ajzkIyrHe8bkLo
 zDxSk/Ah8W3DiHbpT79HQyhKdFhl4QZxyp+EM/d1vkfDd85r92ZdtaIaPiHFD0PHfRse+89vx
 ycMOJq0CByOMoQQiBFUER/0StbDkqH4VWRVXMRCNm76IbMzE3bm4lDaaTWBdLs8myIlvtf60E
 zSkmVW7864lkZ0BXfHurdCKhMRTwJPTMr3aeSSMfBmsWEiEB9vUDTPxUGK7T+JaaidlDtl06U
 HPHZ837pW6FvR1PnAxMXhDrL7gu0Yt0kSU5nag1/khO1rVEe2MfJBbL2kVwyQshMP9xzr+h1R
 qHqOLnq/TOvyeyXQTJTDPJoe85h/o2T1L1/FIz6woVMSgRR1gJ9YOuoTEcb+4BcI7AazmffYK
 DjfSZVUaJGbnrjprLZdNcqgTU0lSKyNqsh6eVO5P418sz2CsreGOcMSRzrUJbt8y38Z1M+Oj4
 ktkzs53tIPi7eejjkryH/qbOzSOJVXsjhjRr8WQf6pE6LKwxhS8TKkRnGDAmDrv0w9dWWqav4
 N59xbM9yWLd6YBxD53dvmikRxLGTOIfbx29QgbDeV3iWYEdvHLeSv4kuqgzrr3MZuwtzgq17w
 03wsRy5d9QfvlvsiF4v77H4Q84KJexy9k17IRWDMY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 Claudio Fontana <claudio.fontana@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Cleber Rosa <crosa@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 06/11/2019 à 17:05, Peter Maydell a écrit :
> On Tue, 5 Nov 2019 at 20:06, Laurent Vivier <laurent@vivier.eu> wrote:
>>
>> Le 05/11/2019 à 20:20, no-reply@patchew.org a écrit :
>>> Patchew URL: https://patchew.org/QEMU/20191105175010.2591-1-laurent@vivier.eu/
>>>
>>>
>>>
>>> Hi,
>>>
>>> This series seems to have some coding style problems. See output below for
>>> more information:
>>>
>>> Subject: [Xen-devel] [PULL v2 0/3] Trivial branch patches
>>> Type: series
>>> Message-id: 20191105175010.2591-1-laurent@vivier.eu
>>>
>>> === TEST SCRIPT BEGIN ===
>>> #!/bin/bash
>>> git rev-parse base > /dev/null || exit 0
>>> git config --local diff.renamelimit 0
>>> git config --local diff.renames True
>>> git config --local diff.algorithm histogram
>>> ./scripts/checkpatch.pl --mailback base..
>>> === TEST SCRIPT END ===
>>>
>>> Switched to a new branch 'test'
>>> 49a55f7 global: Squash 'the the'
>>> c0b5513 hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses
>>> eb43395 hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to PnP registers
>>>
>>> === OUTPUT BEGIN ===
>>> 1/3 Checking commit eb43395bf8f1 (hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to PnP registers)
>>> 2/3 Checking commit c0b5513f971a (hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses)
>>> 3/3 Checking commit 49a55f7feb19 (global: Squash 'the the')
>>> ERROR: do not use C99 // comments
>>> #26: FILE: disas/libvixl/vixl/invalset.h:105:
>>> +  // Note that this does not mean the backing storage is empty: it can still
>>
>> As reported by David Gilbert, this is a false positive as this file is a
>> C++ file.
> 
> True, but it's also a third-party dependency that we have
> taken a copy of. If we care about fixing its typos in comments
> we should do that by submitting the fixes upstream. We should
> avoid making changes to our local copy of this code because
> it just makes it unnecessarily more difficult to do updates to
> newer versions.
> 
> Could you drop that change, please? (Sorry I didn't notice
> it going by when the patch was originally on list.)

Sure.

Thanks,
Laurent


