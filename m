Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEE3C46499
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:06:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863712133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 11:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863712133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjM2S-0002Bc-Bl
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 07:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33809)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hjM0D-0001EN-HR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:03:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hjM0B-0007IT-JH
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 07:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39210)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hjM03-0006bf-7N; Fri, 05 Jul 2019 07:03:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7EB8C28DE;
 Fri,  5 Jul 2019 11:03:28 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-154.brq.redhat.com
 [10.40.204.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E8228E170;
 Fri,  5 Jul 2019 11:03:24 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-2-mlevitsk@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
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
Message-ID: <c47da7ef-82ac-1a76-9c8e-f76336c20c44@redhat.com>
Date: Fri, 5 Jul 2019 13:03:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703155944.9637-2-mlevitsk@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="35KgkK6nk95OW59PLSMiKNc1JPZASnnMn"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Fri, 05 Jul 2019 11:03:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/6] block/nvme: don't touch the
 completion entries
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--35KgkK6nk95OW59PLSMiKNc1JPZASnnMn
Content-Type: multipart/mixed; boundary="X75uAkW7wdTVpzg0tFSJkIuDKUk2F7VgT";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-block@nongnu.org
Message-ID: <c47da7ef-82ac-1a76-9c8e-f76336c20c44@redhat.com>
Subject: Re: [PATCH v3 1/6] block/nvme: don't touch the completion entries
References: <20190703155944.9637-1-mlevitsk@redhat.com>
 <20190703155944.9637-2-mlevitsk@redhat.com>
In-Reply-To: <20190703155944.9637-2-mlevitsk@redhat.com>

--X75uAkW7wdTVpzg0tFSJkIuDKUk2F7VgT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 17:59, Maxim Levitsky wrote:
> Completion entries are meant to be only read by the host and written by=
 the device.
> The driver is supposed to scan the completions from the last point wher=
e it left,
> and until it sees a completion with non flipped phase bit.

(Disclaimer: This is the first time I read the nvme driver, or really
something in the nvme spec.)

Well, no, completion entries are also meant to be initialized by the
host.  To me it looks like this is the place where that happens:
Everything that has been processed by the device is immediately being
re-initialized.

Maybe we shouldn=E2=80=99t do that here but in nvme_submit_command().  Bu=
t
currently we don=E2=80=99t, and I don=E2=80=99t see any other place where=
 we currently
initialize the CQ entries.

Max

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  block/nvme.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/block/nvme.c b/block/nvme.c
> index 73ed5fa75f..6d4e7f3d83 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -315,7 +315,7 @@ static bool nvme_process_completion(BDRVNVMeState *=
s, NVMeQueuePair *q)
>      while (q->inflight) {
>          int16_t cid;
>          c =3D (NvmeCqe *)&q->cq.queue[q->cq.head * NVME_CQ_ENTRY_BYTES=
];
> -        if (!c->cid || (le16_to_cpu(c->status) & 0x1) =3D=3D q->cq_pha=
se) {
> +        if ((le16_to_cpu(c->status) & 0x1) =3D=3D q->cq_phase) {
>              break;
>          }
>          q->cq.head =3D (q->cq.head + 1) % NVME_QUEUE_SIZE;
> @@ -339,10 +339,7 @@ static bool nvme_process_completion(BDRVNVMeState =
*s, NVMeQueuePair *q)
>          qemu_mutex_unlock(&q->lock);
>          req.cb(req.opaque, nvme_translate_error(c));
>          qemu_mutex_lock(&q->lock);
> -        c->cid =3D cpu_to_le16(0);
>          q->inflight--;
> -        /* Flip Phase Tag bit. */
> -        c->status =3D cpu_to_le16(le16_to_cpu(c->status) ^ 0x1);
>          progress =3D true;
>      }
>      if (progress) {
>=20



--X75uAkW7wdTVpzg0tFSJkIuDKUk2F7VgT--

--35KgkK6nk95OW59PLSMiKNc1JPZASnnMn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0fLnoACgkQ9AfbAGHV
z0Do8QgAgu0OEMvgPkHuswXjf+qi87vnYQp6DK7RqLJzn9bKvvukfRuKYvVvGpaG
HYPLDNhYgsxolAylJA0gqkHUhGipUGpcdJ4I43GzerxSFh5oH/R7PW9U+l1WfvmJ
ANv6dsCPEZGMq18GLByOOjSiF/AgcURJoJO3h2g/aCWxbdq4u5VBI2wDPsxx71/3
vx4rkbyQSi7evAfnu46zRJqdEKGzvaMPISasZhsfHT5Wk5D7oPpeTQ9WNO4thUo0
dBZSVS2ZTRZgm/x/HQ6nHBwDC2Wj2tPdcfg2Zb5iAxt9ZvMLVYGw7okirr0stdgi
dY890t6iLwNoWaqZQCj+YHVG4sI6ow==
=HdIe
-----END PGP SIGNATURE-----

--35KgkK6nk95OW59PLSMiKNc1JPZASnnMn--

