Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C4CC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 20:38:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96FBA21726
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 20:38:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FBA21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hteJk-0006vI-LA
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 16:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35397)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hteHg-0006Ro-EP
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 16:36:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hteHe-0006oa-Fn
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 16:36:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hteHc-0006nT-Gp
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 16:36:13 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A44CD83F45
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 20:36:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7244360A97;
 Fri,  2 Aug 2019 20:36:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 150FA1138619; Fri,  2 Aug 2019 22:36:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-28-armbru@redhat.com>
 <10eeb125-0acd-330a-28f1-50efe82b2fe5@redhat.com>
 <87ef23iu5y.fsf@dusky.pond.sub.org>
Date: Fri, 02 Aug 2019 22:36:08 +0200
In-Reply-To: <87ef23iu5y.fsf@dusky.pond.sub.org> (Markus Armbruster's message
 of "Fri, 02 Aug 2019 15:16:57 +0200")
Message-ID: <87tvazfgp3.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Fri, 02 Aug 2019 20:36:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 27/28] sysemu: Move the VMChangeStateEntry
 typedef to qemu/typedefs.h
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Markus Armbruster <armbru@redhat.com> writes:

> Paolo Bonzini <pbonzini@redhat.com> writes:
>
>> On 26/07/19 14:05, Markus Armbruster wrote:
>>> +typedef struct VMChangeStateEntry VMChangeStateEntry;
>>>  typedef struct VMStateDescription VMStateDescription;
>>>  
>>
>> This is a bit borderline; I'd rather split sysemu/sysemu.h, e.g. adding
>> sysemu/runstate.h that would have VMChangeStateEntry functions.  If
>> there aren't many conflicts, perhaps you can drop this patch?
>
> Without it, the next one will be ineffective.

Actually, "ineffective" is an exaggeration, it's not *that* bad.  Two
headers are affected:

                            Before 27  After 27+28  Just 28
qapi/qapi-types-run-state.h      5500         4400     5000
sysemu/vmstate-notify.h             0          180     1000

The numbers are .o depending on the header in my "build everything"
tree, out of 6600 total (not counting tests and objects that don't
depend on qemu/osdep.h).

Mainly because hw/virtio/virtio.h (760 .o) and hw/scsi/scsi.h (180 .o)
need to include sysemu/vmstate-notify.h to get the VMChangeStateEntry
typedef.  Four more headers need it as well, but they are small
potatoes.

Splitting sysemu/runstate.h off sysemu/sysemu.h makes sense anyway, but
won't improve these numbers.

I'd keep PATCH 27.

[...]

