Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A09C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:55:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD292076A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FLPgyKIm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD292076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnQfI-0005C9-Cn
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnQei-0004mF-6f
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:54:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41554
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnQeg-00020t-B1
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:54:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592848489;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5LNEnLXZ9qO5pjAcUCtZJW0o+3UCyFyuIrqho5V2c/o=;
 b=FLPgyKImGEpufDFEk9xh5xlKRcgZm+a1lW13PTsPaEYVIUHJ+W5AoW+dpNg27/ImV6FvuT
 Gnf+FsjalAqvqS6kuaNFQXT4GTiQVlwRv5ENkRxdmyz0muvJcA84oclAga3OW23XpX0AFy
 q2Hk87Ncer/YCBCbpuq2asqnXIQRXBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-136-NLWbn58LMwOqrmkawrJy8g-1; Mon, 22 Jun 2020 13:54:31 -0400
X-MC-Unique: NLWbn58LMwOqrmkawrJy8g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 094E08038AE;
 Mon, 22 Jun 2020 17:54:30 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 436005BACD;
 Mon, 22 Jun 2020 17:54:28 +0000 (UTC)
Date: Mon, 22 Jun 2020 18:54:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH v2 1/2] util: Introduce qemu_get_host_name()
Message-ID: <20200622175425.GP736373@redhat.com>
References: <cover.1592846572.git.mprivozn@redhat.com>
 <567f969602c1742e23c7760944e909346b2d012b.1592846572.git.mprivozn@redhat.com>
 <20200622173849.GN736373@redhat.com>
 <80586aa2-c02b-54a3-cf10-d7cda297cfbd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <80586aa2-c02b-54a3-cf10-d7cda297cfbd@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:17:49
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
Cc: vfeenstr@redhat.com, sw@weilnetz.de, mdroth@linux.vnet.ibm.com,
 qemu-devel@nongnu.org, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 07:53:40PM +0200, Michal Privoznik wrote:
> On 6/22/20 7:38 PM, Daniel P. Berrangé wrote:
> > On Mon, Jun 22, 2020 at 07:26:44PM +0200, Michal Privoznik wrote:
> > > This function offers operating system agnostic way to fetch host
> > > name. It is implemented for both POSIX-like and Windows systems.
> > > 
> > > Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> > > ---
> > >   include/qemu/osdep.h | 10 ++++++++++
> > >   util/oslib-posix.c   | 32 ++++++++++++++++++++++++++++++++
> > >   util/oslib-win32.c   | 13 +++++++++++++
> > >   3 files changed, 55 insertions(+)
> > > 
> > > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > > index ff7c17b857..a795d46b28 100644
> > > --- a/include/qemu/osdep.h
> > > +++ b/include/qemu/osdep.h
> > > @@ -607,4 +607,14 @@ static inline void qemu_reset_optind(void)
> > >   #endif
> > >   }
> > > +/**
> > > + * qemu_get_host_name:
> > > + * @errp: Error object
> > > + *
> > > + * Operating system agnostic way of querying host name.
> > > + *
> > > + * Returns allocated hostname (caller should free), NULL on failure.
> > > + */
> > > +char *qemu_get_host_name(Error **errp);
> > > +
> > >   #endif
> > > diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> > > index 916f1be224..865a3d71a7 100644
> > > --- a/util/oslib-posix.c
> > > +++ b/util/oslib-posix.c
> > > @@ -761,3 +761,35 @@ void sigaction_invoke(struct sigaction *action,
> > >       }
> > >       action->sa_sigaction(info->ssi_signo, &si, NULL);
> > >   }
> > > +
> > > +#ifndef HOST_NAME_MAX
> > > +# ifdef _POSIX_HOST_NAME_MAX
> > > +#  define HOST_NAME_MAX _POSIX_HOST_NAME_MAX
> > > +# else
> > > +#  define HOST_NAME_MAX 255
> > > +# endif
> > > +#endif
> > > +
> > > +char *qemu_get_host_name(Error **errp)
> > > +{
> > > +    long len = -1;
> > > +    char *hostname;
> > > +
> > > +#ifdef _SC_HOST_NAME_MAX
> > > +    len = sysconf(_SC_HOST_NAME_MAX);
> > > +#endif /* _SC_HOST_NAME_MAX */
> > > +
> > > +    if (len < 0) {
> > > +        len = HOST_NAME_MAX;
> > > +    }
> > > +
> > > +    hostname = g_malloc0(len + 1);
> > 
> > Nitpick, generally qemu prefers g_new0
> > 
> > > +
> > > +    if (gethostname(hostname, len) < 0) {
> > > +        error_setg_errno(errp, errno,
> > > +                         "cannot get hostname");
> > > +        return NULL;
> > > +    }
> > 
> > According to my man page, it is undefined by POSIX whether there's a
> > trailing NUL when  hostname exceeds the buffer, so the paranoid thing
> > todo is to add
> > 
> >    hostname[len] = '\0';
> 
> Isn't this guaranteed by allocating len + 1 bytes? I mean, g_malloc0() and
> g_new0() will memset() the memory to zero. And since I tell gethostname()
> the buf is only len bytes long I am guaranteed to have 0 at the end of it,
> aren't I? Maybe I should put a comment just before g_malloc0() or g_new0()
> that documents this thought.

Oh right, yes, I'm mis-reading the code.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


