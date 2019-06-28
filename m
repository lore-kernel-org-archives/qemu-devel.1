Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720E0C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48B782086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 14:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48B782086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgs3h-0004ZP-Hq
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 10:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56153)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hgqzZ-0007Np-1Q
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hgqzX-0002Rv-Lc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:32:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25195)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1hgqzX-0001ir-Ev
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 09:32:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9C57530C0DC4;
 Fri, 28 Jun 2019 11:05:00 +0000 (UTC)
Received: from redhat.com (unknown [10.42.17.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5ACA5D962;
 Fri, 28 Jun 2019 11:04:59 +0000 (UTC)
Date: Fri, 28 Jun 2019 12:04:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: P J P <ppandit@redhat.com>
Message-ID: <20190628110457.GA23344@redhat.com>
References: <20190628094901.13347-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190628094901.13347-1-ppandit@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 28 Jun 2019 11:05:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] qemu-bridge-helper: restrict bridge name
 to IFNAMSIZ
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
Cc: Riccardo Schirone <rschiron@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 28, 2019 at 03:19:01PM +0530, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> The interface names in qemu-bridge-helper are defined to be
> of size IFNAMSIZ(=16), including the terminating null('\0') byte.
> The same is applied to interface names read from 'bridge.conf'
> file to form ACLs rules. If user supplied '--br=bridge' name
> is not restricted to the same length, it could lead to ACL bypass
> issue. Restrict bridge name to IFNAMSIZ, including null byte.

Can you elaborate on the way to exploit this as I'm not seeing
any way that doesn't involve mis-configuration of the ACL
config file data.

Currently the code has:

    const char *bridge = NULL;
    ...
    bridge = &argv[index][5];
    ...
    if (strcmp(bridge, acl_rule->iface) == 0) {

So the user suplied "--br=bridge" name will never be
truncated.

The ACLRule struct has iface[IFNAMSIZ] so it is possible
that we truncate the bridge name that's in the bridge.conf
file if the admin put in a name that was too long.

This is simply an admin mis-configuration, since it is
impossible for a bridge to actually exist that has a
name longer than IFNAMSIZ.

I think we simply need to report a hard error when
reading the bridge.conf file if the name we find does
not fit into IFNAMSIZ.


> 
> Reported-by: Riccardo Schirone <rschiron@redhat.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  qemu-bridge-helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/qemu-bridge-helper.c b/qemu-bridge-helper.c
> index f9940deefd..2eca8c5cc4 100644
> --- a/qemu-bridge-helper.c
> +++ b/qemu-bridge-helper.c
> @@ -246,7 +246,7 @@ int main(int argc, char **argv)
>          if (strcmp(argv[index], "--use-vnet") == 0) {
>              use_vnet = 1;
>          } else if (strncmp(argv[index], "--br=", 5) == 0) {
> -            bridge = &argv[index][5];
> +            bridge = strndup(&argv[index][5], IFNAMSIZ - 1);

This is not fixing the real problem imho

>          } else if (strncmp(argv[index], "--fd=", 5) == 0) {
>              unixfd = atoi(&argv[index][5]);
>          } else {
> -- 
> 2.21.0
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

