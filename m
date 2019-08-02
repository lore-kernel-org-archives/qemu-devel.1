Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00E1BC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 05:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C70D7206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 05:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C70D7206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htPrj-0004hk-Vw
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 01:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34487)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1htPr9-0004Ct-Um
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 01:11:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1htPr8-0002uN-SJ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 01:11:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35474)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1htPr8-0002tx-NU
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 01:11:54 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D4D18796ED;
 Fri,  2 Aug 2019 05:11:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-51.ams2.redhat.com
 [10.36.116.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6825C5D9D3;
 Fri,  2 Aug 2019 05:11:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EA3051138619; Fri,  2 Aug 2019 07:11:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Patrick Welche <prlw1@cam.ac.uk>
References: <156467368424.6955.5535032657029646608.malonedeb@soybean.canonical.com>
Date: Fri, 02 Aug 2019 07:11:51 +0200
In-Reply-To: <156467368424.6955.5535032657029646608.malonedeb@soybean.canonical.com>
 (Patrick Welche's message of "Thu, 01 Aug 2019 15:34:44 -0000")
Message-ID: <87ftmkm9rc.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 02 Aug 2019 05:11:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Bug 1838658] [NEW] qemu 4.0.0 broken by glib
 update
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
Cc: Bug 1838658 <1838658@bugs.launchpad.net>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Patrick Welche <prlw1@cam.ac.uk> writes:

> Public bug reported:
>
> In brief, an install CD will successfully boot with qemu 4.0.0 built with glib 2.58.3, but freeze during boot with qemu 4.0.0 built with glib 2.60.0. I tracked it down to glib's GHashTable improvements. qemu is happy with a glib built from
> ```
>  git checkout -f 2.60.4
>  git revert --no-edit 86c6f7e2b..3bed8a13b
>  git revert --no-edit 75f8ec1df9b48b0c3a13a9125f2c7d7c5adf5159
>  git revert --no-edit 603fb5958..d3074a748
>  git revert --no-edit 0b45ddc55..0600dd322
> ```
> When the GHashTable improvements were committed, there was already a preemptive note about any breakage being due to using private implementation details, hence mentioning it here rather than with glib.
>
> For the full saga, see: http://gnats.netbsd.org/54310

Please quote the preemptive note in full.  I wasted several minutes
looking for it in the supposedly full saga, and in GLib git.  I still
have absolutely no clue what QEMU is doing wrong.

If I read the saga's "Subject: PR/54310 CVS commit: pkgsrc/devel/glib2"
part correctly, the GHashTable improvements have been or are being
removed.  Correct?

