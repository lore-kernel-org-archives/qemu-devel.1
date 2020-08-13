Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FFFC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:04:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D4EE2078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 13:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zoy+oiC0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D4EE2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Ctp-0007ZE-OU
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 09:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k6Ct7-0006xq-Kz
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 09:03:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25112
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1k6Ct4-0007pZ-JP
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 09:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597323797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WhavqHbZq5OjZyxI/0s1yNDyuFu7VJIbzG2vx/IWY88=;
 b=Zoy+oiC0zCcjImfWOSopRXfNDwR9wId15oknZ16OKDL06gLZQ6TE04YTozziEV+NpZvEeF
 WwpabbOOB+J5cOGGLMnQ0HJrNmATk45tNXNGVZ+pHkjmPbJkk6eiQCqeclSiMsSuDWYWHM
 R3RSBbLKzcLFJSy6An2R79nHZdjJnTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-la61fUP4O2GFhnHz10pOUg-1; Thu, 13 Aug 2020 09:03:14 -0400
X-MC-Unique: la61fUP4O2GFhnHz10pOUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FD601DDE4;
 Thu, 13 Aug 2020 13:03:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-29.ams2.redhat.com
 [10.36.113.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3EC45C1A3;
 Thu, 13 Aug 2020 13:03:10 +0000 (UTC)
Subject: Re: [PATCH for-5.2 v3 1/3] migration: Add block-bitmap-mapping
 parameter
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200722080516.126147-1-mreitz@redhat.com>
 <20200722080516.126147-2-mreitz@redhat.com>
 <e5d25c70-3214-09fe-cc2c-0320b6f836ef@redhat.com>
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
Message-ID: <ba2913b3-e35e-bb3b-1643-ebc5fc84c458@redhat.com>
Date: Thu, 13 Aug 2020 15:03:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <e5d25c70-3214-09fe-cc2c-0320b6f836ef@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="coL2HZB91vtbMzfrNtpbgSBIaRra6c3yE"
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 02:03:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--coL2HZB91vtbMzfrNtpbgSBIaRra6c3yE
Content-Type: multipart/mixed; boundary="UXk2rBauPKu5GhsfKXA6kAmcXtJzWi7Ss"

--UXk2rBauPKu5GhsfKXA6kAmcXtJzWi7Ss
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.08.20 16:32, Eric Blake wrote:
> On 7/22/20 3:05 AM, Max Reitz wrote:
>> This migration parameter allows mapping block node names and bitmap
>> names to aliases for the purpose of block dirty bitmap migration.
>>
>> This way, management tools can use different node and bitmap names on
>> the source and destination and pass the mapping of how bitmaps are to be
>> transferred to qemu (on the source, the destination, or even both with
>> arbitrary aliases in the migration stream).
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 qapi/migration.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 104 ++++++++-
>> =C2=A0 migration/migration.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>> =C2=A0 migration/block-dirty-bitmap.c | 373 ++++++++++++++++++++++++++++=
-----
>> =C2=A0 migration/migration.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 30 +++
>> =C2=A0 monitor/hmp-cmds.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 30 +++
>> =C2=A0 5 files changed, 485 insertions(+), 55 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index d5000558c6..d7e953cd73 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -507,6 +507,44 @@
>> =C2=A0=C2=A0=C2=A0 'data': [ 'none', 'zlib',
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>> =C2=A0 +##
>> +# @BitmapMigrationBitmapAlias:
>> +#
>> +# @name: The name of the bitmap.
>> +#
>> +# @alias: An alias name for migration (for example the bitmap name on
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the opposite site).
>> +#
>> +# Since: 5.1
>=20
> 5.2, now, but I can touch that up if it is the only problem raised.

Yes, somehow I missed this, and amended it to 5.2 elsewhere...

>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases for the=
 purpose of dirty bitmap migration.=C2=A0 Such
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases may for=
 example be the corresponding names on the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opposite site.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The mapping mus=
t be one-to-one, and on the destination also
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 complete: On th=
e source, bitmaps on nodes where either the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap or the n=
ode is not mapped will be ignored.=C2=A0 In
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contrast, on th=
e destination, receiving a bitmap (by alias)
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from a node (by=
 alias) when either alias is not mapped will
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 result in an er=
ror.
>=20
> Grammar is a bit odd and it feels repetitive.=C2=A0 How about:
>=20
> The mapping must not provide more than one alias for a bitmap, nor reuse
> the same alias across multiple bitmaps in the same node.

This describes an injective function, as in, one-to-one.

> On the source,
> an omitted node or bitmap within a node will ignore those bitmaps. In
> contrast, on the destination, receiving a bitmap (by alias) from a node
> (by alias) when either alias is not mapped will result in an error.

This will need a rewrite anyway.  Because of Vladimir=E2=80=99s patches you
merged in rc2, it looks like it makes more sense now to ignore unknown
aliases on the destination.  So I=E2=80=99ll have to think up something new=
 anyway.

>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Note that the d=
estination does not know about bitmaps it
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 does not receiv=
e, so there is no limitation or requirement
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regarding the n=
umber of bitmaps received, or how they are
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 named, or on wh=
ich nodes they are placed.
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 By default (whe=
n this parameter has never been set), bitmap
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 names are mappe=
d to themselves.=C2=A0 Nodes are mapped to their
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 block device na=
me if there is one, and to their node name
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 otherwise. (Sin=
ce 5.2)
>=20
> Looks good.
>=20
>=20
>> @@ -781,6 +839,25 @@
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 will cons=
ume more CPU.
>> =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Defaults =
to 1. (Since 5.0)
>> =C2=A0 #
>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases for the=
 purpose of dirty bitmap migration.=C2=A0 Such
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 aliases may for=
 example be the corresponding names on the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opposite site.
>=20
> Ah, the joys of duplicated text.
>=20
>> +++ b/migration/block-dirty-bitmap.c
>=20
>> @@ -128,7 +131,8 @@ typedef struct DirtyBitmapMigState {
>> =C2=A0 =C2=A0 typedef struct DirtyBitmapLoadState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t flags;
>> -=C2=A0=C2=A0=C2=A0 char node_name[256];
>> +=C2=A0=C2=A0=C2=A0 char node_alias[256];
>> +=C2=A0=C2=A0=C2=A0 char bitmap_alias[256];
>=20
> Do we properly check that alias names will never overflow?

Hm, well.  There are assertions guarding against that, but they=E2=80=99re
assertions.

That=E2=80=99s an existing problem, actually.  If you give a bitmap a name
longer than 255 bytes, you run into the same failed assertion.

>> +static GHashTable *construct_alias_map(const
>> BitmapMigrationNodeAliasList *bbm,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 bool name_to_alias,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 GHashTable *alias_map;
>> +
>> +=C2=A0=C2=A0=C2=A0 alias_map =3D g_hash_table_new_full(g_str_hash, g_st=
r_equal,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 g_free,
>> free_alias_map_inner_node);
>> +
>> +=C2=A0=C2=A0=C2=A0 for (; bbm; bbm =3D bbm->next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const BitmapMigrationNodeAli=
as *bmna =3D bbm->value;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const BitmapMigrationBitmapA=
liasList *bmbal;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AliasMapInnerNode *amin;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GHashTable *bitmaps_map;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *node_map_from, *=
node_map_to;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!id_wellformed(bmna->ali=
as)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg(errp, "The node alias %s is not well-formed",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bmna->alias=
);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 fail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> Maybe id_wellformed should enforce lengths?=C2=A0 Otherwise, I'm not seei=
ng a
> length limit applied during the mapping process.

The limit is applied by qemu_put_counted_string(), but it=E2=80=99s enforce=
d via
assertion, so, yeah.  I=E2=80=99ll fix it.

(That=E2=80=99s going to be the easy part.  The harder part is fixing the
pre-existing issue, because we only see bitmap names once migration
starts. Thanks to the new permissive error policy (as in, no
configuration problem should ever produce errors during bitmap
migration), we then need to drop such bitmaps.)

> Modulo that, I think we're ready to go.

Unfortunately, no.  As Vladimir has pointed out, this will require a
hefty rebase now.

Max


--UXk2rBauPKu5GhsfKXA6kAmcXtJzWi7Ss--

--coL2HZB91vtbMzfrNtpbgSBIaRra6c3yE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl81OgwACgkQ9AfbAGHV
z0BVnQgAjFquQVxTh5JhQS7H4VDgJxUHANEs7PNgUiENIGT2SHaWkx8yK7/J1+QZ
yF03GzFjMbs/89QXsMrhA3iR9cvw8MOZtbzovyUy4CLKCRntxq7/4z2KXBNLlmso
EunycNsUv+5Op7PJ+u37cUSIbvVbQ4c4skq2b9JY9ApnsR710NVRPtK2blJ4PYe9
2ia9d7cAiBHo77RxUjfcOOm4oqHkLADaG79vBV8uItQhJzAznTxRnXyPemccoTGX
zNN87pNo1HB5afeF/AphXNBWMwl20lfQrAUhuI5STqc3mypZ0TnC15USszb1kvW4
LCQ3g9TIRM2goVZhcUxWKGYsat+BNw==
=aS1s
-----END PGP SIGNATURE-----

--coL2HZB91vtbMzfrNtpbgSBIaRra6c3yE--


