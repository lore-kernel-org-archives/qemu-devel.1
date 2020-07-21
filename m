Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBDE20714
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 08:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBDE20714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxnYl-00042R-Bq
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 04:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jxnXa-0003LW-Id
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:22:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:45234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jxnXW-0006Fc-Fb
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 04:22:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 00B9CAD18;
 Tue, 21 Jul 2020 08:22:19 +0000 (UTC)
Subject: Re: migration: broken snapshot saves appear on s390 when small fields
 in migration stream removed
From: Claudio Fontana <cfontana@suse.de>
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf
 <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
References: <8bbafdec-836d-b7de-cab8-7a325b6e238d@suse.de>
 <55c406cd-b9ca-4e9b-0acd-d33cfe2a70e3@redhat.com>
 <bf074240-8cc3-96ff-e95e-bd301822b756@suse.de>
 <ea3b617f-c2ea-534c-06ba-f5f9f43828a7@suse.de>
 <8125b1ff-373a-aadc-eccf-27c567007a27@redhat.com>
 <8ff7eeab-bef1-0957-a95c-72819680c431@suse.de>
 <1db6d502-73d1-5e3d-10d1-796d80ab8f07@suse.de>
 <13728e69-75a5-2edc-9ed3-6e08d94c722d@suse.de>
Message-ID: <636bb3c4-2242-284b-30cd-299f447117c2@suse.de>
Date: Tue, 21 Jul 2020 10:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <13728e69-75a5-2edc-9ed3-6e08d94c722d@suse.de>
Content-Type: multipart/mixed; boundary="------------A9E367F46680C57DAD7DC43F"
Content-Language: en-US
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/21 00:27:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, Fam Zheng <fam@euphon.net>,
 Liang Yan <lyan@suse.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Bruce Rogers <brogers@suse.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------A9E367F46680C57DAD7DC43F
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

On 7/20/20 8:24 PM, Claudio Fontana wrote:
> I have now been able to reproduce this on X86 as well.
> 
> It happens much more rarely, about once every 10 times.
> 
> I will sort out the data and try to make it even more reproducible, then post my findings in detail.
> 
> Overall I proceeded as follows:
> 
> 1) hooked the savevm code to skip all fields with the exception of "s390-skeys". So only s390-skeys are actually saved.
> 
> 2) reimplemented "s390-skeys" in a common implementation in cpus.c, used on both x86 and s390, modeling the behaviour of save/load from hw/s390
> 
> 3) ran ./check -qcow2 267 on both x86 and s390.
> 
> In the case of s390, failure seems to be reproducible 100% of the times.
> On X86, it is as mentioned failing about 10% of the times.
> 
> Ciao,
> 
> Claudio


And here is a small series of two patches that can be used to reproduce the problem.

Clearly, this is not directly related to s390 or to skeys or to icount in particular, it is just an issue that happened to be more visible there.

If you could help with this, please apply the attached patches.

Patch 1 just adds a new "300" iotest. It is way easier to extract the relevant part out of test 267, which does a bit too much in the same file.
Also this allows easier use of valgrind, since it does not "require" anything.

Patch 2 hooks the savevm code to skip all fields during the snapshot with the exception of "s390-skeys", a new artificial field implemented to
model what the real s390-skeys is doing.

After applying patch 1 and patch 2, you can test (also on X86), with:

./check -qcow2 300

On X86 many runs will be successful, but a certain % of them will instead fail like this:


