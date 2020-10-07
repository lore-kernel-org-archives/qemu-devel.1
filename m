Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2B9C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:05:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD9F2168B
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 18:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gFsoczKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD9F2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQDok-0000Ze-LE
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 14:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37706)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQDo2-00005r-PD
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29942)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQDnz-0004rp-2g
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 14:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602093885;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=hA/Ic/DvHRIWAAPJE/LGTu0E2S1egMhpGna2Sykdi3w=;
 b=gFsoczKD154lsyNb1b3O0vqhlDCSL57YrjDb+A99qai/65XVGYgxQ0BuzhqVwetDNDTpum
 iAhvK0k40ku/7K2vBOS0bIyAQzccdCYymBk7SQdgLmxVqWfs7pDiczmoi6WIwljdGG//jD
 bhQn1d0e8OR+OSKMFx0ZxYJ4Mz+OisM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-6FM-k7x8Mj2c74P_45QdLQ-1; Wed, 07 Oct 2020 14:04:36 -0400
X-MC-Unique: 6FM-k7x8Mj2c74P_45QdLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD39F18C9F59;
 Wed,  7 Oct 2020 18:04:34 +0000 (UTC)
Received: from redhat.com (ovpn-114-68.ams2.redhat.com [10.36.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F6C55DA2A;
 Wed,  7 Oct 2020 18:04:32 +0000 (UTC)
Date: Wed, 7 Oct 2020 19:04:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: KVM call for agenda for 2020-10-06
Message-ID: <20201007180429.GI2505881@redhat.com>
References: <874kndm1t3.fsf@secure.mitica>
 <20201005144615.GE5029@stefanha-x1.localdomain>
 <CAJSP0QVZcEQueXG1gjwuLszdUtXWi1tgB5muLL6QHJjNTOmyfQ@mail.gmail.com>
 <8fce8f99-56bd-6a87-9789-325d6ffff54d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fce8f99-56bd-6a87-9789-325d6ffff54d@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm-devel <kvm@vger.kernel.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 07, 2020 at 07:50:20PM +0200, Paolo Bonzini wrote:
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

Non-interactive configuration is a nice property for simpler integration
use cases. eg launching from the shell is tedious with QMP compared to
CLI args.

This could be addressed though by having a configuration file to load
config from, where the config entries can be mapped 1-1 onto QMP commands,
essentially making the config file a non-interactive QMP.

> The big question to me is whether the configuration should be
> QAPI-based, that is based on QAPI structs, or QMP-based.  If the latter,
> "object-add" (and to a lesser extent "device-add") are fine mechanisms
> for configuration.  There is still need for better QOM introspection,
> but it would be much simpler than doing QOM object creation via QAPI
> struct, if at all possible.



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


