Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CB2C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AD9522CE3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:32:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AD9522CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Oqn-0001xL-Dn
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:32:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i0Ok5-0003gY-RY
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i0Ok3-00019G-OT
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:25:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38724)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1i0Ok3-00016I-J6
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:25:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9C3EF88FFF6;
 Wed, 21 Aug 2019 11:25:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 36D315D9D3;
 Wed, 21 Aug 2019 11:25:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C13711655EE; Wed, 21 Aug 2019 13:25:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
References: <1565024586-387112-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Date: Wed, 21 Aug 2019 13:25:19 +0200
In-Reply-To: <1565024586-387112-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 (Andrey Shinkevich's message of "Mon, 5 Aug 2019 20:03:06 +0300")
Message-ID: <875zmqlq00.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Wed, 21 Aug 2019 11:25:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] make check-unit: use after free in
 test-opts-visitor
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
Cc: den@openvz.org, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Andrey Shinkevich <andrey.shinkevich@virtuozzo.com> writes:

> In the struct OptsVisitor, the 'repeated_opts' member points to a list
> in the 'unprocessed_opts' hash table after the list has been destroyed.
> A subsequent call to visit_type_int() references the deleted list.
> It results in use-after-free issue reproduced by running the test case
> under the Valgrind: valgrind tests/test-opts-visitor.
> A new mode ListMode::LM_TRAVERSED is declared to mark the list
> traversal completed.
>
> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Queued.  Thanks!