claudio@linux-ch70:~/git/qemu-pristine/qemu-build/tests/qemu-iotests> ./check -qcow2 300
QEMU          -- "/home/claudio/git/qemu-pristine/qemu-build/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_64" -nodefaults -display none -accel qtest
QEMU_IMG      -- "/home/claudio/git/qemu-pristine/qemu-build/tests/qemu-iotests/../../qemu-img" 
QEMU_IO       -- "/home/claudio/git/qemu-pristine/qemu-build/tests/qemu-iotests/../../qemu-io"  --cache writeback --aio threads -f qcow2
QEMU_NBD      -- "/home/claudio/git/qemu-pristine/qemu-build/tests/qemu-iotests/../../qemu-nbd" 
IMGFMT        -- qcow2 (compat=1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 linux-ch70 4.12.14-lp151.28.36-default
TEST_DIR      -- /home/claudio/git/qemu-pristine/qemu-build/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.gdcUu3l0SM
SOCKET_SCM_HELPER -- /home/claudio/git/qemu-pristine/qemu-build/tests/qemu-iotests/socket_scm_helper

300      fail       [10:14:05] [10:14:06]      (last: 0s)    output mismatch (see 300.out.bad)
--- /home/claudio/git/qemu-pristine/qemu/tests/qemu-iotests/300.out     2020-07-21 10:03:54.468104764 +0200
+++ /home/claudio/git/qemu-pristine/qemu-build/tests/qemu-iotests/300.out.bad   2020-07-21 10:14:06.098090543 +0200
@@ -12,6 +12,9 @@
 ID        TAG                 VM SIZE                DATE       VM CLOCK
 --        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
 (qemu) loadvm snap0
+Unexpected storage key data: 0
+error while loading state for instance 0x0 of device 's390-skeys'
+Error: Error -22 while loading VM state
 (qemu) quit
 
 *** done
Failures: 300
Failed 1 of 1 iotests


At this point somebody more knowledgeable about QCOW2, coroutines and backing files could chime in?

Thanks,

Claudio

> 
> 
> On 7/16/20 2:58 PM, Claudio Fontana wrote:
>> Small update on this,
>>
>> On 7/15/20 1:10 PM, Claudio Fontana wrote:
>>> Hi Thomas,
>>>
>>> On 7/14/20 4:35 PM, Thomas Huth wrote:
>>>> On 14/07/2020 16.29, Claudio Fontana wrote:
>>>>> Hello,
>>>>>
>>>>> I have some tiny progress in narrowing down this issue, possibly a qcow2 issue, still unclear,
>>>>> but involving Kevin Wolf and Max Reitz.
>>>>>
>>>>>
>>>>> The reproducer again:
>>>>>
>>>>>> --------------------------------------------cut-------------------------------------------
>>>>>> diff --git a/cpus.c b/cpus.c
>>>>>> index 41d1c5099f..443b88697a 100644
>>>>>> --- a/cpus.c
>>>>>> +++ b/cpus.c
>>>>>> @@ -643,7 +643,7 @@ static void qemu_account_warp_timer(void)
>>>>>>  
>>>>>>  static bool icount_state_needed(void *opaque)
>>>>>>  {
>>>>>> -    return use_icount;
>>>>>> +    return 0;
>>>>>>  }
>>>>>>  
>>>>>>  static bool warp_timer_state_needed(void *opaque)
>>>>>> --------------------------------------------cut-------------------------------------------
>>>>>
>>>>> This issue for now appears on s390 only:
>>>>>
>>>>> On s390 hardware, test 267 fails (both kvm and tcg) in the qcow2 backing file part, with broken migration stream data in the s390-skeys vmsave (old style).
>>>> [...]
>>>>> If someone has a good idea let me know - first attempts to reproduce on x86 failed, but maybe more work could lead to it.
>>>>
>>>
>>> small update: in the GOOD case (enough padding added) a qcow_merge() is triggered for the last write of 16202 bytes.
>>> In the BAD case (not enough padding added) a qcow_merge() is not triggered for the last write of 16201 bytes.
>>>
>>> Note: manually flushing with qemu_fflush in s390-skeys vmsave also works (maybe got lost in the noise).
>>>
>>>
>>>> Two questions:
>>>>
>>>> 1) Can you also reproduce the issue manually, without running iotest
>>>> 267? ... I tried, but so far I failed.
>>>
>>> Thanks for the suggestion, will try.
>>
>> Currently trying to reproduce manually an environment similar to that of the test,
>> at the moment I am not able to reproduce the issue manually.
>>
>> Not very familiar with s390,
>> I've been running with 
>>
>> export QEMU=/home/cfontana/qemu-build/s390x-softmmu/qemu-system-s390x
>>
>> $QEMU -nographic -monitor stdio -nodefaults -no-shutdown FILENAME
>>
>> where FILENAME is the qcow2 produced by the test.
>>
>> let me know if you have a suggestion on how to setup up something simple properly.
>>
>>
>>>
>>>>
>>>> 2) Since all the information so far sounds like the problem could be
>>>> elsewhere in the code, and the skeys just catch it by accident ... have
>>>> you tried running with valgrind? Maybe it catches something useful?
>>>
>>> Nothing yet, but will fiddle with the options a bit more.
>>
>> Only thing I have seen so far:
>>
>>
>> +==33321== 
>> +==33321== Warning: client switching stacks?  SP change: 0x1ffeffe5e8 --> 0x5d9cf60
>> +==33321==          to suppress, use: --max-stackframe=137324009096 or greater
>> +==33321== Warning: client switching stacks?  SP change: 0x5d9cd18 --> 0x1ffeffe5e8
>> +==33321==          to suppress, use: --max-stackframe=137324009680 or greater
>> +==33321== Warning: client switching stacks?  SP change: 0x1ffeffe8b8 --> 0x5d9ce58
>> +==33321==          to suppress, use: --max-stackframe=137324010080 or greater
>> +==33321==          further instances of this message will not be shown.
>> +==33321== Thread 4:
>> +==33321== Conditional jump or move depends on uninitialised value(s)
>> +==33321==    at 0x3AEC70: process_queued_cpu_work (cpus-common.c:331)
>> +==33321==    by 0x2753E1: qemu_wait_io_event_common (cpus.c:1213)
>> +==33321==    by 0x2755CD: qemu_wait_io_event (cpus.c:1253)
>> +==33321==    by 0x27596D: qemu_dummy_cpu_thread_fn (cpus.c:1337)
>> +==33321==    by 0x725C87: qemu_thread_start (qemu-thread-posix.c:521)
>> +==33321==    by 0x4D504E9: start_thread (in /lib64/libpthread-2.26.so)
>> +==33321==    by 0x4E72BBD: ??? (in /lib64/libc-2.26.so)
>> +==33321== 
>> +==33321== Conditional jump or move depends on uninitialised value(s)
>> +==33321==    at 0x3AEC74: process_queued_cpu_work (cpus-common.c:331)
>> +==33321==    by 0x2753E1: qemu_wait_io_event_common (cpus.c:1213)
>> +==33321==    by 0x2755CD: qemu_wait_io_event (cpus.c:1253)
>> +==33321==    by 0x27596D: qemu_dummy_cpu_thread_fn (cpus.c:1337)
>> +==33321==    by 0x725C87: qemu_thread_start (qemu-thread-posix.c:521)
>> +==33321==    by 0x4D504E9: start_thread (in /lib64/libpthread-2.26.so)
>> +==33321==    by 0x4E72BBD: ??? (in /lib64/libc-2.26.so)
>> +==33321== 
>> +==33321== 
>> +==33321== HEAP SUMMARY:
>> +==33321==     in use at exit: 2,138,442 bytes in 13,935 blocks
>> +==33321==   total heap usage: 19,089 allocs, 5,154 frees, 5,187,670 bytes allocated
>> +==33321== 
>> +==33321== LEAK SUMMARY:
>> +==33321==    definitely lost: 0 bytes in 0 blocks
>> +==33321==    indirectly lost: 0 bytes in 0 blocks
>> +==33321==      possibly lost: 7,150 bytes in 111 blocks
>> +==33321==    still reachable: 2,131,292 bytes in 13,824 blocks
>> +==33321==         suppressed: 0 bytes in 0 blocks
>> +==33321== Rerun with --leak-check=full to see details of leaked memory
>>
>>
>>>
>>>>
>>>>  Thomas
>>>>
>>>
>>> Ciao,
>>>
>>> Claudio
>>>
>>>
>>
>> A more interesting update is what follows I think.
>>
>> I was able to "fix" the problem shown by the reproducer:
>>
>> @@ -643,7 +643,7 @@ static void qemu_account_warp_tim@@ -643,7 +643,7 @@ static void qemu_account_warp_timer(void)
>>  
>>  static bool icount_state_needed(void *opaque)
>>  {
>> -    return use_icount;
>> +    return 0;
>>  }
>>  
>> by just slowing down qcow2_co_pwritev_task_entry with some tight loops,
>> without changing any fields between runs (other than the reproducer icount field removal).
>>
>> I tried to insert the same slowdown just in savevm.c at the end of save_snapshot, but that does not work, needs to be in the coroutine.
>>
>> Thanks,
>>
>> Claudio
>>
>>
> 
> 


