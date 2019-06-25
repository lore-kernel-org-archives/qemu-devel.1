Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B456C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23639214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23639214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58374 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiaP-0002A9-Eo
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34588)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hfiWh-0007iQ-T2
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hfiWc-0000z8-FC
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:18:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51945)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hfiWc-0000yF-5f
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:18:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7D26A307D97F;
 Tue, 25 Jun 2019 10:18:05 +0000 (UTC)
Received: from work-vm (ovpn-117-108.ams2.redhat.com [10.36.117.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 62E626085B;
 Tue, 25 Jun 2019 10:18:03 +0000 (UTC)
Date: Tue, 25 Jun 2019 11:18:00 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Message-ID: <20190625101800.GH3226@work-vm>
References: <20190624174636.12428-1-maxiwell@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624174636.12428-1-maxiwell@linux.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 25 Jun 2019 10:18:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: Use RunState enum to save
 global state pre migrate
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Maxiwell S. Garcia (maxiwell@linux.ibm.com) wrote:
> The GlobalState struct has two confusing fields:
> - uint8_t runstate[100]
> - RunState state
> 
> The first field saves the 'current_run_state' from vl.c file before
> migrate. The second field is filled in the post load func using the
> 'runstate' value. So, this commit renames the 'runstate' to
> 'state_pre_migrate' and use the same type used by 'state' and
> 'current_run_state' variables.
> 
> Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>

Hi,
  Thanks for the patch.

  Unfortunately this wont work for a few different reasons:

  a) 'RunState' is an enum whose order and encoding is not specified - 
     to keep migration compatibility the wire format must be stable.
     The textual version is more stable.

  b) It's also too late to change it, because existing migration streams
     send the textual Runstate; this change breaks migration
     compatibility from/to existing qemu's.

Dave

