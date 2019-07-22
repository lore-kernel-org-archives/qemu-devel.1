Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F247C76195
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:15:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD3BF21BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3BF21BF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpUQ9-0000Ww-2D
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38586)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hpUPw-0008O6-PL
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hpUPv-000126-Gn
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34565)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hpUPs-00010O-PH; Mon, 22 Jul 2019 05:15:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDBF683F42;
 Mon, 22 Jul 2019 09:15:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 64DED5D704;
 Mon, 22 Jul 2019 09:15:30 +0000 (UTC)
Date: Mon, 22 Jul 2019 10:15:28 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190722091528.GD23775@redhat.com>
References: <20190721181508.28608-1-mlevitsk@redhat.com>
 <20190721181508.28608-3-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190721181508.28608-3-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Mon, 22 Jul 2019 09:15:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] qemu-img: better error message when
 opening a backing file fails
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 21, 2019 at 09:15:08PM +0300, Maxim Levitsky wrote:
> Currently we print message like that:
> 
> "
> new_file.qcow2 : error message
> "
> 
> However the error could have come from opening the backing file (e.g when it missing encryption keys),
> thus try to clarify this by using this format:
> 
> "
> qemu-img: error creating new_file.qcow2: base_file.qcow2: error message
> Could not open backing image to determine size.
> "
> 
> 
> Test used:
> 
> qemu-img create -f qcow2 \
>         --object secret,id=sec0,data=hunter9 \
>         --object secret,id=sec1,data=my_new_secret_password \
>         -b 'json:{ "encrypt.key-secret": "sec1", "driver": "qcow2", "file": { "driver": "file", "filename": "base.qcow2" }}' \
>         -o encrypt.format=luks,encrypt.key-secret=sec1 \
>         sn.qcow2
> 
> 
> Error message before:
> 
> qemu-img: sn.qcow2: Invalid password, cannot unlock any keyslot
> Could not open backing image to determine size.
> 
> 
> Error message after:
> 
> qemu-img: error creating sn.qcow2: \
> 	json:{ "encrypt.key-secret": "sec1", "driver": "qcow2", "file": { "driver": "file", "filename": "base.qcow2" }}: \
> 	Invalid password, cannot unlock any keyslot
> Could not open backing image to determine size.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block.c    | 1 +
>  qemu-img.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/block.c b/block.c
> index 29e931e217..5eb47b2199 100644
> --- a/block.c
> +++ b/block.c
> @@ -5790,6 +5790,7 @@ void bdrv_img_create(const char *filename, const char *fmt,
>                              "This may become an error in future versions.\n");
>              local_err = NULL;
>          } else if (!bs) {
> +            error_prepend(&local_err, "%s: ", backing_file);
>              /* Couldn't open bs, do not have size */
>              error_append_hint(&local_err,
>                                "Could not open backing image to determine size.\n");

I think it'd be better todo

              error_append_hint(&local_err,
                                "Could not open backing image '%s' to determine size.\n",
                                 backing_file);

At least when backing_file isn't a horrible blob of JSON, the error
message is easier to read this way IMHO.

> diff --git a/qemu-img.c b/qemu-img.c
> index 79983772de..134bf2fbe0 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -545,7 +545,7 @@ static int img_create(int argc, char **argv)
>      bdrv_img_create(filename, fmt, base_filename, base_fmt,
>                      options, img_size, flags, quiet, &local_err);
>      if (local_err) {
> -        error_reportf_err(local_err, "%s: ", filename);
> +        error_reportf_err(local_err, "error creating %s: ", filename);
>          goto fail;
>      }
>  
> -- 
> 2.17.2
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

