Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96F7C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B93E02076E
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jGgYYWEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B93E02076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3MZS-0006GR-28
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k3MYo-0005ly-J9
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:46:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27277
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1k3MYm-0004E3-Gr
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 12:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596645995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uJ3QaSuGnIrVbfsBwBJP9uircM7bamJWScqAMgLtmaE=;
 b=jGgYYWEKegUjY+mGkI0E+WSqHcAxzPEojHu3AmiEodjdKgozbKTTW58vGQUP/pXSpioHFU
 Q/V+hnp9j0+FxehGgJsWQbSSZUPRjQezX+N+o9hIjAxYUXIJjuN9n6MK1Jm0OtFbHFrpBP
 iYUwpCOKLuoAq8UGlESxP6TsgO1bAsk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-jTTbl54aNIiJFG7wHRZFlg-1; Wed, 05 Aug 2020 12:46:32 -0400
X-MC-Unique: jTTbl54aNIiJFG7wHRZFlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBE6B106B242;
 Wed,  5 Aug 2020 16:46:30 +0000 (UTC)
Received: from localhost (ovpn-112-108.rdu2.redhat.com [10.10.112.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D7F6D5D9DC;
 Wed,  5 Aug 2020 16:46:19 +0000 (UTC)
Date: Wed, 5 Aug 2020 12:46:18 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: cleanups with long-term benefits
Message-ID: <20200805164618.GO225270@habkost.net>
References: <87k0yeg7mc.fsf@dusky.pond.sub.org>
 <6e5df5fc-94f8-ee8e-0c14-f56135de25e4@redhat.com>
 <87o8np5ysp.fsf@dusky.pond.sub.org>
 <9f83eb93-5389-7aad-3031-0777de0c35b0@redhat.com>
 <20200805083949.GA3004@work-vm>
 <241436db-1aec-b804-314f-7893954e981b@redhat.com>
 <20200805090540.GC4127670@redhat.com>
 <20200805111155.25abfd26.cohuck@redhat.com>
 <20200805100802.GG4127670@redhat.com>
 <20200805162323.GB37318@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200805162323.GB37318@linux.fritz.box>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 00:45:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Andrea Bolognani <abologna@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 05, 2020 at 06:23:23PM +0200, Kevin Wolf wrote:
> Am 05.08.2020 um 12:08 hat Daniel P. Berrangé geschrieben:
> > On Wed, Aug 05, 2020 at 11:11:55AM +0200, Cornelia Huck wrote:
> > > On Wed, 5 Aug 2020 10:05:40 +0100
> > > Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > 
> > > > On Wed, Aug 05, 2020 at 10:49:35AM +0200, Paolo Bonzini wrote:
> > > > > On 05/08/20 10:39, Dr. David Alan Gilbert wrote:  
> > > > > >> Do you really use "git blame" that much?  "git log -S" does more or less
> > > > > >> the same function (in a different way) and is not affected as much by
> > > > > >> large code movement and transformation patches.  
> > > > > >
> > > > > > I use it a lot!   Following stuff back to find where a change came
> > > > > > from and then asking people.  
> > > > > 
> > > > > Indeed, but I use "git log -S" instead. :)  Another possibility is to
> > > > > just do "git log -p" and search for a relevant line of the code I'm
> > > > > "blaming".  
> > > > 
> > > > I used git blame alot too, but I don't think its a reason to not do the
> > > > cleanups. It is easy enough to just tell blame to use an earlier commit
> > > > if you see it displaying a refactor. I don't think such mild inconvenience
> > > > should stop us making otherwise desirable code changes
> > > 
> > > I don't think people argue that it should block changes; it it simply
> > > another thing to consider when weighing benefits vs. drawbacks.
> > 
> > Actually, I'm saying that including "git blame" in such a weighing is
> > the mechanism for blocking otherwise beneficial change to the code. Or
> > to put it another way, I believe the value assigned to "git blame" in
> > such a comparison is miniscule / effectively zero. The only time
> > "git blame" should win is if the change in question is purely the
> > bike shed colour and has no technical benefits at all.  If there's any
> > technical benefit to making the change it should always win.  We
> > shouldn't preserve technical debt in the code merely to avoid an impact
> > on "git blame".
> 
> We're basically weighing "git blame" against syntax highlighting
> defaults. I don't think the latter has an obviously higher weight.

I think "syntax highlight defaults" is far from being an accurate
description of the motivations behind this discussion.

-- 
Eduardo


