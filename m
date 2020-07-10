Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146E9C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 06:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1DA82077D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 06:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcVkssf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1DA82077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtmcl-0000kW-3B
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 02:35:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtmbr-0008Qd-Aq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 02:34:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23330
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jtmbo-0007oK-M5
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 02:34:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594362847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pjkXfzFLh1NtuikA4vh0Ebp095kM99Wlc9D7r5XXVO0=;
 b=LcVkssf1a9F1rwueac9YvOcL+WsDlStUnOofBnbCUElzRFFgcS9OzNCNtWQmaAS/ExXy5j
 /s+OZ87MTAvdF223uYLEUFsGssGM0mLlqyu577nbsqYJGt8BPoaHFL6nGpMsPFichrMt8h
 mYpZcuuvxqTuHy6oQDDUD/pcpw4uMm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-209-st0Qpub0OfeCLIHSR2FWcA-1; Fri, 10 Jul 2020 02:34:05 -0400
X-MC-Unique: st0Qpub0OfeCLIHSR2FWcA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E8AB9800D5C;
 Fri, 10 Jul 2020 06:34:02 +0000 (UTC)
Received: from gondolin (ovpn-112-227.ams2.redhat.com [10.36.112.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DD3A7611D;
 Fri, 10 Jul 2020 06:33:58 +0000 (UTC)
Date: Fri, 10 Jul 2020 08:33:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH 3/3] cpu-timers, icount: new modules
Message-ID: <20200710083356.4c6e9f78.cohuck@redhat.com>
In-Reply-To: <d0bc3f23-98c0-eadb-55ed-3377f43c494a@suse.de>
References: <20200629093504.3228-1-cfontana@suse.de>
 <20200629093504.3228-4-cfontana@suse.de>
 <aa45a793-35b1-d3bd-18a8-4c52ad888029@redhat.com>
 <f89f249d-dbc4-779b-5b53-fc408461f072@suse.de>
 <ecf5f26b-ce86-3e13-5c5c-567919433acb@redhat.com>
 <e9dca3d1-f52d-13ce-2d7d-66958bc15765@suse.de>
 <d0bc3f23-98c0-eadb-55ed-3377f43c494a@suse.de>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 00:36:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 Eduardo Habkost <ehabkost@redhat.com>, Colin Xu <colin.xu@intel.com>, "Jason
 J. Herne" <jjherne@linux.ibm.com>,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Roman Bolshakov <r.bolshakov@yadro.com>,
 haxm-team@intel.com, Wenchao Wang <wenchao.wang@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 20:46:56 +0200
Claudio Fontana <cfontana@suse.de> wrote:

> On 7/9/20 8:38 PM, Claudio Fontana wrote:
> > On 7/8/20 5:05 PM, Paolo Bonzini wrote:  
> >> On 08/07/20 17:00, Claudio Fontana wrote:  
> >>>> Bisectable, 100% failure rate, etc. :(  Can you split the patch in
> >>>> multiple parts, specifically separating any rename or introducing of
> >>>> includes from the final file move?  
> >>> Hi Paolo,
> >>>
> >>> will take a look!
> >>>
> >>> Is this captured by some travis / cirrus-ci / anything I can easily see the result of?
> >>>
> >>>  
> >>
> >> Nope, unfortunately we don't have an s390 CI.  But if you can get your
> >> hands on one, just "./configure --target-list=s390x-softmmu && make &&
> >> make check-block" will show it.  
> > 
> > So this is tricky, but I am making some progress after getting my hands on one.
> > Maybe if someone understands s390 keys better, I could be clued in.  
> 
> 
> Also adding Cornelia to Cc:.
> 
> Maybe the savevm_s390_storage_keys SaveVMHandlers etc assume that the icount state part of the vmstate is there?

I don't see anything that would deal with icount here. Adding Jason to
cc: in case he has an idea. (I assume it would behave the same under
KVM, as the only thing different are the internal callbacks.)

> 
> 
> > 
> > In short this goes away if I again set icount to enabled for qtest,
> > basically ensuring that --enable-tcg is there and then reenabling icount.
> > 
> > qtest was forcing icount and shift=0 by creating qemu options, in order to misuse its counter feature,
> > instead of using a separate counter.
> > 
> > Removing that ugliness we end up with different behavior of save/load, because vmstate will now suddenly not contain icount-related values anymore.
> > What I do not understand is why this causes a problem because save should just not store the icount state and load should just not load the icount state,
> > and why we die on the load of s390 keys state (it works just fine for other architectures).

Yes, I don't really see why skeys is so special. No endianness stuff, I
assume?

> > 
> > Here is a diff that makes the problem disappear, but needs --enable-tcg:
> > 
> > 
> > ----------------------------------------------------------------------------------------------------
> > diff --git a/accel/qtest.c b/accel/qtest.c
> > index 119d0f16a4..4cb16abc2c 100644
> > --- a/accel/qtest.c
> > +++ b/accel/qtest.c
> > @@ -23,6 +23,12 @@
> >  
> >  static int qtest_init_accel(MachineState *ms)
> >  {
> > +    QemuOpts *opts = qemu_opts_create(qemu_find_opts("icount"), NULL, 0,
> > +                                      &error_abort);
> > +    qemu_opt_set(opts, "shift", "0", &error_abort);
> > +    icount_configure(opts, &error_abort);
> > +    qemu_opts_del(opts);
> > +
> >      return 0;
> >  }
> >  
> > diff --git a/softmmu/vl.c b/softmmu/vl.c
> > index f39fd5270b..a5e788c86a 100644
> > --- a/softmmu/vl.c
> > +++ b/softmmu/vl.c
> > @@ -2786,10 +2786,12 @@ static void configure_accelerators(const char *progname)
> >          error_report("falling back to %s", ac->name);
> >      }
> >  
> > +    /*
> >      if (icount_enabled() && !tcg_enabled()) {
> >          error_report("-icount is not allowed with hardware virtualization");
> >          exit(1);
> >     }
> > +    */
> >  }
> >  
> >  static void create_default_memdev(MachineState *ms, const char *path)
> > ----------------------------------------------------------------------------------------------------
> > 
> > Without this patch, here is the full failure, maybe someone has a good hint, otherwise I'll keep digging from here inside the s390-specific code.
> > 
> > QA output created by 267
> > 
> > === No block devices at all ===
> > 
> > Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> > Testing:
> > QEMU X.Y.Z monitor - type 'help' for more information
> > (qemu) savevm snap0
> > Error: No block device can accept snapshots
> > (qemu) info snapshots
> > No available block device supports snapshots
> > (qemu) loadvm snap0
> > Error: No block device supports snapshots
> > (qemu) quit
> > 
> > 
> > === -drive if=none ===
> > 
> > Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> > Testing: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=none
> > QEMU X.Y.Z monitor - type 'help' for more information
> > (qemu) savevm snap0
> > Error: Device 'none0' is writable but does not support snapshots
> > (qemu) info snapshots
> > No available block device supports snapshots
> > (qemu) loadvm snap0
> > Error: Device 'none0' is writable but does not support snapshots
> > (qemu) quit
> > 
> > Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> > Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none
> > QEMU X.Y.Z monitor - type 'help' for more information
> > (qemu) savevm snap0
> > (qemu) info snapshots
> > List of snapshots present on all disks:
> > ID        TAG                     VM SIZE                DATE       VM CLOCK
> > --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> > (qemu) loadvm snap0
> > (qemu) quit
> > 
> > Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> > Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=none -device virtio-blk,drive=none0
> > QEMU X.Y.Z monitor - type 'help' for more information
> > (qemu) savevm snap0
> > (qemu) info snapshots
> > List of snapshots present on all disks:
> > ID        TAG                     VM SIZE                DATE       VM CLOCK
> > --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> > (qemu) loadvm snap0
> > (qemu) quit
> > 
> > 
> > === -drive if=virtio ===
> > 
> > Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> > Testing: -drive driver=file,file=TEST_DIR/t.IMGFMT,if=virtio
> > QEMU X.Y.Z monitor - type 'help' for more information
> > (qemu) savevm snap0
> > Error: Device 'virtio0' is writable but does not support snapshots
> > (qemu) info snapshots
> > No available block device supports snapshots
> > (qemu) loadvm snap0
> > Error: Device 'virtio0' is writable but does not support snapshots
> > (qemu) quit
> > 
> > Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> > Testing: -drive driver=IMGFMT,file=TEST_DIR/t.IMGFMT,if=virtio
> > QEMU X.Y.Z monitor - type 'help' for more information
> > (qemu) savevm snap0
> > (qemu) info snapshots
> > List of snapshots present on all disks:
> > ID        TAG                     VM SIZE                DATE       VM CLOCK
> > --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> > (qemu) loadvm snap0
> > (qemu) quit
> > 
> > 
> > === Simple -blockdev ===
> > 
> > Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> > Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file
> > QEMU X.Y.Z monitor - type 'help' for more information
> > (qemu) savevm snap0
> > Error: Device '' is writable but does not support snapshots
> > (qemu) info snapshots
> > No available block device supports snapshots
> > (qemu) loadvm snap0
> > Error: Device '' is writable but does not support snapshots
> > (qemu) quit
> > 
> > Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> > Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,node-name=fmt
> > QEMU X.Y.Z monitor - type 'help' for more information
> > (qemu) savevm snap0
> > (qemu) info snapshots
> > List of snapshots present on all disks:
> > ID        TAG                     VM SIZE                DATE       VM CLOCK
> > --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> > (qemu) loadvm snap0
> > (qemu) quit
> > 
> > Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> > Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=raw,file=file,node-name=raw -blockdev driver=IMGFMT,file=raw,node-name=fmt
> > QEMU X.Y.Z monitor - type 'help' for more information
> > (qemu) savevm snap0
> > (qemu) info snapshots
> > List of snapshots present on all disks:
> > ID        TAG                     VM SIZE                DATE       VM CLOCK
> > --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> > (qemu) loadvm snap0
> > (qemu) quit
> > 
> > 
> > === -blockdev with a filter on top ===
> > 
> > Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
> > Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,node-name=fmt -blockdev driver=copy-on-read,file=fmt,node-name=filter
> > QEMU X.Y.Z monitor - type 'help' for more information
> > (qemu) savevm snap0
> > (qemu) info snapshots
> > List of snapshots present on all disks:
> > ID        TAG                     VM SIZE                DATE       VM CLOCK
> > --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> > (qemu) loadvm snap0
> > (qemu) quit
> > 
> > 
> > === -blockdev with a backing file ===
> > 
> > Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728
> > Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base
> > Testing: -blockdev driver=file,filename=TEST_DIR/t.IMGFMT.base,node-name=backing-file -blockdev driver=file,filename=TEST_DIR/t.IMGFMT,node-name=file -blockdev driver=IMGFMT,file=file,backing=backing-file,node-name=fmt
> > QEMU X.Y.Z monitor - type 'help' for more information
> > (qemu) savevm snap0
> > (qemu) info snapshots
> > List of snapshots present on all disks:
> > ID        TAG                     VM SIZE                DATE       VM CLOCK
> > --        snap0                      SIZE yyyy-mm-dd hh:mm:ss   00:00:00.000
> > (qemu) loadvm snap0
> > Unexpected storage key flag data: 0
> > error while loading state for instance 0x0 of device 's390-skeys'
> > Error: Error -22 while loading VM state
> > 
> > 
> > 
> >   
> >>  
> >>>>
> >>>> 	#if defined CONFIG_TCG || !defined NEED_CPU_H
> >>>> 	extern bool icount_enabled(void);
> >>>> 	#else
> >>>> 	#define icount_enabled() 0
> >>>> 	#endif
> >>>>
> >>>> (This way, more TCG-only code in cpus.c gets elided).  You can integrate
> >>>> this change in the next version.
> >>>>
> >>>> Paolo
> >>>>  
> >>>
> >>> Weird, I tested with --disable-tcg explicitly (but may be some time ago now, as I constantly rebased).
> >>>
> >>> Will take a look at the introduction of this #defines in place of variables,
> >>> as this mechanisms will not work in the future for target-specific modules.  
> >>
> >> This is only done for per-target files so it should not be a problem.
> >>
> >> Paolo
> >>
> >>  
> > 
> >   
> 


