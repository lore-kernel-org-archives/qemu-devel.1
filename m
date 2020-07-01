Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FC3C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C572E20722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 10:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KK65wvPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C572E20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqa59-0000Cu-2R
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 06:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqa4N-0007YK-Fs
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:34:23 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40345
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqa4J-0007iP-Rn
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 06:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593599658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/+QkqWntUdceKOX2lCUvFfY2gHKTSUOlpvTc6VepH0w=;
 b=KK65wvPy3PubYNjTrpKwG4ZuPq74AQlj4HZTilEwJab7YOrnkwwqs8NUZsF6KZlt+jVvwI
 tgZdpN7TnzGwfNoFEIyTh+hDUiSwiDBzkhpvywKexrwnA5LtPLQpuIoD3iXmb8Lmnf/KZO
 W4g2OFAXXovggeaOlK0CrdLj2Y5XXnc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-HCq-lo1QN32dpmIDdLcaVw-1; Wed, 01 Jul 2020 06:34:16 -0400
X-MC-Unique: HCq-lo1QN32dpmIDdLcaVw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 873FEBFC0;
 Wed,  1 Jul 2020 10:34:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-108.ams2.redhat.com
 [10.36.113.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C49CD60C81;
 Wed,  1 Jul 2020 10:34:12 +0000 (UTC)
Subject: Re: [PATCH 2/4] migration: Add block-bitmap-mapping parameter
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-3-mreitz@redhat.com> <20200630105121.GD2673@work-vm>
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
Message-ID: <a6a3d41c-6bfa-3341-14f1-c2de9cbd1531@redhat.com>
Date: Wed, 1 Jul 2020 12:34:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630105121.GD2673@work-vm>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JzrBUrA5WzsRlMvCvepIpBBG4E0ehuIXZ"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 01:05:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JzrBUrA5WzsRlMvCvepIpBBG4E0ehuIXZ
Content-Type: multipart/mixed; boundary="ZL5ThtGWWqWwA6YnwW6wCnhWBne8pb9um"

--ZL5ThtGWWqWwA6YnwW6wCnhWBne8pb9um
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 30.06.20 12:51, Dr. David Alan Gilbert wrote:
> * Max Reitz (mreitz@redhat.com) wrote:
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
>>  qapi/migration.json            |  83 +++++++-
>>  migration/migration.h          |   3 +
>>  migration/block-dirty-bitmap.c | 372 ++++++++++++++++++++++++++++-----
>>  migration/migration.c          |  29 +++
>>  4 files changed, 432 insertions(+), 55 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index d5000558c6..5aeae9bea8 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -507,6 +507,44 @@
>>    'data': [ 'none', 'zlib',
>>              { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>> =20
>> +##
>> +# @BitmapMigrationBitmapAlias:
>> +#
>> +# @name: The name of the bitmap.
>> +#
>> +# @alias: An alias name for migration (for example the bitmap name on
>> +#         the opposite site).
>> +#
>> +# Since: 5.1
>> +##
>> +{ 'struct': 'BitmapMigrationBitmapAlias',
>> +  'data': {
>> +      'name': 'str',
>> +      'alias': 'str'
>> +  } }
>> +
>> +##
>> +# @BitmapMigrationNodeAlias:
>> +#
>> +# Maps a block node name and the bitmaps it has to aliases for dirty
>> +# bitmap migration.
>> +#
>> +# @node-name: A block node name.
>> +#
>> +# @alias: An alias block node name for migration (for example the
>> +#         node name on the opposite site).
>> +#
>> +# @bitmaps: Mappings for the bitmaps on this node.
>> +#
>> +# Since: 5.1
>> +##
>> +{ 'struct': 'BitmapMigrationNodeAlias',
>> +  'data': {
>> +      'node-name': 'str',
>> +      'alias': 'str',
>> +      'bitmaps': [ 'BitmapMigrationBitmapAlias' ]
>> +  } }
>> +
>>  ##
>>  # @MigrationParameter:
>>  #
>> @@ -641,6 +679,18 @@
>>  #          will consume more CPU.
>>  #          Defaults to 1. (Since 5.0)
>>  #
>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>> +#          aliases for the purpose of dirty bitmap migration.  Such
>> +#          aliases may for example be the corresponding names on the
>> +#          opposite site.
>> +#          The mapping must be one-to-one and complete: On the source,
>> +#          migrating a bitmap from a node when either is not mapped
>> +#          will result in an error.  On the destination, similarly,
>> +#          receiving a bitmap (by alias) from a node (by alias) when
>> +#          either alias is not mapped will result in an error.
>> +#          By default, all node names and bitmap names are mapped to
>> +#          themselves. (Since 5.1)
>> +#
>>  # Since: 2.4
>>  ##
>>  { 'enum': 'MigrationParameter',
>> @@ -655,7 +705,8 @@
>>             'multifd-channels',
>>             'xbzrle-cache-size', 'max-postcopy-bandwidth',
>>             'max-cpu-throttle', 'multifd-compression',
>> -           'multifd-zlib-level' ,'multifd-zstd-level' ] }
>> +           'multifd-zlib-level' ,'multifd-zstd-level',
>> +           'block-bitmap-mapping' ] }
>> =20
>>  ##
>>  # @MigrateSetParameters:
>> @@ -781,6 +832,18 @@
>>  #          will consume more CPU.
>>  #          Defaults to 1. (Since 5.0)
>>  #
>> +# @block-bitmap-mapping: Maps block nodes and bitmaps on them to
>> +#          aliases for the purpose of dirty bitmap migration.  Such
>> +#          aliases may for example be the corresponding names on the
>> +#          opposite site.
>> +#          The mapping must be one-to-one and complete: On the source,
>> +#          migrating a bitmap from a node when either is not mapped
>> +#          will result in an error.  On the destination, similarly,
>> +#          receiving a bitmap (by alias) from a node (by alias) when
>> +#          either alias is not mapped will result in an error.
>> +#          By default, all node names and bitmap names are mapped to
>> +#          themselves. (Since 5.1)
>> +#
>>  # Since: 2.4
>>  ##
>>  # TODO either fuse back into MigrationParameters, or make
>> @@ -811,7 +874,8 @@
>>              '*max-cpu-throttle': 'int',
>>              '*multifd-compression': 'MultiFDCompression',
>>              '*multifd-zlib-level': 'int',
>> -            '*multifd-zstd-level': 'int' } }
>> +            '*multifd-zstd-level': 'int',
>> +            '*block-bitmap-mapping': [ 'BitmapMigrationNodeAlias' ] } }
>=20
> That's a hairy type for a migration parameter!
> I'm curious what 'info migrate_parameters' does in hmp or what happens
> if you try and set it?

