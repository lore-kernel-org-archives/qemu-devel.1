Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 345C9C48BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:39:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B72922084B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 21:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B72922084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35438 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hftAB-0002Gy-4h
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 17:39:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51815)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <maxiwell@linux.ibm.com>) id 1hft8c-0001Om-0F
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maxiwell@linux.ibm.com>) id 1hft8S-0007KV-HI
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:37:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:9570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <maxiwell@linux.ibm.com>)
 id 1hft8I-0004xz-06
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 17:37:43 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
 x5PLYpcd029396
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 17:35:48 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2tbr8089c6-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 17:35:47 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <qemu-devel@nongnu.org> from <maxiwell@linux.ibm.com>;
 Tue, 25 Jun 2019 22:35:46 +0100
Received: from b03cxnp08027.gho.boulder.ibm.com (9.17.130.19)
 by e32.co.us.ibm.com (192.168.1.132) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Tue, 25 Jun 2019 22:35:44 +0100
Received: from b03ledav005.gho.boulder.ibm.com
 (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 x5PLZhM048497014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Jun 2019 21:35:43 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 465BBBE051;
 Tue, 25 Jun 2019 21:35:43 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9678FBE056;
 Tue, 25 Jun 2019 21:35:41 +0000 (GMT)
Received: from maxibm (unknown [9.85.183.216])
 by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTPS;
 Tue, 25 Jun 2019 21:35:41 +0000 (GMT)
Date: Tue, 25 Jun 2019 18:35:35 -0300
From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20190624174636.12428-1-maxiwell@linux.ibm.com>
 <20190625101800.GH3226@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190625101800.GH3226@work-vm>
User-Agent: NeoMutt/20180716
X-TM-AS-GCONF: 00
x-cbid: 19062521-0004-0000-0000-00001521168D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011330; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000286; SDB=6.01223234; UDB=6.00643715; IPR=6.01004407; 
 MB=3.00027467; MTD=3.00000008; XFM=3.00000015; UTC=2019-06-25 21:35:46
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062521-0005-0000-0000-00008C38C34E
Message-Id: <20190625213535.2b7f2y2t4sybenid@maxibm>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2019-06-25_14:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250166
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 148.163.156.1
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

On Tue, Jun 25, 2019 at 11:18:00AM +0100, Dr. David Alan Gilbert wrote:
> * Maxiwell S. Garcia (maxiwell@linux.ibm.com) wrote:
> > The GlobalState struct has two confusing fields:
> > - uint8_t runstate[100]
> > - RunState state
> > 
> > The first field saves the 'current_run_state' from vl.c file before
> > migrate. The second field is filled in the post load func using the
> > 'runstate' value. So, this commit renames the 'runstate' to
> > 'state_pre_migrate' and use the same type used by 'state' and
> > 'current_run_state' variables.
> > 
> > Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> 
> Hi,
>   Thanks for the patch.
> 
>   Unfortunately this wont work for a few different reasons:
> 
>   a) 'RunState' is an enum whose order and encoding is not specified - 
>      to keep migration compatibility the wire format must be stable.
>      The textual version is more stable.
> 
>   b) It's also too late to change it, because existing migration streams
>      send the textual Runstate; this change breaks migration
>      compatibility from/to existing qemu's.
> 

It makes sense. What do you think about adding a comment to explain it
(as suggest Philippe) and change the 'runstate' to 'state_stored' (or
'state_pre_migrate') to improve the legibility?

Thanks,


