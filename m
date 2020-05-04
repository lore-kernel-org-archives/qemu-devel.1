Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342AEC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:23:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EFFF7206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 12:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxTjtMl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFFF7206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVa84-0000vO-5X
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 08:23:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVZzt-0000pI-Hi
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:14:57 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48721
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVZzr-0006u7-9F
 for qemu-devel@nongnu.org; Mon, 04 May 2020 08:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588594493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WH1VtulMFvUeJ00pE/WEtHY8strj9YZYCGrcXY5vFs8=;
 b=bxTjtMl53hydtis8O2XBFAJ4uQaJn71VuEJoyvpGCt9UilIfS/xlI8CA6qLHKVYUizqLc5
 NedWEoP5UmcAcsopmJ2KvL9irpFLcDDKCR2c1FA8JGTnwSSdu9/nraSjhW/ZpDSY7ysqhA
 Loj6iLlG49yKOWuaD/M3BTeXTKXInv0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-3fGM9Fh1POSIRSW81OkAKw-1; Mon, 04 May 2020 08:14:51 -0400
X-MC-Unique: 3fGM9Fh1POSIRSW81OkAKw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1F51107ACF3;
 Mon,  4 May 2020 12:14:50 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-219.ams2.redhat.com
 [10.36.113.219])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7C4235C1BD;
 Mon,  4 May 2020 12:14:49 +0000 (UTC)
Subject: Re: [PATCH v2 5/6] qemu-img: Add convert --bitmaps option
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200421212019.170707-1-eblake@redhat.com>
 <20200421212019.170707-6-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <43e201ca-48e5-e982-a7fb-1e00ca54e295@redhat.com>
Date: Mon, 4 May 2020 14:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200421212019.170707-6-eblake@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EOPFpO5W74rbdM8vpG3Tl5W8lfzNt05iu"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 08:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EOPFpO5W74rbdM8vpG3Tl5W8lfzNt05iu
Content-Type: multipart/mixed; boundary="h9w1jMtRh7xrOErZ6jeHwL2GGHyoUhK41"

--h9w1jMtRh7xrOErZ6jeHwL2GGHyoUhK41
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.04.20 23:20, Eric Blake wrote:
> Make it easier to copy all the persistent bitmaps of a source image
> along with the contents, by adding a boolean flag for use with
> qemu-img convert.  This is basically shorthand, as the same effect
> could be accomplished with a series of 'qemu-img bitmap --add' and
> 'qemu-img bitmap --merge -b source' commands, or by QMP commands.
>=20
> See also https://bugzilla.redhat.com/show_bug.cgi?id=3D1779893
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/tools/qemu-img.rst |  6 +++-
>  qemu-img.c              | 80 +++++++++++++++++++++++++++++++++++++++--
>  qemu-img-cmds.hx        |  4 +--
>  3 files changed, 84 insertions(+), 6 deletions(-)

[...]

> diff --git a/qemu-img.c b/qemu-img.c
> index e1127273f21e..6cfc1f52ef98 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -2293,7 +2342,6 @@ static int img_convert(int argc, char **argv)
>          goto fail_getopt;
>      }
>=20
> -
>      /* ret is still -EINVAL until here */
>      ret =3D bdrv_parse_cache_mode(src_cache, &src_flags, &src_writethrou=
gh);
>      if (ret < 0) {

[...]

> @@ -2461,9 +2531,7 @@ static int img_convert(int argc, char **argv)
>      if (!skip_create) {
>          open_opts =3D qdict_new();
>          qemu_opt_foreach(opts, img_add_key_secrets, open_opts, &error_ab=
ort);
> -    }
>=20
> -    if (!skip_create) {

I mean, cleanups are always welcome, but I feel compelled[1] to complain
that it=E2=80=99s done in this patch without mentioning it in the commit me=
ssage.

[1] By social norms, not by my personal opinion.

I feel good about all changes, though, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--h9w1jMtRh7xrOErZ6jeHwL2GGHyoUhK41--

--EOPFpO5W74rbdM8vpG3Tl5W8lfzNt05iu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl6wBzcACgkQ9AfbAGHV
z0C6awf/a1rFTGHhFUbZ4hiXap6ATAm0taopHcBFo2MWY0RDw2eaHjmSlgPQw4B7
MGJBTvWohBPwmEVHsy2TvyvfCboGgI3Nkhg9UKRxQdilTy/tonKZTwGFG1pySBze
nlkIiMxSTg4ZiBwMbGj7B4e4B92l6nIUHnCjfZ6Ot1+wZmkZQP8oJzqg1xh4SIq9
k+dTyXTV03qXp7N44qLWsT0XH9jObsAnRAtB3ZQGn866DLwqYRahMKGkPS43iAoI
DRilLkq16xHbDI3zPbpnv44VvWLFaL5IgntKwcNTxVfafozZxmeHcFbTkkWMii6K
76AV/wG7PnsztTSO97QUn+l6VKZ2fw==
=tJhB
-----END PGP SIGNATURE-----

--EOPFpO5W74rbdM8vpG3Tl5W8lfzNt05iu--


