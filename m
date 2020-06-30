Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A730C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53F8C2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P0/w7yXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F8C2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFb4-0003O2-JA
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqFaE-0002i9-RL
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:41:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28461
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jqFaC-0005Ue-Fz
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593520911;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cLNVM3/fCxRp/R0zr2UTX1xN5D5WfDYmQuxJvUOGfmk=;
 b=P0/w7yXJkiXiB8ez8GxY95x3j6utP7VCamPOz0sDymGWImuMxn2VNZh5pQ9sAj7b1P2p6N
 /xv6C5ElsnvEcJXnyUw/XvFc4Q6cr0Q1CCn+juhka8+6Rm/Fg4XAF2WWVrmOG+rFs5uylM
 VfQZFXI4CdlZF/5zVGoeMMHN+rQ/oBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-T3przY_4NeSz_eDyKFCmhA-1; Tue, 30 Jun 2020 08:41:49 -0400
X-MC-Unique: T3przY_4NeSz_eDyKFCmhA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 475ED18FE86F;
 Tue, 30 Jun 2020 12:41:48 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AAABA5C241;
 Tue, 30 Jun 2020 12:41:39 +0000 (UTC)
Date: Tue, 30 Jun 2020 13:41:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 3/3] trace: Example of "centralized" recorder tracing
Message-ID: <20200630124136.GM1370404@redhat.com>
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200626162706.3304357-4-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200626162706.3304357-4-dinechin@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 06:27:06PM +0200, Christophe de Dinechin wrote:
> This is an example showing how the recorder can be used to have one
> "topic" covering multiple entries. Here, the topic is "lock".
> 
> Here are a few use cases:
> 
> - Checking locks:
>     RECORDER_TRACES=lock qemu
> - Graphic visualization of locks:
>     RECORDER_TRACES="lock=state,id" qemu &
>     recorder_scope state
>     <Hit the 't' key to toggle timing display>
>     <Hit the 'c' key to dump the screen data as CSV>
>     cat recorder_scope_data-1.csv
> 
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>
> ---
>  util/qemu-thread-common.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/util/qemu-thread-common.h b/util/qemu-thread-common.h
> index 2af6b12085..0de07a471f 100644
> --- a/util/qemu-thread-common.h
> +++ b/util/qemu-thread-common.h
> @@ -15,6 +15,9 @@
>  
>  #include "qemu/thread.h"
>  #include "trace.h"
> +#include "trace/recorder.h"
> +
> +RECORDER_DEFINE(lock, 16, "Lock state");
>  
>  static inline void qemu_mutex_post_init(QemuMutex *mutex)
>  {
> @@ -23,12 +26,14 @@ static inline void qemu_mutex_post_init(QemuMutex *mutex)
>      mutex->line = 0;
>  #endif
>      mutex->initialized = true;
> +    record(lock, "Init state %d for %p", -1, mutex);
>  }
>  
>  static inline void qemu_mutex_pre_lock(QemuMutex *mutex,
>                                         const char *file, int line)
>  {
>      trace_qemu_mutex_lock(mutex, file, line);
> +    record(lock, "Locking state %d for %p", 1, mutex);
>  }
>  
>  static inline void qemu_mutex_post_lock(QemuMutex *mutex,
> @@ -39,6 +44,7 @@ static inline void qemu_mutex_post_lock(QemuMutex *mutex,
>      mutex->line = line;
>  #endif
>      trace_qemu_mutex_locked(mutex, file, line);
> +    record(lock, "Locked state %d for %p", 2, mutex);
>  }
>  
>  static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
> @@ -49,6 +55,7 @@ static inline void qemu_mutex_pre_unlock(QemuMutex *mutex,
>      mutex->line = 0;
>  #endif
>      trace_qemu_mutex_unlock(mutex, file, line);
> +    record(lock, "Unkocked state %d for %p", 0, mutex);
>  }

IMHO the whole point of having the pluggable trace backend impls, is
precisely that we don't have to add multiple different calls in the
code. A single trace_qemu_mutex_unlock() is supposed to work with
any backend.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


