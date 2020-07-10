Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B716AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84A7720775
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYahxMXp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84A7720775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpkG-0006GL-Oc
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtpja-0005kG-52
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:54:22 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29377
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jtpjY-0007Lv-Dg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594374859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=8eGLoQa4dm6i0nOCvSOj+3ZdTrYTLE9dC6C/38ulHdM=;
 b=ZYahxMXpnh1excHnator0CKKGiC3qMP3FO7k3gcKBlIRINyvTP/dwr4ZRSd69dzT5BaqfJ
 2HLaDuumclXJOORxOxyQRwD5C2Qk2hxFocFcoFszULRZ9/3N2znW1dquEcV4eaIoxwnmlr
 vqLBCb7RC2We4Oz+Df33ippqf18YzEM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-344-kZg37tVwNh-HmPAs6CmWVQ-1; Fri, 10 Jul 2020 05:54:16 -0400
X-MC-Unique: kZg37tVwNh-HmPAs6CmWVQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32418100AA21;
 Fri, 10 Jul 2020 09:54:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-127.ams2.redhat.com
 [10.36.113.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 14D5B19D7E;
 Fri, 10 Jul 2020 09:54:13 +0000 (UTC)
Subject: Re: [PULL 18/31] block/core: add generic infrastructure for
 x-blockdev-amend qmp command
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200706100432.2301919-1-mreitz@redhat.com>
 <20200706100432.2301919-19-mreitz@redhat.com>
 <CAFEAcA_2ysWK=fs4E422uVBjRe6qT6cAec5Haahb-uuZpafNOg@mail.gmail.com>
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
Message-ID: <0ee8065c-2004-e188-4918-7f8c9017fb47@redhat.com>
Date: Fri, 10 Jul 2020 11:54:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_2ysWK=fs4E422uVBjRe6qT6cAec5Haahb-uuZpafNOg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Hm6YG1cLqAalEtYOOp0GDxcQjJP72193N"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 22:08:55
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hm6YG1cLqAalEtYOOp0GDxcQjJP72193N
Content-Type: multipart/mixed; boundary="6Z2CjAuCZ4R7rWOvlJPdnC1afHi1WjfRb"

--6Z2CjAuCZ4R7rWOvlJPdnC1afHi1WjfRb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.07.20 17:09, Peter Maydell wrote:
> On Mon, 6 Jul 2020 at 11:05, Max Reitz <mreitz@redhat.com> wrote:
>>
>> From: Maxim Levitsky <mlevitsk@redhat.com>
>>
>> blockdev-amend will be used similiar to blockdev-create
>> to allow on the fly changes of the structure of the format based block d=
evices.
>>
>> Current plan is to first support encryption keyslot management for luks
>> based formats (raw and embedded in qcow2)
>>
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Message-Id: <20200608094030.670121-12-mlevitsk@redhat.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> Hi; Coverity reports a possible issue with this function
> (CID 1430268):

Thanks for the heads-up, I=E2=80=99ve sent a patch (=E2=80=9Cblock/amend: C=
heck whether
the node exists=E2=80=9D).

>> +void qmp_x_blockdev_amend(const char *job_id,
>> +                          const char *node_name,
>> +                          BlockdevAmendOptions *options,
>> +                          bool has_force,
>> +                          bool force,
>> +                          Error **errp)
>> +{
>> +    BlockdevAmendJob *s;
>> +    const char *fmt =3D BlockdevDriver_str(options->driver);
>> +    BlockDriver *drv =3D bdrv_find_format(fmt);
>> +    BlockDriverState *bs =3D bdrv_find_node(node_name);
>=20
> bdrv_find_node() can return NULL (we check for this
> in almost all callsites)...
>=20
>> +    if (bs->drv !=3D drv) {
>=20
> ...but here we dereference it unconditionally.
>=20
>> +        error_setg(errp,
>> +                   "x-blockdev-amend doesn't support changing the block=
 driver");
>> +        return;
>> +    }
>=20
> thanks
> -- PMM
>=20



--6Z2CjAuCZ4R7rWOvlJPdnC1afHi1WjfRb--

--Hm6YG1cLqAalEtYOOp0GDxcQjJP72193N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl8IOsMACgkQ9AfbAGHV
z0DocQf/f4PM81m+Rg8ypM2F1YDzc9VYIjfJ1tCPShYQEE5m8GSRSx0vFSCfggyG
2IuZPKQ2IQwf55uSNQe2ysDMQ/I9EtZwnGJ4QwF+qeUapSTjdSUQd+mqvRPuKgJJ
8ZfqaV5A3URxX/TIo6Kok5SBsRE6YlcL+HzdzQeh6edLpI0HrUurkdWO1MsAjMyf
Otpuj/480kt863m0D3cxKWwBxX016D+rNCf+zDBhJbjA2cW0fGHcW+y/2xDN73tX
2ud78QspAPocOaAXKRcs1Y9p0R6SQ9J58PAvs3gCgWOwS23NE2nAVskl2MOcfKRg
WdRjBiR44uP0lViIrhOl30CJcfmiow==
=JQkr
-----END PGP SIGNATURE-----

--Hm6YG1cLqAalEtYOOp0GDxcQjJP72193N--


