Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C947C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:25:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBACF20707
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 12:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+yW8gNM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBACF20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52268 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo4Sa-0007Uf-76
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 08:25:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55198)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jo4Rq-0006sg-QJ
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:24:14 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37093
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jo4Rn-00072I-TK
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 08:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593001450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mi1dqfasqUTBa7ZOBEAdxqHD4bvAmRf+rws/8dKtyQE=;
 b=d+yW8gNMKfDybXCNdfajQNkhoCFoBQhc8xl0j47uLhFakMIdWOxf10XxYgSXI72rXR1B+8
 yA2xDiBGg/XEK4Kx2996/0ewlVNNxMhFGXOrsR1szFs3ut3f8pSbr99SHAzOJOhW0dhlQg
 Kfh6t5XUN1pISzfpVpQUqSojAznb35M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-xl7gxcU8Nx-Lo09Q2YO2IQ-1; Wed, 24 Jun 2020 08:24:09 -0400
X-MC-Unique: xl7gxcU8Nx-Lo09Q2YO2IQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22462804001;
 Wed, 24 Jun 2020 12:24:08 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-87.ams2.redhat.com [10.36.114.87])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C2BB1F2;
 Wed, 24 Jun 2020 12:24:03 +0000 (UTC)
Date: Wed, 24 Jun 2020 14:24:02 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Coiby Xu <coiby.xu@gmail.com>
Subject: Re: [PATCH v9 1/5] Allow vu_message_read to be replaced
Message-ID: <20200624122402.GA9253@linux.fritz.box>
References: <20200614183907.514282-1-coiby.xu@gmail.com>
 <20200614183907.514282-2-coiby.xu@gmail.com>
 <20200618104347.GB6012@linux.fritz.box>
 <20200624033615.u7u7c4bjeugqa4l3@Rk>
MIME-Version: 1.0
In-Reply-To: <20200624033615.u7u7c4bjeugqa4l3@Rk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 01:59:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: bharatlkmlkvm@gmail.com, qemu-devel@nongnu.org, stefanha@redhat.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 24.06.2020 um 05:36 hat Coiby Xu geschrieben:
> On Thu, Jun 18, 2020 at 12:43:47PM +0200, Kevin Wolf wrote:
> > Am 14.06.2020 um 20:39 hat Coiby Xu geschrieben:
> > > Allow vu_message_read to be replaced by one which will make use of the
> > > QIOChannel functions. Thus reading vhost-user message won't stall the
> > > guest.
> > > 
> > > Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> > 
> > _vu_queue_notify() still has a direct call of vu_message_read() instead
> > of using the pointer. Is this intentional?
> 
> This is a mistake. Thank you for reminding me!
> 
> > Renaming the function would make sure that such semantic merge conflicts
> > don't stay unnoticed.
> 
> Thank you for this tip! Do you suggest renaming the function only for
> the purpose of testing or should I adopt a name when submitting the
> patch? For the latter case, I will change it to vu_message_read_default
> then.

I think I would rename it permanently and keep the new name for the
actual submission. The reason is that if someone else is working on a
series adding new references, the compiler would catch it there, too.

vu_message_read_default() sounds good to me.

> > > @@ -1704,6 +1702,7 @@ vu_deinit(VuDev *dev)
> > >          }
> > > 
> > >          if (vq->kick_fd != -1) {
> > > +            dev->remove_watch(dev, vq->kick_fd);
> > >              close(vq->kick_fd);
> > >              vq->kick_fd = -1;
> > >          }
> > 
> > This hunk looks unrelated.
> 
> In v4, I made the comment to explain why it's needed. But libvhost-user
> is supposed to be independent from QEMU, so Stefan suggested to remove it,

Yes, I saw the reason why you need it in later patches.

If you can remove it completely, that is even better, but otherwise I
would make the addition only later (either in the patch that actually
needs it or in a new separate patch) because it's not really part of
"allowing vu_message_read to be replaced", as the commit message says.

Kevin


