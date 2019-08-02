Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 778A7C32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:17:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4892087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 13:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4892087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htXRD-0006ny-KF
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 09:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48109)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1htXQc-0006PE-FZ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:17:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1htXQb-0006me-JW
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:17:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52478)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1htXQb-0006mD-Eq
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 09:17:01 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C46C08667D
 for <qemu-devel@nongnu.org>; Fri,  2 Aug 2019 13:17:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E801C60605;
 Fri,  2 Aug 2019 13:16:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6D2AA1138619; Fri,  2 Aug 2019 15:16:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
References: <20190726120542.9894-1-armbru@redhat.com>
 <20190726120542.9894-28-armbru@redhat.com>
 <10eeb125-0acd-330a-28f1-50efe82b2fe5@redhat.com>
Date: Fri, 02 Aug 2019 15:16:57 +0200
In-Reply-To: <10eeb125-0acd-330a-28f1-50efe82b2fe5@redhat.com> (Paolo
 Bonzini's message of "Fri, 2 Aug 2019 11:48:31 +0200")
Message-ID: <87ef23iu5y.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 02 Aug 2019 13:17:00 +0000 (UTC)
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 26/07/19 14:05, Markus Armbruster wrote:
>> +typedef struct VMChangeStateEntry VMChangeStateEntry;
>>  typedef struct VMStateDescription VMStateDescription;
>>  
>
> This is a bit borderline; I'd rather split sysemu/sysemu.h, e.g. adding
> sysemu/runstate.h that would have VMChangeStateEntry functions.  If
> there aren't many conflicts, perhaps you can drop this patch?

Without it, the next one will be ineffective.

Which parts of sysemu.h would you rather move to runstate.h?

* VMChangeStateEntry and the three functions using it, obviously, along
  with VMChangeStateHandler.

* vm_state_notify(), because it belongs to the above.

* The runstate_FOO() functions, because they're named like the new
  header?

* vm_stop(), vm_stop_force_state(), vmstop_requested(),
  vmstop_requested, because they use RunState?

* The remaining vm_FOO(), because they're closely related to vm_stop()?

* Everything else from qemu_exit_preconfig_request() to
  qemu_remove_exit_notifier(), along with WakeupReason?

* More?

If only the first two, we can call the new header vmstate-notify.h.

