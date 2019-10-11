Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E495ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:23:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DA9206A1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 14:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DA9206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIvpM-0003PN-37
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 10:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45432)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iIvoO-0002gi-17
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iIvoM-0003Z0-1K
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:22:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iIvoL-0003XQ-OU
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 10:22:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B8B0C10DCCA4;
 Fri, 11 Oct 2019 14:22:28 +0000 (UTC)
Received: from localhost (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91371100EBD3;
 Fri, 11 Oct 2019 14:22:17 +0000 (UTC)
Date: Fri, 11 Oct 2019 16:22:16 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 07/10] migration: add new migration state wait-unplug
Message-ID: <20191011142216.hbzyehh5w7h5i3nb@jenstp.localdomain>
References: <20191011112015.11785-1-jfreimann@redhat.com>
 <20191011112015.11785-8-jfreimann@redhat.com>
 <20191011085334-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191011085334-mutt-send-email-mst@kernel.org>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Fri, 11 Oct 2019 14:22:28 +0000 (UTC)
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
Cc: parav@mellanox.com, aadam@redhat.com, qemu-devel@nongnu.org,
 dgilbert@redhat.com, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 11, 2019 at 08:57:48AM -0400, Michael S. Tsirkin wrote:
>On Fri, Oct 11, 2019 at 01:20:12PM +0200, Jens Freimann wrote:
>> This patch adds a new migration state called wait-unplug.  It is entered
>> after the SETUP state and will transition into ACTIVE once all devices
>> were succesfully unplugged from the guest.
>>
>> So if a guest doesn't respond or takes long to honor the unplug request
>> the user will see the migration state 'wait-unplug'.
>>
>> In the migration thread we query failover devices if they're are still
>> pending the guest unplug. When all are unplugged the migration
>> continues. We give it a defined number of iterations including small
>> waiting periods before we proceed.
>>
>> Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> ---
>>  include/migration/vmstate.h |  2 ++
>>  migration/migration.c       | 34 ++++++++++++++++++++++++++++++++++
>>  migration/migration.h       |  3 +++
>>  migration/savevm.c          | 36 ++++++++++++++++++++++++++++++++++++
>>  migration/savevm.h          |  1 +
>>  qapi/migration.json         |  5 ++++-
>>  6 files changed, 80 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
>> index 1fbfd099dd..39ef125225 100644
>> --- a/include/migration/vmstate.h
>> +++ b/include/migration/vmstate.h
>> @@ -186,6 +186,8 @@ struct VMStateDescription {
>>      int (*pre_save)(void *opaque);
>>      int (*post_save)(void *opaque);
>>      bool (*needed)(void *opaque);
>> +    bool (*dev_unplug_pending)(void *opaque);
>> +
>>      const VMStateField *fields;
>>      const VMStateDescription **subsections;
>>  };
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 5f7e4d15e9..a17d9fb990 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -52,9 +52,14 @@
>>  #include "hw/qdev-properties.h"
>>  #include "monitor/monitor.h"
>>  #include "net/announce.h"
>> +#include "qemu/queue.h"
>>
>>  #define MAX_THROTTLE  (32 << 20)      /* Migration transfer speed throttling */
>>
>> +/* Time in milliseconds to wait for guest OS to unplug PCI device */
>> +#define FAILOVER_GUEST_UNPLUG_WAIT 10000
>
>This value should be controllable from QMP.
>And I think the default should be infinite wait.

ok, I can do that.
>
>> +#define FAILOVER_UNPLUG_RETRIES 5
>
>
>This is a bit of a hack. We really should just
>have unplug signal wakeup, or time expire.
>E.g. a new kind of notifier?

I tried to keep it simple. But you're probably right.
Seems like a new notifier similar to the migration state notifier is a good
option. Maybe I could also reuse the migration state notifier I have
added and check for the new migration state in it. 

Thanks for the review!

regards,
Jens 

