Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C991C468BC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8B8F2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 09:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8B8F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42602 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haGIz-0007X9-Re
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 05:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37935)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1haGHq-0006oO-A5
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:08:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1haGHp-0003dv-3T
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:08:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58258)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1haGHo-0003c9-R4
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 05:08:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D1AE2C0AD2B4
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 09:08:15 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D54D614C1;
 Mon, 10 Jun 2019 09:08:14 +0000 (UTC)
Date: Mon, 10 Jun 2019 10:08:11 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190610090811.GC7809@redhat.com>
References: <20190607221414.15962-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190607221414.15962-1-eblake@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Mon, 10 Jun 2019 09:08:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] RFC: qio: Improve corking of TLS sessions
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 07, 2019 at 05:14:14PM -0500, Eric Blake wrote:
> Our current implementation of qio_channel_set_cork() is pointless for
> TLS sessions: we block the underlying channel, but still hand things
> piecemeal to gnutls which then produces multiple encryption packets.
> Better is to directly use gnutls corking, which collects multiple
> inputs into a single encryption packet.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>
> 
> ---
> 
> RFC because unfortunately, I'm not sure I like the results.  My test
> case (using latest nbdkit.git) involves sending 10G of random data
> over NBD using parallel writes (and doing nothing on the server end;
> this is all about timing the data transfer):
> 
> $ dd if=/dev/urandom of=rand bs=1M count=10k
> $ time nbdkit -p 10810 --tls=require --tls-verify-peer \
>    --tls-psk=/tmp/keys.psk --filter=stats null 10g statsfile=/dev/stderr \
>    --run '~/qemu/qemu-img convert -f raw -W -n --target-image-opts \
>      --object tls-creds-psk,id=tls0,endpoint=client,dir=/tmp,username=eblake \
>      rand driver=nbd,server.type=inet,server.host=localhost,server.port=10810,tls-creds=tls0'
> 
> Pre-patch, I measured:
> real	0m34.536s
> user	0m29.264s
> sys	0m4.014s
> 
> while post-patch, it changed to:
> real	0m36.055s
> user	0m27.685s
> sys	0m10.138s
> 
> Less time spent in user space, but for this particular qemu-img
> behavior (writing 2M chunks at a time), gnutls is now uncorking huge
> packets and the kernel is doing enough extra work that the overall
> program actually takes longer. :(

I wonder if the problem is that we're hitting a tradeoff between
time spent in encryption vs time spent in network I/O.

When we don't cork, the kernel has already sent the first packet
during the time gnutls is burning CPU encrypting the second packet.

When we do cork gnutls has to encrypt both packets before the kernel
can send anything.

> For smaller I/O patterns, the effects of corking are more likely to be
> beneficial, but I don't have a ready test case to produce that pattern
> (short of creating a guest running fio on a device backed by nbd).

I think it would probably be useful to see guest kernels with fio
and definitely see results for something closer to sector sized
I/O.

2 MB chunks is pretty unrealistic for a guest workload where there
will be lots of sector sized I/O. Sure QEMU / guest OS can merge
sectors, but it still feels like most I/O is going to be much smaller
than 2 MB.


> diff --git a/io/channel.c b/io/channel.c
> index 2a26c2a2c0b9..3510912465ac 100644
> --- a/io/channel.c
> +++ b/io/channel.c
> @@ -379,7 +379,16 @@ void qio_channel_set_cork(QIOChannel *ioc,
>      QIOChannelClass *klass = QIO_CHANNEL_GET_CLASS(ioc);
> 
>      if (klass->io_set_cork) {
> -        klass->io_set_cork(ioc, enabled);
> +        int r = klass->io_set_cork(ioc, enabled);
> +
> +        while (r == QIO_CHANNEL_ERR_BLOCK) {
> +            if (qemu_in_coroutine()) {
> +                qio_channel_yield(ioc, G_IO_OUT);
> +            } else {
> +                qio_channel_wait(ioc, G_IO_OUT);
> +            }
> +            r = klass->io_set_cork(ioc, enabled);
> +        }
>      }

Interesting - did you actually hit this EAGAIN behaviour ? I wouldn't
have expected anything to be pending in gnutls that needs retry. 


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

