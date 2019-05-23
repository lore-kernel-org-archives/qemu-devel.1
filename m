Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7431DC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:52:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B0E92175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 16:52:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0E92175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40637 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTqws-0003Z8-0q
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 12:52:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTqv9-0002R1-Pf
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hTqmN-0007lF-5z
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:41:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58478)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hTqmN-0007kp-0G
	for qemu-devel@nongnu.org; Thu, 23 May 2019 12:41:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3BD64308794F
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 16:41:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-250.ams2.redhat.com
	[10.36.117.250])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id AF5E45B685;
	Thu, 23 May 2019 16:41:15 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 441851138648; Thu, 23 May 2019 18:41:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Dr. David Alan Gilbert \(git\)" <dgilbert@redhat.com>
References: <20190523145840.11774-1-dgilbert@redhat.com>
	<20190523145840.11774-2-dgilbert@redhat.com>
Date: Thu, 23 May 2019 18:41:14 +0200
In-Reply-To: <20190523145840.11774-2-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Thu, 23 May 2019 15:58:39 +0100")
Message-ID: <87k1ehgm39.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Thu, 23 May 2019 16:41:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] net/announce: Allow optional list of
 interfaces
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, laine@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> writes:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> Allow the caller to restrict the set of interfaces that announces are
> sent on.  The default is still to send on all interfaces.
>
> e.g.
>
>   { "execute": "announce-self", "arguments": { "initial": 50, "max": 550, "rounds": 5, "step": 50, "ifaces": ["vn2","vn1"] } }
>
> Note: There's still only one timer for the qmp command, so that
> performing an 'announce-self' on one list of interfaces followed
> by another 'announce-self' on another list will stop the announces
> on the existing set.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
[...]
> diff --git a/qapi/net.json b/qapi/net.json
> index 5f7bff1637..871cfa7405 100644
> --- a/qapi/net.json
> +++ b/qapi/net.json
> @@ -706,7 +706,8 @@
>    'data': { 'initial': 'int',
>              'max': 'int',
>              'rounds': 'int',
> -            'step': 'int' } }
> +            'step': 'int',
> +            '*ifaces': ['str'] } }

QMP traditionally eschews abbreviations like "iface".

>  
>  ##
>  # @announce-self:
> @@ -718,9 +719,10 @@
>  #
>  # Example:
>  #
> -# -> { "execute": "announce-self"
> +# -> { "execute": "announce-self",
>  #      "arguments": {
> -#          "initial": 50, "max": 550, "rounds": 10, "step": 50 } }
> +#          "initial": 50, "max": 550, "rounds": 10, "step": 50,
> +#          "ifaces": ["vn2","vn3"] } }
>  # <- { "return": {} }
>  #
>  # Since: 4.0

