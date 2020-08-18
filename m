Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B07DC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:38:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CD220786
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 15:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XnRaNEOT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CD220786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k83ge-0003E1-Fv
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 11:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k83E8-0002XG-89
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:08:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k83E5-00078j-BA
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 11:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597763315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=AjohSILyeJrC5swlsdvD81cK/R9mJ9yiZJD96VfeFPo=;
 b=XnRaNEOTcVsgfdb3en5lsAylqJk2vMm5tujjUFYnTUa91Z81fU2pp894vf990HwQz+MpMN
 lbvugZUfvHj8uUiici/N/FEXFzEzUrhdfROXVuYavk7ePzUSnGbEo7vXASzQuJeNhLsL52
 64rOeyyI5YhECDKazVSCtNrZ52FxuMc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-2hQEt69UOwKUyu0pdcFwtQ-1; Tue, 18 Aug 2020 11:08:33 -0400
X-MC-Unique: 2hQEt69UOwKUyu0pdcFwtQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3BA81DDF1;
 Tue, 18 Aug 2020 15:08:32 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-119.ams2.redhat.com
 [10.36.112.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B1967756C4;
 Tue, 18 Aug 2020 15:08:28 +0000 (UTC)
Subject: Re: [RFC PATCH 18/22] block/export: Add 'id' option to
 block-export-add
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200813162935.210070-1-kwolf@redhat.com>
 <20200813162935.210070-19-kwolf@redhat.com>
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
Message-ID: <0aa46154-3bd5-43fa-5731-c3e5bc66802b@redhat.com>
Date: Tue, 18 Aug 2020 17:08:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813162935.210070-19-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="d9xWe7CpAhFDQPXKUCnd0a4ITcfsNuh4w"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 03:22:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d9xWe7CpAhFDQPXKUCnd0a4ITcfsNuh4w
Content-Type: multipart/mixed; boundary="OS1KPAmMn475AldG7SsVKnA7Db3M0FLIW"

--OS1KPAmMn475AldG7SsVKnA7Db3M0FLIW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.08.20 18:29, Kevin Wolf wrote:
> We'll need an id to identify block exports in monitor commands. This
> adds one.
>=20
> Note that this is different from the 'name' option in the NBD server,
> which is the externally visible export name. While block export ids need
> to be unique in the whole process, export names must be unique only for
> the same server. Different export types or (potentially in the future)
> multiple NBD servers can have the same export name externally, but still
> need different block export ids internally.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-export.json |  3 +++
>  include/block/export.h |  3 +++
>  block/export/export.c  | 27 +++++++++++++++++++++++++++
>  qemu-nbd.c             |  1 +
>  4 files changed, 34 insertions(+)

Looks good, just one thing:

> diff --git a/block/export/export.c b/block/export/export.c
> index 675db9a8b9..72f1fab975 100644
> --- a/block/export/export.c
> +++ b/block/export/export.c

[...]

> @@ -144,6 +170,7 @@ void qmp_nbd_server_add(NbdServerAddOptions *arg, Err=
or **errp)
>      BlockExportOptions *export_opts =3D g_new(BlockExportOptions, 1);
>      *export_opts =3D (BlockExportOptions) {
>          .type                   =3D BLOCK_EXPORT_TYPE_NBD,
> +        .id                     =3D g_strdup(arg->name ?: arg->device),

Maybe this behavior should be documented for nbd-server-add?

>          .device                 =3D g_strdup(arg->device),
>          .u.nbd =3D {
>              .has_name           =3D arg->has_name,


--OS1KPAmMn475AldG7SsVKnA7Db3M0FLIW--

--d9xWe7CpAhFDQPXKUCnd0a4ITcfsNuh4w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl877usACgkQ9AfbAGHV
z0CJ/AgAseqfHrTQbqblTjvo6MQ+zEi3lXmp2fSCIi8xJEl+GhhxHpdpydOuz1RU
Zy2HDjDzAlvhWL0eMmIvQUPluVURiOJHrI1UAi2ZLg/LX/c2CpSxB0dkjNykfQBE
QCtiyUR1V9N8RJbbxH5G9BqViGsLdv0Ri8FZHimvhAFg1YRlrPEpQlAnvjKMjt//
O20ZW00EIWYO9+Qf7i6am1a1p5J/qlHdlJxNqs/qav/aMqHFqUTKkqlMZk4FJ6cV
dVlxB/qN7sGBMJxpKMwoORTsz9rKLtDH8eicUbrinDNSgP9aTkLmN9PVYFxTZRy0
4aTSz8+WCAUbiddbTPWQkDJZ97GpAQ==
=s7Qw
-----END PGP SIGNATURE-----

--d9xWe7CpAhFDQPXKUCnd0a4ITcfsNuh4w--


