Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E5FC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:11:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E5D9206F0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 12:11:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LskN0XWD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E5D9206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ionhn-00075X-LA
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 07:11:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1iomlq-0003uO-Ia
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:11:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1iomlp-0007Se-7l
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:11:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60429
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1iomlp-0007SM-2n
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 06:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578395492;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VMhaHz8a8eqw0QUUlDgjxXYhrC8lBZebcTFf6RYoCU8=;
 b=LskN0XWDdEgPgP2xDMkptZaAjsu8NzpDw84VdwJ6w40ZlQicFtelXnykabvNoYynuJcw42
 Or+ke63KJ9Kd/m3zLd8a5Wx5XTURbK4ob9T7CCaDautGp9W4Rfj8U1N3peYyrmZFviX3dx
 IJ/pWaO9I8nldv423pQ1fHh+hbGZnYc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-0qW6IWUhMlCskdDCVjv-sQ-1; Tue, 07 Jan 2020 06:11:15 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8784801E6C
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 11:11:14 +0000 (UTC)
Received: from redhat.com (ovpn-112-61.ams2.redhat.com [10.36.112.61])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D2777C019;
 Tue,  7 Jan 2020 11:11:10 +0000 (UTC)
Date: Tue, 7 Jan 2020 11:11:06 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH 060/104] virtiofsd: Add timestamp to the log with
 FUSE_LOG_DEBUG level
Message-ID: <20200107111106.GD3368802@redhat.com>
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-61-dgilbert@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191212163904.159893-61-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 0qW6IWUhMlCskdDCVjv-sQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Dec 12, 2019 at 04:38:20PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>=20
> virtiofsd has some threads, so we see a lot of logs with debug option.
> It would be useful for debugging if we can see the timestamp.
>=20
> Add nano second timestamp, which got by get_clock(), to the log with
> FUSE_LOG_DEBUG level if the syslog option isn't set.
>=20
> The log is like as:
>=20
>   ]# ./virtiofsd -d -o vhost_user_socket=3D/tmp/vhostqemu0 -o source=3D/t=
mp/share0 -o cache=3Dauto
>   ...
>   [5365943125463727] [ID: 00000002] fv_queue_thread: Start for queue 0 ki=
ck_fd 9
>   [5365943125568644] [ID: 00000002] fv_queue_thread: Waiting for Queue 0 =
event
>   [5365943125573561] [ID: 00000002] fv_queue_thread: Got queue event on Q=
ueue 0
>=20
> Signed-off-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