> ---
>  include/sysemu/sysemu.h  |  2 +-
>  migration/global_state.c | 65 ++++++----------------------------------
>  vl.c                     | 11 ++-----
>  3 files changed, 12 insertions(+), 66 deletions(-)
> 
> diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> index 61579ae71e..483b536c4f 100644
> --- a/include/sysemu/sysemu.h
> +++ b/include/sysemu/sysemu.h
> @@ -23,7 +23,7 @@ bool runstate_check(RunState state);
>  void runstate_set(RunState new_state);
>  int runstate_is_running(void);
>  bool runstate_needs_reset(void);
> -bool runstate_store(char *str, size_t size);
> +RunState runstate_get(void);
>  typedef struct vm_change_state_entry VMChangeStateEntry;
>  typedef void VMChangeStateHandler(void *opaque, int running, RunState state);
>  
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 2c8c447239..b49b99f3a1 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -20,8 +20,7 @@
>  #include "trace.h"
>  
>  typedef struct {
> -    uint32_t size;
> -    uint8_t runstate[100];
> +    RunState state_pre_migrate;
>      RunState state;
>      bool received;
>  } GlobalState;
> @@ -30,21 +29,14 @@ static GlobalState global_state;
>  
>  int global_state_store(void)
>  {
> -    if (!runstate_store((char *)global_state.runstate,
> -                        sizeof(global_state.runstate))) {
> -        error_report("runstate name too big: %s", global_state.runstate);
> -        trace_migrate_state_too_big();
> -        return -EINVAL;
> -    }
> +    global_state.state_pre_migrate = runstate_get();
> +
>      return 0;
>  }
>  
>  void global_state_store_running(void)
>  {
> -    const char *state = RunState_str(RUN_STATE_RUNNING);
> -    assert(strlen(state) < sizeof(global_state.runstate));
> -    strncpy((char *)global_state.runstate,
> -           state, sizeof(global_state.runstate));
> +    global_state.state_pre_migrate = RUN_STATE_RUNNING;
>  }
>  
>  bool global_state_received(void)
> @@ -60,7 +52,6 @@ RunState global_state_get_runstate(void)
>  static bool global_state_needed(void *opaque)
>  {
>      GlobalState *s = opaque;
> -    char *runstate = (char *)s->runstate;
>  
>      /* If it is not optional, it is mandatory */
>  
> @@ -70,8 +61,8 @@ static bool global_state_needed(void *opaque)
>  
>      /* If state is running or paused, it is not needed */
>  
> -    if (strcmp(runstate, "running") == 0 ||
> -        strcmp(runstate, "paused") == 0) {
> +    if (s->state_pre_migrate == RUN_STATE_RUNNING ||
> +        s->state_pre_migrate == RUN_STATE_PAUSED) {
>          return false;
>      }
>  
> @@ -82,45 +73,10 @@ static bool global_state_needed(void *opaque)
>  static int global_state_post_load(void *opaque, int version_id)
>  {
>      GlobalState *s = opaque;
> -    Error *local_err = NULL;
> -    int r;
> -    char *runstate = (char *)s->runstate;
> -
>      s->received = true;
> -    trace_migrate_global_state_post_load(runstate);
> -
> -    if (strnlen((char *)s->runstate,
> -                sizeof(s->runstate)) == sizeof(s->runstate)) {
> -        /*
> -         * This condition should never happen during migration, because
> -         * all runstate names are shorter than 100 bytes (the size of
> -         * s->runstate). However, a malicious stream could overflow
> -         * the qapi_enum_parse() call, so we force the last character
> -         * to a NUL byte.
> -         */
> -        s->runstate[sizeof(s->runstate) - 1] = '\0';
> -    }
> -    r = qapi_enum_parse(&RunState_lookup, runstate, -1, &local_err);
> -
> -    if (r == -1) {
> -        if (local_err) {
> -            error_report_err(local_err);
> -        }
> -        return -EINVAL;
> -    }
> -    s->state = r;
> -
> -    return 0;
> -}
> -
> -static int global_state_pre_save(void *opaque)
> -{
> -    GlobalState *s = opaque;
> -
> -    trace_migrate_global_state_pre_save((char *)s->runstate);
> -    s->size = strnlen((char *)s->runstate, sizeof(s->runstate)) + 1;
> -    assert(s->size <= sizeof(s->runstate));
> +    s->state = s->state_pre_migrate;
>  
> +    trace_migrate_global_state_post_load(RunState_str(s->state));
>      return 0;
>  }
>  
> @@ -129,11 +85,9 @@ static const VMStateDescription vmstate_globalstate = {
>      .version_id = 1,
>      .minimum_version_id = 1,
>      .post_load = global_state_post_load,
> -    .pre_save = global_state_pre_save,
>      .needed = global_state_needed,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT32(size, GlobalState),
> -        VMSTATE_BUFFER(runstate, GlobalState),
> +        VMSTATE_UINT32(state_pre_migrate, GlobalState),
>          VMSTATE_END_OF_LIST()
>      },
>  };
> @@ -141,7 +95,6 @@ static const VMStateDescription vmstate_globalstate = {
>  void register_global_state(void)
>  {
>      /* We would use it independently that we receive it */
> -    strcpy((char *)&global_state.runstate, "");
>      global_state.received = false;
>      vmstate_register(NULL, 0, &vmstate_globalstate, &global_state);
>  }
> diff --git a/vl.c b/vl.c
> index 99a56b5556..2b15d68d60 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -680,16 +680,9 @@ bool runstate_check(RunState state)
>      return current_run_state == state;
>  }
>  
> -bool runstate_store(char *str, size_t size)
> +RunState runstate_get(void)
>  {
> -    const char *state = RunState_str(current_run_state);
> -    size_t len = strlen(state) + 1;
> -
> -    if (len > size) {
> -        return false;
> -    }
> -    memcpy(str, state, len);
> -    return true;
> +    return current_run_state;
>  }
>  
>  static void runstate_init(void)
> -- 
> 2.20.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

