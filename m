Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736A3C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:40:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CC8F20850
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 05:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC8F20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53913 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hE5yi-0007m4-I5
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 01:40:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5xq-00075Q-ML
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:40:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hE5xo-0001Ir-Iz
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:40:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54444)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hE5xk-0001G6-6o; Wed, 10 Apr 2019 01:39:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C02DF307DAA3;
	Wed, 10 Apr 2019 05:39:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D14F5D719;
	Wed, 10 Apr 2019 05:39:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 234461138648; Wed, 10 Apr 2019 07:39:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
References: <20190409210655.777-1-jsnow@redhat.com>
Date: Wed, 10 Apr 2019 07:39:50 +0200
In-Reply-To: <20190409210655.777-1-jsnow@redhat.com> (John Snow's message of
	"Tue, 9 Apr 2019 17:06:55 -0400")
Message-ID: <87y34i2zbt.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 10 Apr 2019 05:39:53 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qemu-img: fix .hx and .texi disparity
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410053950.sD4Z-hl0z8khs24aHq1CcSvqoxaDkHf2uqr0mjgQ2oM@z>

John Snow <jsnow@redhat.com> writes:

> It turns out that having options listed in three places continues to be
> a bad idea. I'm still toying with the idea of an improved infrastructure
> here, but in the meantime, another bandaid.
>
> There are three locations:
> (1) .hx file, formatted as texi
> (2) .hx file, formatted as human readable.
> (3) .texi file, as section headers, formatted as texi.
>
> You can compare the two summaries within the .hx file like so:
>
> Human-readable command summaries:
> `./qemu-img --help | grep 'Command syntax' -A14`
> Detokenized texi command summaries:
> `grep "@item" qemu-img-cmds.hx | sed -E 's|@var\{([^\}]*?)\}|\1|g'`
>
> You can compare the two separate texi summaries like so:
>
> Texi command summaries:
> `grep "@item" qemu-img-cmds.hx"`
> Texi command headers:
> grep -E "@item.*@var" qemu-img.texi | tail -14
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Extra points for explaining how you found the issues in detail
sufficient for reproducing.

Nice to have in 4.0.

Reviewed-by: Markus Armbruster <armbru@redhat.com>

