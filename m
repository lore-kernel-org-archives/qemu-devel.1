Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5574CC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:21:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE7CC2192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 16:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QB4OCK85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE7CC2192A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVzoZ-0001bP-MF
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 12:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33898)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVz4N-0002vN-Pj
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kVz4K-0002Fd-0d
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 11:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603467206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gBTqbxPLN4v0Cxd/7zJuKjD0h5EEBYn6B3nelfxngwQ=;
 b=QB4OCK85QQweJNJWGZdlK/lZoF88A0aPocHT4eGsexluOppf8ya2rKH5xRYXNr+c5iCdPH
 Cwjmv3RUhSpZxuppj5IbUcC8rzaxguiIZ8e3wHseJ35JVDIm34zj3old4lmb5y97TTlwI3
 xar8NpCDLFmm57Gca/jOzuudWc9Ee2Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-4f5jUjNDOvuqcag4oarWqA-1; Fri, 23 Oct 2020 11:33:24 -0400
X-MC-Unique: 4f5jUjNDOvuqcag4oarWqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99233804B75
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2020 15:33:23 +0000 (UTC)
Received: from localhost (unknown [10.40.208.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 69DF75D9E2;
 Fri, 23 Oct 2020 15:33:16 +0000 (UTC)
Date: Fri, 23 Oct 2020 17:33:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [PATCH 03/12] qom: Make object_class_property_add_uint*_ptr()
 get offset
Message-ID: <20201023173314.6d46ada9@redhat.com>
In-Reply-To: <20201021133041.GT5733@habkost.net>
References: <20201009160122.1662082-1-ehabkost@redhat.com>
 <20201009160122.1662082-4-ehabkost@redhat.com>
 <20201021142408.72d2b92f@redhat.com>
 <20201021133041.GT5733@habkost.net>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 01:44:00
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
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Oct 2020 09:30:41 -0400
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Oct 21, 2020 at 02:24:08PM +0200, Igor Mammedov wrote:
> > On Fri,  9 Oct 2020 12:01:13 -0400
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > The existing object_class_property_add_uint*_ptr() functions are
> > > not very useful, because they need a pointer to the property
> > > value, which can't really be provided before the object is
> > > created.
> > > 
> > > Replace the pointer parameter in those functions with a
> > > `ptrdiff_t offset` parameter.
> > > 
> > > Include a uint8 class property in check-qom-proplist unit tests,
> > > to ensure the feature is working.  
> > 
> > 
> > Not sure I like approach, it's reinventing qdev pointer properties in QOM form.  
> 
> Yes, and that's on purpose.  If we want to eventually merge the
> two competing APIs into a single one, we need to make them
> converge.
> 
> > I had an impression that Paolo wanted qdev pointer properties be gone
> > and replaced by something like link properties.  
> 
> This is completely unrelated to qdev pointer properties and link
> properties.  The properties that use object_property_add_uint*_ptr()
> today are not qdev pointer properties and will never be link
> properties.  They are just integer properties.

right, _prt confused me for a while.

> 
> > 
> > object_property_add_uintXX_ptr() were introduced as a quick hack,
> > when ACPI code generation was moved from Seabios, to avoid more
> > code shuffling in device models and adding more boiler plate in
> > form of custom setters/getters (the later didn't seem to bother
> > us everywhere else where we use object_[class_]property_add() ).
> > Then it spread little bit to another places.
> > 
> > I'd rather get rid of object_property_add_uintXX_ptr() API altogether
> > in favor of object_[class_]property_add() like it is used in other places
> > to handle intXX properties.
> > Adding helpers similar to object_property_add_bool() for intXX
> > could reduce boiler plate need for converting current instances of
> > _ptr(), and such helpers would also help with reducing boilerplate
> > for the rest of instances where object_[class_]property_add()
> > currently is used for dealing with integers.  
> 
> I find object_property_add_bool() terrible.  It requires too much
> boilerplate.  I actually have plans to introduce
> object*_property_add_bool_ptr() to simplify existing
> object_property_add_bool() callers.

But boiler-plate related to QOM properties set/get methods was considered
tolerable back then.
It was a long time ago, so I don't recall why we decided to abandon
qdev properties API.

> I don't love object*_property_add_*_ptr() either.  I consider the
> qdev property API better.  But we need a reasonable alternative,
> because the qdev API can't be used by non-device objects yet.
> I don't think object*_property_add() and
> object*_property_add_bool() are reasonable alternatives.

I also like old qdev API as it can be introspected (it's just data at
class level), very concise when used and has default values.

Instead of duplicating all that pointer arithmetic from qdev properties
in QOM API, it could be better to fix qdev properties so that they
would work for Object as well.
At least all that thrown away type safety would stay constrained/hidden
inside of qdev property macros, instead of being opencoded (offsets) all
over the place.

How hard it would be make qdev properties to work with Object and what
makes you duplicate ugly part of it in QOM instead of making them to
handle Object strait away?
That would also result in huge removal of boiler plate of current QOM
properties.

That should suit your goal to make (most) properties introspectable
and statically described.

[...]


