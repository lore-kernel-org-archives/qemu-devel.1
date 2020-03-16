Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD60CC0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2BD62051A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 16:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2BD62051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDsI1-0003wa-AL
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 12:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40894)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jDpzt-0007Jb-40
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jDpzs-0000rB-3i
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 09:41:37 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:50210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jDpzp-0008UX-7V; Mon, 16 Mar 2020 09:41:33 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0AEB4747DFF;
 Mon, 16 Mar 2020 14:41:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E2332747DFD; Mon, 16 Mar 2020 14:41:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E07A0747DF7;
 Mon, 16 Mar 2020 14:41:28 +0100 (CET)
Date: Mon, 16 Mar 2020 14:41:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/8] Misc hw/ide legacy clean up
In-Reply-To: <alpine.BSF.2.22.395.2003161401100.70254@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.22.395.2003161440060.12641@zero.eik.bme.hu>
References: <cover.1584134074.git.balaton@eik.bme.hu>
 <87lfo0lr9t.fsf@dusky.pond.sub.org>
 <alpine.BSF.2.22.395.2003161401100.70254@zero.eik.bme.hu>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, philmd@redhat.com,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 hpoussin@reactos.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 16 Mar 2020, BALATON Zoltan wrote:
> On Mon, 16 Mar 2020, Markus Armbruster wrote:
>> BALATON Zoltan <balaton@eik.bme.hu> writes:
>>> These are some clean ups to remove more legacy init functions and
>>> lessen dependence on include/hw/ide.h with some simplifications in
>>> board code. There should be no functional change.
>> 
>> PATCH 1 could quote precedence more clearly in the commit message, but
>> that's detail.
>> 
>> I don't like PATCH 4.
>
> Sent alternative v2 version of patch 7 so you can drop patch 4 if you like,

and patch 6 v2 also sent that is affected as well if you drop patch 4.

> the rest of the series should apply unchanged. Note that there might be some 
> places where MAX_IDE_BUS is defined but not used and current code probably 
> has assumption about this being 2 elsewhere and would break with any other 
> value so other than philosophical there should be no reason to keep this 
> defined everywhere.
>
>> PATCH 1-3,5-8:
>> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> Thanks.
>
> Regards,
> BALATON Zoltan
>

