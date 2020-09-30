Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED56BC4727C
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DC132076A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 18:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZKKUL9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC132076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNgVd-0006C8-9z
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 14:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNgSm-0003ea-MC
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:04:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40518)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1kNgSg-00064n-KU
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 14:04:24 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601489057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JjOx2BBzqDT7j74JFQ8QKN1hwYGUsUmj1u3hC17tEMU=;
 b=hZKKUL9iMqd9+DGsLaegmGYJVZolfJgCz6K9GbbE7n72tdUx+YQfTmsw8Sg6ijeKY65uMn
 W1WndAdATMVkpdB+acHegex/yI1dl1kooEMLBUd4PSBjUedUEgMFcYgGFKG7sCmAAs1Wdp
 BsOnfZJf/74bHJdAK86gmFVgMtjtlfs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-WvnA7ep9MB-ygIQEVelEDw-1; Wed, 30 Sep 2020 14:04:15 -0400
X-MC-Unique: WvnA7ep9MB-ygIQEVelEDw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E2701106BB40;
 Wed, 30 Sep 2020 18:04:12 +0000 (UTC)
Received: from starship (unknown [10.35.206.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F5BE7F8C8;
 Wed, 30 Sep 2020 18:04:10 +0000 (UTC)
Message-ID: <fd2fd78366b9222f6375cb01500aba7bbe43e43a.camel@redhat.com>
Subject: Re: [PATCH 08/10] scsi/scsi_bus: Add scsi_device_get
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 30 Sep 2020 21:04:09 +0300
In-Reply-To: <67859d7f-5293-a11e-add3-f93893dfa7af@redhat.com>
References: <20200925172604.2142227-1-pbonzini@redhat.com>
 <20200925172604.2142227-9-pbonzini@redhat.com>
 <0d124b6991e607e496da4afa39027320e617aa0e.camel@redhat.com>
 <67859d7f-5293-a11e-add3-f93893dfa7af@redhat.com>
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlevitsk@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 00:26:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.469,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2020-09-30 at 19:46 +0200, Paolo Bonzini wrote:
> On 30/09/20 16:32, Maxim Levitsky wrote:
> > > 	Compared to Maxim's patch, I am avoiding the extra argument
> > > 	to do_scsi_device_find by moving the RCU_READ_LOCK_GUARD()
> > > 	out of do_scsi_device_find itself.
> > Which is a good idea, although my mindset was like, I got a device,
> > lets just grab a ref to it before it disappears and then do
> > whatever I want.
> 
> Understood, but "I got a device, I know I'm under RCU so it can't
> disappear" is more efficient and just as common.  This also explains the
> difference in patch 7.

Fair point. I am still learing to correctly use RCU.

Best regards,
	Maxim Levitsky
> 
> Paolo
> 



