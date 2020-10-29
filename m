Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DBBC4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:38:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7806F20796
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 13:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbyHDcLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7806F20796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kY88T-0005KN-0Q
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 09:38:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40944)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kY87e-0004WS-Rj
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:37:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30362)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kY87Y-0007zj-SP
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 09:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603978658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4TgzNA+HYd2F+kaWo2ThKgjqc0zU+r6/e2rVpEaNugk=;
 b=bbyHDcLPUd5960z6wFMlp/aUYwwKTp64SDyvGLMM+plkz0+Bldmpl6PXcC0Hx4o9/Yw6xM
 nxDrC/uQk4+nOsRHyGzad+azNoGWSnVs+PxBJEeh/mohB0gObOPBhFVkcthlktKNRV811p
 8fSLLkFraUPJubDHwRofYwH5+ZiGung=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-lYqgXu3LO02Ulp8ENFV6ow-1; Thu, 29 Oct 2020 09:37:36 -0400
X-MC-Unique: lYqgXu3LO02Ulp8ENFV6ow-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8B3EE8015FB
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 13:37:35 +0000 (UTC)
Received: from localhost (unknown [10.40.208.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 314C960C17;
 Thu, 29 Oct 2020 13:37:28 +0000 (UTC)
Date: Thu, 29 Oct 2020 14:37:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 03/12] qom: Make object_class_property_add_uint*_ptr()
 get offset
Message-ID: <20201029143726.2a63d613@redhat.com>
In-Reply-To: <20201029125634.GJ5733@habkost.net>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
 <20201009160122.1662082-4-ehabkost@redhat.com>
 <20201021142408.72d2b92f@redhat.com>
 <20201021133041.GT5733@habkost.net>
 <20201023173314.6d46ada9@redhat.com>
 <6f5c3a13-6798-9d7d-e686-69d549366095@redhat.com>
 <20201029125634.GJ5733@habkost.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/29 01:47:28
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 29 Oct 2020 08:56:34 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Oct 28, 2020 at 04:22:40PM +0100, Paolo Bonzini wrote:
> > On 23/10/20 17:33, Igor Mammedov wrote:  
> > > On Wed, 21 Oct 2020 09:30:41 -0400
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >   
> > >> On Wed, Oct 21, 2020 at 02:24:08PM +0200, Igor Mammedov wrote:  
> > >>> On Fri,  9 Oct 2020 12:01:13 -0400
> > >>> Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >>>     
> > >>>> The existing object_class_property_add_uint*_ptr() functions are
> > >>>> not very useful, because they need a pointer to the property
> > >>>> value, which can't really be provided before the object is
> > >>>> created.
> > >>>>
> > >>>> Replace the pointer parameter in those functions with a
> > >>>> `ptrdiff_t offset` parameter.
> > >>>>
> > >>>> Include a uint8 class property in check-qom-proplist unit tests,
> > >>>> to ensure the feature is working.    
> > >>>
> > >>>
> > >>> Not sure I like approach, it's reinventing qdev pointer properties in QOM form.    
> > >>
> > >> Yes, and that's on purpose.  If we want to eventually merge the
> > >> two competing APIs into a single one, we need to make them
> > >> converge.
> > >>  
> > >>> I had an impression that Paolo wanted qdev pointer properties be gone
> > >>> and replaced by something like link properties.    
> > >>
> > >> This is completely unrelated to qdev pointer properties and link
> > >> properties.  The properties that use object_property_add_uint*_ptr()
> > >> today are not qdev pointer properties and will never be link
> > >> properties.  They are just integer properties.  
> > 
> > I think this series a step in the right direction, but please take more
> > "inspiration" from link properties, which are done right.  In
> > particular, properties should have an optional check function and be
> > read-only unless the check function is there.
> > 
> > You can make the check function take an uint64_t for simplicity, so that
> > all the check functions for uint properties have the same prototype.
> > For example a single "property_check_uint_allow" function can allow
> > setting the property (which is almost always wrong, but an easy cop out
> > for this series).  
> 
> A property check callback that needs the property value is a more
> complex use case, and would require too much property-type-specific
> boilerplate today.  I plan to address it, but not right now.
sounds good to me,
as long as user don't have deal with offsets directly and macro does
its type check thing.


> In my next series that makes static properties usable by any QOM
> object, I will add a separate "allow_set" callback to the
> internal QOM property API, which will not take the property value
> as argument.  This would be enough for the dev->realized checks
> that are currently in qdev.
> 
> Interestingly, there is only one link property check callback
> function in the QEMU tree that actually cares about the property
> value: isa_ipmi_bmc_check().  All other cases either don't care
> about the property value at all (qdev_prop_allow_set_link_before_realize(),
> object_property_allow_set_link()), or are being misused for
> something other than property checking (xlnx_dp_set_dpdma()).
> 


