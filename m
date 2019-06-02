Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3380C282DC
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 12:11:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25F127907
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 12:11:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25F127907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48565 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXPKU-0004pL-PY
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 08:11:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXPJl-0004XE-B6
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 08:10:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1hXPJk-0004eP-B7
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 08:10:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36758)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hXPJj-0004a3-Fh
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 08:10:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7268E8665A;
	Sun,  2 Jun 2019 12:10:25 +0000 (UTC)
Received: from xz-x1 (ovpn-12-71.pek2.redhat.com [10.72.12.71])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B28F6266B;
	Sun,  2 Jun 2019 12:10:20 +0000 (UTC)
Date: Sun, 2 Jun 2019 20:10:14 +0800
From: Peter Xu <peterx@redhat.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <20190602121014.GC4958@xz-x1>
References: <a84b7e03-f9a8-b577-be27-4d93d1caa1c9@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a84b7e03-f9a8-b577-be27-4d93d1caa1c9@siemens.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Sun, 02 Jun 2019 12:10:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] ioapic: kvm: Skip route updates for masked
 pins
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jun 02, 2019 at 01:42:13PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Masked entries will not generate interrupt messages, thus do no need to
> be routed by KVM. This is a cosmetic cleanup, just avoiding warnings of
> the kind
> 
> qemu-system-x86_64: vtd_irte_get: detected non-present IRTE (index=0, high=0xff00, low=0x100)
> 
> if the masked entry happens to reference a non-present IRTE.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks, Jan.

The "non-cosmetic" part of clearing of those entries (e.g. including
when the entries were not setup correctly rather than masked) was
never really implemented and that task has been on my todo list for
quite a while but with a very low priority (low enough to sink...).  I
hope I didn't overlook its importance since AFAICT general OSs should
hardly trigger those paths and so far I don't see it a very big issue.

Regards,

-- 
Peter Xu

