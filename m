Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C55C3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:19:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A6722CEC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 16:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A6722CEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1CHc-0002k8-KX
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 12:19:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43669)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i1CGU-0002JK-Cd
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:18:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i1CGS-0006He-O7
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:18:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45540)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i1CGS-0006Gy-GM
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 12:18:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5152D2A09C2;
 Fri, 23 Aug 2019 16:18:11 +0000 (UTC)
Received: from work-vm (ovpn-117-244.ams2.redhat.com [10.36.117.244])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 426B16092D;
 Fri, 23 Aug 2019 16:18:10 +0000 (UTC)
Date: Fri, 23 Aug 2019 17:18:07 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190823161807.GP2784@work-vm>
References: <20190621142739.23703-1-richardw.yang@linux.intel.com>
 <20190819112632.GA2765@work-vm>
 <20190819140828.otv7vq5lahvquczl@master>
 <20190823152916.GN2784@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823152916.GN2784@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 23 Aug 2019 16:18:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migrtion: define
 MigrationState/MigrationIncomingState.state as MigrationStatus
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
Cc: quintela@redhat.com, Wei Yang <richardw.yang@linux.intel.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> * Wei Yang (richard.weiyang@gmail.com) wrote:
> > On Mon, Aug 19, 2019 at 12:26:32PM +0100, Dr. David Alan Gilbert wrote:
> > >* Wei Yang (richardw.yang@linux.intel.com) wrote:
> > >> No functional change. Add default case to fix warning.
> > >
> > >I think the problem with this is that migrate_set_state uses an
> > >atomic_cmpxchg and so we have to be careful that the type we use
> > >is compatible with that.
> > >MigrationStatus is an enum and I think compilers are allowed to
> > >choose the types of that;  so I'm not sure we're guaranteed
> > >that an enum is always OK for the atomic_cmpxchg, and if it is
> > 
> > Took a look into the definition of atomic_cmpxchg, which finally calls
> > 
> >   * __atomic_compare_exchange_n for c++11
> >   * __sync_val_compare_and_swap
> > 
> > Both of them take two pointers to compare and exchange its content.
> > 
> > Per C99 standard, http://www.open-std.org/JTC1/SC22/WG14/www/docs/n1256.pdf,
> > it mentioned:
> > 
> >   Each enumerated type shall be compatible with char, a signed integer type,
> >   or an unsigned integer type. The choice of type is implementation-defined,
> >   but shall be capable of representing the values of all the members of the
> >   enumeration.
> > 
> > Based on this, I think atomic_cmpxchg should work fine with enum.
> 
> Hmm OK, but I'd need you to test n some 32bit and other comp=ilers etc;
> make sure it works on 32bit, clang, gcc, 32bit ARM etc - because
> otherwise I'm going to have to worry about checking all those.

Actually since QEMU is defined to be C99, the test is to check with some
C99 compilers; eblake assures me that in theory C11 should be OK,
but C99 and our atomics are more of an interesting question.

Dave
> Dave
> 
> > >then we also might have to make the old_state and new_state
> > >variables match.
> > >
> > 
> > You are right.
> > >Dave
> > >
> > >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> > >> ---
> > >>  migration/migration.c | 8 +++++++-
> > >>  migration/migration.h | 6 +++---
> > >>  2 files changed, 10 insertions(+), 4 deletions(-)
> > >> 
> > >> diff --git a/migration/migration.c b/migration/migration.c
> > >> index 2865ae3fa9..0fd2364961 100644
> > >> --- a/migration/migration.c
> > >> +++ b/migration/migration.c
> > >> @@ -946,6 +946,8 @@ static void fill_source_migration_info(MigrationInfo *info)
> > >>      case MIGRATION_STATUS_CANCELLED:
> > >>          info->has_status = true;
> > >>          break;
> > >> +    default:
> > >> +        return;
> > >>      }
> > >>      info->status = s->state;
> > >>  }
> > >> @@ -1054,6 +1056,8 @@ static void fill_destination_migration_info(MigrationInfo *info)
> > >>          info->has_status = true;
> > >>          fill_destination_postcopy_migration_info(info);
> > >>          break;
> > >> +    default:
> > >> +        return;
> > >>      }
> > >>      info->status = mis->state;
> > >>  }
> > >> @@ -1446,7 +1450,7 @@ void qmp_migrate_start_postcopy(Error **errp)
> > >>  
> > >>  /* shared migration helpers */
> > >>  
> > >> -void migrate_set_state(int *state, int old_state, int new_state)
> > >> +void migrate_set_state(MigrationStatus *state, int old_state, int new_state)
> > >>  {
> > >>      assert(new_state < MIGRATION_STATUS__MAX);
> > >>      if (atomic_cmpxchg(state, old_state, new_state) == old_state) {
> > >> @@ -1683,6 +1687,8 @@ bool migration_is_idle(void)
> > >>          return false;
> > >>      case MIGRATION_STATUS__MAX:
> > >>          g_assert_not_reached();
> > >> +    default:
> > >> +        g_assert_not_reached();
> > >>      }
> > >>  
> > >>      return false;
> > >> diff --git a/migration/migration.h b/migration/migration.h
> > >> index 5e8f09c6db..418ee00053 100644
> > >> --- a/migration/migration.h
> > >> +++ b/migration/migration.h
> > >> @@ -65,7 +65,7 @@ struct MigrationIncomingState {
> > >>  
> > >>      QEMUBH *bh;
> > >>  
> > >> -    int state;
> > >> +    MigrationStatus state;
> > >>  
> > >>      bool have_colo_incoming_thread;
> > >>      QemuThread colo_incoming_thread;
> > >> @@ -151,7 +151,7 @@ struct MigrationState
> > >>      /* params from 'migrate-set-parameters' */
> > >>      MigrationParameters parameters;
> > >>  
> > >> -    int state;
> > >> +    MigrationStatus state;
> > >>  
> > >>      /* State related to return path */
> > >>      struct {
> > >> @@ -234,7 +234,7 @@ struct MigrationState
> > >>      bool decompress_error_check;
> > >>  };
> > >>  
> > >> -void migrate_set_state(int *state, int old_state, int new_state);
> > >> +void migrate_set_state(MigrationStatus *state, int old_state, int new_state);
> > >>  
> > >>  void migration_fd_process_incoming(QEMUFile *f);
> > >>  void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
> > >> -- 
> > >> 2.19.1
> > >> 
> > >--
> > >Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> > 
> > -- 
> > Wei Yang
> > Help you, Help me
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

