Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32322C35254
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:08:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF81020725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 12:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eRFuaq6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF81020725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3fCC-0001zY-6A
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 07:08:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j3fBe-0001az-94
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:07:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j3fBd-0001qu-9Q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:07:42 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57686
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j3fBd-0001ql-5s
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 07:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581941260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/b2LYO/mfB4qPMwxLk3t6f7WdNgOUufd9nNyd/sZ6QY=;
 b=eRFuaq6a2XmXrQiiCpdUaOLLxGbmrMQnEaK8WCYuEXPIKvx84jkGeGCwQpBfvbh+5f+SwL
 YZcLbBSflelfO7TTP9ZW+wmykKvPbEQBfD/FOSsnmYVp4I7MjmGH4GJOgHQOHoTgXukbG9
 RMtXKKO+hn8HmInPXOt+/XBreRSL85M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-nKulT2oTONO5WHrGGI_K1Q-1; Mon, 17 Feb 2020 07:07:34 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E197413F5
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 12:07:33 +0000 (UTC)
Received: from work-vm (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 24DEA90F46;
 Mon, 17 Feb 2020 12:07:27 +0000 (UTC)
Date: Mon, 17 Feb 2020 12:07:24 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 2/3] tools/virtiofsd/passthrough_ll: Remove unneeded
 variable assignment
Message-ID: <20200217120724.GH3434@work-vm>
References: <20200217094240.9927-1-philmd@redhat.com>
 <20200217094240.9927-3-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200217094240.9927-3-philmd@redhat.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: nKulT2oTONO5WHrGGI_K1Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: =?iso-8859-1?B?SuFu?= Tomko <jtomko@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> Fix warning reported by Clang static code analyzer:
>=20
>     CC      tools/virtiofsd/passthrough_ll.o
>   tools/virtiofsd/passthrough_ll.c:925:9: warning: Value stored to 'newfd=
' is never read
>           newfd =3D -1;
>           ^       ~~
>   tools/virtiofsd/passthrough_ll.c:942:9: warning: Value stored to 'newfd=
' is never read
>           newfd =3D -1;
>           ^       ~~
>=20
> Fixes: 7c6b66027
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>

OK; actually one of those is in upstream, and another was added
by Miklos's 'virtiofsd: fail when parent inode isn't known in
lo_do_lookup()' - which kind of balances that if out.
I suspect the reason was because out_err: closes newfd if it's
not -1, so they were keeping it safe like that just in case another
error case gets added.

Dave

> ---
> v2: do not set newfd, use it (jtomko)
> ---
>  tools/virtiofsd/passthrough_ll.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/tools/virtiofsd/passthrough_ll.c b/tools/virtiofsd/passthrou=
gh_ll.c
> index e9e71d5fc2..02ff01fad0 100644
> --- a/tools/virtiofsd/passthrough_ll.c
> +++ b/tools/virtiofsd/passthrough_ll.c
> @@ -922,7 +922,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
>      inode =3D lo_find(lo, &e->attr);
>      if (inode) {
>          close(newfd);
> -        newfd =3D -1;
>      } else {
>          inode =3D calloc(1, sizeof(struct lo_inode));
>          if (!inode) {
> @@ -939,7 +938,6 @@ static int lo_do_lookup(fuse_req_t req, fuse_ino_t pa=
rent, const char *name,
> =20
>          inode->nlookup =3D 1;
>          inode->fd =3D newfd;
> -        newfd =3D -1;
>          inode->key.ino =3D e->attr.st_ino;
>          inode->key.dev =3D e->attr.st_dev;
>          pthread_mutex_init(&inode->plock_mutex, NULL);
> --=20
> 2.21.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


