Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF758C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 08:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9B52080D
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 08:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htCc6j05"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9B52080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyWi4-0006Aw-U7
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 04:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58034)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyWhR-0005aq-5Z
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 04:35:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36564
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jyWhO-0001yo-Fg
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 04:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595493328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ujx3uyBhK1srhnRFreFukRnpfKvp1bZ90UjjhZ4/ERs=;
 b=htCc6j05jHl6hEaVskY6Wce2SMheIk37E3mHZRT1YmE8oZo2WbozWQ+uHRFQiqP5jhTpJO
 AwsKU7mhUT1JxR4lOlPrW0YXHXKhn/jvgqWMAwbxCtAqGMPXnev/8t3pwowMvwYsztSLPa
 /EOP/Zq9UL39biHcJZjWNJYGncPvOgE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-iepYMIbZOWap9yKch7-uLA-1; Thu, 23 Jul 2020 04:35:23 -0400
X-MC-Unique: iepYMIbZOWap9yKch7-uLA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AF908015CE;
 Thu, 23 Jul 2020 08:35:22 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-146.ams2.redhat.com
 [10.36.113.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8202A27CDD;
 Thu, 23 Jul 2020 08:35:19 +0000 (UTC)
Subject: Re: [PATCH v2 15/20] iotests: 219: prepare for backup over block-copy
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200601181118.579-1-vsementsov@virtuozzo.com>
 <20200601181118.579-16-vsementsov@virtuozzo.com>
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
Message-ID: <9d29163a-5fe3-f97e-594a-abe5be016310@redhat.com>
Date: Thu, 23 Jul 2020 10:35:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200601181118.579-16-vsementsov@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CPSjUM4GhV0SSnh9O7Gx26tN74iTruM2u"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/23 02:33:29
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
Cc: kwolf@redhat.com, wencongyang2@huawei.com, xiechanglong.d@gmail.com,
 armbru@redhat.com, qemu-devel@nongnu.org, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CPSjUM4GhV0SSnh9O7Gx26tN74iTruM2u
Content-Type: multipart/mixed; boundary="ApqzMzMtGqnJTrlqXQo5uCDwCdmtIeteo"

--ApqzMzMtGqnJTrlqXQo5uCDwCdmtIeteo
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 01.06.20 20:11, Vladimir Sementsov-Ogievskiy wrote:
> The further change of moving backup to be a on block-copy call will

-on?

> make copying chunk-size and cluster-size a separate things. So, even

s/a/two/

> with 64k cluster sized qcow2 image, default chunk would be 1M.
> Test 219 depends on specified chunk-size. Update it for explicit
> chunk-size for backup as for mirror.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  tests/qemu-iotests/219 | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/219 b/tests/qemu-iotests/219
> index db272c5249..2bbed28f39 100755
> --- a/tests/qemu-iotests/219
> +++ b/tests/qemu-iotests/219
> @@ -203,13 +203,13 @@ with iotests.FilePath('disk.img') as disk_path, \
>      # but related to this also automatic state transitions like job
>      # completion), but still get pause points often enough to avoid maki=
ng this
>      # test very slow, it's important to have the right ratio between spe=
ed and
> -    # buf_size.
> +    # copy-chunk-size.
>      #
> -    # For backup, buf_size is hard-coded to the source image cluster siz=
e (64k),
> -    # so we'll pick the same for mirror. The slice time, i.e. the granul=
arity
> -    # of the rate limiting is 100ms. With a speed of 256k per second, we=
 can
> -    # get four pause points per second. This gives us 250ms per iteratio=
n,
> -    # which should be enough to stay deterministic.
> +    # Chose 64k copy-chunk-size both for mirror (by buf_size) and backup=
 (by
> +    # x-max-chunk). The slice time, i.e. the granularity of the rate lim=
iting
> +    # is 100ms. With a speed of 256k per second, we can get four pause p=
oints
> +    # per second. This gives us 250ms per iteration, which should be eno=
ugh to
> +    # stay deterministic.

Don=E2=80=99t we also have to limit the number of workers to 1 so we actual=
ly
keep 250 ms per iteration instead of just finishing four requests
immediately, then pausing for a second?

>      test_job_lifecycle(vm, 'drive-mirror', has_ready=3DTrue, job_args=3D=
{
>          'device': 'drive0-node',
> @@ -226,6 +226,7 @@ with iotests.FilePath('disk.img') as disk_path, \
>                  'target': copy_path,
>                  'sync': 'full',
>                  'speed': 262144,
> +                'x-max-chunk': 65536,
>                  'auto-finalize': auto_finalize,
>                  'auto-dismiss': auto_dismiss,
>              })
>=20



--ApqzMzMtGqnJTrlqXQo5uCDwCdmtIeteo--

--CPSjUM4GhV0SSnh9O7Gx26tN74iTruM2u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8ZS8YACgkQ9AfbAGHV
z0CjUQf+O/28HTz8nr+pfcsPuU5NrRs0ohml8eJWr5/ZhTJGSrtCth9XVVOqpK/8
7OANDw+d/+f5P+97Ly2k/UNppphZZM6crrPzNVZ2m3Wj+s9oWktD043N8/a7jnlQ
c1Ul4Sf4Hya3/4w/eYe2nIbcmVew13IPRDc9QVhK4rsnY66EuzF7EFRE9Im28Qnn
J+njYmvMEnIrvx/KdEL3JRlVZTPSXh2dh43ciZmmSOCMcg67xdlTw1rosr7cVdj9
2ZoX8kN1TEYG4+8F38qnrTMJUkaWuGGTKEW1JumAX3sgwjF8kfVOF36Qoj1z4+fc
6BH3kWu5tbPGTKIPvOrghRfrAR8ZnQ==
=kNXH
-----END PGP SIGNATURE-----

--CPSjUM4GhV0SSnh9O7Gx26tN74iTruM2u--


