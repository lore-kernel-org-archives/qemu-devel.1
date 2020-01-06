Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D9BC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8B3207FD
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhFn1rPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B8B3207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXwv-0001nD-KP
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:22:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <rjones@redhat.com>) id 1ioXFi-0000dc-8M
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:37:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <rjones@redhat.com>) id 1ioXFf-0001X0-KF
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:37:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48609
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <rjones@redhat.com>) id 1ioXFf-0001V4-F1
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578335838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8LBT8lWGbj5wXWuf6lIrINqLmDi7lCmsvVs67nXSJUM=;
 b=LhFn1rPE2jUFHy613vlBcuwxY11DzHFTKMYw2+kMkHltoudxtxOWVPZcyOhOPAY9lLPIb+
 tmVcZn/L1DKRm3t9jn+DTG5HKFyfXrRB9rQKmbWUNmgVx4611rk5lz0yyTOGliH7pTxUp0
 0YYckkNBP1EJL1I0B/ZnkgQYYN+6IGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-D5Ro7BNkMz2B5z3tJxRz_g-1; Mon, 06 Jan 2020 13:37:14 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D645A800D5F;
 Mon,  6 Jan 2020 18:37:13 +0000 (UTC)
Received: from localhost (ovpn-117-237.ams2.redhat.com [10.36.117.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC2E7DB55;
 Mon,  6 Jan 2020 18:37:13 +0000 (UTC)
Date: Mon, 6 Jan 2020 18:37:12 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>
Subject: Re: [PATCH v1 19/59] block/ssh.c: remove unneeded labels
Message-ID: <20200106183712.GH3888@redhat.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106182425.20312-20-danielhb413@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20200106182425.20312-20-danielhb413@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: D5Ro7BNkMz2B5z3tJxRz_g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 06, 2020 at 03:23:45PM -0300, Daniel Henrique Barboza wrote:
> The 'out' labels for check_host_key_knownhosts() and authenticate()
> functions can be removed and, instead, call 'return' with the
> appropriate return value. The 'ret' integer from both functions
> could also be removed.
>=20
> CC: Richard W.M. Jones <rjones@redhat.com>
> CC: qemu-block@nongnu.org
> Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
> ---
>  block/ssh.c | 61 +++++++++++++++++------------------------------------
>  1 file changed, 19 insertions(+), 42 deletions(-)
>=20
> diff --git a/block/ssh.c b/block/ssh.c
> index b4375cf7d2..e0c56d002a 100644
> --- a/block/ssh.c
> +++ b/block/ssh.c
> @@ -276,7 +276,6 @@ static void ssh_parse_filename(const char *filename, =
QDict *options,
> =20
>  static int check_host_key_knownhosts(BDRVSSHState *s, Error **errp)
>  {
> -    int ret;
>  #ifdef HAVE_LIBSSH_0_8
>      enum ssh_known_hosts_e state;
>      int r;
> @@ -295,7 +294,6 @@ static int check_host_key_knownhosts(BDRVSSHState *s,=
 Error **errp)
>          trace_ssh_check_host_key_knownhosts();
>          break;
>      case SSH_KNOWN_HOSTS_CHANGED:
> -        ret =3D -EINVAL;
>          r =3D ssh_get_server_publickey(s->session, &pubkey);
>          if (r =3D=3D 0) {
>              r =3D ssh_get_publickey_hash(pubkey, SSH_PUBLICKEY_HASH_SHA2=
56,
> @@ -320,28 +318,23 @@ static int check_host_key_knownhosts(BDRVSSHState *=
s, Error **errp)
>                         "host key does not match the one in known_hosts; =
this "
>                         "may be a possible attack");
>          }
> -        goto out;
> +        return -EINVAL;
>      case SSH_KNOWN_HOSTS_OTHER:
> -        ret =3D -EINVAL;
>          error_setg(errp,
>                     "host key for this server not found, another type exi=
sts");
> -        goto out;
> +        return -EINVAL;
>      case SSH_KNOWN_HOSTS_UNKNOWN:
> -        ret =3D -EINVAL;
>          error_setg(errp, "no host key was found in known_hosts");
> -        goto out;
> +        return -EINVAL;
>      case SSH_KNOWN_HOSTS_NOT_FOUND:
> -        ret =3D -ENOENT;
>          error_setg(errp, "known_hosts file not found");
> -        goto out;
> +        return -ENOENT;
>      case SSH_KNOWN_HOSTS_ERROR:
> -        ret =3D -EINVAL;
>          error_setg(errp, "error while checking the host");
> -        goto out;
> +        return -EINVAL;
>      default:
> -        ret =3D -EINVAL;
>          error_setg(errp, "error while checking for known server (%d)", s=
tate);
> -        goto out;
> +        return -EINVAL;
>      }
>  #else /* !HAVE_LIBSSH_0_8 */
>      int state;
> @@ -355,40 +348,31 @@ static int check_host_key_knownhosts(BDRVSSHState *=
s, Error **errp)
>          trace_ssh_check_host_key_knownhosts();
>          break;
>      case SSH_SERVER_KNOWN_CHANGED:
> -        ret =3D -EINVAL;
>          error_setg(errp,
>                     "host key does not match the one in known_hosts; this=
 "
>                     "may be a possible attack");
> -        goto out;
> +        return -EINVAL;
>      case SSH_SERVER_FOUND_OTHER:
> -        ret =3D -EINVAL;
>          error_setg(errp,
>                     "host key for this server not found, another type exi=
sts");
> -        goto out;
> +        return -EINVAL;
>      case SSH_SERVER_FILE_NOT_FOUND:
> -        ret =3D -ENOENT;
>          error_setg(errp, "known_hosts file not found");
> -        goto out;
> +        return -ENOENT;
>      case SSH_SERVER_NOT_KNOWN:
> -        ret =3D -EINVAL;
>          error_setg(errp, "no host key was found in known_hosts");
> -        goto out;
> +        return -EINVAL;
>      case SSH_SERVER_ERROR:
> -        ret =3D -EINVAL;
>          error_setg(errp, "server error");
> -        goto out;
> +        return -EINVAL;
>      default:
> -        ret =3D -EINVAL;
>          error_setg(errp, "error while checking for known server (%d)", s=
tate);
> -        goto out;
> +        return -EINVAL;
>      }
>  #endif /* !HAVE_LIBSSH_0_8 */
> =20
>      /* known_hosts checking successful. */
> -    ret =3D 0;
> -
> - out:
> -    return ret;
> +    return 0;
>  }
> =20
>  static unsigned hex2decimal(char ch)
> @@ -501,20 +485,18 @@ static int check_host_key(BDRVSSHState *s, SshHostK=
eyCheck *hkc, Error **errp)
> =20
>  static int authenticate(BDRVSSHState *s, Error **errp)
>  {
> -    int r, ret;
> +    int r;
>      int method;
> =20
>      /* Try to authenticate with the "none" method. */
>      r =3D ssh_userauth_none(s->session, NULL);
>      if (r =3D=3D SSH_AUTH_ERROR) {
> -        ret =3D -EPERM;
>          session_error_setg(errp, s, "failed to authenticate using none "
>                                      "authentication");
> -        goto out;
> +        return -EPERM;
>      } else if (r =3D=3D SSH_AUTH_SUCCESS) {
>          /* Authenticated! */
> -        ret =3D 0;
> -        goto out;
> +        return 0;
>      }
> =20
>      method =3D ssh_userauth_list(s->session, NULL);
> @@ -527,23 +509,18 @@ static int authenticate(BDRVSSHState *s, Error **er=
rp)
>      if (method & SSH_AUTH_METHOD_PUBLICKEY) {
>          r =3D ssh_userauth_publickey_auto(s->session, NULL, NULL);
>          if (r =3D=3D SSH_AUTH_ERROR) {
> -            ret =3D -EINVAL;
>              session_error_setg(errp, s, "failed to authenticate using "
>                                          "publickey authentication");
> -            goto out;
> +            return -EINVAL;
>          } else if (r =3D=3D SSH_AUTH_SUCCESS) {
>              /* Authenticated! */
> -            ret =3D 0;
> -            goto out;
> +            return 0;
>          }
>      }
> =20
> -    ret =3D -EPERM;
>      error_setg(errp, "failed to authenticate using publickey authenticat=
ion "
>                 "and the identities held by your ssh-agent");
> -
> - out:
> -    return ret;
> +    return -EPERM;
>  }
> =20
>  static QemuOptsList ssh_runtime_opts =3D {

I agree that the code is functionality the same after this change.
Don't know whether or not one style or the other is preferred by qemu,
but in any case:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjon=
es
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-top is 'top' for virtual machines.  Tiny program with many
powerful monitoring features, net stats, disk stats, logging, etc.
http://people.redhat.com/~rjones/virt-top