> Dave
> 
> > ---
> >  include/sysemu/sysemu.h  |  2 +-
> >  migration/global_state.c | 65 ++++++----------------------------------
> >  vl.c                     | 11 ++-----
> >  3 files changed, 12 insertions(+), 66 deletions(-)
> > 
> > diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
> > index 61579ae71e..483b536c4f 100644
> > --- a/include/sysemu/sysemu.h
> > +++ b/include/sysemu/sysemu.h
> > @@ -23,7 +23,7 @@ bool runstate_check(RunState state);
> >  void runstate_set(RunState new_state);
> >  int runstate_is_running(void);
> >  bool runstate_needs_reset(void);
> > -bool runstate_store(char *str, size_t size);
> > +RunState runstate_get(void);
> >  typedef struct vm_change_state_entry VMChangeStateEntry;
> >  typedef void VMChangeStateHandler(void *opaque, int running, RunState state);
> >  
> > diff --git a/migration/global_state.c b/migration/global_state.c
> > index 2c8c447239..b49b99f3a1 100644
> > --- a/migration/global_state.c
> > +++ b/migration/global_state.c
> > @@ -20,8 +20,7 @@
> >  #include "trace.h"
> >  
> >  typedef struct {
> > -    uint32_t size;
> > -    uint8_t runstate[100];
> > +    RunState state_pre_migrate;
> >      RunState state;
> >      bool received;
> >  } GlobalState;
> > @@ -30,21 +29,14 @@ static GlobalState global_state;
> >  
> >  int global_state_store(void)
> >  {
> > -    if (!runstate_store((char *)global_state.runstate,
> > -                        sizeof(global_state.runstate))) {
> > -        error_report("runstate name too big: %s", global_state.runstate);
> > -        trace_migrate_state_too_big();
> > -        return -EINVAL;
> > -    }
> > +    global_state.state_pre_migrate = runstate_get();
> > +
> >      return 0;
> >  }
> >  
> >  void global_state_store_running(void)
> >  {
> > -    const char *state = RunState_str(RUN_STATE_RUNNING);
> > -    assert(strlen(state) < sizeof(global_state.runstate));
> > -    strncpy((char *)global_state.runstate,
> > -           state, sizeof(global_state.runstate));
> > +    global_state.state_pre_migrate = RUN_STATE_RUNNING;
> >  }
> >  
> >  bool global_state_received(void)
> > @@ -60,7 +52,6 @@ RunState global_state_get_runstate(void)
> >  static bool global_state_needed(void *opaque)
> >  {
> >      GlobalState *s = opaque;
> > -    char *runstate = (char *)s->runstate;
> >  
> >      /* If it is not optional, it is mandatory */
> >  
> > @@ -70,8 +61,8 @@ static bool global_state_needed(void *opaque)
> >  
> >      /* If state is running or paused, it is not needed */
> >  
> > -    if (strcmp(runstate, "running") == 0 ||
> > -        strcmp(runstate, "paused") == 0) {
> > +    if (s->state_pre_migrate == RUN_STATE_RUNNING ||
> > +        s->state_pre_migrate == RUN_STATE_PAUSED) {
> >          return false;
> >      }
> >  
> > @@ -82,45 +73,10 @@ static bool global_state_needed(void *opaque)
> >  static int global_state_post_load(void *opaque, int version_id)
> >  {
> >      GlobalState *s = opaque;
> > -    Error *local_err = NULL;
> > -    int r;
> > -    char *runstate = (char *)s->runstate;
> > -
> >      s->received = true;
> > -    trace_migrate_global_state_post_load(runstate);
> > -
> > -    if (strnlen((char *)s->runstate,
> > -                sizeof(s->runstate)) == sizeof(s->runstate)) {
> > -        /*
> > -         * This condition should never happen during migration, because
> > -         * all runstate names are shorter than 100 bytes (the size of
> > -         * s->runstate). However, a malicious stream could overflow
> > -         * the qapi_enum_parse() call, so we force the last character
> > -         * to a NUL byte.
> > -         */
> > -        s->runstate[sizeof(s->runstate) - 1] = '\0';
> > -    }
> > -    r = qapi_enum_parse(&RunState_lookup, runstate, -1, &local_err);
> > -
> > -    if (r == -1) {
> > -        if (local_err) {
> > -            error_report_err(local_err);
> > -        }
> > -        return -EINVAL;
> > -    }
> > -    s->state = r;
> > -
> > -    return 0;
> > -}
> > -
> > -static int global_state_pre_save(void *opaque)
> > -{
> > -    GlobalState *s = opaque;
> > -
> > -    trace_migrate_global_state_pre_save((char *)s->runstate);
> > -    s->size = strnlen((char *)s->runstate, sizeof(s->runstate)) + 1;
> > -    assert(s->size <= sizeof(s->runstate));
> > +    s->state = s->state_pre_migrate;
> >  
> > +    trace_migrate_global_state_post_load(RunState_str(s->state));
> >      return 0;
> >  }
> >  
> > @@ -129,11 +85,9 @@ static const VMStateDescription vmstate_globalstate = {
> >      .version_id = 1,
> >      .minimum_version_id = 1,
> >      .post_load = global_state_post_load,
> > -    .pre_save = global_state_pre_save,
> >      .needed = global_state_needed,
> >      .fields = (VMStateField[]) {
> > -        VMSTATE_UINT32(size, GlobalState),
> > -        VMSTATE_BUFFER(runstate, GlobalState),
> > +        VMSTATE_UINT32(state_pre_migrate, GlobalState),
> >          VMSTATE_END_OF_LIST()
> >      },
> >  };
> > @@ -141,7 +95,6 @@ static const VMStateDescription vmstate_globalstate = {
> >  void register_global_state(void)
> >  {
> >      /* We would use it independently that we receive it */
> > -    strcpy((char *)&global_state.runstate, "");
> >      global_state.received = false;
> >      vmstate_register(NULL, 0, &vmstate_globalstate, &global_state);
> >  }
> > diff --git a/vl.c b/vl.c
> > index 99a56b5556..2b15d68d60 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -680,16 +680,9 @@ bool runstate_check(RunState state)
> >      return current_run_state == state;
> >  }
> >  
> > -bool runstate_store(char *str, size_t size)
> > +RunState runstate_get(void)
> >  {
> > -    const char *state = RunState_str(current_run_state);
> > -    size_t len = strlen(state) + 1;
> > -
> > -    if (len > size) {
> > -        return false;
> > -    }
> > -    memcpy(str, state, len);
> > -    return true;
> > +    return current_run_state;
> >  }
> >  
> >  static void runstate_init(void)
> > -- 
> > 2.20.1
> > 
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 


