Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1B8C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A4C020738
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:44:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="IABwcHce"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A4C020738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFZz-0001q9-8O
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAFXW-0006L2-T9; Mon, 24 Aug 2020 12:41:46 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:54492 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1kAFXT-0008B7-Hv; Mon, 24 Aug 2020 12:41:46 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id C53EB57505;
 Mon, 24 Aug 2020 16:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-transfer-encoding:content-disposition
 :content-type:content-type:mime-version:references:message-id
 :subject:subject:from:from:date:date:received:received:received;
 s=mta-01; t=1598287297; x=1600101698; bh=irJXQ06b6pDKOSNw6VJCoS
 6tou+SyWQOYbUw6wK4RNQ=; b=IABwcHceE7hMXxWlzHbu4ICB4q06vjGS6At3gz
 DRCbgV7J5Di74EkwMnoN1hOCYLuxpQVBt9jcuWGVAqBTOSKKBhJUsQVzXGiaQ2jn
 UQ7UI9Oy37SnYoX24PtcVIAWDT0zOdwSfy7IL4JAiEL7oaUfcQSzxeH1zUX9UPMX
 EK0XU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mVX4MvzVPA0R; Mon, 24 Aug 2020 19:41:37 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 243E25229A;
 Mon, 24 Aug 2020 19:41:35 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Mon, 24
 Aug 2020 19:41:34 +0300
Date: Mon, 24 Aug 2020 19:41:34 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Suspicious QOM types without instance/class size
Message-ID: <20200824164134.GA41106@SPB-NB-133.local>
References: <20200820215529.GH642093@habkost.net>
 <20200821105352.GA89922@SPB-NB-133.local>
 <20200821172927.GJ642093@habkost.net>
 <20200821174802.GK642093@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200821174802.GK642093@habkost.net>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/24 12:41:38
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>,
 David Gibson <david@gibson.dropbear.id.au>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, Cameron Esfahani <dirty@apple.com>,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 21, 2020 at 01:48:02PM -0400, Eduardo Habkost wrote:
> On Fri, Aug 21, 2020 at 01:29:38PM -0400, Eduardo Habkost wrote:
> > On Fri, Aug 21, 2020 at 01:53:52PM +0300, Roman Bolshakov wrote:
> > > On Thu, Aug 20, 2020 at 05:55:29PM -0400, Eduardo Habkost wrote:
> > > > While trying to convert TypeInfo declarations to the new
> > > > OBJECT_DECLARE* macros, I've stumbled on a few suspicious cases
> > > > where instance_size or class_size is not set, despite having type
> > > > checker macros that use a specific type.
> > > > 
> > > > The ones with "WARNING" are abstract types (maybe not serious if
> > > > subclasses set the appropriate sizes).  The ones with "ERROR"
> > > > don't seem to be abstract types.
> > > > 
> > > 
> > > > ERROR: target/i386/hvf/hvf.c:908:1: instance_size should be set to sizeof(HVFState)?
> > > 
> > 
> > > BTW, the object definition for hvf seems different from KVM (and perhaps
> > > wrong?), e.g. HVFState is allocated within init_machine handler and then
> > > assigned to a global variable:
> > 
> > Interesting.  It looks like hvf_state is _not_ the actual QOM
> > object instance.  The actual TYPE_HVF_ACCEL instance is created
> > by do_configure_accelerator().  That would explain why the lack
> > of instance_init never caused any problems.
> > 
> > Luckily, no code ever used the HVF_STATE macro.  If
> > HVF_STATE(hvf_state) got called, it would crash because of
> > uninitialized object instance data.  If HVF_STATE(machine->accel)
> > got called, it would return an invalid HVFState pointer (not
> > hvf_state).
> > 
> > I believe the simplest short term solution here is to just delete
> > the HVF_STATE macro and HVFState::parent field.  We can worry
> > about actually moving hvf_state to the machine->accel QOM object
> > later.
> 
> Actually, it might be easier to do the full QOM conversion in a
> single patch instead of deleting the incomplete code.
> 

I agree full QOM conversion is better, perhaps we can later move
certains bits to accel/hvf.c like it's done for kvm/tcg/qtest.

> Can you check if the following patch works?  I don't have a host
> where I can test it.
> 

Sure, thanks :)

> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
> index d81f569aed..81d1662d06 100644
> --- a/target/i386/hvf/hvf.c
> +++ b/target/i386/hvf/hvf.c
> @@ -878,13 +878,11 @@ static int hvf_accel_init(MachineState *ms)
>  {
>      int x;
>      hv_return_t ret;
> -    HVFState *s;
> +    HVFState *s = HVF_STATE(ms->accelerator);

The file also needs definition of MachineState:
#include "hw/boards.h"

>  
>      ret = hv_vm_create(HV_VM_DEFAULT);
>      assert_hvf_ok(ret);
>  
> -    s = g_new0(HVFState, 1);
> - 
>      s->num_slots = 32;
>      for (x = 0; x < s->num_slots; ++x) {
>          s->slots[x].size = 0;
> @@ -908,6 +906,7 @@ static void hvf_accel_class_init(ObjectClass *oc, void *data)
>  static const TypeInfo hvf_accel_type = {
>      .name = TYPE_HVF_ACCEL,
>      .parent = TYPE_ACCEL,
> +    .instance_size = sizeof(HVFState),
>      .class_init = hvf_accel_class_init,
>  };
>  
>  

Unfortunately it fails to start (even without the HVF patch):
ERROR:../qom/object.c:314:type_initialize: assertion failed: (parent->class_size <= ti->class_size)
Bail out! ERROR:../qom/object.c:314:type_initialize: assertion failed: (parent->class_size <= ti->class_size)

(lldb) bt
* thread #3, stop reason = signal SIGABRT
  * frame #0: 0x00007fff6a75e33a libsystem_kernel.dylib`__pthread_kill + 10
    frame #1: 0x00007fff6a81ae60 libsystem_pthread.dylib`pthread_kill + 430
    frame #2: 0x00007fff6a6e5808 libsystem_c.dylib`abort + 120
    frame #3: 0x0000000101289c36 libglib-2.0.0.dylib`g_assertion_message + 406
    frame #4: 0x0000000101289c9e libglib-2.0.0.dylib`g_assertion_message_expr + 94
    frame #5: 0x0000000100353c00 qemu-system-x86_64`type_initialize(ti=0x00000001032403e0) at object.c:314:9 [opt]
    frame #6: 0x000000010035378b qemu-system-x86_64`type_initialize(ti=0x000000010323fd70) at object.c:310:9 [opt]
    frame #7: 0x0000000100353de8 qemu-system-x86_64`object_class_foreach_tramp(key=<unavailable>, value=0x000000010323fd70, opaque=0x0000700005cb8d98) at object.c:1030:5 [opt]
    frame #8: 0x000000010124b83d libglib-2.0.0.dylib`g_hash_table_foreach + 125
    frame #9: 0x0000000100354079 qemu-system-x86_64`object_class_get_list [inlined] object_class_foreach(fn=<unavailable>, implements_type=<unavailable>, include_abstract=<unavailable>, opaque=0x0000700005cb8d90) at object.c:1052:5 [opt]
    frame #10: 0x000000010035401e qemu-system-x86_64`object_class_get_list(implements_type=<unavailable>, include_abstract=<unavailable>) at object.c:1109 [opt]
    frame #11: 0x000000010030875d qemu-system-x86_64`qemu_init [inlined] select_machine at vl.c:2438:24 [opt]
    frame #12: 0x000000010030874c qemu-system-x86_64`qemu_init(argc=<unavailable>, argv=<unavailable>, envp=<unavailable>) at vl.c:3842 [opt]
    frame #13: 0x0000000100008ef9 qemu-system-x86_64`qemu_main(argc=<unavailable>, argv=<unavailable>, envp=<unavailable>) at main.c:49:5 [opt]
    frame #14: 0x00000001000386f6 qemu-system-x86_64`call_qemu_main(opaque=<unavailable>) at cocoa.m:1710:14 [opt]
    frame #15: 0x000000010045f7ae qemu-system-x86_64`qemu_thread_start(args=<unavailable>) at qemu-thread-posix.c:521:9 [opt]
    frame #16: 0x00007fff6a81b109 libsystem_pthread.dylib`_pthread_start + 148
    frame #17: 0x00007fff6a816b8b libsystem_pthread.dylib`thread_start + 15

(lldb) f 6
frame #6: 0x000000010035378b qemu-system-x86_64`type_initialize(ti=0x000000010323fd70) at object.c:310:9 [opt]
   307
   308      parent = type_get_parent(ti);
   309      if (parent) {
-> 310          type_initialize(parent);
   311          GSList *e;
   312          int i;
   313
(lldb) p *ti
(TypeImpl) $3 = {
  name = 0x000000010323fee0 "tls-creds-anon"
  class_size = 80
  instance_size = 88
  class_init = 0x0000000100365160 (qemu-system-x86_64`qcrypto_tls_creds_anon_class_init at tlscredsanon.c:186)
  class_base_init = 0x0000000000000000
  class_data = 0x0000000000000000
  instance_init = 0x00000001003650d0 (qemu-system-x86_64`qcrypto_tls_creds_anon_init at tlscredsanon.c:199)
  instance_post_init = 0x0000000000000000
  instance_finalize = 0x00000001003650e0 (qemu-system-x86_64`qcrypto_tls_creds_anon_finalize at tlscredsanon.c:177)
  abstract = false
  parent = 0x000000010323fef0 "tls-creds"
  parent_type = 0x00000001032403e0
  class = 0x00000001032844f0
  num_interfaces = 1
  interfaces = {
    [0] = (typename = "user-creatable")
    [1] = (typename = 0x0000000000000000)
    [2] = (typename = 0x0000000000000000)
    [3] = (typename = 0x0000000000000000)
    [4] = (typename = 0x0000000000000000)
    [5] = (typename = 0x0000000000000000)
    [6] = (typename = 0x0000000000000000)
    [7] = (typename = 0x0000000000000000)
    [8] = (typename = 0x0000000000000000)
    [9] = (typename = 0x0000000000000000)
    [10] = (typename = 0x0000000000000000)
    [11] = (typename = 0x0000000000000000)
    [12] = (typename = 0x0000000000000000)
    [13] = (typename = 0x0000000000000000)
    [14] = (typename = 0x0000000000000000)
    [15] = (typename = 0x0000000000000000)
    [16] = (typename = 0x0000000000000000)
    [17] = (typename = 0x0000000000000000)
    [18] = (typename = 0x0000000000000000)
    [19] = (typename = 0x0000000000000000)
    [20] = (typename = 0x0000000000000000)
    [21] = (typename = 0x0000000000000000)
    [22] = (typename = 0x0000000000000000)
    [23] = (typename = 0x0000000000000000)
    [24] = (typename = 0x0000000000000000)
    [25] = (typename = 0x0000000000000000)
    [26] = (typename = 0x0000000000000000)
    [27] = (typename = 0x0000000000000000)
    [28] = (typename = 0x0000000000000000)
    [29] = (typename = 0x0000000000000000)
    [30] = (typename = 0x0000000000000000)
    [31] = (typename = 0x0000000000000000)
  }
}

(lldb) f 5 (NB, it's from the different run of lldb, so addresses can be
different due to KASLR)
qemu-system-x86_64 was compiled with optimization - stepping may behave oddly; variables may not be available.
frame #5: 0x0000000100353c00 qemu-system-x86_64`type_initialize(ti=0x0000000101e409d0) at object.c:314:9 [opt]
   311          GSList *e;
   312          int i;
   313
-> 314          g_assert(parent->class_size <= ti->class_size);
   315          g_assert(parent->instance_size <= ti->instance_size);
   316          memcpy(ti->class, parent->class, parent->class_size);
   317          ti->class->interfaces = NULL;
(lldb) p *ti
(TypeImpl) $0 = {
  name = 0x0000000101e40b40 "tls-creds"
  class_size = 40
  instance_size = 80
  class_init = 0x0000000100369740 (qemu-system-x86_64`qcrypto_tls_creds_class_init at tlscreds.c:229)
  class_base_init = 0x0000000000000000
  class_data = 0x0000000000000000
  instance_init = 0x00000001003696d0 (qemu-system-x86_64`qcrypto_tls_creds_init at tlscreds.c:249)
  instance_post_init = 0x0000000000000000
  instance_finalize = 0x0000000100369700 (qemu-system-x86_64`qcrypto_tls_creds_finalize at tlscreds.c:258)
  abstract = true
  parent = 0x0000000101e40b50 "object"
  parent_type = 0x0000000101e3f360
  class = 0x0000000101e84b30
  num_interfaces = 0
  interfaces = {
    [0] = (typename = 0x0000000000000000)
    [1] = (typename = 0x0000000000000000)
    [2] = (typename = 0x0000000000000000)
    [3] = (typename = 0x0000000000000000)
    [4] = (typename = 0x0000000000000000)
    [5] = (typename = 0x0000000000000000)
    [6] = (typename = 0x0000000000000000)
    [7] = (typename = 0x0000000000000000)
    [8] = (typename = 0x0000000000000000)
    [9] = (typename = 0x0000000000000000)
    [10] = (typename = 0x0000000000000000)
    [11] = (typename = 0x0000000000000000)
    [12] = (typename = 0x0000000000000000)
    [13] = (typename = 0x0000000000000000)
    [14] = (typename = 0x0000000000000000)
    [15] = (typename = 0x0000000000000000)
    [16] = (typename = 0x0000000000000000)
    [17] = (typename = 0x0000000000000000)
    [18] = (typename = 0x0000000000000000)
    [19] = (typename = 0x0000000000000000)
    [20] = (typename = 0x0000000000000000)
    [21] = (typename = 0x0000000000000000)
    [22] = (typename = 0x0000000000000000)
    [23] = (typename = 0x0000000000000000)
    [24] = (typename = 0x0000000000000000)
    [25] = (typename = 0x0000000000000000)
    [26] = (typename = 0x0000000000000000)
    [27] = (typename = 0x0000000000000000)
    [28] = (typename = 0x0000000000000000)
    [29] = (typename = 0x0000000000000000)
    [30] = (typename = 0x0000000000000000)
    [31] = (typename = 0x0000000000000000)
  }
}

It doesn't seem related to HVF QOM changes 🤔

Bisected it to:

b717702de21461138ac0e1d6775da0bd0482c013 is the first bad commit
commit b717702de21461138ac0e1d6775da0bd0482c013
Author: Daniel P. Berrangé <berrange@redhat.com>
Date:   Wed Aug 19 20:12:35 2020 -0400

    crypto: use QOM macros for declaration/definition of secret types

    This introduces the use of the OBJECT_DEFINE and OBJECT_DECLARE macro
    families in the secret types, in order to eliminate boilerplate code.

    Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
    Message-Id: <20200723181410.3145233-4-berrange@redhat.com>
    [ehabkost: rebase, update to pass additional arguments to macro]
    Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
    Message-Id: <20200820001236.1284548-58-ehabkost@redhat.com>

Regards,
Roman

