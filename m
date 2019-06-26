Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D552C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55099204EC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 08:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55099204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg3gf-0006dY-LL
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 04:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52811)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <rjones@redhat.com>) id 1hg3fT-0005nv-6R
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:52:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1hg3fS-0001va-0z
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 04:52:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32991)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>)
 id 1hg3fP-0001Xn-DI; Wed, 26 Jun 2019 04:52:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EEC2D64DA8;
 Wed, 26 Jun 2019 08:52:12 +0000 (UTC)
Received: from localhost (ovpn-116-19.ams2.redhat.com [10.36.116.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A1DC608A4;
 Wed, 26 Jun 2019 08:52:12 +0000 (UTC)
Date: Wed, 26 Jun 2019 09:52:11 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190626085211.GZ3888@redhat.com>
References: <20190626024942.29758-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190626024942.29758-1-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Wed, 26 Jun 2019 08:52:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qemu-nbd: Permit TLS with Unix sockets
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
Cc: berrange@redhat.com, qemu-devel@nongnu.org,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 09:49:42PM -0500, Eric Blake wrote:
> Although you generally won't use encryption with a Unix socket (after
> all, everything is local, so why waste the CPU power), there are
> situations in testsuites where Unix sockets are much nicer than TCP
> sockets.  Since nbdkit allows encryption over both types of sockets,
> it makes sense for qemu-nbd to do likewise.

Also it's somewhat useful if using a separate tunnel process (openssh
for one can do this now).

> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qemu-nbd.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index a8cb39e51043..ddfb6815fb69 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -931,10 +931,6 @@ int main(int argc, char **argv)
>      }
> 
>      if (tlscredsid) {
> -        if (sockpath) {
> -            error_report("TLS is only supported with IPv4/IPv6");
> -            exit(EXIT_FAILURE);
> -        }
>          if (device) {
>              error_report("TLS is not supported with a host device");
>              exit(EXIT_FAILURE);
> -- 
> 2.20.1

The patch looks very simple, just removing an unnecessary restriction,
so:

Acked-by: Richard W.M. Jones <rjones@redhat.com>

If we could have the same change on the qemu client side that would
be great because we could use it here:

https://github.com/libguestfs/nbdkit/blob/e0d324683c86455a2fe62e97d57f1313cad9c9f3/tests/functions.sh.in#L133

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
libguestfs lets you edit virtual machines.  Supports shell scripting,
bindings from many languages.  http://libguestfs.org

