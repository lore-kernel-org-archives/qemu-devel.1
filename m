Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78FCC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:32:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5DB2226B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQkoGNia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5DB2226B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXXj-0001Yf-0R
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIXVt-0000Gh-CB
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:30:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIXVr-0005CS-CU
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:30:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600263018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HgJQykdvududQASZzz8oixzqyHR7Hmk1u5rLS/hlQfQ=;
 b=WQkoGNiaPDa9u/MLdjtW7qHSrForoddhAjc3CYv7kJ3HvNVE7NWYMetdoYpe4xewGwasOs
 64yYV6DYafIb2Bmoxh1pOixvLrjCx+i1bT0xAzC6fK1MDT/NRdk6aM3meq1QFvkPJBragt
 oBia6ecoA7FB7aW5JeA0Egs2mt2mWuI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-FH6ojMgVMvOr5wj7To7cHA-1; Wed, 16 Sep 2020 09:30:14 -0400
X-MC-Unique: FH6ojMgVMvOr5wj7To7cHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D621A81F03B;
 Wed, 16 Sep 2020 13:30:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C981319D6C;
 Wed, 16 Sep 2020 13:30:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3D965113864A; Wed, 16 Sep 2020 15:30:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Python 3.5 EOL; when can require 3.6?
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
Date: Wed, 16 Sep 2020 15:30:01 +0200
In-Reply-To: <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
 (Peter Maydell's message of "Wed, 16 Sep 2020 13:30:49 +0100")
Message-ID: <878sd9luhy.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 16 Sep 2020 at 08:43, Markus Armbruster <armbru@redhat.com> wrote:
>> We require Python 3.5.  It will reach its "end of life" at the end of
>> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
>> already does for its Python parts.
>
> I think these things really ought to start with the converse question:
> what is the important new thing that 3.6 brings to the table that
> makes it worth moving our minimum requirement forward ?

I'm chiefly after PEP 526 "Syntax for Variable Annotations" for much
saner type hints.  John's "[PATCH 00/37] qapi: static typing conversion
pt1" already uses it, because not using it results in illegible code.

Nice to have: PEP 498 "Literal String Interpolation" may let us improve
QAPI code geneator readability.  I haven't tried, yet.

<https://www.python.org/dev/peps/pep-0494/#features-for-3-6> has the
full list of new features.

> If our code still works on 3.5 and there's nothing we really want to
> do to the code that would be awkward to do without insisting on
> 3.6, why should we irritate users by arbitrarily bumping the version
> requirement ?
>
> Also as Dan notes upstream's EOL policies aren't very relevant,
> because our policy is based on what distros ship.
>
> My broader point of view: C does not have any kind of infrastructure
> like Rust's cargo or node's npm that makes it easy for a project to
> say "we depend on these versions of these other packages" and
> have them be satisified in a fairly painless-to-the-end-user/distro
> way. So I prefer to take the approach of being as conservative as
> possible about what we depend on, because the alternative tends
> to be either pain for the person trying to compile QEMU (when they
> have to scrabble around finding and building dependencies they
> don't have conveniently to hand) or pain for us (when we have
> to ship a dependency as a submodule). The default should be
> "leave the version dependency where it is", not "bump the version
> dependency as soon as we can".

Understood.

Anyone writing Python code in QEMU has paid a price for this policy.  I
certainly did.  I'm okay with that as long as it helps more than it
hurts.

Lack of sane type hints is hurting QAPI developement.

I believe requiring 3.6 will hurt QEMU less than hobbled QAPI
development.


