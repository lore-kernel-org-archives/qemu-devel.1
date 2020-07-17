Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8F7FC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1D1020717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 13:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KGFUjJ5w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1D1020717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwQE5-0005h5-VF
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 09:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jwQDF-0005AC-1e
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:15:41 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47245
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jwQDC-0003hX-Vw
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 09:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594991734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DHersnaSuqRNYI4CygS5tU7Td1W22QfrZ9hEpdRq9qY=;
 b=KGFUjJ5wDGmIkQFu6Wey2FHmph9KrXShUa8j1n8Kky3l+nr7wRCPnTJhCNuOFnPWzrYEqI
 pZLhoTr/7pjkOBpAIBR7hkLIk/QX3u6xJ+0IHWNZXWzbaKbyrrMR+boMTC07nls/rKQgHJ
 CHv5DWcreW9mXbwRqfWoRjqKccF8AuE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-Y1tQ7Yj-P7qa0uTXt5kCNg-1; Fri, 17 Jul 2020 09:15:30 -0400
X-MC-Unique: Y1tQ7Yj-P7qa0uTXt5kCNg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0ABB21940921;
 Fri, 17 Jul 2020 13:15:28 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-123.ams2.redhat.com
 [10.36.113.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F7C979502;
 Fri, 17 Jul 2020 13:15:25 +0000 (UTC)
Subject: Re: [PATCH v2 03/20] qapi: backup: add x-use-copy-range parameter
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-4-vsementsov@virtuozzo.com>
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
Message-ID: <a18ed0cf-cd8a-1600-e821-82a94dd8a7be@redhat.com>
Date: Fri, 17 Jul 2020 15:15:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200601181118.579-4-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mZpHJyIq9HfjK30YPVumImPX7XfTPVeoO"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 05:27:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mZpHJyIq9HfjK30YPVumImPX7XfTPVeoO
Content-Type: multipart/mixed; boundary="P0VUx70JfqI0EVdtkGAtm1anoh4Jq6M78"

--P0VUx70JfqI0EVdtkGAtm1anoh4Jq6M78
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
> Add parameter to enable/disable copy_range. Keep current default for
> now (enabled).

Why x-, though?  I can=E2=80=99t think of a reason why we would have to rem=
ove this.

> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  qapi/block-core.json       | 4 +++-
>  block/backup-top.h         | 1 +
>  include/block/block-copy.h | 2 +-
>  include/block/block_int.h  | 1 +
>  block/backup-top.c         | 4 +++-
>  block/backup.c             | 4 +++-
>  block/block-copy.c         | 4 ++--
>  block/replication.c        | 1 +
>  blockdev.c                 | 5 +++++
>  9 files changed, 20 insertions(+), 6 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 6fbacddab2..0c7600e4ec 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1405,6 +1405,8 @@
>  #                    above node specified by @drive. If this option is n=
ot given,
>  #                    a node name is autogenerated. (Since: 4.2)
>  #
> +# @x-use-copy-range: use copy offloading if possible. Default true. (Sin=
ce 5.1)

Would it make more sense to invert it to disable-copy-range?  First,
this would make for a cleaner meaning, because it would allow dropping
the =E2=80=9Cif possible=E2=80=9D part.  Setting use-copy-range=3Dtrue woul=
d intuitively
imply to me that I get an error if copy-range cannot be used.  Sure,
there=E2=80=99s this little =E2=80=9Cif possible=E2=80=9D in the documentat=
ion, but it goes
against my intuition.  disable-copy-range=3Dtrue is intuitively clear.
Second, this would give us a default of false, which is marginally nicer.

Max


--P0VUx70JfqI0EVdtkGAtm1anoh4Jq6M78--

--mZpHJyIq9HfjK30YPVumImPX7XfTPVeoO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8RpGsACgkQ9AfbAGHV
z0De5ggAl5lX22inwR7RSzdhDebVaUTjgt0sYgVLRaMcj+1u7GC6KkAaCI6/8qCP
w9flSN7EVntS2EHyrPDs+iiP/Cm68rt/7Vi8LeKwqY3Gi4H6K+m1GoHJmEFW/d4a
dKx+Yp5UEw46qSNa+Tjg2h/NG2yGxQEA4MVlQ0noh201wEQ2OSz3ZdJGnb8t8Et+
FHA6SFo3YQEmI58zhezfO25FCxt6FK+/BQmJfkSnWW/upc0/ht6a9tmuNqVjsRnR
C2TliQ9e/xCrQvOPlRp5mc68bktn3sD7o7eqYR8HcYRS+A4BD7Na5rEB16LVA4Ap
dlbb/BXVVAPhrRBgqfwWu0ABrAsEkw==
=J2NH
-----END PGP SIGNATURE-----

--mZpHJyIq9HfjK30YPVumImPX7XfTPVeoO--


