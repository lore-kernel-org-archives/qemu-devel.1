Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37AE1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C3420772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxQ3cpZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C3420772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIZs-0002pR-7C
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtIEo-0007av-82
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:08:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58455
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jtIEm-0007Xe-G6
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594246099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Jsrsa+mpfAxFfODBIxliRBouMPa/EZVyLpo6azFhnKQ=;
 b=QxQ3cpZVHQ0G2kWNkPrN60LhXouFGPjp/2myEklYXtcKzvTnSh6KWfNTePmXko9RpKBYUM
 8q6/f0a0H+LBvzha1ZGZL7yc1Gg6J0WppoEZX3MVSVzZiMO6iq8WcYVahwTrtNRVCv2BQu
 LIQP2Fty5d6e90W7NTt3fLoaDtRASUg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-399-bwkkyKd1PQapLglg_WyteA-1; Wed, 08 Jul 2020 12:05:59 -0400
X-MC-Unique: bwkkyKd1PQapLglg_WyteA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32EAE1902EA0;
 Wed,  8 Jul 2020 16:05:58 +0000 (UTC)
Received: from linux.fritz.box (ovpn-114-206.ams2.redhat.com [10.36.114.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 417035C1D3;
 Wed,  8 Jul 2020 16:05:57 +0000 (UTC)
Date: Wed, 8 Jul 2020 18:05:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PULL 13/29] qapi: Flatten object-add
Message-ID: <20200708160555.GE4902@linux.fritz.box>
References: <20200306171458.1848-1-kwolf@redhat.com>
 <20200306171458.1848-14-kwolf@redhat.com>
 <7dc27dad-7797-dc2a-9456-2a7aaf9a4e5c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <7dc27dad-7797-dc2a-9456-2a7aaf9a4e5c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:09
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
Cc: peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 08.07.2020 um 17:48 hat Paolo Bonzini geschrieben:
> On 06/03/20 18:14, Kevin Wolf wrote:
> > Mapping object-add to the command line as is doesn't result in nice
> > syntax because of the nesting introduced with 'props'. This becomes
> > nicer and more consistent with device_add and netdev_add when we accept
> > properties for the object on the top level instead.
> > 
> > 'props' is still accepted after this patch, but marked as deprecated.
> > 
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > Message-Id: <20200224143008.13362-8-kwolf@redhat.com>
> > Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> 
> Hi Kevin and Markus,
> 
> I just noticed this patch.  In my opinion "nice syntax" is not a good
> argument for having a "gen: false" command that is even less
> introspectable than the "props" argument.

Markus was going to introduce new QAPI schema syntax that would allow to
specify a few options explicitly and then one option for "the rest" that
would just be mapped to a QDict like "any" or "gen": false, and that
wouldn't require any nesting.

I'm not sure if any progress was made there, but making things
consistent between device_add, netdev_add and object_add was a step in
this direction anyway.

> As an aside, it would have been nice to run this through Markus and me,
> though in all fairness I'm not sure I would have been responsive back
> in February.

It went through my tree because of the other patches in the series, but
I wrote this patch specifically at Markus's request.

> I would like to un-deprecate this for 5.1, and revert it in either 5.1
> or 5.2.  (Also I will be away next week, so the decision would have to
> be taken quickly).

Please discuss it with Markus then.

Kevin


