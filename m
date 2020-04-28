Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84809C8300E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC5D206F0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 13:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC5D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTQAB-0004oR-97
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 09:20:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33560)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jTQ7a-0000mf-NC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jTQ5s-0002dd-1k
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:17:58 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:56918)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alazar@bitdefender.com>)
 id 1jTQ5r-0002Rd-Az
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 09:16:11 -0400
Received: from smtp.bitdefender.com (smtp02.buh.bitdefender.net [10.17.80.76])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 AE584306E47C; Tue, 28 Apr 2020 16:16:08 +0300 (EEST)
Received: from localhost (unknown [91.199.104.50])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 912373000E5A;
 Tue, 28 Apr 2020 16:16:08 +0300 (EEST)
From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 20/26] kvm: vmi: intercept live migration
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
In-Reply-To: <20200428122439.GD2794@work-vm>
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-21-alazar@bitdefender.com>
 <20200427190855.GN2923@work-vm> <15880760940.91F7391B.25850@host>
 <20200428122439.GD2794@work-vm>
Date: Tue, 28 Apr 2020 16:16:31 +0300
Message-ID: <15880797910.d6Bf.5687@host>
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

On Tue, 28 Apr 2020 13:24:39 +0100, "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Adalbert Lazăr (alazar@bitdefender.com) wrote:
> > On Mon, 27 Apr 2020 20:08:55 +0100, "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > * Adalbert Lazăr (alazar@bitdefender.com) wrote:
> > > > From: Marian Rotariu <marian.c.rotariu@gmail.com>
> > > > 
> > > > It is possible that the introspection tool has made some changes inside
> > > > the introspected VM which can make the guest crash if the introspection
> > > > connection is suddenly closed.
> > > > 
> > > > When the live migration starts, for now, the introspection tool is
> > > > signaled to remove its hooks from the introspected VM.
> > > > 
> > > > CC: Juan Quintela <quintela@redhat.com>
> > > > CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > > Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
> > > > Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
> > > 
> > > OK, so this isn't too intrusive to the migration code; and other than
> > > renaming 'start_live_migration_thread' to
> > > 'start_outgoing_migration_thread' I think I'd be OK with this,
> > > 
> > > but it might depend what your overall aim is.
> > > 
> > > For example, you might be better intercepting each migration_state
> > > change in your notifier, that's much finer grain than just the start of
> > > migration.
> > 
> > Thank you, Dave.
> > 
> > We want to intercept the live migration and 'block' it while the guest
> > is running (some changes made to the guest by the introspection app has
> > to be undone while the vCPUs are in certain states).
> > 
> > I'm not sure what is the best way to block these kind of events
> > (including the pause/shutdown commands). If calling main_loop_wait()
> > is enough (patch [22/26] kvm: vmi: add 'async_unhook' property [1])
> > then we can drop a lot of code.
> > 
> > The use of a notifier will be nice, but from what I understand, we can't
> > block the migration from a notification callback.
> 
> Oh, if your intention is *just* to block a migration starting then you
> can use 'migrate_add_blocker' - see hw/9pfs/9p.c for an example where
> it's used and then removed; they use it to stop migration while the fs
>  is mounted.  That causes an attempt to start a migration to give an
> error (of your choosing).

One use case is to do VM introspection all the time the guest is running.
From the user perspective, the pause/suspend/shutdown/snapshot/migrate
commands should work regardless if the VM is currently introspected
or not. Our first option was to delay these commands for a couple of
seconds when the VM is introspected, while the introspection app reverts
its changes, without blocking the vCPUs.

I'll see if we can mix the migrate notifier with migrate_add_blocker(),
or add a new migration state. To block the migration (with an error)
is our second option, because the user doing this might not be allowed
to stop the VM introspection.

Thank you,
Adalbert

