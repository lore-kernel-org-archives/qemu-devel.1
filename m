Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03ADDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70D82075F
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G8iPAJ7T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70D82075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdtWd-0004WH-1a
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58494)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdtVu-00043D-HN
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:42:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60298
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdtVt-0000k2-19
 for qemu-devel@nongnu.org; Wed, 27 May 2020 06:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590576140;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s2SCMguOxhY4Fpk4nzlXF4iRL9DyJho6U2fiQB/CijM=;
 b=G8iPAJ7TP5PsOtFCuDFZlrLk4GiY+sqIIkSIcLYmYILJQpyqBtwvGyDuK2ZSVBvTeNXIOj
 Fl2gDLY0V4VDoRpXM/o4JbSewvx1zZpBjnMSg37yIq0FzE8LVmyfvVx7KmaKpbKNLnJn1X
 LD2fUMkjpHvFNqxjbj0ycJ7aWupMTCk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-XLE9AAysNoO91aRMq-n00A-1; Wed, 27 May 2020 06:42:18 -0400
X-MC-Unique: XLE9AAysNoO91aRMq-n00A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81678EC1A4;
 Wed, 27 May 2020 10:42:16 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E9E4079C50;
 Wed, 27 May 2020 10:42:12 +0000 (UTC)
Date: Wed, 27 May 2020 11:42:09 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anup Patel <Anup.Patel@wdc.com>
Subject: Re: [PATCH v2 1/5] hw: Add sockets_specified field in CpuTopology
Message-ID: <20200527104209.GJ2665520@redhat.com>
References: <20200527054226.232103-1-anup.patel@wdc.com>
 <20200527054226.232103-2-anup.patel@wdc.com>
 <20200527084554.GC2665520@redhat.com>
 <DM6PR04MB6201A8060078D3539BFDE3688DB10@DM6PR04MB6201.namprd04.prod.outlook.com>
 <20200527095123.GH2665520@redhat.com>
 <DM6PR04MB62018CFC12FAAFA39AA667368DB10@DM6PR04MB6201.namprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <DM6PR04MB62018CFC12FAAFA39AA667368DB10@DM6PR04MB6201.namprd04.prod.outlook.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:45:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 10:01:21AM +0000, Anup Patel wrote:
> 
> 
> > -----Original Message-----
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > Sent: 27 May 2020 15:21
> > To: Anup Patel <Anup.Patel@wdc.com>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>; Marcel Apfelbaum
> > <marcel.apfelbaum@gmail.com>; Peter Maydell <peter.maydell@linaro.org>;
> > Palmer Dabbelt <palmer@dabbelt.com>; Alistair Francis
> > <Alistair.Francis@wdc.com>; Sagar Karandikar <sagark@eecs.berkeley.edu>;
> > Atish Patra <Atish.Patra@wdc.com>; qemu-riscv@nongnu.org; qemu-
> > devel@nongnu.org; Anup Patel <anup@brainfault.org>
> > Subject: Re: [PATCH v2 1/5] hw: Add sockets_specified field in CpuTopology
> > 
> > On Wed, May 27, 2020 at 09:48:39AM +0000, Anup Patel wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Daniel P. Berrangé <berrange@redhat.com>
> > > > Sent: 27 May 2020 14:16
> > > > To: Anup Patel <Anup.Patel@wdc.com>
> > > > Cc: Eduardo Habkost <ehabkost@redhat.com>; Marcel Apfelbaum
> > > > <marcel.apfelbaum@gmail.com>; Peter Maydell
> > > > <peter.maydell@linaro.org>; Palmer Dabbelt <palmer@dabbelt.com>;
> > > > Alistair Francis <Alistair.Francis@wdc.com>; Sagar Karandikar
> > > > <sagark@eecs.berkeley.edu>; Atish Patra <Atish.Patra@wdc.com>;
> > > > qemu-riscv@nongnu.org; qemu- devel@nongnu.org; Anup Patel
> > > > <anup@brainfault.org>
> > > > Subject: Re: [PATCH v2 1/5] hw: Add sockets_specified field in
> > > > CpuTopology
> > > >
> > > > On Wed, May 27, 2020 at 11:12:22AM +0530, Anup Patel wrote:
> > > > > When "sockets" sub-option of "-smp" option is not specified, the
> > > > > smp_parse() function will assume one CPU per-socket and set the
> > > > > number of sockets equal to number of CPUs.
> > > > >
> > > > > This is counter-intuitive and we should allow machine emulation to
> > > > > decide default number of sockets when "sockets" sub-option is not
> > > > > specified.
> > > >
> > > > I don't agree with this.  Having the semantics of the -smp option be
> > > > the same across all targets/machines *is* intuitive.  Changing
> > > > semantics of -smp per- machine will create a worse experiance for
> > > > people configuring QEMU as the configuration will mean different things
> > depending on the machine choce.
> > >
> > > Okay then why don't we default to sockets=1 in smp_parse() when "sockets"
> > > sub-options is not specified ?? This will make it uniform across machines.
> > >
> > > Is there a reason to by default have sockets=max_cpus ??
> > 
> > IIUC both of these questions are due to backwards compatibility with pre-
> > existing QEMU versions.
> 
> I see that hw/x86/pc.c implements it's own smp_parse() callback.
> Can we take that route ??
> 
> We need to have sockets=1 by default for RISC-V machines because
> each socket has it's own interrupt controller and other peripherals.

I guess the fact that smp_parse() exists as a callback pretty much
says that allowing machine type overrides of default semantics is
permitted. So yeah, using a smp_parse callback seems reasonable.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


