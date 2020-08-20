Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B620AC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:15:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81BFE207BB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 16:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfJ08waN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81BFE207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8nE4-0006nB-Qb
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 12:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52148)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8nDU-0006Gg-FJ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:15:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34025
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1k8nDS-0007z3-JJ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 12:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597940101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Zz29hRVVOVBNtRukFk27L/q6b0oDEhaDhLCj4qcf3MQ=;
 b=dfJ08waN1Qs91oAcXs+lk39UxGLQ1eS1gltg9bmds6xy07gLu3reX5JAQSYMo+0+lE+9Kv
 6jH+leQ8ggnNww/joq2ulcmE37/rtgzjFu5HLhfOxZdfjtBh24zKkZwnM1MbejlqgVZ+K0
 jzmlqg5fhFaTjvcquuV6cD8vsWr4TK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-0YUw6fWcMFezhKNHCU73vg-1; Thu, 20 Aug 2020 12:14:59 -0400
X-MC-Unique: 0YUw6fWcMFezhKNHCU73vg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7169785C70A;
 Thu, 20 Aug 2020 16:14:58 +0000 (UTC)
Received: from linux.fritz.box (ovpn-112-185.ams2.redhat.com [10.36.112.185])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7986960BF1;
 Thu, 20 Aug 2020 16:14:57 +0000 (UTC)
Date: Thu, 20 Aug 2020 18:14:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: deprecation of in-tree builds
Message-ID: <20200820161456.GG99531@linux.fritz.box>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <alpine.BSF.2.22.395.2003212338020.36211@zero.eik.bme.hu>
 <20200323133244.GK261260@stefanha-x1.localdomain>
 <CAFEAcA9VPgQ1MPYhcda4tdxMuhMC5R9fd6D=OVOZKRLMO8n_xw@mail.gmail.com>
 <20200820105401.GA99531@linux.fritz.box>
 <9bdbb3b9-01df-2a6b-0c82-b58ef6e0edf9@redhat.com>
 <20200820133023.GD99531@linux.fritz.box>
 <80348ec7-4897-a2ab-54a6-2997ee47b598@redhat.com>
MIME-Version: 1.0
In-Reply-To: <80348ec7-4897-a2ab-54a6-2997ee47b598@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 03:03:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 20.08.2020 um 17:50 hat Paolo Bonzini geschrieben:
> On 20/08/20 15:30, Kevin Wolf wrote:
> > So without that, and also without a mention in deprecated.rst, I don't
> > think having mentioned a wish to break things a while ago means that we
> > should just follow through with that despite the objections.
> > 
> > At least this isn't how it has worked for other patch series. If it is
> > the new standard, I can remove -drive tomorrow. I've been mentioning for
> > years that I don't like it and want to remove it, so people can just
> > deal with it.
> 
> Come on, you're too smart to say that seriously.  The deprecation policy
> only applies to user-visible features, users don't care if ./configure
> && make works.  (There is precedent for that: the switch from "make
> subdir-*" to "make */all" was never included in user-visible documentation).
> 
> I hate to say this but if the Meson conversion does not land in the next
> few days (I will disappear again on Saturday) I'm just going to drop it
> on the floor and let people have fun with their Makefiles.
> 
> I have already spent the last 3 weeks on it almost full time and I
> cannot really justify, to both myself and my employer, spending much
> more time on a build system rather than fixing real bugs[1] or doing
> shiny new stuff.

I just don't understand why 99.9% of it were okay to do, but the final
bit that would make the switch a lot more seamless to people is asking
too much. You're familiar with the state after your patches, I'm not. I
assume you're also the one who sends the pull request, and anything
developed after that pull request will mean that people will already
be impacted.

If you ask me to do pause my work, instead familiarise myself with your
work and do that final bit so that you can then include it in your pull
request, I'm sure your employer will pay for more time being spent
rather than less.

Kevin


