Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0C8C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:20:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97ED32395C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 13:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cdwtz7WJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97ED32395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLndt-0001KX-NW
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 09:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLnXU-0001xd-Fv
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:13:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kLnXS-00042A-PG
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 09:13:28 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601039605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7byq/43urxKD/pGBbVN5gQ2pX5MjOJqBzwFP1wtlyo0=;
 b=cdwtz7WJNg290s9ufatqhvJBJ8DqBGSJiymwsHONB6w2aw9DEF8U2liwz57GyVw36cGAAg
 qxsS/ju+mmpbg4jPuvfsIu2Q8q9vAgSL1UzwZHq3LGYuSyRasyD+1bHdsguj98Tio33E5l
 nQfGUwGys4lyKsQhU+zzg8GyJqS1t2Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-RTrUrKTAMEWQfAo4Zvxokw-1; Fri, 25 Sep 2020 09:13:24 -0400
X-MC-Unique: RTrUrKTAMEWQfAo4Zvxokw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D0AF91018725;
 Fri, 25 Sep 2020 13:13:22 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 929BB60C15;
 Fri, 25 Sep 2020 13:13:22 +0000 (UTC)
Date: Fri, 25 Sep 2020 09:13:21 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 09/38] qapi/common.py: Add indent manager
Message-ID: <20200925131321.GO3717385@habkost.net>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-10-jsnow@redhat.com>
 <20200922222232.GK2044576@habkost.net>
 <c57afb75-3db9-abec-dd21-c32f9f918104@redhat.com>
 <87sgb6t6p1.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87sgb6t6p1.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 25, 2020 at 01:51:54PM +0200, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> > On 9/22/20 6:22 PM, Eduardo Habkost wrote:
[...]
> > Yeah, there's only one user right now, so ... I just kinda wanted to
> > get rid of the global usage. Maybe if we make the code generator
> > fancier we'll find out what form is best.
> 
> You don't get rid of the global variable, you just change it from
> integer to a class.  A class can be handier when generating multiple
> things interleaved, because you can have one class instance per thing.

To be fair, John doesn't claim to be getting rid of a global
variable.  He's getting rid of usage of the 'global' keyword to
make linters happier.  There are ways to do that without changing
the code too much, though.

> 
> Note that we already have a class instance per thing we generate:
> instances of subtypes of QAPIGen.  The thought of moving the indentation
> machinery into QAPIGen or or maybe QAPIGenCCode crossed my mind many
> moons ago, but I had bigger fish to fry, and then I forgot :)
> 
> John, I suggest you don't try to make this pretty just yet.  Do what
> needs to be done for the type hint job.  We can make it pretty later.

-- 
Eduardo