Oh.  I didn=E2=80=99t know these were accessible via HMP.

As for setting it, that fails an assertion because I thus forgot to
handle it in hmp_migrate_set_parameter().  I think the best thing to do
would be to just error out, stating that you cannot set that parameter
via HMP.

Similarly, info migrate_parameters doesn=E2=80=99t suport it, because I did=
n=E2=80=99t
implement it in hmp_info_migrate_parameters().  Since
hmp_info_migrate_parameters() seems to allow free-form reporting, I
suppose we could report it as:

block-bitmap-mapping:
  node1 -> alias1
    bitmap1 -> bmap-alias1
    bitmap2 -> bmap-alias2
  node2 -> alias2
    bitmap1 -> bmap-alias1

etc.

Or we just don=E2=80=99t report it there (apart from maybe =E2=80=9C(presen=
t)=E2=80=9D), because
you can=E2=80=99t set it via migrate_set_parameter.


If there=E2=80=99s any problem with exposing this via the migration paramet=
ers,
I have no problem with adding a new QMP command as I did in the RFC.  I
was just pointed towards the migration parameters by reviewers, which
made sense to me, because, well, this kind of is a migration parameter.

Max


--ZL5ThtGWWqWwA6YnwW6wCnhWBne8pb9um--

--JzrBUrA5WzsRlMvCvepIpBBG4E0ehuIXZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl78ZqIACgkQ9AfbAGHV
z0BnWQf+Mz5MmZ4mkuUco7ig2sKZypRdT5iQc4okvI9HKtx/Qb0x5GP3Gqcf7JKR
+nLD7HIHcwLTnk8BmZib79el3DgqH5+Qmjy32JJDYr+M5+oXR42OD6BDM+SqZyQP
Zb64UnGk21DPSIuFbYQwdIgAlt1X/G3aWAF6dBWb8dBdgSFOmqGmPEvUhFDl4+dp
2U1x28rlxCUCTTJaiHTUDGLsmii8ZWZ2GI8odo6qC8v/BSBHPhtfKJeClTxqIE0t
QDifLNerNVcR99nUZ5+oBf9u8Lk+NcS4OJU3qqycn1ssFyA7BXXl8l3dN0G70OSy
NtDy93DQQxN1lChPFQGRGp6RxNRGPw==
=Z725
-----END PGP SIGNATURE-----

--JzrBUrA5WzsRlMvCvepIpBBG4E0ehuIXZ--