--------------A9E367F46680C57DAD7DC43F
Content-Type: text/x-patch; charset=UTF-8;
 name="0002-XXX-reproducer-for-backing-file-migration-test-issue.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0002-XXX-reproducer-for-backing-file-migration-test-issue.pa";
 filename*1="tch"

From 36538b4dfde5ccaa663d3d7c738fdef595027cb6 Mon Sep 17 00:00:00 2001
From: Claudio Fontana <cfontana@suse.de>
Date: Tue, 21 Jul 2020 10:10:29 +0200
Subject: [PATCH 2/2] XXX reproducer for backing file migration test issue

do not commit. During a snapshot save, this changeset throws away
all fields from the stream with the exception of "s390-skeys",
which is added as a field for all architectures (renaming the
real s390-skeys to something else).

This allows to compare the reproducibility of the snapshot
issue with all architectures.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 hw/s390x/s390-skeys.c |  2 +-
 migration/savevm.c    | 31 +++++++++++++++++++++++
 softmmu/cpus.c        | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index db2f49cb27..41116bdcc1 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -389,7 +389,7 @@ static inline void s390_skeys_set_migration_enabled(Object *obj, bool value,
     ss->migration_enabled = value;
 
     if (ss->migration_enabled) {
-        register_savevm_live(TYPE_S390_SKEYS, 0, 1,
+        register_savevm_live("s390-oldkeys", 0, 1,
                              &savevm_s390_storage_keys, ss);
     } else {
         unregister_savevm(VMSTATE_IF(ss), TYPE_S390_SKEYS, ss);
diff --git a/migration/savevm.c b/migration/savevm.c
index 45c9dd9d8a..b63af07ccd 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1163,6 +1163,11 @@ void qemu_savevm_state_setup(QEMUFile *f)
 
     trace_savevm_state_setup();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+
+        if (strcmp(se->idstr, "s390-skeys") != 0) {
+            /* only save keys */
+            continue;
+        }
         if (!se->ops || !se->ops->save_setup) {
             continue;
         }
@@ -1194,6 +1199,11 @@ int qemu_savevm_state_resume_prepare(MigrationState *s)
     trace_savevm_state_resume_prepare();
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+
+        if (strcmp(se->idstr, "s390-skeys") != 0) {
+            /* only save keys */
+            continue;
+        }
         if (!se->ops || !se->ops->resume_prepare) {
             continue;
         }
@@ -1224,6 +1234,11 @@ int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy)
 
     trace_savevm_state_iterate();
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+
+        if (strcmp(se->idstr, "s390-skeys") != 0) {
+            /* only save keys */
+            continue;
+        }
         if (!se->ops || !se->ops->save_live_iterate) {
             continue;
         }
@@ -1325,6 +1340,12 @@ int qemu_savevm_state_complete_precopy_iterable(QEMUFile *f, bool in_postcopy)
     int ret;
 
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+
+        if (strcmp(se->idstr, "s390-skeys") != 0) {
+            /* only save keys */
+            continue;
+        }
+
         if (!se->ops ||
             (in_postcopy && se->ops->has_postcopy &&
              se->ops->has_postcopy(se->opaque)) ||
@@ -1368,6 +1389,11 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     json_start_array(vmdesc, "devices");
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
 
+        if (strcmp(se->idstr, "s390-skeys") != 0) {
+            /* only save keys */
+            continue;
+        }
+
         if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
             continue;
         }
@@ -1583,6 +1609,11 @@ int qemu_save_device_state(QEMUFile *f)
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         int ret;
 
+        if (strcmp(se->idstr, "s390-skeys") != 0) {
+            /* only save keys */
+            continue;
+        }
+
         if (se->is_ram) {
             continue;
         }
diff --git a/softmmu/cpus.c b/softmmu/cpus.c
index a802e899ab..ae3ad0878c 100644
--- a/softmmu/cpus.c
+++ b/softmmu/cpus.c
@@ -63,6 +63,9 @@
 
 #include "sysemu/cpu-throttle.h"
 
+#include "migration/qemu-file-types.h"
+#include "migration/register.h"
+
 #ifdef CONFIG_LINUX
 
 #include <sys/prctl.h>
@@ -732,11 +735,76 @@ static const VMStateDescription vmstate_timers = {
     }
 };
 
+static void s390_storage_keys_save(QEMUFile *f, void *opaque)
+{
+    uint64_t eos = 1, data = 2;
+    uint8_t *buf;
+
+    buf = g_try_malloc(32768);
+    if (!buf) {
+        error_report("storage key save could not allocate memory");
+        goto end_stream;
+    }
+
+    qemu_put_be64(f, data);
+    qemu_put_be64(f, 32768);
+
+    memset(buf, 0, 32768);
+    qemu_put_buffer(f, buf, 32768);
+    g_free(buf);
+
+ end_stream:
+    qemu_put_be64(f, eos);
+}
+
+static int s390_storage_keys_load(QEMUFile *f, void *opaque, int version_id)
+{
+    int ret = 0;
+    uint64_t data;
+    uint8_t *buf;
+
+    while (ret == 0) {
+        data = qemu_get_be64(f);
+
+        switch (data) {
+        case 2: {
+            const uint64_t total_count = qemu_get_be64(f);
+            buf = g_try_malloc(32768);
+            if (!buf) {
+                error_report("storage key load could not allocate memory");
+                ret = -ENOMEM;
+                break;
+            }
+            qemu_get_buffer(f, buf, total_count);
+            g_free(buf);
+            break;
+        }
+        case 1: {
+            /* normal exit */
+            return 0;
+        }
+        default:
+            error_report("Unexpected storage key data: %#lx", data);
+            ret = -EINVAL;
+        }
+    }
+    return ret;
+}
+
+static SaveVMHandlers savevm_s390_storage_keys = {
+    .save_state = s390_storage_keys_save,
+    .load_state = s390_storage_keys_load,
+};
+
 void cpu_ticks_init(void)
 {
     seqlock_init(&timers_state.vm_clock_seqlock);
     qemu_spin_init(&timers_state.vm_clock_lock);
     vmstate_register(NULL, 0, &vmstate_timers, &timers_state);
+
+    register_savevm_live("s390-skeys", 0, 1,
+                         &savevm_s390_storage_keys, NULL);
+
     cpu_throttle_init();
 }
 
-- 
2.16.4


--------------A9E367F46680C57DAD7DC43F
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-iotests-300-new-test-for-catching-backing-file-migra.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-iotests-300-new-test-for-catching-backing-file-migra.pa";
 filename*1="tch"

From 807eefab80e06244c973098a9a012fe3871d19b8 Mon Sep 17 00:00:00 2001
From: Claudio Fontana <cfontana@suse.de>
Date: Tue, 21 Jul 2020 10:06:37 +0200
Subject: [PATCH 1/2] iotests/300: new test for catching backing file migration
 issue

this test has been split off from 267, checking only
the backing file, and not "requiring" any components,
as to make it easier to debug and run under valgrind.

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 tests/qemu-iotests/300     | 100 +++++++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/300.out |  17 ++++++++
 tests/qemu-iotests/group   |   1 +
 3 files changed, 118 insertions(+)
 create mode 100755 tests/qemu-iotests/300
 create mode 100644 tests/qemu-iotests/300.out

diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
new file mode 100755
index 0000000000..aec01c6691
--- /dev/null
+++ b/tests/qemu-iotests/300
@@ -0,0 +1,100 @@
+#!/usr/bin/env bash
+#
+# Test which nodes are involved in internal snapshots
+#
+# Copyright (C) 2019 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=kwolf@redhat.com
+
+# adapted by Claudio Fontana <cfontana@suse.de>
+#
+# this is a standalone extract from 267 focused on the first backing file
+# testcase, which failed consistently on s390 and less consistently
+# on X86 under particular conditions, depending on the number of fields
+# in the migration stream.
+#
+# Also, in contrast to 267, we do not "require" anything,
+# which fixes running under valgrind, which otherwise breaks.
+#
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+
+# Internal snapshots are (currently) impossible with refcount_bits=1,
+# and generally impossible with external data files
+_unsupported_imgopts 'refcount_bits=1[^0-9]' data_file
+
+do_run_qemu()
+{
+    echo Testing: "$@"
+    (
+        if ! test -t 0; then
+            while read cmd; do
+                echo $cmd
+            done
+        fi
+        echo quit
+    ) | $QEMU -nographic -monitor stdio -nodefaults "$@"
+    echo
+}
+
+run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp |
+        _filter_generated_node_ids | _filter_imgfmt | _filter_vmstate_size
+}
+
+size=128M
+
+run_test()
+{
+    _make_test_img -b "$BACKING_FILE" -F $IMGFMT $size
+    printf "savevm snap0\ninfo snapshots\nloadvm snap0\n" | run_qemu "$@" | _filter_date
+}
+
+echo
+echo "=== -blockdev with a backing file ==="
+echo
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $size
+
+BACKING_FILE="$TEST_IMG.base" \
+run_test -blockdev driver=file,filename="$TEST_IMG.base",node-name=backing-file \
+         -blockdev driver=file,filename="$TEST_IMG",node-name=file \
+         -blockdev driver=$IMGFMT,file=file,backing=backing-file,node-name=fmt
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/300.out b/tests/qemu-iotests/300.out
new file mode 100644
index 0000000000..9904043638
--- /dev/null
+++ b/tests/qemu-iotests/300.out
@@ -0,0 +1,17 @@
+QA output created by 300
+
+=== -blockdev with a backing file ===
+
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-file,node-name=fmt
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) savevm snap0
+(qemu) info snapshots
+List of snapshots present on all disks:
+ID        TAG                 VM SIZE                DATE       VM CLOCK
+--        snap0                  SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
+(qemu) loadvm snap0
+(qemu) quit
+
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1d0252e1f0..cb66b5a58c 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -307,4 +307,5 @@
 296 rw
 297 meta
 299 auto quick
+300 rw auto quick snapshot backing
 301 backing quick
-- 
2.16.4


--------------A9E367F46680C57DAD7DC43F--

