Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBF3C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86497206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 14:45:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86497206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTRUc-0001NZ-Kv
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 10:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46614)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jTRPZ-0005mx-Mv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jTRNJ-0005oy-0q
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:40:36 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:59150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alazar@bitdefender.com>)
 id 1jTRNI-0005oY-GH
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 10:38:16 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 D9BDD306E47C; Tue, 28 Apr 2020 17:38:13 +0300 (EEST)
Received: from localhost (unknown [91.199.104.50])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id BBC163000E5A;
 Tue, 28 Apr 2020 17:38:13 +0300 (EEST)
From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 20/26] kvm: vmi: intercept live migration
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
In-Reply-To: <20200428134320.GE2794@work-vm>
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-21-alazar@bitdefender.com>
 <20200427190855.GN2923@work-vm> <15880760940.91F7391B.25850@host>
 <20200428122439.GD2794@work-vm> <15880797910.d6Bf.5687@host>
 <20200428134320.GE2794@work-vm>
Date: Tue, 28 Apr 2020 17:38:40 +0300
Message-ID: <15880847200.C32EdC.20466@host>
User-agent: void
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Received-SPF: pass client-ip=91.199.104.161;
 envelope-from=alazar@bitdefender.com; helo=mx01.bbu.dsd.mx.bitdefender.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 08:14:28
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 91.199.104.161
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
Cc: Marian Rotariu <marian.c.rotariu@gmail.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Apr 2020 14:43:20 +0100, "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Adalbert Lazăr (alazar@bitdefender.com) wrote:
> > One use case is to do VM introspection all the time the guest is running.
> > From the user perspective, the pause/suspend/shutdown/snapshot/migrate
> > commands should work regardless if the VM is currently introspected
> > or not. Our first option was to delay these commands for a couple of
> > seconds when the VM is introspected, while the introspection app reverts
> > its changes, without blocking the vCPUs.
> 
> Ah OK, so it's not really about blocking it completely; just delaying it
> a bit; in that case add_blocker is the wrong thing.
> 
> > I'll see if we can mix the migrate notifier with migrate_add_blocker(),
> > or add a new migration state. To block the migration (with an error)
> > is our second option, because the user doing this might not be allowed
> > to stop the VM introspection.
> 
> Maybe the right thing is to do something just like
> MIGRATION_STATUS_WAIT_UNPLUG, it's right near the start of the thread.
> Again it's job is just to make the migration wait while it does some
> stuff before it can let migration continue.
> 

This is it! Thank you, Dave.

We already register a VMStateDescription structure to save the VM start time
([18/26] kvm: vmi: store/restore 'vm_start_time' on migrate/snapshot [1]).
All we have to do is setup the dev_unplug_pending callback and
return true when the introspection channel is still active.

[1]: https://lore.kernel.org/qemu-devel/20200415005938.23895-19-alazar@bitdefender.com/

