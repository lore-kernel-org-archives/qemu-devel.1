Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21FBC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:49:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8D620732
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 17:49:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dzUImKY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8D620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnQZu-00007x-Qc
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 13:49:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnQZI-000862-2w
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:49:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jnQZG-0001HF-Bk
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 13:49:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592848153;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+VQWQEbIjiNgYl7tC7QRGHI799KMfXkcSGrbewUWF9c=;
 b=dzUImKY7nlV7TCM2WmnNwmNLilSkyVtXYZWkz+3HosTy4+Dr1tlvuFDQfnwigoFittGbzI
 b6zzWHPu5GbAyG1PGre9rSQoCo6FXrIHOM+UH8uk7Zf+2LInJ0MTHwR9wsIJQ/KrMMz7v4
 gM48XzL4r8BQxIUQv4+v+gFXeENG9Lk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-v7XCVohqMkCWEawi973GDg-1; Mon, 22 Jun 2020 13:49:07 -0400
X-MC-Unique: v7XCVohqMkCWEawi973GDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 992C38005AD;
 Mon, 22 Jun 2020 17:49:06 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.63])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D2DA7167C;
 Mon, 22 Jun 2020 17:49:04 +0000 (UTC)
Date: Mon, 22 Jun 2020 18:49:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 1/2] util: Introduce qemu_get_host_name()
Message-ID: <20200622174901.GO736373@redhat.com>
References: <cover.1592846572.git.mprivozn@redhat.com>
 <567f969602c1742e23c7760944e909346b2d012b.1592846572.git.mprivozn@redhat.com>
 <16ab58fb-226d-5d25-19d6-c8d14b169aab@redhat.com>
MIME-Version: 1.0
In-Reply-To: <16ab58fb-226d-5d25-19d6-c8d14b169aab@redhat.com>
User-Agent: Mutt/1.14.0 (2020-05-02)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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
Cc: mdroth@linux.vnet.ibm.com, Michal Privoznik <mprivozn@redhat.com>,
 qemu-devel@nongnu.org, vfeenstr@redhat.com, marcandre.lureau@gmail.com,
 sw@weilnetz.de, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 22, 2020 at 07:46:08PM +0200, Philippe Mathieu-Daudé wrote:
> On 6/22/20 7:26 PM, Michal Privoznik wrote:
> > This function offers operating system agnostic way to fetch host
> > name. It is implemented for both POSIX-like and Windows systems.
> > 
> > Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
> > ---
> >  include/qemu/osdep.h | 10 ++++++++++
> >  util/oslib-posix.c   | 32 ++++++++++++++++++++++++++++++++
> >  util/oslib-win32.c   | 13 +++++++++++++
> >  3 files changed, 55 insertions(+)
> > 
> > diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
> > index ff7c17b857..a795d46b28 100644
> > --- a/include/qemu/osdep.h
> > +++ b/include/qemu/osdep.h
> > @@ -607,4 +607,14 @@ static inline void qemu_reset_optind(void)
> >  #endif
> >  }
> >  
> > +/**
> > + * qemu_get_host_name:
> > + * @errp: Error object
> > + *
> > + * Operating system agnostic way of querying host name.
> > + *
> > + * Returns allocated hostname (caller should free), NULL on failure.
> 
> free -> g_free?

free & g_free are guaranteed interchangable, given our min glib2 version.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


