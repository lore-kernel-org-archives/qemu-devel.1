Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB071C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FA44206D6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 12:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FA44206D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bitdefender.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTP8q-0007RY-HC
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 08:15:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55306)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jTP8E-0006sz-A2
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alazar@bitdefender.com>) id 1jTP8C-0004BN-Ql
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:14:33 -0400
Received: from mx01.bbu.dsd.mx.bitdefender.com ([91.199.104.161]:55408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alazar@bitdefender.com>)
 id 1jTP8C-0004B7-4z
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 08:14:32 -0400
Received: from smtp.bitdefender.com (smtp01.buh.bitdefender.com [10.17.80.75])
 by mx01.bbu.dsd.mx.bitdefender.com (Postfix) with ESMTPS id
 AFAA030747BF; Tue, 28 Apr 2020 15:14:27 +0300 (EEST)
Received: from localhost (unknown [91.199.104.50])
 by smtp.bitdefender.com (Postfix) with ESMTPSA id 909AF303A3E5;
 Tue, 28 Apr 2020 15:14:27 +0300 (EEST)
From: Adalbert =?iso-8859-2?b?TGF643I=?= <alazar@bitdefender.com>
Subject: Re: [RFC PATCH v1 20/26] kvm: vmi: intercept live migration
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
In-Reply-To: <20200427190855.GN2923@work-vm>
References: <20200415005938.23895-1-alazar@bitdefender.com>
 <20200415005938.23895-21-alazar@bitdefender.com>
 <20200427190855.GN2923@work-vm>
Date: Tue, 28 Apr 2020 15:14:54 +0300
Message-ID: <15880760940.91F7391B.25850@host>
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

On Mon, 27 Apr 2020 20:08:55 +0100, "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> * Adalbert Lazăr (alazar@bitdefender.com) wrote:
> > From: Marian Rotariu <marian.c.rotariu@gmail.com>
> > 
> > It is possible that the introspection tool has made some changes inside
> > the introspected VM which can make the guest crash if the introspection
> > connection is suddenly closed.
> > 
> > When the live migration starts, for now, the introspection tool is
> > signaled to remove its hooks from the introspected VM.
> > 
> > CC: Juan Quintela <quintela@redhat.com>
> > CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > Signed-off-by: Marian Rotariu <marian.c.rotariu@gmail.com>
> > Signed-off-by: Adalbert Lazăr <alazar@bitdefender.com>
> 
> OK, so this isn't too intrusive to the migration code; and other than
> renaming 'start_live_migration_thread' to
> 'start_outgoing_migration_thread' I think I'd be OK with this,
> 
> but it might depend what your overall aim is.
> 
> For example, you might be better intercepting each migration_state
> change in your notifier, that's much finer grain than just the start of
> migration.

Thank you, Dave.

We want to intercept the live migration and 'block' it while the guest
is running (some changes made to the guest by the introspection app has
to be undone while the vCPUs are in certain states).

I'm not sure what is the best way to block these kind of events
(including the pause/shutdown commands). If calling main_loop_wait()
is enough (patch [22/26] kvm: vmi: add 'async_unhook' property [1])
then we can drop a lot of code.

The use of a notifier will be nice, but from what I understand, we can't
block the migration from a notification callback.

> The other thing I worry about is that there doesn't seem to be much
> guard against odd orderings of things - for example, what happens
> if the introspection client was to issue the  INTERCEPT_MIGRATE command
> twice while a migration was already running?  Or before an actual
> incoming channel connetion had happened?
> 
> Dave

Sorry that I haven't described the interception. When we intercept
an action that we want to 'block', we set a static variable first,
regardless if the introspection channel is connected or not, and :

   - if the introspection channel is not connected we don't block the
   action, but this (variable) will prevent the activation of this
   channel until the action (ie. migrate) is completed (a). I assume
   that there could be only one migrate (or suspend/pause) user command
   at any given time (b).

   - if the introspection channel is connected, the introspection app
   is signaled to start its unhook/undo process. We let the code flow
   continue, but the action (migrate/suspend/pause) is delayed until
   the introspection channel is closed. Meanwhile, any other intercepted
   action will not be blocked/delayed (c), but the fact that these actions
   are in progress is saved to static variables and the introspecton
   channel won't be reactivated.

