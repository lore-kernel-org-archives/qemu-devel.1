Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C584C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2005F2082C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=me.com header.i=@me.com header.b="ihcluXrj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2005F2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58702 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb0q7-0004Hm-47
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 06:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58454)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <tgfbeta@me.com>) id 1hb0nO-0002to-ON
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:47:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tgfbeta@me.com>) id 1hb0nN-0002SW-M1
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:47:58 -0400
Received: from pv50p00im-ztdg10011301.me.com ([17.58.6.40]:36315)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tgfbeta@me.com>) id 1hb0nN-0002Qb-Fz
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=04042017;
 t=1560336473; bh=GCeCm8uQLWsGH/B+sA1wnoOgD7Gg/RvGEeF7f+1x67g=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=ihcluXrjjb1ApP5zHjE9pUclyXFNENzUY3ldEwF8bsekuuKTw2v0Hr+BqBrPQcbY4
 I4fHRinioj8kck7Ia8leKAlv3ZTqDzjmzPkLRUL361+vztU8ZT9EqqPsMbHpa7JMAv
 h0IcX4TnWBymKSnJFfUtdF/818H7reoIUcnfTKj05LHDTZXaljSU7k7WuScQ9UEtJD
 XaGOXNRdW6lp53zABdYHOITj5XkqW4y2JRaQAUjL6eQ824oNIy77CiVv0lNnAIWsUp
 4JM2p5vq7lCMCKae5AWntQBK+VsXNI0YxQ+FWQC3W6vSNmkVZnXi1iaa119waqtJUd
 fdmuPuiNehMMQ==
Received: from [172.18.2.102] (unknown [36.106.167.139])
 by pv50p00im-ztdg10011301.me.com (Postfix) with ESMTPSA id 3ECC1640336;
 Wed, 12 Jun 2019 10:47:52 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
In-Reply-To: <CAFEAcA_=A3w490ey9_EyO7gJ1PRjs4L+aRtNPGzx-L7XyGVmZg@mail.gmail.com>
Date: Wed, 12 Jun 2019 18:47:49 +0800
Content-Transfer-Encoding: quoted-printable
Message-Id: <A97EF5AC-945D-4698-B328-BDE53097934B@me.com>
References: <B3540B0C-9A71-4733-8109-11B0DC7A17D2@me.com>
 <CAFEAcA_=A3w490ey9_EyO7gJ1PRjs4L+aRtNPGzx-L7XyGVmZg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-12_06:, , signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1812120000 definitions=main-1906120075
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 17.58.6.40
Subject: Re: [Qemu-devel] [PATCH 0/2] ui/cocoa: Fix input device issues on
 Mojave
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
From: Chen Zhang via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Chen Zhang <tgfbeta@me.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you and best regards.

> On Jun 12, 2019, at 6:39 PM, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>=20
> On Tue, 4 Jun 2019 at 10:34, Chen Zhang <tgfbeta@me.com> wrote:
>>=20
>> The following patches fixed issues of absolute and relative input =
devices
>> on macOS Mojave.
>>=20
>> Chen Zhang (2):
>>  ui/cocoa: Fix absolute input device grabbing issue on Mojave
>>  ui/cocoa: Fix mouse grabbing in fullscreen mode for relative input
>>    device
>>=20
>> ui/cocoa.m | 50 +++++++++++++++++++++++++++++++++++++++++++++++---
>> 1 file changed, 47 insertions(+), 3 deletions(-)
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> I'll apply these to master some time this week.
>=20
> thanks
> -- PMM


