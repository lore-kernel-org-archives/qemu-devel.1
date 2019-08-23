Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94205C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:14:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F87622CF7
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 06:14:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F87622CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i12qE-0008TC-Fl
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 02:14:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52500)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1i12ov-0006sy-Pc
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1i12ou-0002TL-Gd
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 02:13:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1i12ou-0002Sq-BK; Fri, 23 Aug 2019 02:13:08 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BE89F3082131;
 Fri, 23 Aug 2019 06:13:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EB8CC5E1CB;
 Fri, 23 Aug 2019 06:13:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5B0431162B63; Fri, 23 Aug 2019 08:13:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190822230916.576-1-philmd@redhat.com>
Date: Fri, 23 Aug 2019 08:13:02 +0200
In-Reply-To: <20190822230916.576-1-philmd@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 23 Aug 2019 01:09:13
 +0200")
Message-ID: <874l2876kx.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 23 Aug 2019 06:13:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/3] mailmap: Clean up
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Trivial cleanup of .mailmap to have a nice 'git shortlog' output.
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   mailmap: Reorder by sections
>   mailmap: Update philmd email address
>   mailmap: Add many entries to improve 'git shortlog' statistics
>
>  .mailmap | 123 +++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 115 insertions(+), 8 deletions(-)

Series
Reviewed-by: Markus Armbruster <armbru@redhat.com>

However, it increases the difference to contrib/gitdm/aliases.  I'm just
as guilty; my recent "[PATCH 2/2] contrib/gitdm: Add armbru@pond.sub.org
to group-map-redhat" updates only that. and not .mailmap.

Perhaps we want to keep the two in sync manually.  We should then add
suitable comments to each file.

Could we instead teach gitdm to use .mailmap, and ditch
contrib/gitdm/aliases?

aliases' format is documented in gitdm's README.  Each line maps a
non-canonical e-mail address to a canonical one.

.mailmap's format is documented in git-shortlog(1).  It can do a bit
more.  Even the common part differs: it has two addresses in different
order *boggle*.

