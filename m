Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FFEECE58E
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:35:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6894C2089C
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 08:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6894C2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKIJ9-00070f-BF
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 04:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iKIIM-0006JH-6E
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:35:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iKIIK-0004AN-Tn
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:35:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iKIIK-00049l-OS
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 04:35:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0CA98E1CE7
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 08:35:02 +0000 (UTC)
Received: from redhat.com (unknown [10.36.118.28])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 59921608A5;
 Tue, 15 Oct 2019 08:34:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/2] migration: Boost SaveStateEntry.instance_id to 64 bits
In-Reply-To: <20191015075444.10955-2-peterx@redhat.com> (Peter Xu's message of
 "Tue, 15 Oct 2019 15:54:43 +0800")
References: <20191015075444.10955-1-peterx@redhat.com>
 <20191015075444.10955-2-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Tue, 15 Oct 2019 10:34:57 +0200
Message-ID: <87tv8aqudq.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 15 Oct 2019 08:35:02 +0000 (UTC)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> wrote:
> It was "int" and used as 32bits fields (see save_section_header()).
> It's unsafe already because sizeof(int) could be 2 on i386,

i386 is 32bits, so int is 32bits O:-)
I really hope that we would never, ever, need a 64bits instance id.
It would mean that we have more than 2.000.000.000 objects of the same
type, no?

I am pretty sure than in 16bits platforms we have other problems than
insntance_id (namely that we don't have enough memory).

>I think.
> So at least uint32_t would suite more.  While it also uses "-1" as a
> placeholder of "we want to generate the instance ID automatically".
> Hence a more proper value should be int64_t.
>
> This will start to be useful after next patch in which we can start to
> convert a real uint32_t value as instance ID.

Later, Juan.

