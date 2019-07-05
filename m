Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3605C4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:33:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B510218BA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:33:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B510218BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjLXR-0007yJ-Mt
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55634)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <berrange@redhat.com>) id 1hjLVQ-0006nq-CZ
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:31:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1hjLVO-0005SY-Ew
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:31:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41659)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1hjLVI-0005EY-P6; Fri, 05 Jul 2019 06:31:45 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E224D81E08;
 Fri,  5 Jul 2019 10:31:42 +0000 (UTC)
Received: from redhat.com (ovpn-112-48.ams2.redhat.com [10.36.112.48])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9C00D7F461;
 Fri,  5 Jul 2019 10:31:39 +0000 (UTC)
Date: Fri, 5 Jul 2019 11:31:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190705103136.GF32473@redhat.com>
References: <20190703224707.12437-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190703224707.12437-1-eblake@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 05 Jul 2019 10:31:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 RFC] qemu-nbd: Permit TLS with Unix
 sockets
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 rjones@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 03, 2019 at 05:47:07PM -0500, Eric Blake wrote:
> Although you generally won't use encryption with a Unix socket (after
> all, everything is local, so why waste the CPU power), there are
> situations in testsuites where Unix sockets are much nicer than TCP
> sockets.  Since nbdkit allows encryption over both types of sockets,
> it makes sense for qemu-nbd to do likewise.
> 
> The restriction has been present since its introduction in commits
> 145614a1 and 75822a12 (v2.6), where the former documented the
> limitation but did not provide any additional explanation why it was
> added; but looking closer, it seems the most likely reason is that
> x509 verification requires a hostname. But we can do the same as
> migration did, and add a tls-hostname parameter to supply that
> information.

Yes, the x509 cert validation is precisely the reason.

The client must validate the hostname it is connecting to, against
the x509 certificate received from the server. If it doesn't use
IP, then it had no hostnmae to validate the cert against.

Since that time though, we added support for PSK credentials with
TLS which requires no hostname validation, so the restriction no
longer makes sense.

Adding ability to set a tls-hostname parameter further enables its
use with x509 credentials.

> RFC: The test is racy - it sometimes passes, and sometimes fails with:
> 
>  == check TLS with authorization over Unix ==
>  qemu-img: Could not open 'driver=nbd,path=SOCKET,tls-creds=tls0,tls-hostname=localhost': Failed to read option reply: Cannot read from TLS channel: Input/output error
> -qemu-img: Could not open 'driver=nbd,path=SOCKET,tls-creds=tls0,tls-hostname=localhost': Failed to read option reply: Cannot read from TLS channel: Input/output error
> +qemu-img: Could not open 'driver=nbd,path=SOCKET,tls-creds=tls0,tls-hostname=localhost': Failed to read option reply: Cannot read from TLS channel: Software caused connection abort

It is a bit complex to debug this because unfortunately gnutls API
doesn't allow us to propagate the root cause error accurately.

We return ECONNABORTED when GNUTLS reports GNUTLS_E_PREMATURE_TERMINATION.
It reports this when it tries to read a packet header and gets EOF from
the socket.

We return EIO in other cases where there's no GNUTLS error code we
want to handle explicitly. With some debugging I find that GNUTLS
is returned GNUTLS_E_PULL_ERROR which is a generic code it returns
whenever the read() callback fails for a reason which isn't EAGAIN.

With more debugging I find the original recvfrom() is returning
ECONNRESET, so this is basically just another name for EOF.

I'm curious why we see EOF sometimes and ECONNRESET at other times.
I disabled the qio_channel_shutdown call on the server and that just
changed to a different race. Now we sometimes get ECONNRESET, and
sometimes get EIO when trying to send the first NBD option header
instead.

> I suspect that there is a bug in the qio TLS channel code when it
> comes to handling a failed TLS handshake, which results in the racy
> output. I'll need help solving that first.  It might also be nice if
> we had a bit more visibility into the gnutls error message when TLS
> handshake fails.

I'm not sure there is a bug - it feels like there's just a few different
shutdown scenarios we can hit based on timing, due to the fact there is
no synchronization with the client when we drop the connection if
authz fails.


