Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E912AC43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:46:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB63A20652
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 13:46:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB63A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL6cD-0001S8-VI
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 09:46:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hL6ag-00007B-Mt
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:45:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kchamart@redhat.com>) id 1hL6af-0003cN-GF
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 09:45:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kchamart@redhat.com>)
	id 1hL6ad-0003VJ-0n; Mon, 29 Apr 2019 09:45:03 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59E59821F1;
	Mon, 29 Apr 2019 13:45:00 +0000 (UTC)
Received: from paraplu.localdomain (ovpn-117-61.ams2.redhat.com [10.36.117.61])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E050C600C2;
	Mon, 29 Apr 2019 13:44:57 +0000 (UTC)
Received: by paraplu.localdomain (Postfix, from userid 1001)
	id C548D3E02C3; Mon, 29 Apr 2019 15:44:54 +0200 (CEST)
Date: Mon, 29 Apr 2019 15:44:54 +0200
From: Kashyap Chamarthy <kchamart@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190429134454.GB4675@paraplu>
References: <20190426221528.30293-1-jsnow@redhat.com>
	<20190426221528.30293-3-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <20190426221528.30293-3-jsnow@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.28]);
	Mon, 29 Apr 2019 13:45:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/2] docs/interop/bitmaps: rewrite and
 modernize doc
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>, vsementsov@virtuozzo.com, aliang@redhat.com,
	qemu-block@nongnu.org, qemu-stable@nongnu.org,
	qemu-devel@nongnu.org, armbru@redhat.com, nsoffer@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429134454.51wntKo2jV0HSO5td5wm4LhMSmB3oBB6bM2m3bqeC4w@z>

On Fri, Apr 26, 2019 at 06:15:28PM -0400, John Snow wrote:
> This just about rewrites the entirety of the bitmaps.rst document to
> make it consistent with the 4.0 release. I have added new features seen
> in the 4.0 release, as well as tried to clarify some points that keep
> coming up when discussing this feature both in-house and upstream.
> 
> Yes, it's a lot longer, mostly due to examples. I get a bit chatty.
> I could use a good editor to help reign in my chattiness.
> 
> It does not yet cover pull backups or migration details, but I intend to
> keep extending this document to cover those cases.
> 
> Please try compiling it with sphinx and look at the rendered output, I
> don't have hosting to share my copy at present. 

FWIW, here's a public rendering (with the "Alabaster" Sphinx theme) with
your v3 applied:

    https://kashyapc.fedorapeople.org/QEMU-Docs-v4.0.0-143-g1cb2ca0415/_build/html/docs/interop/bitmaps.html

Thanks for the overhaul.  Afraid, I've been just too swamped to be able
to look at this in detail, much as I'd love to.  I will slowly catch up.

    - - -

(Note to self: send to the list the text-to-rST converted QEMU docs
sitting locally on a Git branch.)

[...]

> I think this new layout reads nicer in the HTML format than the old
> one did, at the expense of looking less readable in the source tree
> itself (though not completely unmanagable. We did decide to convert it
> from Markdown to ReST, after all, so I am going all-in on ReST.)

[...]


-- 
/kashyap

