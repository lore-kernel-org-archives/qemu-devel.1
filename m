Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE05BC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:26:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2F1320673
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 09:26:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2F1320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHlkw-0006fK-GY
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 05:26:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35709)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iHljp-0005PD-DL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:25:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iHljo-00081l-2r
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 05:25:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1iHljh-0007wJ-Vu; Tue, 08 Oct 2019 05:24:54 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DEA7551EF1;
 Tue,  8 Oct 2019 09:24:52 +0000 (UTC)
Received: from redhat.com (ovpn-112-66.ams2.redhat.com [10.36.112.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B03CA19C68;
 Tue,  8 Oct 2019 09:24:51 +0000 (UTC)
Date: Tue, 8 Oct 2019 10:24:48 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qemu-nbd: Document benefit of --pid-file
Message-ID: <20191008092448.GD1192@redhat.com>
References: <20191007194840.29518-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191007194840.29518-1-eblake@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Tue, 08 Oct 2019 09:24:52 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: vsementsov@virtuozzo.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 02:48:40PM -0500, Eric Blake wrote:
> One benefit of --pid-file is that it is easier to probe the file
> system to see if a pid file has been created than it is to probe if a
> socket is available for connection. Document that this is an
> intentional feature.

I'm not seeing how checking the pid file is better than checking
the socket directly ? I think it is probably actually worse.

The main problem with the socket is that while we unlink on clean
shutdown, it may still exist in disk if the process has exitted
abnormally.

With the pidfile though we don't ever unlink it, even on clean
shutdown, as we don't use the pid files existance as a mutual
exclusion check. We instead acquire fcntl locks on it.

IOW the pidfile could exist already when qemu-nbd starts up and
will still exist when it quits.

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-nbd.texi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qemu-nbd.texi b/qemu-nbd.texi
> index 7f55657722bd..d495bbe8a0ed 100644
> --- a/qemu-nbd.texi
> +++ b/qemu-nbd.texi
> @@ -118,7 +118,8 @@ in list mode.
>  @item --fork
>  Fork off the server process and exit the parent once the server is running.
>  @item --pid-file=PATH
> -Store the server's process ID in the given file.
> +Store the server's process ID in the given file.  The pid file is not
> +created until after the server socket is open.
>  @item --tls-authz=ID
>  Specify the ID of a qauthz object previously created with the
>  --object option. This will be used to authorize connecting users
> -- 
> 2.21.0
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

