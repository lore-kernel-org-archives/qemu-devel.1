Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D172C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195B8206B6
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 10:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ub6XWDCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195B8206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3GcU-0003zL-9S
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 06:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3Gbp-0003Tk-FL
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:25:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37690
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1k3Gbm-0003XN-GQ
 for qemu-devel@nongnu.org; Wed, 05 Aug 2020 06:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596623116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wv1Sm59lILbjOslmVhx934AdwyDCqHFGtQYPmy0237k=;
 b=Ub6XWDCb/PM6GQPZqD8CS64u4Gae1v/2CfgImfkLiCkhjaKxFEzrUlJ0IJTP5qxqegm21l
 PXwiL7Wvo46rRppwbpaglg3P6C02hJvM3RbdkivQh33p/vdcZRFv1ZwYJEPb1PgPgKPTmD
 rBRMti1mWYgH3XNU7ohb9Bnl3RgNkhA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-clUsBvQlMnuo-Ia6xld6dw-1; Wed, 05 Aug 2020 06:25:15 -0400
X-MC-Unique: clUsBvQlMnuo-Ia6xld6dw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE969101C8A8;
 Wed,  5 Aug 2020 10:25:13 +0000 (UTC)
Received: from gondolin (ovpn-113-4.ams2.redhat.com [10.36.113.4])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5AF981002388;
 Wed,  5 Aug 2020 10:25:00 +0000 (UTC)
Date: Wed, 5 Aug 2020 12:24:57 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: cleanups with long-term benefits
Message-ID: <20200805122457.1acb4c8d.cohuck@redhat.com>
In-Reply-To: <20200805100802.GG4127670@redhat.com>
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
 <20200805100802.GG4127670@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=cohuck@redhat.com;
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Andrea Bolognani <abologna@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Aug 2020 11:08:02 +0100
Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:

> On Wed, Aug 05, 2020 at 11:11:55AM +0200, Cornelia Huck wrote:
> > On Wed, 5 Aug 2020 10:05:40 +0100
> > Daniel P. Berrang=C3=A9 <berrange@redhat.com> wrote:
> >  =20
> > > On Wed, Aug 05, 2020 at 10:49:35AM +0200, Paolo Bonzini wrote: =20
> > > > On 05/08/20 10:39, Dr. David Alan Gilbert wrote:   =20
> > > > >> Do you really use "git blame" that much?  "git log -S" does more=
 or less
> > > > >> the same function (in a different way) and is not affected as mu=
ch by
> > > > >> large code movement and transformation patches.   =20
> > > > >
> > > > > I use it a lot!   Following stuff back to find where a change cam=
e
> > > > > from and then asking people.   =20
> > > >=20
> > > > Indeed, but I use "git log -S" instead. :)  Another possibility is =
to
> > > > just do "git log -p" and search for a relevant line of the code I'm
> > > > "blaming".   =20
> > >=20
> > > I used git blame alot too, but I don't think its a reason to not do t=
he
> > > cleanups. It is easy enough to just tell blame to use an earlier comm=
it
> > > if you see it displaying a refactor. I don't think such mild inconven=
ience
> > > should stop us making otherwise desirable code changes =20
> >=20
> > I don't think people argue that it should block changes; it it simply
> > another thing to consider when weighing benefits vs. drawbacks. =20
>=20
> Actually, I'm saying that including "git blame" in such a weighing is
> the mechanism for blocking otherwise beneficial change to the code. Or
> to put it another way, I believe the value assigned to "git blame" in
> such a comparison is miniscule / effectively zero. The only time
> "git blame" should win is if the change in question is purely the
> bike shed colour and has no technical benefits at all.  If there's any
> technical benefit to making the change it should always win.  We
> shouldn't preserve technical debt in the code merely to avoid an impact
> on "git blame".

I think we have to agree to disagree on this. Making "git blame" harder
to use is annoying, and at least for me there's a threshold of
usefulness for the code change that should be considered. (No judgment
on the proposed change here; I don't have really have a horse in that
race.)