> @@ -1624,12 +1629,25 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
>              goto error;
>          }
> 
> -        /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET6 */
> -        if (s->saddr->type != SOCKET_ADDRESS_TYPE_INET) {
> -            error_setg(errp, "TLS only supported over IP sockets");
> +        switch (s->saddr->type) {
> +        case SOCKET_ADDRESS_TYPE_INET:
> +            hostname = s->saddr->u.inet.host;
> +            if (qemu_opt_get(opts, "tls-hostname")) {
> +                error_setg(errp, "tls-hostname not required with inet socket");
> +                goto error;
> +            }

We don't need to forbid this. Consider if you have setup an SSH tunnel
from localhost:someport, over to your remote server. NBD will get told
to connect to localhost, but will need to validate the cert against
the real remote hostname.

> +            break;
> +        case SOCKET_ADDRESS_TYPE_UNIX:
> +            hostname = qemu_opt_get(opts, "tls-hostname");
> +            break;
> +        default:
> +            /* TODO SOCKET_ADDRESS_KIND_FD where fd has AF_INET or AF_INET6 */
> +            error_setg(errp, "TLS only supported over IP or Unix sockets");
>              goto error;
>          }

I don't think we need any of this switch, instead just something like thus:

   hostname = qemu_opt_get(opts, "tls-hostname");
   if (!hostname) {
       if (s->saddr->type == SOCKET_ADDRESS_TYPE_INET) {
           hostname  = s->sadddr->u.inet.host;
       } else {
           error_setg(errp,  "tls-hostname is required for non-IP sockets");
	   goto error;
       }
   }

> -        hostname = s->saddr->u.inet.host;
> +    } else if (qemu_opt_get(opts, "tls-hostname")) {
> +        error_setg(errp, "tls-hostname not supported without tls-creds");
> +        goto error;
>      }
> 
>      /* NBD handshake */
> @@ -1752,6 +1770,7 @@ static const char *const nbd_strong_runtime_opts[] = {
>      "port",
>      "export",
>      "tls-creds",
> +    "tls-hostname",
>      "server.",
> 
>      NULL
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index a8cb39e51043..40ea1e299dc7 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -62,6 +62,7 @@
>  #define QEMU_NBD_OPT_FORK          263
>  #define QEMU_NBD_OPT_TLSAUTHZ      264
>  #define QEMU_NBD_OPT_PID_FILE      265
> +#define QEMU_NBD_OPT_TLSHOST       266
> 
>  #define MBR_SIZE 512
> 
> @@ -76,6 +77,7 @@ static int nb_fds;
>  static QIONetListener *server;
>  static QCryptoTLSCreds *tlscreds;
>  static const char *tlsauthz;
> +static const char *tlshost;
> 
>  static void usage(const char *name)
>  {
> @@ -640,6 +642,7 @@ int main(int argc, char **argv)
>          { "description", required_argument, NULL, 'D' },
>          { "tls-creds", required_argument, NULL, QEMU_NBD_OPT_TLSCREDS },
>          { "tls-authz", required_argument, NULL, QEMU_NBD_OPT_TLSAUTHZ },
> +        { "tls-hostname", required_argument, NULL, QEMU_NBD_OPT_TLSHOST },
>          { "image-opts", no_argument, NULL, QEMU_NBD_OPT_IMAGE_OPTS },
>          { "trace", required_argument, NULL, 'T' },
>          { "fork", no_argument, NULL, QEMU_NBD_OPT_FORK },
> @@ -864,6 +867,9 @@ int main(int argc, char **argv)
>          case QEMU_NBD_OPT_TLSAUTHZ:
>              tlsauthz = optarg;
>              break;
> +        case QEMU_NBD_OPT_TLSHOST:
> +            tlshost = optarg;
> +            break;
>          case QEMU_NBD_OPT_FORK:
>              fork_process = true;
>              break;
> @@ -931,18 +937,22 @@ int main(int argc, char **argv)
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
>          }
>          if (tlsauthz && list) {
> -            error_report("TLS authorization is incompatible with export list");
> +            error_report("TLS authorization is incompatible with --list");
>              exit(EXIT_FAILURE);
>          }
> +        if (tlshost) {
> +            if (!list) {
> +                error_report("TLS hostname is only for use with --list");
> +                exit(EXIT_FAILURE);
> +            }
> +        } else {
> +            tlshost = bindto;

I was a bit confused by the "bindto" name being used as the hostname
to connect to for the --list client. Perhas we should rename it to
something neutral - just hostname perhaps.

> +        }
>          tlscreds = nbd_get_tls_creds(tlscredsid, list, &local_err);
>          if (local_err) {
>              error_report("Failed to get TLS creds %s",
> @@ -954,11 +964,15 @@ int main(int argc, char **argv)
>              error_report("--tls-authz is not permitted without --tls-creds");
>              exit(EXIT_FAILURE);
>          }
> +        if (tlshost) {
> +            error_report("--tls-hostname is not permitted without --tls-creds");
> +            exit(EXIT_FAILURE);
> +        }
>      }
> 
>      if (list) {
>          saddr = nbd_build_socket_address(sockpath, bindto, port);
> -        return qemu_nbd_client_list(saddr, tlscreds, bindto);
> +        return qemu_nbd_client_list(saddr, tlscreds, tlshost);
>      }
> 
>  #if !HAVE_NBD_DEVICE

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

