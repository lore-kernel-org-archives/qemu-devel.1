Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3304FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 08:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9888C20869
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 08:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9888C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL1O6-0005qr-OR
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 04:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iL1NM-0005M5-TW
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 04:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iL1NK-0005WO-9F
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 04:43:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37251)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iL1NK-0005VX-3O
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 04:43:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EFEC318CB8F0;
 Thu, 17 Oct 2019 08:43:11 +0000 (UTC)
Received: from redhat.com (ovpn-116-80.ams2.redhat.com [10.36.116.80])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6C4E55D713;
 Thu, 17 Oct 2019 08:43:11 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Scott Cheloha <cheloha@linux.vnet.ibm.com>
Subject: Re: [PATCH] migration: savevm_state_insert_handler: constant-time
 element insertion
In-Reply-To: <20191016164156.4506-1-cheloha@linux.vnet.ibm.com> (Scott
 Cheloha's message of "Wed, 16 Oct 2019 11:41:56 -0500")
References: <20191016164156.4506-1-cheloha@linux.vnet.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Thu, 17 Oct 2019 10:43:08 +0200
Message-ID: <87lftjpxsz.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Thu, 17 Oct 2019 08:43:12 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Reply-To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Scott Cheloha <cheloha@linux.vnet.ibm.com> wrote:

Hi

> Registering a SaveStateEntry object via savevm_state_insert_handler()
> is an O(n) operation because the list is a priority queue maintained by
> walking the list from head to tail to find a suitable insertion point.
>
> This adds considerable overhead for VMs with many such objects.  For
> instance, ppc64 machines with large maxmem (8T+) spend ~10% or more of
> their CPU time in savevm_state_insert_handler() before attempting to
> boot a kernel.

Ouch ...


> If we track the head for each priority's subqueue we can insert new
> elements in constant time.

We are adding a subqueue by priority, right? (see later comments)

> This commit also introduces a new function,
> savevm_state_remove_handler(),

savevm_state_handler_remove()

search didn't find it O:-)

> which abstracts the logic for replacing the head of an element's subqueue
> when removing it.

I think that it is better if you split the new function creation.  Make
commit easier to write O:-)


>  static SaveState savevm_state = {
>      .handlers = QTAILQ_HEAD_INITIALIZER(savevm_state.handlers),
> +    .handler_pri_head = { [MIG_PRI_DEFAULT ... MIG_PRI_MAX] = NULL },

Why are you still maintaining the handlers QTAILQ?  Once here will not
be easier to just change handlers field to be an array
handlers[MIG_PRI_MAX] field, and adjust callers?

Changes are only inside this file.

The code to maintain the subqueue inside the other queue is just as
complex as chaning all the callers.  What do you think?

savevm_state_handler_insert() for instance becomes even easier, just a
QTALIQ_INSERT_TAIL() in the proper queue, right?


I agree with the idea of the patch.  Especially when you told us how bad
the performance of the current code is.

Out of curiosity, how many objects are we talking about?

Later, Juan.

