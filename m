Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0A1C4727D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:46:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83FF2206CA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqJzU8Op"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83FF2206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOLNx-00071F-E9
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:46:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50246)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kOLMr-0005s4-4Y
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:45:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24631)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kOLMo-00067x-Qu
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:45:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601646298;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4YOj9f1u0WuqMJa6i5RjfllYrxr9560gViHY41B4MI=;
 b=ZqJzU8OpNOa/1JKmOcP+U3v0zFwDmF6G/vZS5Zr0LPaX96v4ZWEkhoWAN7C5nJU8S/LpL0
 mJhT95LwsX6zk96OWqGJsR73zDRnWGrCOC6tAI8JBW7ApidcHHXyqp8z1XOpW0efEDikFB
 dAgsGDzxMOBKYk5RyO2EW2Aj+71yzcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-367-YeouwQnhPhK23kczjh1uTg-1; Fri, 02 Oct 2020 09:44:46 -0400
X-MC-Unique: YeouwQnhPhK23kczjh1uTg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 68CCF8030A5;
 Fri,  2 Oct 2020 13:44:45 +0000 (UTC)
Received: from redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B91173678;
 Fri,  2 Oct 2020 13:44:43 +0000 (UTC)
Date: Fri, 2 Oct 2020 14:44:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH v2 11/11] tests/9pfs: add local Tmkdir test
Message-ID: <20201002134440.GD2338114@redhat.com>
References: <cover.1601639563.git.qemu_oss@crudebyte.com>
 <9488e95ff86b6ceea0254dab6a7dff67cbe0bf16.1601639563.git.qemu_oss@crudebyte.com>
 <20201002125614.GA2338114@redhat.com> <2826440.YJNrgBH8pc@silver>
MIME-Version: 1.0
In-Reply-To: <2826440.YJNrgBH8pc@silver>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

On Fri, Oct 02, 2020 at 03:41:07PM +0200, Christian Schoenebeck wrote:
> On Freitag, 2. Oktober 2020 14:56:14 CEST Daniel P. Berrangé wrote:
> > On Fri, Oct 02, 2020 at 01:51:54PM +0200, Christian Schoenebeck wrote:
> > > This test case uses the 9pfs 'local' driver to create a directory
> > > and then checks if the expected directory was actually created
> > > (as real directory) on host side.
> > > 
> > > Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> > > ---
> > > 
> > >  tests/qtest/virtio-9p-test.c | 139 +++++++++++++++++++++++++++++++++++
> > >  1 file changed, 139 insertions(+)
> > > 
> > > diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> > > index af7e169d3a..93161a4b35 100644
> > > --- a/tests/qtest/virtio-9p-test.c
> > > +++ b/tests/qtest/virtio-9p-test.c
> > > @@ -18,6 +18,62 @@
> > > 
> > >  #define QVIRTIO_9P_TIMEOUT_US (10 * 1000 * 1000)
> > >  static QGuestAllocator *alloc;
> > > 
> > > +/*
> > > + * Used to auto generate new fids. Start with arbitrary high value to
> > > avoid + * collision with hard coded fids in basic test code.
> > > + */
> > > +static uint32_t fid_generator = 1000;
> > > +
> > > +static uint32_t genfid(void)
> > > +{
> > > +    return fid_generator++;
> > > +}
> > > +
> > > +/**
> > > + * Splits the @a in string by @a delim into individual (non empty)
> > > strings
> > > + * and outputs them to @a out. The output array @a out is NULL
> > > terminated.
> > > + *
> > > + * Output array @a out must be freed by calling split_free().
> > > + *
> > > + * @returns number of individual elements in output array @a out (without
> > > the + *          final NULL terminating element)
> > > + */
> > > +static int split(const char *in, const char *delim, char ***out)
> > > +{
> > > +    int n = 0, i = 0;
> > > +    char *tmp, *p;
> > > +
> > > +    tmp = g_strdup(in);
> > > +    for (p = strtok(tmp, delim); p != NULL; p = strtok(NULL, delim)) {
> > > +        if (strlen(p) > 0) {
> > > +            ++n;
> > > +        }
> > > +    }
> > > +    g_free(tmp);
> > > +
> > > +    *out = g_malloc0(n * sizeof(char *) + 1); /* last element NULL
> > > delimiter */
> > Surely this should be  (n + 1) * sizeof(char *), because the last
> > element still needs to be large enough to hold a pointer, not a
> > single extra byte.
> 
> Right, good catch!
> 
> > > +
> > > +    tmp = g_strdup(in);
> > > +    for (p = strtok(tmp, delim); p != NULL; p = strtok(NULL, delim)) {
> > > +        if (strlen(p) > 0) {
> > > +            (*out)[i++] = g_strdup(p);
> > > +        }
> > > +    }
> > > +    g_free(tmp);
> > > +
> > > +    return n;
> > > +}
> > 
> > This seems to largely re-invent g_strsplit
> > 
> > https://developer.gnome.org/glib/2.62/glib-String-Utility-Functions.html#g-s
> > trsplit
> 
> Yes, except that g_strsplit() outputs empty array elements as well. That's not 
> desired/working for this patch.

Either make the caller ignore/skip over empty elements, or make
this method call g_strsplit and then filter out the empty elements.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


