Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16222C31E50
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:22:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB65E2063F
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB65E2063F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsWv-0003IU-5G
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:22:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41058)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hcsPd-0000hC-Vj
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hcsPZ-0004hw-BO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hcsPL-0004YU-4T; Mon, 17 Jun 2019 10:14:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 510D11796;
 Mon, 17 Jun 2019 14:14:43 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 387CD5E7C6;
 Mon, 17 Jun 2019 14:14:32 +0000 (UTC)
Message-ID: <ab796f1ca07ef09aac17486472e941ce096d2cbe.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Aarushi Mehta
 <mehta.aaru20@gmail.com>
Date: Mon, 17 Jun 2019 17:14:31 +0300
In-Reply-To: <20190611095153.GQ14257@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-11-mehta.aaru20@gmail.com>
 <20190611095153.GQ14257@stefanha-x1.localdomain>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Mon, 17 Jun 2019 14:14:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 10/12] block/io_uring: adds userspace
 completion polling
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-06-11 at 10:51 +0100, Stefan Hajnoczi wrote:
> On Mon, Jun 10, 2019 at 07:19:03PM +0530, Aarushi Mehta wrote:
> > +static bool qemu_luring_poll_cb(void *opaque)
> > +{
> > +    LuringState *s = opaque;
> > +    struct io_uring_cqe *cqes;
> > +
> > +    if (io_uring_peek_cqe(&s->ring, &cqes) == 0) {
> > +        if (!cqes) {
> > +            qemu_luring_process_completions_and_submit(s);
> > +            return true;
> > +        }
> 
> Is this logic inverted?  We have a completion when cqes != NULL.

This indeed looks inverted to me.

Best regards,
	Maxim Levitsky


