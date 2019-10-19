Return-Path: <SRS0=F+Q9=YM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DF1CA9EAB
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:54:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295D121925
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Oct 2019 15:54:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295D121925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57498 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLr3u-0005wI-5l
	for qemu-devel@archiver.kernel.org; Sat, 19 Oct 2019 11:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iLr2i-0004TY-0a
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iLr2g-0004yo-Os
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:53:23 -0400
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:51197)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iLr2g-0004y3-JG
 for qemu-devel@nongnu.org; Sat, 19 Oct 2019 11:53:22 -0400
Received: from player772.ha.ovh.net (unknown [10.108.35.124])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 1445E1E4E04
 for <qemu-devel@nongnu.org>; Sat, 19 Oct 2019 17:53:19 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 91104B258CEB;
 Sat, 19 Oct 2019 15:53:13 +0000 (UTC)
Subject: Re: qemu/powernv: coreboot support?
To: "Marty E. Plummer" <hanetzer@startmail.com>
References: <20191018172622.kz4smemh5cwesfit@proprietary-killer>
 <21ba3404-dcd3-fe06-7725-d58e249f9fd2@kaod.org>
 <20191019153108.gkupn3tnihspq7th@proprietary-killer>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1cbd1882-15c8-5471-cd65-1c84c2920ba8@kaod.org>
Date: Sat, 19 Oct 2019 17:53:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191019153108.gkupn3tnihspq7th@proprietary-killer>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 3562065834511207379
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkedugddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.39.161
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
Cc: Joel Stanley <joel@jms.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/10/2019 17:31, Marty E. Plummer wrote:
> On Sat, Oct 19, 2019 at 03:46:59PM +0200, C=C3=A9dric Le Goater wrote:
>> On 18/10/2019 19:28, Marty E. Plummer wrote:
>>> Hello,
>>>
>>> First off, thank you for the work you've done on the ppc64 support, i=
t
>>> has been very useful. I'm currently working on a coreboot port for th=
e
>>> talos ii line of systems (which means more ppc64 support, support
>>> specifically for the power9 sforza chip, and specific mainboard suppo=
rt.
>>> My plate is very full lol) and have been using qemu to debug the
>>> bootblock.
>>>
>>> It has been very useful for that, but I'm now at the point where I ne=
ed
>>> to jump to romstage, and that's where it gets tricky. qemu parses the=
 rom
>>> image and looks for a ffs header, locates skiboot on it, and jumps st=
raight
>>> to that. Not exactly ideal for debugging something not produced from =
op-build.
>>
>> yes. I suppose you are using my branch powernv-4.2 which adds PNOR sup=
port
>> and a way to boot directly from PNOR. In that case, QEMU parses the PN=
OR
>> file to extract the PAYLOAD partition (skiboot). skiboot also detects =
the
>> flash and extract the kernel and initramfs from the PNOR.
>>
>> However, you can bypass all this internal boot process by simply passi=
ng
>> a -bios option and not passing a MTD device.
>>
> Doing so gives me the following error:
> qemu-system-ppc64: Could not load OPAL firmware 'build/coreboot.rom'
> (this is after I patched the 4mb size limit up)

Could you make that rom available ?=20

Thanks,

C.=20

