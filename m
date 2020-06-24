Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69C4C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4192206EB
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfWllCgO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4192206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo9ec-00031o-0e
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jo9dx-0002bI-6C
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 13:57:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29543
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1jo9du-0006LM-Ej
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 13:57:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593021420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PEjyCUyE3sWVZkGYeKg9uWZfDhdSTHNNM4bGtfd+Xg4=;
 b=GfWllCgOpld9EEa/Sw7CADz4xPOnckTJnbCFQ8BiCx5DNI3XV4+JU6Z71olzvor3oWTizf
 H76kl2oWwd0xCSRQyf3psgHGM4uOx/nt+espOTMUGuRXGnksNwjneIZy1QSKMCEcmi4Cjc
 O1OzqS9tmnlFz0o0SRCmtigRaIjDOqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-63-DH3F2a6MOI6snMh9HIjN3A-1; Wed, 24 Jun 2020 13:56:58 -0400
X-MC-Unique: DH3F2a6MOI6snMh9HIjN3A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11116800C64;
 Wed, 24 Jun 2020 17:56:57 +0000 (UTC)
Received: from work-vm (ovpn-112-192.ams2.redhat.com [10.36.112.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C03715C557;
 Wed, 24 Jun 2020 17:56:55 +0000 (UTC)
Date: Wed, 24 Jun 2020 18:56:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Jason Andryuk <jandryuk@gmail.com>
Subject: Re: Migration vmdesc and xen-save-devices-state
Message-ID: <20200624175653.GA49433@work-vm>
References: <CAKf6xptNySqXOHAZJiiBq=h99GBQcS8Cbzmpyqzy-ucxX8Od2Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKf6xptNySqXOHAZJiiBq=h99GBQcS8Cbzmpyqzy-ucxX8Od2Q@mail.gmail.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
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
Cc: xen-devel <xen-devel@lists.xenproject.org>, QEMU <qemu-devel@nongnu.org>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Jason Andryuk (jandryuk@gmail.com) wrote:
> Hi,
> 
> At some point, QEMU changed to add a json VM description (vmdesc)
> after the migration data.  The vmdesc is not needed to restore the
> migration data, but qemu_loadvm_state() will read and discard the
> vmdesc to clear the stream when should_send_vmdesc() is true.

About 5 years ago :-)

> xen-save-devices-state generates its migration data without a vmdesc.
> xen-load-devices-state in turn calls qemu_loadvm_state() which tries
> to load vmdesc since should_send_vmdesc is true for xen.  When
> restoring from a file, this is fine since it'll return EOF, print
> "Expected vmdescription section, but got 0" and end the restore
> successfully.
> 
> Linux stubdoms load their migration data over a console, so they don't
> hit the EOF and end up waiting.  There does seem to be a timeout
> though and restore continues after a delay, but we'd like to eliminate
> the delay.
> 
> Two options to address this are to either:
> 1) set suppress_vmdesc for the Xen machines to bypass the
> should_send_vmdesc() check.
> or
> 2) just send the vmdesc data.
> 
> Since vmdesc is just discarded, maybe #1 should be followed.

#1 does sound simple!

> If going with #2, qemu_save_device_state() needs to generate the
> vmdesc data.  Looking at qemu_save_device_state() and
> qemu_savevm_state_complete_precopy_non_iterable(), they are both very
> similar and could seemingly be merged.  qmp_xen_save_devices_state()
> could even leverage the bdrv_inactivate_all() call in
> qemu_savevm_state_complete_precopy_non_iterable().
> 
> The would make qemu_save_device_state a little more heavywight, which
> could impact COLO.  I'm not sure how performance sensitive the COLO
> code is, and I haven't measured anything.

COLO snapshots are potentially quite sensitive; although we've got a
load of other things we could do with speeding up, we could do without
making them noticably heavier.

Dave

> Does anyone have thoughts or opinions on the subject?
> 
> Thanks,
> Jason
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


