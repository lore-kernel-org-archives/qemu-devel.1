Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F28C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 06:34:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 216C02054F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 06:34:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 216C02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsLhy-0006KR-Cj
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 02:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57261)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hsLhY-0005tZ-JY
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 02:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hsLhX-0004Pp-Et
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 02:33:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45370)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hsLhX-0004Pj-A1
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 02:33:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8DB453084288
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 06:33:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C200608A5;
 Tue, 30 Jul 2019 06:33:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F082A1138619; Tue, 30 Jul 2019 08:33:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-22-armbru@redhat.com>
 <20190729191605.GF4313@habkost.net>
Date: Tue, 30 Jul 2019 08:33:32 +0200
In-Reply-To: <20190729191605.GF4313@habkost.net> (Eduardo Habkost's message of
 "Mon, 29 Jul 2019 16:16:05 -0300")
Message-ID: <87zhkwf2v7.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Tue, 30 Jul 2019 06:33:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 21/28] Include hw/qdev-properties.h less
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. =?utf-8?Q?Berrang?= =?utf-8?Q?=C3=A9?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Eduardo Habkost <ehabkost@redhat.com> writes:

> On Fri, Jul 26, 2019 at 02:05:35PM +0200, Markus Armbruster wrote:
>> In my "build everything" tree, changing hw/qdev-properties.h triggers
>> a recompile of some 2700 out of 6600 objects (not counting tests and
>> objects that don't depend on qemu/osdep.h).
>> 
>> Many places including hw/qdev-properties.h (directly or via hw/qdev.h)
>> actually need only hw/qdev-core.h.  Include hw/qdev-core.h there
>> instead.
>> 
>> hw/qdev.h is actually pointless: all it does is include hw/qdev-core.h
>> and hw/qdev-properties.h, which in turn includes hw/qdev-core.h.
>> Replace the remaining uses of hw/qdev.h by hw/qdev-properties.h.
>> 
>> While there, delete a few superfluous inclusions of hw/qdev-core.h.
>> 
>> Touching hw/qdev-properties.h now recompiles some 1200 objects.
>
> Impressive, thanks for doing this.
>
> I only see superfluous whitespace changes at
> hw/sd/sdhci-internal.h and hw/qdev-dma.h, below.

Rebasing leftovers, will drop.

> They are harmless, though, so:
>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Thanks!

> [...]
>> diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
>> index 34141400f8..1d9053c183 100644
>> --- a/hw/sd/sdhci-internal.h
>> +++ b/hw/sd/sdhci-internal.h
>> @@ -21,6 +21,7 @@
>>   * You should have received a copy of the GNU General Public License along
>>   * with this program; if not, see <http://www.gnu.org/licenses/>.
>>   */
>> +
>>  #ifndef SDHCI_INTERNAL_H
>>  #define SDHCI_INTERNAL_H
>>  
> [...]
>> diff --git a/include/hw/qdev-dma.h b/include/hw/qdev-dma.h
>> index b00391aa0c..002705c57d 100644
>> --- a/include/hw/qdev-dma.h
>> +++ b/include/hw/qdev-dma.h
>> @@ -10,6 +10,7 @@
>>  #ifndef HW_QDEV_DMA_H
>>  #define HW_QDEV_DMA_H
>>  
>> +
>>  #define DEFINE_PROP_DMAADDR(_n, _s, _f, _d)                               \
>>      DEFINE_PROP_UINT64(_n, _s, _f, _d)
>>  
> [...]