>
>> +
>>  /* Amount of time to allocate to each "chunk" of bandwidth-throttled
>>   * data. */
>>  #define BUFFER_DELAY     100
>> @@ -954,6 +959,9 @@ static void fill_source_migration_info(MigrationInfo *info)
>>      case MIGRATION_STATUS_CANCELLED:
>>          info->has_status = true;
>>          break;
>> +    case MIGRATION_STATUS_WAIT_UNPLUG:
>> +        info->has_status = true;
>> +        break;
>>      }
>>      info->status = s->state;
>>  }
>> @@ -1695,6 +1703,7 @@ bool migration_is_idle(void)
>>      case MIGRATION_STATUS_COLO:
>>      case MIGRATION_STATUS_PRE_SWITCHOVER:
>>      case MIGRATION_STATUS_DEVICE:
>> +    case MIGRATION_STATUS_WAIT_UNPLUG:
>>          return false;
>>      case MIGRATION_STATUS__MAX:
>>          g_assert_not_reached();
>> @@ -3224,6 +3233,8 @@ static void *migration_thread(void *opaque)
>>      int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
>>      MigThrError thr_error;
>>      bool urgent = false;
>> +    bool all_unplugged = true;
>> +    int i = 0;
>>
>>      rcu_register_thread();
>>
>> @@ -3260,6 +3271,27 @@ static void *migration_thread(void *opaque)
>>
>>      qemu_savevm_state_setup(s->to_dst_file);
>>
>> +    migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>> +                      MIGRATION_STATUS_WAIT_UNPLUG);
>> +
>> +    while (i < FAILOVER_UNPLUG_RETRIES &&
>> +           s->state == MIGRATION_STATUS_WAIT_UNPLUG) {
>> +        i++;
>> +        qemu_sem_timedwait(&s->wait_unplug_sem, FAILOVER_GUEST_UNPLUG_WAIT);
>
>Should be FAILOVER_GUEST_UNPLUG_WAIT / FAILOVER_UNPLUG_RETRIES
>
>such that time set is the total.
>
>> +        all_unplugged = qemu_savevm_state_guest_unplug_pending();
>> +        if (all_unplugged) {
>> +            break;
>> +        }
>> +    }
>> +
>> +    if (all_unplugged) {
>> +        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
>> +                MIGRATION_STATUS_ACTIVE);
>> +    } else {
>> +        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
>> +                          MIGRATION_STATUS_CANCELLING);
>> +    }
>> +
>>      s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
>>      migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
>>                        MIGRATION_STATUS_ACTIVE);
>> @@ -3508,6 +3540,7 @@ static void migration_instance_finalize(Object *obj)
>>      qemu_mutex_destroy(&ms->qemu_file_lock);
>>      g_free(params->tls_hostname);
>>      g_free(params->tls_creds);
>> +    qemu_sem_destroy(&ms->wait_unplug_sem);
>>      qemu_sem_destroy(&ms->rate_limit_sem);
>>      qemu_sem_destroy(&ms->pause_sem);
>>      qemu_sem_destroy(&ms->postcopy_pause_sem);
>> @@ -3553,6 +3586,7 @@ static void migration_instance_init(Object *obj)
>>      qemu_sem_init(&ms->postcopy_pause_rp_sem, 0);
>>      qemu_sem_init(&ms->rp_state.rp_sem, 0);
>>      qemu_sem_init(&ms->rate_limit_sem, 0);
>> +    qemu_sem_init(&ms->wait_unplug_sem, 0);
>>      qemu_mutex_init(&ms->qemu_file_lock);
>>  }
>>
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 4f2fe193dc..79b3dda146 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -206,6 +206,9 @@ struct MigrationState
>>      /* Flag set once the migration thread called bdrv_inactivate_all */
>>      bool block_inactive;
>>
>> +    /* Migration is waiting for guest to unplug device */
>> +    QemuSemaphore wait_unplug_sem;
>> +
>>      /* Migration is paused due to pause-before-switchover */
>>      QemuSemaphore pause_sem;
>>
>> diff --git a/migration/savevm.c b/migration/savevm.c
>> index bb9462a54d..26e5bde687 100644
>> --- a/migration/savevm.c
>> +++ b/migration/savevm.c
>> @@ -942,6 +942,20 @@ static void qemu_savevm_command_send(QEMUFile *f,
>>      qemu_fflush(f);
>>  }
>>
>> +static int qemu_savevm_nr_failover_devices(void)
>> +{
>> +    SaveStateEntry *se;
>> +    int n = 0;
>> +
>> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +        if (se->vmsd && se->vmsd->dev_unplug_pending) {
>> +            n++;
>> +        }
>> +    }
>> +
>> +    return n;
>> +}
>> +
>>  void qemu_savevm_send_colo_enable(QEMUFile *f)
>>  {
>>      trace_savevm_send_colo_enable();
>> @@ -1113,6 +1127,28 @@ void qemu_savevm_state_header(QEMUFile *f)
>>      }
>>  }
>>
>> +bool qemu_savevm_state_guest_unplug_pending(void)
>> +{
>> +    int nr_failover_devs;
>> +    SaveStateEntry *se;
>> +    bool ret = false;
>> +    int n = 0;
>> +
>> +    nr_failover_devs = qemu_savevm_nr_failover_devices();
>> +
>> +    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
>> +        if (!se->vmsd || !se->vmsd->dev_unplug_pending) {
>> +            continue;
>> +        }
>> +        ret = se->vmsd->dev_unplug_pending(se->opaque);
>> +        if (!ret) {
>> +            n++;
>> +        }
>> +    }
>> +
>> +    return n == nr_failover_devs;
>> +}
>> +
>>  void qemu_savevm_state_setup(QEMUFile *f)
>>  {
>>      SaveStateEntry *se;
>> diff --git a/migration/savevm.h b/migration/savevm.h
>> index 51a4b9caa8..ba64a7e271 100644
>> --- a/migration/savevm.h
>> +++ b/migration/savevm.h
>> @@ -31,6 +31,7 @@
>>
>>  bool qemu_savevm_state_blocked(Error **errp);
>>  void qemu_savevm_state_setup(QEMUFile *f);
>> +bool qemu_savevm_state_guest_unplug_pending(void);
>>  int qemu_savevm_state_resume_prepare(MigrationState *s);
>>  void qemu_savevm_state_header(QEMUFile *f);
>>  int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 52e69e2868..5a06cd489f 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -133,6 +133,9 @@
>>  # @device: During device serialisation when pause-before-switchover is enabled
>>  #        (since 2.11)
>>  #
>> +# @wait-unplug: wait for device unplug request by guest OS to be completed.
>> +#               (since 4.2)
>> +#
>>  # Since: 2.3
>>  #
>>  ##
>> @@ -140,7 +143,7 @@
>>    'data': [ 'none', 'setup', 'cancelling', 'cancelled',
>>              'active', 'postcopy-active', 'postcopy-paused',
>>              'postcopy-recover', 'completed', 'failed', 'colo',
>> -            'pre-switchover', 'device' ] }
>> +            'pre-switchover', 'device', 'wait-unplug' ] }
>>
>>  ##
>>  # @MigrationInfo:
>> --
>> 2.21.0

