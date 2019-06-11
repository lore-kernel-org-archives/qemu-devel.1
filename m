Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00306C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CACC72086A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 09:58:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CACC72086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hadXq-0007Ju-4S
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 05:58:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49636)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@redhat.com>) id 1hadUL-0006AE-7H
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1hadUI-0006Qq-P4
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 05:54:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>)
 id 1hadUD-0006Ec-Vg; Tue, 11 Jun 2019 05:54:38 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2AD7C308FBB1;
 Tue, 11 Jun 2019 09:54:26 +0000 (UTC)
Received: from localhost (unknown [10.36.118.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2814819C70;
 Tue, 11 Jun 2019 09:54:18 +0000 (UTC)
Date: Tue, 11 Jun 2019 10:54:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Message-ID: <20190611095417.GR14257@stefanha-x1.localdomain>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-12-mehta.aaru20@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZRLamLUCLuRJXeX8"
Content-Disposition: inline
In-Reply-To: <20190610134905.22294-12-mehta.aaru20@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Tue, 11 Jun 2019 09:54:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 11/12] qemu-io: adds support for io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, saket.sinha89@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--ZRLamLUCLuRJXeX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2019 at 07:19:04PM +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> ---
>  qemu-io.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/qemu-io.c b/qemu-io.c
> index 8d5d5911cb..54b82151c4 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -129,6 +129,7 @@ static void open_help(void)
>  " -n, -- disable host cache, short for -t none\n"
>  " -U, -- force shared permissions\n"
>  " -k, -- use kernel AIO implementation (on Linux only)\n"
> +" -i  -- use kernel io_uring (Linux 5.1+)\n"
>  " -t, -- use the given cache mode for the image\n"
>  " -d, -- use the given discard mode for the image\n"
>  " -o, -- options to be given to the block driver"
> @@ -188,6 +189,11 @@ static int open_f(BlockBackend *blk, int argc, char =
**argv)
>          case 'k':
>              flags |=3D BDRV_O_NATIVE_AIO;
>              break;
> +#ifdef CONFIG_LINUX_IO_URING
> +        case 'i':
> +            flags |=3D BDRV_O_IO_URING;
> +            break;
> +#endif
>          case 't':
>              if (bdrv_parse_cache_mode(optarg, &flags, &writethrough) < 0=
) {
>                  error_report("Invalid cache option: %s", optarg);
> @@ -290,6 +296,7 @@ static void usage(const char *name)
>  "  -C, --copy-on-read   enable copy-on-read\n"
>  "  -m, --misalign       misalign allocations for O_DIRECT\n"
>  "  -k, --native-aio     use kernel AIO implementation (on Linux only)\n"
> +"  -i  --io_uring       use kernel io_uring (Linux 5.1+)\n"
>  "  -t, --cache=3DMODE     use the given cache mode for the image\n"
>  "  -d, --discard=3DMODE   use the given discard mode for the image\n"
>  "  -T, --trace [[enable=3D]<pattern>][,events=3D<file>][,file=3D<file>]\=
n"
> @@ -499,6 +506,7 @@ int main(int argc, char **argv)
>          { "copy-on-read", no_argument, NULL, 'C' },
>          { "misalign", no_argument, NULL, 'm' },
>          { "native-aio", no_argument, NULL, 'k' },
> +        { "io_uring", no_argument, NULL, 'i' },
>          { "discard", required_argument, NULL, 'd' },
>          { "cache", required_argument, NULL, 't' },
>          { "trace", required_argument, NULL, 'T' },
> @@ -566,6 +574,11 @@ int main(int argc, char **argv)
>          case 'k':
>              flags |=3D BDRV_O_NATIVE_AIO;
>              break;
> +#ifdef CONFIG_LINUX_IO_URING
> +        case 'i':
> +            flags |=3D BDRV_O_IO_URING;
> +            break;
> +#endif

An --aio=3Dthreads|native|io_uring option would be more general than
adding --io_uring.  That new AIO engines do not require their own
command-line options.

Can you implement something like the -drive aio=3D parameter so that a
single option can specify threads, native, or io_uring?

Thanks,
Stefan

--ZRLamLUCLuRJXeX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlz/ekkACgkQnKSrs4Gr
c8h5eAf8CbWQz8qKbiqOTE2A825zKqDC1psuNv2Eg3KHJy+CylyNp3V5h4Xc4Bew
gSQ0AL2iX1DioMEvv8YjUWNr6c/SO3it4DgCTXAupJWOVPBUILlJNpco38UIjr1e
PTrDav88g6WDEDxp7qkZyLzVrclwGEcdQ7ECAjGuOjlQJBxzYyouXvAHKov6X7nz
lQitQuyqOUcmVnd8dBw7cXAcyCvyHv47/owUp58oHb/xKZGa+AzXdDBgX3iPbslm
jlFY4ksuEZE1HGhQ+9/TPCAXvrpF/SGFOXbxTCwArdERVP9521XgwTmygDiBRcok
sAW5n3vJkEpq5GQ1U17tOtUY6Q5XIA==
=JAmw
-----END PGP SIGNATURE-----

--ZRLamLUCLuRJXeX8--

