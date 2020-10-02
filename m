Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BAD9C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:40:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF625206B2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 14:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guraDtQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF625206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOMEL-0007Z6-0C
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 10:40:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kOMA9-0002qj-Q5
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:35:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27165)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kOM9z-0003Zc-JQ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 10:35:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601649346;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=iABMwCheA8fdr3RCr8k/GRg3sQDyCK0PX5UAKX1yzvU=;
 b=guraDtQ411/rW/C5aO191W0Io+zdH4kjpbbg3+vgjV8iaevvxxbMX/FsEhvnfJPmWbAKqY
 Jo7OcTHQYTENbUDaUhgCIsAnnbmaAmMs8DNLBT5g/yerb4GMQk1HbpPSklV2L1XiCPX28C
 acXAngCB2S3Ynb1etxrLbSEVMJ4dLjU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-e5JhMQWnM82Ad4ZdOOKO_Q-1; Fri, 02 Oct 2020 10:35:41 -0400
X-MC-Unique: e5JhMQWnM82Ad4ZdOOKO_Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95467425DF;
 Fri,  2 Oct 2020 14:35:40 +0000 (UTC)
Received: from redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EA955C1DA;
 Fri,  2 Oct 2020 14:35:38 +0000 (UTC)
Date: Fri, 2 Oct 2020 15:35:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 08/11] tests/9pfs: introduce local tests
Message-ID: <20201002143535.GG2338114@redhat.com>
References: <cover.1601639563.git.qemu_oss@crudebyte.com>
 <8dd7d15176ca1e947054dd6891e478cdf7902f7e.1601639563.git.qemu_oss@crudebyte.com>
 <27148257.gUaGpDsOI2@silver>
MIME-Version: 1.0
In-Reply-To: <27148257.gUaGpDsOI2@silver>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 02, 2020 at 04:26:48PM +0200, Christian Schoenebeck wrote:
> On Freitag, 2. Oktober 2020 13:51:54 CEST Christian Schoenebeck wrote:
> > This patch introduces 9pfs test cases using the 9pfs 'local'
> > filesystem driver which reads/writes/creates/deletes real files
> > and directories.
> > 
> > In this initial version, there is only one local test which actually
> > only checks if the 9pfs 'local' device was created successfully.
> > 
> > Before the 9pfs 'local' tests are run, a test directory 'qtest-9p-local'
> > is created (with world rwx permissions) under the current working
> > directory. At this point that test directory is not auto deleted yet.
> > 
> > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > ---
> >  tests/qtest/libqos/virtio-9p.c | 100 +++++++++++++++++++++++++++++++++
> >  tests/qtest/libqos/virtio-9p.h |   5 ++
> >  tests/qtest/virtio-9p-test.c   |  44 ++++++++++-----
> >  3 files changed, 135 insertions(+), 14 deletions(-)
> > 
> > diff --git a/tests/qtest/libqos/virtio-9p.c b/tests/qtest/libqos/virtio-9p.c
> > index 2e300063e3..86e40e5d56 100644
> > --- a/tests/qtest/libqos/virtio-9p.c
> > +++ b/tests/qtest/libqos/virtio-9p.c
> > @@ -24,6 +24,63 @@
> >  #include "qgraph.h"
> > 
> >  static QGuestAllocator *alloc;
> > +static char *local_test_path;
> > +
> > +static char *strpr(const char* format, ...) GCC_FMT_ATTR(1, 2);
> > +
> > +/* Concatenates the passed 2 pathes. Returned result must be freed. */
> > +static char *concat_path(const char* a, const char* b)
> > +{
> > +    const int len = strlen(a) + strlen("/") + strlen(b);
> > +    char *path = g_malloc0(len + 1);
> > +    snprintf(path, len + 1, "%s/%s", a, b);
> > +    g_assert(strlen(path) == len);
> > +    return path;
> > +}
> 
> Ok, but maybe I could make that concat_path() function wrap g_strconcat().

Or even one of g_build_path or g_build_filename may be useful

> > +/*
> > + * Lazy sprintf() implementation which auto allocates buffer. Returned
> > result + * must be freed.
> > + */
> > +static char *strpr(const char* format, ...)
> > +{
> > +    va_list argp;
> > +
> > +    va_start(argp, format);
> > +    const int sz = vsnprintf(NULL, 0, format, argp) + 1;
> > +    va_end(argp);
> > +
> > +    g_assert(sz > 0);
> > +    char *s = g_malloc0(sz);
> > +
> > +    va_start(argp, format);
> > +    const int len = vsnprintf(s, sz, format, argp);
> > +    va_end(argp);
> > +
> > +    g_assert(len + 1 == sz);
> > +    return s;
> > +}
> 
> And this strpr() function entirely be replaced by g_strdup_printf().

Yep, its preferrable to use g_strdup_printf instead of manually
allocating.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


