Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69207C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A93B2084B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A93B2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54068 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE6D2-0002A8-F7
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 01:55:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE6CF-0001ih-0l
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:54:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE6CD-0008AH-U2
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:54:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hE6C9-00086z-Jr; Wed, 10 Apr 2019 01:54:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E6183082E21;
	Wed, 10 Apr 2019 05:54:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 03CF85D719;
	Wed, 10 Apr 2019 05:54:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 6CB941138648; Wed, 10 Apr 2019 07:54:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190410012413.31569-1-jsnow@redhat.com>
	<20190410012413.31569-3-jsnow@redhat.com>
Date: Wed, 10 Apr 2019 07:54:42 +0200
In-Reply-To: <20190410012413.31569-3-jsnow@redhat.com> (John Snow's message of
	"Tue, 9 Apr 2019 21:24:12 -0400")
Message-ID: <87sguq2yn1.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Wed, 10 Apr 2019 05:54:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH RFC 2/3] pxtool: Add new qemu-img command
 info generation tool
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
	qemu-block@nongnu.org, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410055442.L5vdVKetYK1Wjx6AAYz-UfiIAi50piiK3TtNmp00Cqo@z>

John Snow <jsnow@redhat.com> writes:

> Presently we use hxtool and a .hx format to generate a few things like
> the qemu_img subcommand dispatch table, the qemu_img help() display output,
> and a help output in qemu-img.texi.
>
> Unfortunately, this means that this information is duplicated in at least
> three places:
>
> (1) in qemu-img-cmds.hx as a human readable string
> (2) in qemu-img-cmds.hx as a texi string
> (3) in qemu-img.texi again, as a texi string
>
> We can do a little better, though: all of these sources can be generated
> from a single json file. Add a new small tool ("pxtool") that can do this.
>
> This tool can at least handle generating (1) and (2) from the same source
> without needing to reduplicate that information. Deduplicating (3) happens
> in the next patch.
>
> Notes:
>  - The json format was chosen to be very "stupid", and the command line
>    documentation is being kept one-per-line to make future diffs easier
>    to read.
>  - It's easy enough to generate the human-readable output from the texi
>    output by removing '@var{foo}' with 'foo'.
>  - The qemu-img command dispatch always calls img_cmdname, so we don't
>    need to store this information separately, either.
>  - The need for DEF() macros could be removed as well, but I left it in
>    to create a minimally disruptive patch.
> Signed-off-by: John Snow <jsnow@redhat.com>

We got just five .hx:

    qemu-img.cmds.hx            killed off by this patch
    qemu-options.hx             CLI QAPIfication should kill this off
    hw/audio/pl041.hx           misnamed, not actually food for hxtool
    hmp-commands.hx             no exit strategy
    hmp-commands-info.hx            for these two, yet

CLI QAPIfication got stuck in the back-burner, and as long as that's the
case, it's not an alternative to your patches.

