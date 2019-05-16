Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2095C04AB4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A281E2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 08:27:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A281E2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50589 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRBjZ-0003j3-UH
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 04:27:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hRBiV-0003AA-2j
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hRBiU-0003RE-9g
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:26:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32989)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hRBiU-0003Qf-4s
	for qemu-devel@nongnu.org; Thu, 16 May 2019 04:26:18 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CB583091740
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 08:26:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EB83A17B8D;
	Thu, 16 May 2019 08:26:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 6EBBD11385E4; Thu, 16 May 2019 10:26:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190509130345.227526-1-sgarzare@redhat.com>
	<20190509130345.227526-2-sgarzare@redhat.com>
Date: Thu, 16 May 2019 10:26:15 +0200
In-Reply-To: <20190509130345.227526-2-sgarzare@redhat.com> (Stefano
	Garzarella's message of "Thu, 9 May 2019 15:03:42 +0200")
Message-ID: <87ftpevm8o.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 16 May 2019 08:26:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/4] net: fix assertion failure when
 ipv6-prefixlen is not a number
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Stefano Garzarella <sgarzare@redhat.com> writes:

> If 'ipv6-prefixlen' is not a number, the current behaviour
> produces an assertion failure:
>     $ qemu-system-x86_64 -net user,ipv6-net=feca::0/a
>     qemu-system-x86_64: qemu/util/qemu-option.c:1175: qemu_opts_foreach:
>     Assertion `!errp || !*errp' failed.
>     Aborted (core dumped)
>
> This patch fixes it, jumping to the end of the function when
> 'ipv6-prefixlen' is not a number, and printing the more friendly
> message:
>     $ qemu-system-x86_64 -net user,ipv6-net=feca::0/a
>     qemu-system-x86_64: Parameter 'ipv6-prefixlen' expects a number
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>

