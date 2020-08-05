Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D491CC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCB6207FC
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cem9lO+I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCB6207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GPG-0004U6-Tm
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39648)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3GLQ-0007hM-K6
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:08:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39290
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3GLO-0001Io-PB
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596622101;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oW19D/184eYQdwLQAfWwI65mqP28F9dcBCqe2GQe1xo=;
 b=Cem9lO+I62pdvqkqGMR7gh4Oo5A1r+OIBcku6x6Dfkz+6qJEciBJBtbPJ4yn7+exMPpUhE
 Ki9HRKKHByy2Fj+omBcdRDTPGCmfrkS3syZhpwX+J7XacrplEc2baB+SWsm+vG9DBq6YzB
 HbkeBfAgZ4gja8Q1GkZeJk6b5e/q+nM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-ol3kOy9AM4Cv7gkG08evKg-1; Wed, 05 Aug 2020 06:08:18 -0400
X-MC-Unique: ol3kOy9AM4Cv7gkG08evKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64429800461;
 Wed,  5 Aug 2020 10:08:17 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.39])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CDA771771;
 Wed,  5 Aug 2020 10:08:05 +0000 (UTC)
Date: Wed, 5 Aug 2020 11:08:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: cleanups with long-term benefits
Message-ID: <20200805100802.GG4127670@redhat.com>
References: <87y2mvhg3k.fsf@dusky.pond.sub.org>
 <facfef76-d880-82dd-f862-a64f8f487ba2@redhat.com>
 <87k0yeg7mc.fsf@dusky.pond.sub.org>
 <6e5df5fc-94f8-ee8e-0c14-f56135de25e4@redhat.com>
 <87o8np5ysp.fsf@dusky.pond.sub.org>
 <9f83eb93-5389-7aad-3031-0777de0c35b0@redhat.com>
 <20200805083949.GA3004@work-vm>
 <241436db-1aec-b804-314f-7893954e981b@redhat.com>
 <20200805090540.GC4127670@redhat.com>
 <20200805111155.25abfd26.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805111155.25abfd26.cohuck@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 01:46:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 05, 2020 at 11:11:55AM +0200, Cornelia Huck wrote:
> On Wed, 5 Aug 2020 10:05:40 +0100
> Daniel P. Berrangé <berrange@redhat.com> wrote:
> 
> > On Wed, Aug 05, 2020 at 10:49:35AM +0200, Paolo Bonzini wrote:
> > > On 05/08/20 10:39, Dr. David Alan Gilbert wrote:  
> > > >> Do you really use "git blame" that much?  "git log -S" does more or less
> > > >> the same function (in a different way) and is not affected as much by
> > > >> large code movement and transformation patches.  
> > > >
> > > > I use it a lot!   Following stuff back to find where a change came
> > > > from and then asking people.  
> > > 
> > > Indeed, but I use "git log -S" instead. :)  Another possibility is to
> > > just do "git log -p" and search for a relevant line of the code I'm
> > > "blaming".  
> > 
> > I used git blame alot too, but I don't think its a reason to not do the
> > cleanups. It is easy enough to just tell blame to use an earlier commit
> > if you see it displaying a refactor. I don't think such mild inconvenience
> > should stop us making otherwise desirable code changes
> 
> I don't think people argue that it should block changes; it it simply
> another thing to consider when weighing benefits vs. drawbacks.

Actually, I'm saying that including "git blame" in such a weighing is
the mechanism for blocking otherwise beneficial change to the code. Or
to put it another way, I believe the value assigned to "git blame" in
such a comparison is miniscule / effectively zero. The only time
"git blame" should win is if the change in question is purely the
bike shed colour and has no technical benefits at all.  If there's any
technical benefit to making the change it should always win.  We
shouldn't preserve technical debt in the code merely to avoid an impact
on "git blame".

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


