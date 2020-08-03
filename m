Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A51EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23F5C207BB
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 12:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axsUVxJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F5C207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ZWE-0008Kv-A9
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 08:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33082)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k2ZVF-0007q8-Ra
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:23:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51993
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k2ZVE-0004M7-5b
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 08:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596457418;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iJC4enJZXlhiXOaxUTdZok78zjEbK7o8qf8YqP+VnJg=;
 b=axsUVxJUnD/5/oohLrAb8AA60Qqk2UuaUHjkOn2rWYCo6XUPUtE5WvN7FIJDWIuTsB0e6I
 vnHSqLYbiikHjPKjKyczFNMWC8IilVOEprLxQt5gIaKntQnxwzjK6skFI8rUO0DViyICRE
 Nzo5IC0fL3vQ8ju8LBK2jppDwg89iTM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-DjNlfs1xNJeGmRt0bJk82w-1; Mon, 03 Aug 2020 08:23:26 -0400
X-MC-Unique: DjNlfs1xNJeGmRt0bJk82w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99DB71005504;
 Mon,  3 Aug 2020 12:23:25 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D527D19C4F;
 Mon,  3 Aug 2020 12:23:07 +0000 (UTC)
Date: Mon, 3 Aug 2020 13:23:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] schemas: Add vim modeline
Message-ID: <20200803122304.GJ3670709@redhat.com>
References: <20200730093732.GB3477223@redhat.com>
 <87k0ylz0ep.fsf@dusky.pond.sub.org>
 <20200730132446.GL3477223@redhat.com>
 <875za33ku1.fsf@dusky.pond.sub.org>
 <20200731150738.GB3660103@redhat.com>
 <03bb7822-20a0-2945-6c86-1d5f1b2a01d9@redhat.com>
 <20200731154429.GD3660103@redhat.com>
 <21cda868-85d3-77db-31d8-0248a5029318@redhat.com>
 <20200803113655.GI3670709@redhat.com>
 <fcc9056d-4d72-5bdb-bd21-2bf6213f5a55@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fcc9056d-4d72-5bdb-bd21-2bf6213f5a55@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/03 02:56:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 03, 2020 at 02:16:19PM +0200, Paolo Bonzini wrote:
> On 03/08/20 13:36, Daniel P. Berrangé wrote:
> >>> Given that QEMU needs to pass
> >>> uint64 values, JSON was simply the wrong choice of format for QMP.
> >
> > I wasn't refering to RFC7159. The problem of undefined integer precision
> > with JSON came up right at the very start when QMP was first designed and
> > implemented, and has come up again periodically ever since then. libvirt
> > needed to do workarounds right at the start in 2009, in order to fully
> > handle signed/unsigned 64-bit integers with QMP.
> 
> I assume the workaround you refer to is to store the number as a string
> and converting it lazily to either an integer or a floating-point type
> in whoever uses the JSON API.  It may not be pretty but probably it
> would have been the same for any text-based, schema-less protocol.  For
> example, it didn't require writing your own parser.

Yes, we get the raw values as a string, but not all parsers for C
allow you to do this.  We'd really love to move off YAJL for JSON
parsing, but the most viable alternatives don't have a way to let
you get the string before they parse it as an integer and report
errors.

> It could be avoided by using a schema in Libvirt, just like QEMU has no
> problem with it on the other side; it's just a different design choice
> with different trade-offs, I don't think it's enough of an issue to
> declare JSON "the wrong choice of format for QMP".

The schema doesn't help - the problem is many JSON parsers don't allow
use of full uint64 values when parsing - alot will simply report an
error for anything bigger than LLONG_MAX and offer no workaround.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


