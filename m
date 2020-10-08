Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B528EC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:04:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9C5D208C7
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 08:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9qYyZzN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C5D208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQQuq-00015x-I5
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 04:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37548)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQQuA-0000eh-P9
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 04:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55284)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQQu7-0002VB-CL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 04:04:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602144238;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=frUSY1FV+5KcpFAPiPXVFV/A4EyrriuOfzc4SfX2Q6Q=;
 b=W9qYyZzNU21dAQybV22axrxDdj2cgSzJCm2gmpF0GzX4gL5OX7A6qAJ0W6OG25Bi5wKN2P
 jPAmY27A4Ma+rxl0Q7JqD5gw50QoS4q+1DHzVM3INM9TZNt/hfsCFL3aVbHIFjB5lmWOJI
 VM8qyRbht+BJ1JbvoRdId9iEAJ9ogF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-336-l1evTXV1MLa3hRU4bH2gJg-1; Thu, 08 Oct 2020 04:03:54 -0400
X-MC-Unique: l1evTXV1MLa3hRU4bH2gJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33D8910866B0;
 Thu,  8 Oct 2020 08:03:53 +0000 (UTC)
Received: from linux.fritz.box (ovpn-113-68.ams2.redhat.com [10.36.113.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 597AE5C22D;
 Thu,  8 Oct 2020 08:03:47 +0000 (UTC)
Date: Thu, 8 Oct 2020 10:03:45 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: KVM call for agenda for 2020-10-06
Message-ID: <20201008080345.GB4672@linux.fritz.box>
References: <874kndm1t3.fsf@secure.mitica>
 <20201005144615.GE5029@stefanha-x1.localdomain>
 <CAJSP0QVZcEQueXG1gjwuLszdUtXWi1tgB5muLL6QHJjNTOmyfQ@mail.gmail.com>
 <8fce8f99-56bd-6a87-9789-325d6ffff54d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fce8f99-56bd-6a87-9789-325d6ffff54d@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Cc: Daniel Berrange <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 07.10.2020 um 19:50 hat Paolo Bonzini geschrieben:
> On 06/10/20 20:21, Stefan Hajnoczi wrote:
> >     * Does command-line order matter?
> >         * Two options: allow any order OR left-to-right ordering
> >         * Andrea Bolognani: Most users expect left-to-right ordering,
> > why allow any order?
> >         * Eduardo Habkost: Can we enforce left-to-right ordering or do
> > we need to follow the deprecation process?
> >         * Daniel Berrange: Solve compability by introducing new
> > binaries without the burden of backwards compability
> 
> I think "new binaries" shouldn't even have a command line; all
> configuration should happen through QMP commands.  Those are naturally
> time-ordered, which is equivalent to left-to-right, and therefore the
> question is sidestepped.  Perhaps even having a command line in
> qemu-storage-daemon was a mistake.
> 
> For "old binaries" we are not adding too many options, so apart from the
> nasty distinction between early and late objects we're at least not
> making it worse.
> 
> The big question to me is whether the configuration should be
> QAPI-based, that is based on QAPI structs, or QMP-based.  If the latter,
> "object-add" (and to a lesser extent "device-add") are fine mechanisms
> for configuration.  There is still need for better QOM introspection,
> but it would be much simpler than doing QOM object creation via QAPI
> struct, if at all possible.

I would strongly vote for QAPI-based. It doesn't have to be fully based
on QAPI structs internally, but the defining property for me is that the
external interface is described in the QAPI schema (which implies using
QAPI structs for the external facing code).

Not only is it a PITA to work with things like "gen": false or "props":
"any", but having two systems to configure things side by side is also
highly inconsistent.

I have recently discussed object-add with Markus, or to be more precise,
a QAPIfied --object in qsd wrapping it. This doesn't work well without
having a schema. I believe the right thing to do there is build a QAPI
schema describing the existing QOM properties in a first step (which
already gives you all of the advantages of QAPI like introspection), and
then in a second step generate the respective QOM code for initialising
the properties from the schema instead of duplicating it.

This can get challenging with dynamic properties, but as far as I can
see, user creatable objects only have class properties or object
properties created right in .instance_init (which should be equivalent).

As the number of user creatable objects isn't too large, this shouldn't
be too hard. I'm less sure about device-add, though in theory the same
approch would probably result in the best interface.

Kevin


