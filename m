Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3925C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:47:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CE1B206F1
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 08:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPaBYP+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CE1B206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdriU-0005TA-Oo
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 04:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32806)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdrhq-00051H-JT
 for qemu-devel@nongnu.org; Wed, 27 May 2020 04:46:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38406
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jdrho-0001ah-Mu
 for qemu-devel@nongnu.org; Wed, 27 May 2020 04:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590569191;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AV+Z/YU7yJ1LR0I6KHoSdy0lolqG2JopyB3NQlO4WTI=;
 b=SPaBYP+cWu0+IrtkUNHgkobMxhVCGoon2QZLUXiaNNt7bjGRMk88e43gwmeRy19OcwtbzX
 YlRRtastXmi0UdNQd7bGTgBpxMgk8FDhYzLE3YhMq+ygUKJYjJOzak0I1CDXQBZSqdITbu
 ZWjo8W8d5Wya+UXVqln8TNNhZhdyGyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-BL6OO7JfOjCyii1YZmRYhg-1; Wed, 27 May 2020 04:46:02 -0400
X-MC-Unique: BL6OO7JfOjCyii1YZmRYhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4CEC460;
 Wed, 27 May 2020 08:46:00 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE6DE5D9E8;
 Wed, 27 May 2020 08:45:57 +0000 (UTC)
Date: Wed, 27 May 2020 09:45:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Anup Patel <anup.patel@wdc.com>
Subject: Re: [PATCH v2 1/5] hw: Add sockets_specified field in CpuTopology
Message-ID: <20200527084554.GC2665520@redhat.com>
References: <20200527054226.232103-1-anup.patel@wdc.com>
 <20200527054226.232103-2-anup.patel@wdc.com>
MIME-Version: 1.0
In-Reply-To: <20200527054226.232103-2-anup.patel@wdc.com>
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FROM_EXCESS_BASE64=0.979, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 qemu-devel@nongnu.org, Atish Patra <atish.patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 27, 2020 at 11:12:22AM +0530, Anup Patel wrote:
> When "sockets" sub-option of "-smp" option is not specified, the
> smp_parse() function will assume one CPU per-socket and set the
> number of sockets equal to number of CPUs.
> 
> This is counter-intuitive and we should allow machine emulation to
> decide default number of sockets when "sockets" sub-option is not
> specified.

I don't agree with this.  Having the semantics of the -smp option
be the same across all targets/machines *is* intuitive.  Changing
semantics of -smp per-machine will create a worse experiance for
people configuring QEMU as the configuration will mean different
things depending on the machine choce.


>           To achieve this, we add boolean flag sockets_specified
> in struct CpuTopology which tells machine emulation whether the
> "sockets" sub-option was specified in command-line.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  hw/core/machine.c   | 2 ++
>  include/hw/boards.h | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index bb3a7b18b1..fd5ef5a4bb 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -706,6 +706,8 @@ static void smp_parse(MachineState *ms, QemuOpts *opts)
>          unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
>          unsigned threads = qemu_opt_get_number(opts, "threads", 0);
>  
> +         ms->smp.sockets_specified = (sockets == 0) ? false : true;
> +
>          /* compute missing values, prefer sockets over cores over threads */
>          if (cpus == 0 || sockets == 0) {
>              cores = cores > 0 ? cores : 1;
> diff --git a/include/hw/boards.h b/include/hw/boards.h
> index 18815d9be2..59b28ada65 100644
> --- a/include/hw/boards.h
> +++ b/include/hw/boards.h
> @@ -244,6 +244,7 @@ typedef struct DeviceMemoryState {
>   * @cores: the number of cores in one package
>   * @threads: the number of threads in one core
>   * @sockets: the number of sockets on the machine
> + * @sockets_specified: the number of sockets were specified for the machine
>   * @max_cpus: the maximum number of logical processors on the machine
>   */
>  typedef struct CpuTopology {
> @@ -251,6 +252,7 @@ typedef struct CpuTopology {
>      unsigned int cores;
>      unsigned int threads;
>      unsigned int sockets;
> +    bool sockets_specified;
>      unsigned int max_cpus;
>  } CpuTopology;
>  
> -- 
> 2.25.1
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


