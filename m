Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12916C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1162488C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 14:44:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1162488C
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSLXL-00043c-Eq
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 10:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40232)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSLUJ-0000oq-Je
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:41:15 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:41965)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSLUD-0003Kb-PR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 10:41:14 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E60337475FF;
 Tue, 13 Oct 2020 16:41:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id A0A007475FE; Tue, 13 Oct 2020 16:41:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 9EB927475FA;
 Tue, 13 Oct 2020 16:41:06 +0200 (CEST)
Date: Tue, 13 Oct 2020 16:41:06 +0200 (CEST)
To: =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [PATCH 04/10] meson: option to build as shared library
In-Reply-To: <20201013075104.GA70612@redhat.com>
Message-ID: <e27acf2-4dbe-4674-78cc-67aa7b505c54@eik.bme.hu>
References: <20201012232939.48481-1-j@getutm.app>
 <20201012232939.48481-5-j@getutm.app> <20201013075104.GA70612@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-417889366-1602600066=:11522"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 10:41:07
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Joelle van Dyne <j@getutm.app>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-417889366-1602600066=:11522
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 13 Oct 2020, Daniel P. Berrangé wrote:
> On Mon, Oct 12, 2020 at 04:29:33PM -0700, Joelle van Dyne wrote:
>> From: osy <osy86@users.noreply.github.com>
>>
>> On iOS, we cannot fork() new processes, so the best way to load QEMU into an
>> app is through a shared library. We add a new configure option
>> `--enable-shared-lib` that will build the bulk of QEMU into a shared lib.
>> The usual executables will then link to the library.
>
> Note that QEMU as a combined work is licensed GPLv2-only, so if an app is
> linking to it as a shared library, the application's license has to be
> GPLv2 compatible. I fear that shipping as a shared library is an easy way
> for apps to get into a license violating situation without realizing.

Please don't let that be an obstacle in merging this series. They'll do it 
anyway as seen here so having it upstream is probably better than having a 
lot of different/divergent forks.

In case of UTM it seems to be licensed under Apache License 2.0:

https://github.com/utmapp/UTM/blob/master/LICENSE

which FSF says not compatible with GPLv2 but it is with GPLv3:

http://www.gnu.org/licenses/license-list.html#apache2

Not sure however if that's for using Apache licenced part in GPLv2 code or 
the other way around like in UTM in which case I think the whole work will 
effectively become GPLv3 as most parts of QEMU is probably GPLv2+ already 
or BSD like free that should be possible to combine with only files 
explicitely GPLv2 in QEMU remaining at that license and UTM parts are 
Apache 2.0 when separated from QEMU. I have no idea about legal stuff 
whatsoever but combining two free software components should be legal some 
way (otherwise it's not possible to combine GPLv2 with GPLv3 either).

I hope this does not turn into a legal bike shedding thread that results 
in finding out there are other than technical problems in the way to 
accept this series but the contrary, I'd say let the legal problems be 
handled by those using QEMU and don't reject patches based on maybe 
possible legal problems. Stating the licence clearly and maybe providing 
links to further resources to resolve licence problems in QEMU docs should 
be enough.

Regards,
BALATON Zoltan
--3866299591-417889366-1602600066=:11522--