Indeed, there are cases that are not handled well:

  a) if the migration is started and canceled before the introspection
  object is created (through QMP), the introspection channel will be
  disabled until the next migration starts and finishes.

  b) if a migration command has been delayed, a following migrate command
  (if this is possible) won't be delayed and we will have two migration
  threads started.

  c) if a migration command has been delayed, a following suspend/pause
  command won't be delayed and the introspection app might not have
  enough time to finish its unhook/undo process.

[1]: https://lore.kernel.org/qemu-devel/20200415005938.23895-23-alazar@bitdefender.com/

> > ---
> >  accel/kvm/vmi.c                | 31 +++++++++++++++++++++++++++----
> >  include/sysemu/vmi-intercept.h |  1 +
> >  migration/migration.c          | 18 +++++++++++++++---
> >  migration/migration.h          |  2 ++
> >  4 files changed, 45 insertions(+), 7 deletions(-)
> > 
> > diff --git a/accel/kvm/vmi.c b/accel/kvm/vmi.c
> > index 90906478b4..ea7191e48d 100644
> > --- a/accel/kvm/vmi.c
> > +++ b/accel/kvm/vmi.c
> > @@ -21,6 +21,8 @@
> >  #include "chardev/char.h"
> >  #include "chardev/char-fe.h"
> >  #include "migration/vmstate.h"
> > +#include "migration/migration.h"
> > +#include "migration/misc.h"
> >  
> >  #include "sysemu/vmi-intercept.h"
> >  #include "sysemu/vmi-handshake.h"
> > @@ -58,6 +60,7 @@ typedef struct VMIntrospection {
> >      int64_t vm_start_time;
> >  
> >      Notifier machine_ready;
> > +    Notifier migration_state_change;
> >      bool created_from_command_line;
> >  
> >      bool kvmi_hooked;
> > @@ -74,9 +77,11 @@ static const char *action_string[] = {
> >      "suspend",
> >      "resume",
> >      "force-reset",
> > +    "migrate",
> >  };
> >  
> >  static bool suspend_pending;
> > +static bool migrate_pending;
> >  
> >  #define TYPE_VM_INTROSPECTION "introspection"
> >  
> > @@ -88,6 +93,15 @@ static bool suspend_pending;
> >  static Error *vm_introspection_init(VMIntrospection *i);
> >  static void vm_introspection_reset(void *opaque);
> >  
> > +static void migration_state_notifier(Notifier *notifier, void *data)
> > +{
> > +    MigrationState *s = data;
> > +
> > +    if (migration_has_failed(s)) {
> > +        migrate_pending = false;
> > +    }
> > +}
> > +
> >  static void machine_ready(Notifier *notifier, void *data)
> >  {
> >      VMIntrospection *i = container_of(notifier, VMIntrospection, machine_ready);
> > @@ -144,6 +158,9 @@ static void complete(UserCreatable *uc, Error **errp)
> >  
> >      ic->uniq = i;
> >  
> > +    i->migration_state_change.notify = migration_state_notifier;
> > +    add_migration_state_change_notifier(&i->migration_state_change);
> > +
> >      qemu_register_reset(vm_introspection_reset, i);
> >  }
> >  
> > @@ -478,6 +495,9 @@ static void continue_with_the_intercepted_action(VMIntrospection *i)
> >      case VMI_INTERCEPT_SUSPEND:
> >          vm_stop(RUN_STATE_PAUSED);
> >          break;
> > +    case VMI_INTERCEPT_MIGRATE:
> > +        start_live_migration_thread(migrate_get_current());
> > +        break;
> >      default:
> >          error_report("VMI: %s: unexpected action %d",
> >                       __func__, i->intercepted_action);
> > @@ -571,9 +591,9 @@ static void chr_event_open(VMIntrospection *i)
> >  {
> >      Error *local_err = NULL;
> >  
> > -    if (suspend_pending) {
> > -        info_report("VMI: %s: too soon (suspend=%d)",
> > -                    __func__, suspend_pending);
> > +    if (suspend_pending || migrate_pending) {
> > +        info_report("VMI: %s: too soon (suspend=%d, migrate=%d)",
> > +                    __func__, suspend_pending, migrate_pending);
> >          maybe_disable_socket_reconnect(i);
> >          qemu_chr_fe_disconnect(&i->sock);
> >          return;
> > @@ -608,7 +628,7 @@ static void chr_event_close(VMIntrospection *i)
> >      cancel_unhook_timer(i);
> >      cancel_handshake_timer(i);
> >  
> > -    if (suspend_pending) {
> > +    if (suspend_pending || migrate_pending) {
> >          maybe_disable_socket_reconnect(i);
> >  
> >          if (i->intercepted_action != VMI_INTERCEPT_NONE) {
> > @@ -680,6 +700,9 @@ static bool record_intercept_action(VMI_intercept_command action)
> >          break;
> >      case VMI_INTERCEPT_FORCE_RESET:
> >          break;
> > +    case VMI_INTERCEPT_MIGRATE:
> > +        migrate_pending = true;
> > +        break;
> >      default:
> >          return false;
> >      }
> > diff --git a/include/sysemu/vmi-intercept.h b/include/sysemu/vmi-intercept.h
> > index ef591b49e7..b4a9a3faa7 100644
> > --- a/include/sysemu/vmi-intercept.h
> > +++ b/include/sysemu/vmi-intercept.h
> > @@ -15,6 +15,7 @@ typedef enum {
> >      VMI_INTERCEPT_SUSPEND,
> >      VMI_INTERCEPT_RESUME,
> >      VMI_INTERCEPT_FORCE_RESET,
> > +    VMI_INTERCEPT_MIGRATE,
> >  } VMI_intercept_command;
> >  
> >  bool vm_introspection_intercept(VMI_intercept_command ic, Error **errp);
> > diff --git a/migration/migration.c b/migration/migration.c
> > index 187ac0410c..222037d739 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -55,6 +55,8 @@
> >  #include "qemu/queue.h"
> >  #include "multifd.h"
> >  
> > +#include "sysemu/vmi-intercept.h"
> > +
> >  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
> >  
> >  /* Amount of time to allocate to each "chunk" of bandwidth-throttled
> > @@ -3471,6 +3473,13 @@ static void *migration_thread(void *opaque)
> >      return NULL;
> >  }
> >  
> > +void start_live_migration_thread(MigrationState *s)
> > +{
> > +    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
> > +                    QEMU_THREAD_JOINABLE);
> > +    s->migration_thread_running = true;
> > +}
> > +
> >  void migrate_fd_connect(MigrationState *s, Error *error_in)
> >  {
> >      Error *local_err = NULL;
> > @@ -3534,9 +3543,12 @@ void migrate_fd_connect(MigrationState *s, Error *error_in)
> >          migrate_fd_cleanup(s);
> >          return;
> >      }
> > -    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
> > -                       QEMU_THREAD_JOINABLE);
> > -    s->migration_thread_running = true;
> > +
> > +    if (vm_introspection_intercept(VMI_INTERCEPT_MIGRATE, &error_in)) {
> > +        return;
> > +    }
> > +
> > +    start_live_migration_thread(s);
> >  }
> >  
> >  void migration_global_dump(Monitor *mon)
> > diff --git a/migration/migration.h b/migration/migration.h
> > index 507284e563..eb5668e1f2 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -263,6 +263,8 @@ struct MigrationState
> >      uint8_t clear_bitmap_shift;
> >  };
> >  
> > +void start_live_migration_thread(MigrationState *s);
> > +
> >  void migrate_set_state(int *state, int old_state, int new_state);
> >  
> >  void migration_fd_process_incoming(QEMUFile *f, Error **errp);
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 

