Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B49C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:02:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F04082084D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 09:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVHXuW+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04082084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRXkl-0001s4-VT
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 05:02:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRXio-0008Et-Iq
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1jRXin-0000nG-Ke
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:00:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:56486
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jRXin-0000lv-3I
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 05:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587632436;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=URRRW/5PE363Qq9l0nO1+3a15H3ey+j1USaQhJJk3eM=;
 b=EVHXuW+qZqHcYmTSq1URBMfWQSAGSUTdwo/a1+fwTKun5PGY+z+8InFbsfS6WaTiTpDVSy
 SsQNnJRbMu5p4QmE4e7113LKgsP2LMbf+Qiha7QMbDUa2UyJ0fRgAw3VLysaQtdW7MRDpz
 7BBeeuW8ggwrrbrzCH5R1Fn+E+qCBBI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-yQdvcrNJMNaoOgF_wQLYdA-1; Thu, 23 Apr 2020 05:00:17 -0400
X-MC-Unique: yQdvcrNJMNaoOgF_wQLYdA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA6EB107B798;
 Thu, 23 Apr 2020 09:00:16 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C04F25D9E2;
 Thu, 23 Apr 2020 09:00:10 +0000 (UTC)
Date: Thu, 23 Apr 2020 10:00:06 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: xiaoqiang zhao <zxq_yx_007@163.com>
Subject: Re: [PATCH v2] qemu-sockets: add abstract UNIX domain socket support
Message-ID: <20200423090006.GA1077680@redhat.com>
References: <20200423035640.29202-1-zxq_yx_007@163.com>
MIME-Version: 1.0
In-Reply-To: <20200423035640.29202-1-zxq_yx_007@163.com>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 02:14:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding Eric & Markus for QAPI modelling questions

On Thu, Apr 23, 2020 at 11:56:40AM +0800, xiaoqiang zhao wrote:
> unix_connect_saddr now support abstract address type
>=20
> By default qemu does not support abstract UNIX domain
> socket address. Add this ability to make qemu handy
> when abstract address is needed.

Was that a specific app you're using with QEMU that needs this ?

> Abstract address is marked by prefixing the address name with a '@'.

For full support of the abstract namespace we would ned to allow
the "sun_path" to contain an arbitrary mix of NULs and non-NULs
characters, and allow connect() @addrlen to be an arbitrary size.

This patch only allows a single initial NUL, and reqiures @addrlen
to be the full size of sun_path, padding with trailing NULs. This
limitation is impossible to lift with QEMU's current approach to
UNIX sockets, as it relies on passing around a NULL terminated
string, so there's no way to have embedded NULs. Since there's
no explicit length, we have to chooose between forcing the full
sun_path size as @addrlen, or forcing the string length as the
@addrlen value.

IIUC, socat makes the latter decision by default, but has a
flag to switch to the former.

  [man socat]
  unix-tightsocklen=3D[0|1]
  On  socket  operations,  pass  a  socket  address  length that does not
  include the whole struct sockaddr_un record but (besides  other  compo=E2=
=80=90
  nents)  only  the  relevant  part  of  the filename or abstract string.
  Default is 1.
  [/man]

This actually is supported for both abstract and non-abstract
sockets, though IIUC this doesn't make a semantic difference
for non-abstract sockets.

The point is we have four possible combinations

 NON-ABSTRACT + FULL SIZE
 NON-ABSTRACT + MINIMAL SIZE  (default)
 ABSTRACT + FULL SIZE
 ABSTRACT + MINIMAL SIZE  (default)

With your patch doing the latter, it means QEMU supports
only two combinations

  NON+ABSTRACT + FULL SIZE
  ABSTRACT + MINIMAL SIZE

and also can't use "@somerealpath" for a non-abstract
socket, though admittedly this is unlikely.

Socat uses a special option to request use of abstract
sockets. eg ABSTRACT:somepath, and automatically adds
the leading NUL, so there's no need for a special "@"
character. This means that UNIX:@somepath still resolves
to a filesystem path and not a abstract socket path.

Finally, the patch as only added support for connect()
not listen(). I think if QEMU wants to support abstract
sockets we must do both, and also have unit tests added
to tests/test-util-sockets.c


The question is whether we're ok with this simple
approach in QEMU, or should do a full approach with
more explicit modelling.

ie should we change QAPI thus:

{ 'struct': 'UnixSocketAddress',
  'data': {
    'path': 'str',
    'tight': 'bool',
    'abstract': 'bool' } }

where 'tight' is a flag indicating whether to set @addrlen
to the minimal string length, or the maximum sun_path length.
And 'abstract' indicates that we automagically add a leading
NUL.

This would *not* allow for NULs in the middle of path,
but I'm not so bothered about that, since I can't see that
being widely used. If we really did need that it could be
added via a 'base64': 'bool' flag, to indicate that @path
is base64 encoded and thus may contain NULs

From a CLI POV, this could be mapped to QAPI thus

 *  -chardev unix:somepath

      @path=3D=3Dsomepath
      @tight=3D=3Dfalse
      @abstract=3D=3Dfalse

 *  -chardev unix:somepath,tight

      @path=3D=3Dsomepath
      @tight=3D=3Dtrue
      @abstract=3D=3Dfalse

 *  -chardev unix-abstract:somepath

      @path=3D=3Dsomepath
      @tight=3D=3Dfalse
      @abstract=3D=3Dtrue

 *  -chardev unix-abstract:somepath,tight

      @path=3D=3Dsomepath
      @tight=3D=3Dtrue
      @abstract=3D=3Dtrue


>=20
> Signed-off-by: xiaoqiang zhao <zxq_yx_007@163.com>
> ---
>  util/qemu-sockets.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index bcc06d0e01..7ba9c497ab 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -939,6 +939,7 @@ static int unix_connect_saddr(UnixSocketAddress *sadd=
r, Error **errp)
>      struct sockaddr_un un;
>      int sock, rc;
>      size_t pathlen;
> +    socklen_t serverlen;
> =20
>      if (saddr->path =3D=3D NULL) {
>          error_setg(errp, "unix connect: no path specified");
> @@ -963,10 +964,17 @@ static int unix_connect_saddr(UnixSocketAddress *sa=
ddr, Error **errp)
>      un.sun_family =3D AF_UNIX;
>      memcpy(un.sun_path, saddr->path, pathlen);
> =20
> +    if (saddr->path[0] =3D=3D '@') {
> +        un.sun_path[0] =3D '\0';
> +        serverlen =3D pathlen + offsetof(struct sockaddr_un, sun_path);
> +    } else {
> +        serverlen =3D sizeof(un);
> +    }
> +
>      /* connect to peer */
>      do {
>          rc =3D 0;
> -        if (connect(sock, (struct sockaddr *) &un, sizeof(un)) < 0) {
> +        if (connect(sock, (struct sockaddr *) &un, serverlen) < 0) {
>              rc =3D -errno;
>          }
>      } while (rc =3D=3D -EINTR);
> --=20
> 2.17.1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


