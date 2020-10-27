Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A22FC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:19:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A6C206B2
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 22:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ve1aEP6w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A6C206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXXJt-0007a1-Md
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 18:19:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kXXIu-00071q-UK
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 18:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kXXIr-0003Qf-KL
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 18:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603837131;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=swW9lP82Q8asy0qDrjELoougrDMiLSkvR/ZZUsaCZ+s=;
 b=Ve1aEP6whTsx8DHsFUN/NqlY+OBACQDAmVAzCT8omMtDfulVoJuOOVxTXUZlDbjkB1KR4b
 +wxVavqua7bUDv4TklOXMdqqBwmG1QMkmDa8BUiOazFGX87YEl6zxHyyESgD6i284Efv82
 IfrV3SQ4PxQOLCw624fIBvhygMlGt/4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-WQ_YpJRBMn6h5JHzqHRUdA-1; Tue, 27 Oct 2020 18:18:49 -0400
X-MC-Unique: WQ_YpJRBMn6h5JHzqHRUdA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C92AA1009E23
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 22:18:48 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4918519C4F;
 Tue, 27 Oct 2020 22:18:44 +0000 (UTC)
Date: Tue, 27 Oct 2020 18:18:42 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 03/12] qom: Make object_class_property_add_uint*_ptr()
 get offset
Message-ID: <20201027221842.GG5733@habkost.net>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
 <20201009160122.1662082-4-ehabkost@redhat.com>
 <20201021142408.72d2b92f@redhat.com>
 <20201021133041.GT5733@habkost.net>
 <20201023173314.6d46ada9@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201023173314.6d46ada9@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 23, 2020 at 05:33:14PM +0200, Igor Mammedov wrote:
> On Wed, 21 Oct 2020 09:30:41 -0400
> Eduardo Habkost <ehabkost@redhat.com> wrote:
[...]
> > I don't love object*_property_add_*_ptr() either.  I consider the
> > qdev property API better.  But we need a reasonable alternative,
> > because the qdev API can't be used by non-device objects yet.
> > I don't think object*_property_add() and
> > object*_property_add_bool() are reasonable alternatives.
> 
> I also like old qdev API as it can be introspected (it's just data at
> class level), very concise when used and has default values.
> 
> Instead of duplicating all that pointer arithmetic from qdev properties
> in QOM API, it could be better to fix qdev properties so that they
> would work for Object as well.
> At least all that thrown away type safety would stay constrained/hidden
> inside of qdev property macros, instead of being opencoded (offsets) all
> over the place.
> 
> How hard it would be make qdev properties to work with Object and what
> makes you duplicate ugly part of it in QOM instead of making them to
> handle Object strait away?

It is doable, but lots of work.  I'm working on this right now.

> That would also result in huge removal of boiler plate of current QOM
> properties.

Yep.

> 
> That should suit your goal to make (most) properties introspectable
> and statically described.

That's correct.  I just don't want a huge qdev refactor to be a
reason to delay important work in other areas.

-- 
Eduardo


