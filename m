Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053E5C433E4
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:47:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3F2D206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhC4hFnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F2D206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5AM-0008NF-0w
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 10:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw58Z-0006qZ-4Q
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:45:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25882
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jw58X-0000NN-CM
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 10:45:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594910724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=98Y3+XnxCRQ2kZFsiLS4SOaxMOl8h7L9yufeFxyZrOQ=;
 b=NhC4hFncvDLZjyNOQ057AoU88BUs3iPuAQ84NSQJ5JiotiG3X+S2/wi7rr7cMSKQ6yNGNL
 SScHSgUtGs5cLgKdBMU24yeAfuNwLl7vWReWPzcqkB0JatNrCyMo4esST9sMMX8+FVn4jt
 KkXrC2y6Qk3M/lyUJEFk1Qr5qIz50RI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-jqTPPa0wOY26eDiWzp2ylQ-1; Thu, 16 Jul 2020 10:45:22 -0400
X-MC-Unique: jqTPPa0wOY26eDiWzp2ylQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CB0C15C20;
 Thu, 16 Jul 2020 14:45:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-112-160.ams2.redhat.com
 [10.36.112.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 786557A4A4;
 Thu, 16 Jul 2020 14:45:16 +0000 (UTC)
Subject: Re: [PATCH for-5.1] iotests/030: Reduce job speed to make race less
 likely
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200716132829.20127-1-kwolf@redhat.com>
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
Message-ID: <54bab231-775e-aa20-fed3-bea1a741c696@redhat.com>
Date: Thu, 16 Jul 2020 16:45:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200716132829.20127-1-kwolf@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u48zThU7kWKGsg25zO6tRE0Zbe0N6y6rG"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:25:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u48zThU7kWKGsg25zO6tRE0Zbe0N6y6rG
Content-Type: multipart/mixed; boundary="uHA6cAtcPeOKBJCsLJrvR39sScEuO6Sn8"

--uHA6cAtcPeOKBJCsLJrvR39sScEuO6Sn8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.20 15:28, Kevin Wolf wrote:
> It can happen that the throttling of the stream job doesn't make it slow
> enough that we can be sure that it still exists when it is referenced
> again. Just use a much smaller speed to make this very unlikely to
> happen again.
>=20
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/qemu-iotests/030 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--uHA6cAtcPeOKBJCsLJrvR39sScEuO6Sn8--

--u48zThU7kWKGsg25zO6tRE0Zbe0N6y6rG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8QZ/oACgkQ9AfbAGHV
z0CijQgAmKqdhP++QgOxDJTOPhH9x+WfWpilZX1XwfW4vwIKxL0UQhfiQNxdZhC9
Z/GuXXednUbpgFNyDcJwb99v4/nm5zEmTrSf8hSQUS2uXhk4LxXWau1IeKBBUN9Y
luR2ClQC7N+Uyf+5goK2XHejRHvoVeYf0MQj4SxEl9SrTOw5qeQflXUIBbGZ58Qk
Kwsb+nzNS+uj9JsDCF1H7A1H6ZQyVHSE+QjK9pq53yDQ3IJtG4xVS1VoS9llTfZ/
CqonVDvBlupirhG1Hu3tqwAVRhX/7xt1SeSmaq/ZKn/ydKOBi2NgcxZuUPu+iBor
5/ddKIandByyuDyPynzRRO0DcrhAQw==
=erEe
-----END PGP SIGNATURE-----

--u48zThU7kWKGsg25zO6tRE0Zbe0N6y6rG--


