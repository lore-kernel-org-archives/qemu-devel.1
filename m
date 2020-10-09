Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E2AC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F37F4222BA
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 13:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfBB+ZWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F37F4222BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQsln-0000Pd-Tc
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 09:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQsiC-0006dX-Ni
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52940)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQsiA-0001Mz-KX
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 09:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602251129;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=bLgBf2EQvQav7x/C2D0ump4vSp4cER5SB/Nd+1wfrp0=;
 b=VfBB+ZWaIcYhBiKQUn+S3tcQzNL3+RAeMGjvZyR1QklkR5yx8icJaBQOZpir6x9GEmX0m3
 OzgwvMP9Fj+atufhotMX3Yko/zffCD3O9SMTyrKe8RIGVANPv5kPuEf6x4DQPngdM8fYCQ
 +yF7UXaxYk2VeKBcnxhlyfm3A7IbUD4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-ye3ZxogOObeQ1PRqo0ygzw-1; Fri, 09 Oct 2020 09:45:27 -0400
X-MC-Unique: ye3ZxogOObeQ1PRqo0ygzw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE0FC101962D;
 Fri,  9 Oct 2020 13:45:26 +0000 (UTC)
Received: from redhat.com (ovpn-114-251.ams2.redhat.com [10.36.114.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 538A650B44;
 Fri,  9 Oct 2020 13:45:25 +0000 (UTC)
Date: Fri, 9 Oct 2020 14:45:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Chetan Pant <chetan4windows@gmail.com>
Subject: Re: [PATCH 5/5] Fixing Lesser GPL version number [5/5]
Message-ID: <20201009134522.GE25901@redhat.com>
References: <20201009064410.2913-1-chetan4windows@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20201009064410.2913-1-chetan4windows@gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, thuth@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 09, 2020 at 06:44:10AM +0000, Chetan Pant wrote:
> There is no "version 2" of the "Lesser" General Public License. It is
> either "GPL version 2.0" or "Lesser GPL version 2.1". This patch replaces all
> occurrences of "Lesser GPL version 2" with "Lesser GPL version 2.1" in comment section.
> Also, It came to notice that some of the files that were edited for the change
> were not following latest comment rules. For example using "//" to mark comment
> instead of "/*". That is also fixed in this patch.
> 
> This patch is divided in 5 parts, directory wise, in order to make reviewing process easier.
> Below listed are the parts of the patch, where asterisk denotes the part you are currently viewing.
> 
> 	[ ] Files in authz/backends/block/linux-user/tests/migration directory (82 Files)
> 	[ ] Files in hw/include/disas (100 files)
> 	[ ] Files inside target/ 'alpha,arm,cris,hppa,i386' (96 files)
> 	[ ] Files inside target/ 'lm32,microblaze,mips,ppc,rx,sparc,tilegx,tricore,xtensa' (63 files)
> 	[*] Files in ui/util/include/scripts and QEMU root directory (76 Files)
> 
> Below is how the license version was corrected:
> 
> 1. To find the number of file having "Lesser GPL version 2 ":
> 	grep -l Lesser $(grep -rl "version 2 " * ) > result.dat
>    Total of 417 files were found (After manually exluding the files like COPYING and COPYING.LIB from the result)
> 
> 2. To find the number of occurences of "version 2 " in the resulted files:
> 	egrep -c "version 2 " $(cat result.dat)
>    410 files had "version 2" occurence 1 time (name of those files was saved in one_timers.dat)
>    and in 7 files "version 2" occurences were multiple times.
> 
> 3. Files having occurence exactly 1 time were corrected using below command:
> 	sed -i "s/version 2 /version 2.1 /g" $(cat one_timers.dat)
>    For rest of 7 files, correction was done manually.
> 
> Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
> ---
>  cpus-common.c                         | 2 +-
>  exec-vary.c                           | 2 +-
>  exec.c                                | 2 +-
>  include/authz/base.h                  | 2 +-
>  include/authz/list.h                  | 2 +-
>  include/authz/listfile.h              | 2 +-
>  include/authz/pamacct.h               | 2 +-
>  include/authz/simple.h                | 2 +-

Can you include these with the "authz" pieces from patch 1 and I'll
queue them


>  include/io/channel-buffer.h           | 2 +-
>  include/io/channel-command.h          | 2 +-
>  include/io/channel-file.h             | 2 +-
>  include/io/channel-socket.h           | 2 +-
>  include/io/channel-tls.h              | 2 +-
>  include/io/channel-util.h             | 2 +-
>  include/io/channel-watch.h            | 2 +-
>  include/io/channel-websock.h          | 2 +-
>  include/io/channel.h                  | 2 +-
>  include/io/dns-resolver.h             | 2 +-
>  include/io/task.h                     | 2 +-

Combine with the "io" pieces from patch 1.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


