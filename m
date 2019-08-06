Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859B6C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C812086D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 16:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C812086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hv2J3-00072X-NJ
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 12:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45869)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@pond.sub.org>) id 1hv2If-0006e6-P6
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@pond.sub.org>) id 1hv2Ie-0002hz-Sn
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:27:01 -0400
Received: from oxygen.pond.sub.org ([94.130.129.15]:33820)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@pond.sub.org>) id 1hv2Ie-0002dt-Mk
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 12:27:00 -0400
Received: from blackfin.pond.sub.org
 (p200300D36F3D4600DACB8AFFFEE0C842.dip0.t-ipconnect.de
 [IPv6:2003:d3:6f3d:4600:dacb:8aff:fee0:c842])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 0608269177
 for <qemu-devel@nongnu.org>; Tue,  6 Aug 2019 18:26:55 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3CFC1113864E; Tue,  6 Aug 2019 18:26:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-28-armbru@redhat.com>
 <10eeb125-0acd-330a-28f1-50efe82b2fe5@redhat.com>
 <87ef23iu5y.fsf@dusky.pond.sub.org>
 <0462d0a9-b6ef-1969-84a4-40273728a534@redhat.com>
Date: Tue, 06 Aug 2019 18:26:55 +0200
Message-ID: <87wofqcl9s.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 94.130.129.15
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 02/08/19 15:16, Markus Armbruster wrote:
>> * VMChangeStateEntry and the three functions using it, obviously, along
>>   with VMChangeStateHandler.
>> 
>> * vm_state_notify(), because it belongs to the above.
>> 
>> * The runstate_FOO() functions, because they're named like the new
>>   header?
>> 
>> * vm_stop(), vm_stop_force_state(), vmstop_requested(),
>>   vmstop_requested, because they use RunState?
>> 
>> * The remaining vm_FOO(), because they're closely related to vm_stop()?
>> 
>> * Everything else from qemu_exit_preconfig_request() to
>>   qemu_remove_exit_notifier(), along with WakeupReason?
>
> Yes, that could be an idea, but not qemu_add/remove_exit_notifier.

I did this in v2 this instead of creating sysemu/vmstate-notify.h.

Reminder:

* PATCH 27 "sysemu: Move the VMChangeStateEntry typedef to
  qemu/typedefs.h" makes the subsequent patches more effective: it saves
  ~800 dependencies on whatever header defines the typedef.

* PATCH 28 "Include sysemu/sysemu.h a lot less" succeeds almost entirely
  due to not including it from hw/qdev-core.h.  Damage done by recent
  commit e965ffa70a "qdev: add qdev_add_vm_change_state_handler()".

  The stupidest way to undo that damage would be moving
  qdev_add_vm_change_state_handler() to sysemu/sysemu.h.

  I chose to move it to new sysemu/vmstate-notify.h along with its
  buddies from sysemu/sysemu.h.  The dependency improvement is
  negligible, just because it makes sysemu/sysemu.h less of a dumping
  ground.

For v2, I flipped PATCH 28 to the stupidest way, and put it *before*
PATCH 27.  I split off sysemu/runstate.h only in PATCH 29.  I hope that
way the benefit of each change is more obvious.

