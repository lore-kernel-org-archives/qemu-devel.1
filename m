Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9A5C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:42:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C07A206D9
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 11:42:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C07A206D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juDtI-0004HK-OF
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 07:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juDsJ-0003ou-Q8
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:40:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:42562)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1juDsH-0001ae-4o
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 07:40:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 86190ABCF;
 Sat, 11 Jul 2020 11:40:53 +0000 (UTC)
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
To: Cornelia Huck <cohuck@redhat.com>, "Jason J. Herne" <jjherne@linux.ibm.com>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
 <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
 <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
 <d0bc3f23-98c0-eadb-55ed-3377f43c494a@suse.de>
 <20200710083356.4c6e9f78.cohuck@redhat.com>
From: Claudio Fontana <cfontana@suse.de>
Message-ID: <c834b040-2365-4c6a-a301-553a1ede3e14@suse.de>
Date: Sat, 11 Jul 2020 13:40:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200710083356.4c6e9f78.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 23:52:14
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/20 8:33 AM, Cornelia Huck wrote:
> On Thu, 9 Jul 2020 20:46:56 +0200
> Claudio Fontana <cfontana@suse.de> wrote:
> 
>> On 7/9/20 8:38 PM, Claudio Fontana wrote:
>>> On 7/8/20 5:05 PM, Paolo Bonzini wrote:  
>>>> On 08/07/20 17:00, Claudio Fontana wrote:  
>>>>>> Bisectable, 100% failure rate, etc. :(  Can you split the patch in
>>>>>> multiple parts, specifically separating any rename or introducing of
>>>>>> includes from the final file move?  
>>>>> Hi Paolo,
>>>>>
>>>>> will take a look!
>>>>>
>>>>> Is this captured by some travis / cirrus-ci / anything I can easily see the result of?
>>>>>
>>>>>  
>>>>
>>>> Nope, unfortunately we don't have an s390 CI.  But if you can get your
>>>> hands on one, just "./configure --target-list=s390x-softmmu && make &&
>>>> make check-block" will show it.  
>>>
>>> So this is tricky, but I am making some progress after getting my hands on one.
>>> Maybe if someone understands s390 keys better, I could be clued in.  
>>
>>
>> Also adding Cornelia to Cc:.
>>
>> Maybe the savevm_s390_storage_keys SaveVMHandlers etc assume that the icount state part of the vmstate is there?
> 
> I don't see anything that would deal with icount here. Adding Jason to
> cc: in case he has an idea. (I assume it would behave the same under
> KVM, as the only thing different are the internal callbacks.)
> 


I found out something that for me shows that more investigation here is warranted.


Here is my latest workaround for the problem:



diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 1e036cc602..47c9a015af 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -252,6 +252,8 @@ static const TypeInfo qemu_s390_skeys_info = {
     .class_size    = sizeof(S390SKeysClass),
 };
 
+extern void qemu_fflush(QEMUFile *f);
+
 static void s390_storage_keys_save(QEMUFile *f, void *opaque)
 {
     S390SKeysState *ss = S390_SKEYS(opaque);
@@ -302,6 +304,7 @@ static void s390_storage_keys_save(QEMUFile *f, void *opaque)
     g_free(buf);
 end_stream:
     qemu_put_be64(f, eos);
+    qemu_fflush(f);
 }
 
 static int s390_storage_keys_load(QEMUFile *f, void *opaque, int version_id)
------------------------------------------------------------------------------------


I think that this might imply that my patch changing the migration stream has only triggered an existing problem.

The sympthom is: the load keys code does not see the EOS (byte value 1).
It does see the keys (which are all empty in the test, ie 32678 times the byte value 0). 

The workaround for the sympthom: flush the qemu file after putting the EOS in there.


Any ideas on where to investigate next?

Thanks,

Claudio



>>
>>
>>>
>>> In short this goes away if I again set icount to enabled for qtest,
>>> basically ensuring that --enable-tcg is there and then reenabling icount.
>>>
>>> qtest was forcing icount and shift=0 by creating qemu options, in order to misuse its counter feature,
>>> instead of using a separate counter.
>>>
>>> Removing that ugliness we end up with different behavior of save/load, because vmstate will now suddenly not contain icount-related values anymore.
>>> What I do not understand is why this causes a problem because save should just not store the icount state and load should just not load the icount state,
>>> and why we die on the load of s390 keys state (it works just fine for other architectures).
> 
> Yes, I don't really see why skeys is so special. No endianness stuff, I
> assume?
> 
>>>
>>> Here is a diff that makes the problem disappear, but needs --enable-tcg:
>>>
>>>
>>> ----------------------------------------------------------------------------------------------------
>>> diff --git a/accel/qtest.c b/accel/qtest.c
>>> index 119d0f16a4..4cb16abc2c 100644
>>> --- a/accel/qtest.c
>>> +++ b/accel/qtest.c
>>> @@ -23,6 +23,12 @@
>>>  
>>>  static int qtest_init_accel(MachineState *ms)
>>>  {
>>> +    QemuOpts *opts = qemu_opts_create(qemu_find_opts("icount"), NULL, 0,
>>> +                                      &error_abort);
>>> +    qemu_opt_set(opts, "shift", "0", &error_abort);
>>> +    icount_configure(opts, &error_abort);
>>> +    qemu_opts_del(opts);
>>> +
>>>      return 0;
>>>  }
>>>  
>>> diff --git a/softmmu/vl.c b/softmmu/vl.c
>>> index f39fd5270b..a5e788c86a 100644
>>> --- a/softmmu/vl.c
>>> +++ b/softmmu/vl.c
>>> @@ -2786,10 +2786,12 @@ static void configure_accelerators(const char *progname)
>>>          error_report("falling back to %s", ac->name);
>>>      }
>>>  
>>> +    /*
>>>      if (icount_enabled() && !tcg_enabled()) {
>>>          error_report("-icount is not allowed with hardware virtualization");
>>>          exit(1);
>>>     }
>>> +    */
>>>  }
>>>  
>>>  static void create_default_memdev(MachineState *ms, const char *path)
>>> ----------------------------------------------------------------------------------------------------
>>>
>>> Without this patch, here is the full failure, maybe someone has a good hint, otherwise I'll keep digging from here inside the s390-specific code.
>>>
>>> QA output created by 267
>>>
>>> === No block devices at all ===
>>>
>>> Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>> Testing:
>>> QEMU X.Y.Z monitor - type 'help' for more information
>>> (qemu) savevm snap0
>>> Error: No block device can accept snapshots
>>> (qemu) info snapshots
>>> No available block device supports snapshots
>>> (qemu) loadvm snap0
>>> Error: No block device supports snapshots
>>> (qemu) quit
>>>
>>>
>>> === -drive if=none ===
>>>
>>> Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>> Testing: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none
>>> QEMU X.Y.Z monitor - type 'help' for more information
>>> (qemu) savevm snap0
>>> Error: Device 'none0' is writable but does not support snapshots
>>> (qemu) info snapshots
>>> No available block device supports snapshots
>>> (qemu) loadvm snap0
>>> Error: Device 'none0' is writable but does not support snapshots
>>> (qemu) quit
>>>
>>> Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>> Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none
>>> QEMU X.Y.Z monitor - type 'help' for more information
>>> (qemu) savevm snap0
>>> (qemu) info snapshots
>>> List of snapshots present on all disks:
>>> ID        TAG                     VM SIZE                DATE       VM CLOCK
>>> --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
>>> (qemu) loadvm snap0
>>> (qemu) quit
>>>
>>> Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>> Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none -device virtio-blk,drive=none0
>>> QEMU X.Y.Z monitor - type 'help' for more information
>>> (qemu) savevm snap0
>>> (qemu) info snapshots
>>> List of snapshots present on all disks:
>>> ID        TAG                     VM SIZE                DATE       VM CLOCK
>>> --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
>>> (qemu) loadvm snap0
>>> (qemu) quit
>>>
>>>
>>> === -drive if=virtio ===
>>>
>>> Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>> Testing: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=virtio
>>> QEMU X.Y.Z monitor - type 'help' for more information
>>> (qemu) savevm snap0
>>> Error: Device 'virtio0' is writable but does not support snapshots
>>> (qemu) info snapshots
>>> No available block device supports snapshots
>>> (qemu) loadvm snap0
>>> Error: Device 'virtio0' is writable but does not support snapshots
>>> (qemu) quit
>>>
>>> Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>> Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=virtio
>>> QEMU X.Y.Z monitor - type 'help' for more information
>>> (qemu) savevm snap0
>>> (qemu) info snapshots
>>> List of snapshots present on all disks:
>>> ID        TAG                     VM SIZE                DATE       VM CLOCK
>>> --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
>>> (qemu) loadvm snap0
>>> (qemu) quit
>>>
>>>
>>> === Simple -blockdev ===
>>>
>>> Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>> Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file
>>> QEMU X.Y.Z monitor - type 'help' for more information
>>> (qemu) savevm snap0
>>> Error: Device '' is writable but does not support snapshots
>>> (qemu) info snapshots
>>> No available block device supports snapshots
>>> (qemu) loadvm snap0
>>> Error: Device '' is writable but does not support snapshots
>>> (qemu) quit
>>>
>>> Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>> Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,node-name=fmt
>>> QEMU X.Y.Z monitor - type 'help' for more information
>>> (qemu) savevm snap0
>>> (qemu) info snapshots
>>> List of snapshots present on all disks:
>>> ID        TAG                     VM SIZE                DATE       VM CLOCK
>>> --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
>>> (qemu) loadvm snap0
>>> (qemu) quit
>>>
>>> Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>> Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=raw,file=file,node-name=raw -blockdev driver=IMGFMT,file=raw,node-name=fmt
>>> QEMU X.Y.Z monitor - type 'help' for more information
>>> (qemu) savevm snap0
>>> (qemu) info snapshots
>>> List of snapshots present on all disks:
>>> ID        TAG                     VM SIZE                DATE       VM CLOCK
>>> --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
>>> (qemu) loadvm snap0
>>> (qemu) quit
>>>
>>>
>>> === -blockdev with a filter on top ===
>>>
>>> Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
>>> Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,node-name=fmt -blockdev driver=copy-on-read,file=fmt,node-name=filter
>>> QEMU X.Y.Z monitor - type 'help' for more information
>>> (qemu) savevm snap0
>>> (qemu) info snapshots
>>> List of snapshots present on all disks:
>>> ID        TAG                     VM SIZE                DATE       VM CLOCK
>>> --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
>>> (qemu) loadvm snap0
>>> (qemu) quit
>>>
>>>
>>> === -blockdev with a backing file ===
>>>
>>> Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
>>> Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
>>> Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-file,node-name=fmt
>>> QEMU X.Y.Z monitor - type 'help' for more information
>>> (qemu) savevm snap0
>>> (qemu) info snapshots
>>> List of snapshots present on all disks:
>>> ID        TAG                     VM SIZE                DATE       VM CLOCK
>>> --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
>>> (qemu) loadvm snap0
>>> Unexpected storage key flag data: 0
>>> error while loading state for instance 0x0 of device 's390-skeys'
>>> Error: Error -22 while loading VM state
>>>
>>>
>>>
>>>   
>>>>  
>>>>>>
>>>>>> 	#if defined CONFIG_TCG || !defined NEED_CPU_H
>>>>>> 	extern bool icount_enabled(void);
>>>>>> 	#else
>>>>>> 	#define icount_enabled() 0
>>>>>> 	#endif
>>>>>>
>>>>>> (This way, more TCG-only code in cpus.c gets elided).  You can integrate
>>>>>> this change in the next version.
>>>>>>
>>>>>> Paolo
>>>>>>  
>>>>>
>>>>> Weird, I tested with --disable-tcg explicitly (but may be some time ago now, as I constantly rebased).
>>>>>
>>>>> Will take a look at the introduction of this #defines in place of variables,
>>>>> as this mechanisms will not work in the future for target-specific modules.  
>>>>
>>>> This is only done for per-target files so it should not be a problem.
>>>>
>>>> Paolo
>>>>
>>>>  
>>>
>>>   
>>
> 


