Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E0F7C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:09:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE07F2073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OGvhcvXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE07F2073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itTzz-0003HW-On
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:09:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33575)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1itTzC-0002YC-HL
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1itTz7-0002Go-D6
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:08:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28878
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1itTz7-0002GV-8p
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579514920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vGvd18/+PN8mjAuhyDO0vc8GCUowUB0KOta+RB8MRy0=;
 b=OGvhcvXAYEE5iG4CkXIWcOpX9vXu/DpMTqwvClJ0aEF3Jc/y5ESMvxjvy7Ro9rzV2zWKXu
 s7RmckxC/JleffwKTqpG49ZosY6jD8jkNgQQX6mXUu3WXSOVCSsy+i0oayZTzoBN8Ugy9E
 UAUthk0O0YHvTnuQqk5coY9ddkuTqj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-vUPIgj_WPt6Py1M6WGLKyg-1; Mon, 20 Jan 2020 05:08:38 -0500
X-MC-Unique: vUPIgj_WPt6Py1M6WGLKyg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1B84618C35A0
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 10:08:37 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 57BC75D9E1;
 Mon, 20 Jan 2020 10:08:31 +0000 (UTC)
References: <20191212163904.159893-1-dgilbert@redhat.com>
 <20191212163904.159893-71-dgilbert@redhat.com>
User-agent: mu4e 1.2.0; emacs 26.3
From: Sergio Lopez <slp@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 070/104] virtiofsd: fail when parent inode isn't known in
 lo_do_lookup()
In-reply-to: <20191212163904.159893-71-dgilbert@redhat.com>
Date: Mon, 20 Jan 2020 11:08:24 +0100
Message-ID: <878sm28mp3.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: vgoyal@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain


Dr. David Alan Gilbert (git) <dgilbert@redhat.com> writes:

> From: Miklos Szeredi <mszeredi@redhat.com>
>
> The Linux file handle APIs (struct export_operations) can access inodes
> that are not attached to parents because path name traversal is not
> performed.  Refuse if there is no parent in lo_do_lookup().
>
> Also clean up lo_do_lookup() while we're here.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tools/virtiofsd/passthrough_ll.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4lfBgACgkQ9GknjS8M
AjVtcA//Uu/7Hcq93/3Xqsts7AoMOmxshVzg5JrseZ5T+3rJdBEI1EMeNIrnQNeP
IshBYVhF2IQYc55ht//hT0fH6BtMOWp5hbdHQZYxTK1uLl6Kw7s3A/tx7vEK1MKy
IeDtNCOjiPISum8RUXjR8Yh0mvgFI5icBdRRFUeXkDVovEZWwm0AHi5Vh/tGZYm8
OrpjMOnrVtrycysHmKeMiAMZid7WLdZEU4L8FQ45Zo5LQDUKGB7hAKCyn3j/7BMe
8O1dBT7XEQVSUe04hv5JeMbhpSctT652TSwfXqtmQdIjBtIBfRr3pBy2ZghaErv5
Yfp2VD7hq+50XtoTKBUztgwjWhH6tjGhbQiaNVJ1rk7kwa2DIgGtr51sdNPGBw4q
KbuoUxnXOdifmSl9CXDu039TZ4i8YXOwoD6M5ea23gfoxb8A9+FhkgsKB2vceg5H
VrMdyJc4uzLWaxOdtQk2IbdpiOfke4ZxRcEGngv28TXrfvsI3rxvL55fIRYda1Zk
K7jWWZuZhL4XXWmwLXlhVdvJxDB8sHtR7SvB5Ni5C6wWlunRfg0EpDFaE15ueOvs
UBQiVBGgx4aORaOapaMUJTnGS/e/ClQKJzJkYMeMQz+hRwfFPNP7IbsK0L78TZF5
zUjxpn1hc0pY7A7LHZpFIGaJR/cD0dK4XE4Ta3Gp/lVlpPE1P4o=
=b+UB
-----END PGP SIGNATURE-----
--=-=-=--


