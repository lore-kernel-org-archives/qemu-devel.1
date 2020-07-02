Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C834C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:42:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 593C220760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZfCqDEpQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 593C220760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvjo-0003bh-Lh
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqvjC-0003Ax-Hd
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:41:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jqvj9-0004Ec-Ub
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593682914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=IMXMbyNF+bHSmZRv1X9s4wZHXgDmeCFowNLVnIiijuI=;
 b=ZfCqDEpQOphfGILF79TXFOe5okdmCGPicg0fCDvOWR8EfP8YW/cusNPgMDL447K97Yor78
 ydAFPyb3efcO7R/C4aRX0EavLA3z7U8u2O54AvII2Z06FhIonmC7qcWeuWet4fUzspiQcu
 EdhaagXkJ3JqBi1bADPpLq8WhjotimI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-ODmBm6eIP0WlorLqqQ2kSw-1; Thu, 02 Jul 2020 05:41:51 -0400
X-MC-Unique: ODmBm6eIP0WlorLqqQ2kSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 887D818A8221;
 Thu,  2 Jul 2020 09:41:42 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-196.ams2.redhat.com
 [10.36.113.196])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA25619C66;
 Thu,  2 Jul 2020 09:41:40 +0000 (UTC)
Subject: Re: [PATCH 2/4] migration: Add block-bitmap-mapping parameter
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200630084552.46362-1-mreitz@redhat.com>
 <20200630084552.46362-3-mreitz@redhat.com>
 <635e40aa-f289-da2f-274f-17c9d0e05003@virtuozzo.com>
 <02586cc8-138c-2bc8-c79a-cf3371a5afd4@redhat.com>
 <72cc50dd-d204-0de4-21cc-11d4d78f7c47@virtuozzo.com>
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
Message-ID: <889082d7-c917-ba7c-6da3-e854d8c44a32@redhat.com>
Date: Thu, 2 Jul 2020 11:41:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <72cc50dd-d204-0de4-21cc-11d4d78f7c47@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mreitz@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9xfmWceFuZaZ4ZeU5KiTr1qfb4UZLu7u4"
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mreitz@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
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
Cc: Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9xfmWceFuZaZ4ZeU5KiTr1qfb4UZLu7u4
Content-Type: multipart/mixed; boundary="Sh97Awi3zkRIIFNzJ6oNCfJ2GkxkPqXVD"

--Sh97Awi3zkRIIFNzJ6oNCfJ2GkxkPqXVD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.07.20 11:19, Vladimir Sementsov-Ogievskiy wrote:
> 02.07.2020 11:09, Max Reitz wrote:
>> On 01.07.20 16:34, Vladimir Sementsov-Ogievskiy wrote:
>>> 30.06.2020 11:45, Max Reitz wrote:
>>>> This migration parameter allows mapping block node names and bitmap
>>>> names to aliases for the purpose of block dirty bitmap migration.
>>>>
>>>> This way, management tools can use different node and bitmap names on
>>>> the source and destination and pass the mapping of how bitmaps are
>>>> to be
>>>> transferred to qemu (on the source, the destination, or even both with
>>>> arbitrary aliases in the migration stream).
>>>>
>>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>> ---
>>>> =C2=A0=C2=A0 qapi/migration.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 83 +++++++-
>>>> =C2=A0=C2=A0 migration/migration.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
>>>> =C2=A0=C2=A0 migration/block-dirty-bitmap.c | 372
>>>> ++++++++++++++++++++++++++++-----
>>>> =C2=A0=C2=A0 migration/migration.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 29 +++
>>>> =C2=A0=C2=A0 4 files changed, 432 insertions(+), 55 deletions(-)
>>>>
>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>> index d5000558c6..5aeae9bea8 100644
>>>> --- a/qapi/migration.json
>>>> +++ b/qapi/migration.json
>>>> @@ -507,6 +507,44 @@
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 'data': [ 'none', 'zlib',
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 { 'name': 'zstd', 'if': 'defined(CONFIG_ZSTD)' } ] }
>>>> =C2=A0=C2=A0 +##
>>>> +# @BitmapMigrationBitmapAlias:
>>>> +#
>>>> +# @name: The name of the bitmap.
>>>> +#
>>>> +# @alias: An alias name for migration (for example the bitmap name on
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the opposite site).
>>>> +#
>>>> +# Since: 5.1
>>>> +##
>>>> +{ 'struct': 'BitmapMigrationBitmapAlias',
>>>> +=C2=A0 'data': {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'name': 'str',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'alias': 'str'
>>>> +=C2=A0 } }
>>>> +
>>>> +##
>>>> +# @BitmapMigrationNodeAlias:
>>>> +#
>>>> +# Maps a block node name and the bitmaps it has to aliases for dirty
>>>> +# bitmap migration.
>>>> +#
>>>> +# @node-name: A block node name.
>>>> +#
>>>> +# @alias: An alias block node name for migration (for example the
>>>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node name on the op=
posite site).
>>>> +#
>>>> +# @bitmaps: Mappings for the bitmaps on this node.
>>>> +#
>>>> +# Since: 5.1
>>>> +##
>>>> +{ 'struct': 'BitmapMigrationNodeAlias',
>>>> +=C2=A0 'data': {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'node-name': 'str',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'alias': 'str',
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'bitmaps': [ 'BitmapMigrationBitmapAli=
as' ]
>>>
>>> So, we still can't migrate bitmaps from one node to different nodes,
>>> but we
>>> also don't know a usecase for it, so it seems OK. But with such
>>> scheme we
>>> can select and rename bitmaps in-flight, and Peter said about
>>> corresponding
>>> use-case.
>>>
>>> I'm OK with this, still, just an idea in my mind:
>>>
>>> we could instead just have a list of
>>>
>>> BitmapMigrationAlias: {
>>> =C2=A0=C2=A0node-name
>>> =C2=A0=C2=A0bitmap-name
>>> =C2=A0=C2=A0node-alias
>>> =C2=A0=C2=A0bitmap-alias
>>> }
>>>
>>> so, mapping is set for each bitmap in separate.
>>
>> Well, OK, but why?
>=20
> But why not :) Just thinking out loud. May be someone will imaging good
> reasons for it.

The reason for =E2=80=9CWhy not=E2=80=9D is that this code now exists. ;)

>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_=
hash_table_insert(bitmaps_map,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_strdup(bmap_map_from),
>>>> g_strdup(bmap_map_to));
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amin =3D g_new(AliasMapInn=
erNode, 1);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *amin =3D (AliasMapInnerNo=
de){
>>>
>>> style: space before '{'
>>
>> Is that required?
>=20
> If checkpatch doesn't complain, than not..

O:)

>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .s=
tring =3D g_strdup(node_map_to),
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .s=
ubtree =3D bitmaps_map,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_hash_table_insert(alias_=
map, g_strdup(node_map_from), amin);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return alias_map;
>>>> +
>>>> +fail:
>>>> +=C2=A0=C2=A0=C2=A0 g_hash_table_destroy(alias_map);
>>>> +=C2=A0=C2=A0=C2=A0 return NULL;
>>>> +}
>>>> +
>>>> +/**
>>>> + * Run construct_alias_map() in both directions to check whether @bbm
>>>> + * is valid.
>>>> + * (This function is to be used by migration/migration.c to validate
>>>> + * the user-specified block-bitmap-mapping migration parameter.)
>>>> + *
>>>> + * Returns true if and only if the mapping is valid.
>>>> + */
>>>> +bool check_dirty_bitmap_mig_alias_map(const
>>>> BitmapMigrationNodeAliasList *bbm,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 Error **errp)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 GHashTable *alias_map;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 alias_map =3D construct_alias_map(bbm, true, errp)=
;
>>>> +=C2=A0=C2=A0=C2=A0 if (!alias_map) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 g_hash_table_destroy(alias_map);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 alias_map =3D construct_alias_map(bbm, false, errp=
);
>>>> +=C2=A0=C2=A0=C2=A0 if (!alias_map) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0 g_hash_table_destroy(alias_map);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return true;
>>>> +}
>>>> +
>>>> =C2=A0=C2=A0 void init_dirty_bitmap_incoming_migration(void)
>>>> =C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_mutex_init(&finish_lock);
>>>> @@ -191,11 +351,11 @@ static void send_bitmap_header(QEMUFile *f,
>>>> DirtyBitmapMigBitmapState *dbms,
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_bitmap_flags(f, flags);
>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_M=
IG_FLAG_DEVICE_NAME) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_counted_string(f,=
 dbms->node_name);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_counted_string(f,=
 dbms->node_alias);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (flags & DIRTY_BITMAP_M=
IG_FLAG_BITMAP_NAME) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_counted_string(f,=
 bdrv_dirty_bitmap_name(bitmap));
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_put_counted_string(f,=
 dbms->bitmap_alias);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 @@ -263,15 +423,20 @@ static void dirty_bitmap_mig_cleanu=
p(void)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QSIMPLEQ_=
REMOVE_HEAD(&dirty_bitmap_mig_state.dbms_list,
>>>> entry);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirt=
y_bitmap_set_busy(dbms->bitmap, false);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_unre=
f(dbms->bs);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(dbms->node_alias);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(dbms->bitmap_alias)=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(db=
ms);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 =C2=A0 /* Called with iothread lock taken. */
>>>> -static int add_bitmaps_to_list(BlockDriverState *bs, const char
>>>> *bs_name)
>>>> +static int add_bitmaps_to_list(BlockDriverState *bs, const char
>>>> *bs_name,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GHashTable *alias_map)
>>>> =C2=A0=C2=A0 {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *bitmap;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DirtyBitmapMigBitmapState *dbms;
>>>> +=C2=A0=C2=A0=C2=A0 GHashTable *bitmap_aliases;
>>>
>>> can bitmap_aliases be const ptr too?
>>
>> Unfortunately no because g_hash_table_lookup() expects the hash table to
>> not be const, for whatever reason.
>>
>>>> +=C2=A0=C2=A0=C2=A0 const char *node_alias, *bitmap_name, *bitmap_alia=
s;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap =3D bdrv_dirty_bitm=
ap_first(bs);
>>>> @@ -279,21 +444,40 @@ static int add_bitmaps_to_list(BlockDriverState
>>>> *bs, const char *bs_name)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0 bitmap_name =3D bdrv_dirty_bitmap_nam=
e(bitmap);
>>>
>>> Note, that bitmap is wrong here: it may be internal unnamed bitmap whic=
h
>>> we should ignore.
>>> I have sent a patch for this: "[PATCH] migration/block-dirty-bitmap: fi=
x
>>> add_bitmaps_to_list"
>>>
>>>> +
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bs_name || strcmp(bs_name, "=
") =3D=3D 0) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_rep=
ort("Bitmap '%s' in unnamed node can't be
>>>> migrated",
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_name(=
bitmap));
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_name);
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0 if (bs_name[0] =3D=3D '#') {
>>>> +=C2=A0=C2=A0=C2=A0 if (alias_map) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const AliasMapInnerNode *a=
min =3D
>>>> g_hash_table_lookup(alias_map, bs_name);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!amin) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_report("Bitmap '%s' on node '%s' with no alias
>>>> cannot be "
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "migrated", bitmap_name, bs_name);
>>>
>>> As I've said before, it may be reasonable to ignore bitmaps not
>>> referenced in the hash-table.
>>
>> No problem with that.=C2=A0 We just decided on this behavior when we
>> discussed the RFC.
>=20
> Sorry for that. The reason for my changed opinion is a recent bug from
> customers about bitmap migration.

No problem.  (My original proposal was different still, where
non-specified mappings would default to the identity mapping.)

>>> And it seems to be good default behavior. We are really tired from
>>> problems with bitmaps which
>>> can't migrate for different reasons, when bitmaps are actually
>>> non-critical data, and choosing
>>> from customer problems like:
>>>
>>> =C2=A0=C2=A01. - Hey, after update migration is broken! It says that so=
me bitmaps
>>> can't be migrated, what is that?
>>> =C2=A0 =C2=A0=C2=A02. - Hmm, it seems, that in some cases, incremental =
backup
>>> doesn't work
>>> after migration and full backup
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is automatically done instead.. Wh=
y?
>>>
>>> I now prefer the [2].
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn -1;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node_alias =3D amin->strin=
g;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_aliases =3D amin->s=
ubtree;
>>>> +=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 node_alias =3D bs_name;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_aliases =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>
>>> Hmm, actually bs_name argument is incompatiblewith alias_map, let's
>>> assert that they are not non-null simultaneously.
>>>
>>> Ah stop, I see, you use bs_name as node-name later and before.. Hmm,
>>> seems all this a bit confused.
>>>
>>> Prior the patch, why do we have bs_name: because it may be node-name or
>>> blk-name, to be use in migration protocol as (actually) an alias, so
>>> bs_name is more like an alias..
>>>
>>> So, we have bs, which already have bs->node_name, we have alias_map,
>>> where we have relation node_name -> alias, and we have bs_name, which i=
s
>>> something like an alias_name.
>>>
>>> I think the most clean thing is to allow only one of bs_name and
>>> alias_map to be non-null, use bs_name only for old scenario, and for ne=
w
>>> scenario use bdrv_get_node_name() for error-reporting. And a comment
>>> about function semantics won't hurt.
>>>
>>> upd: aha, I see that in case of new semantics, bs_name is exactly
>>> bdrv_get_node_name(). It's a bit redundant but OK too.. Let's at least
>>> add an assertion.
>>
>> Now I=E2=80=99m confused.=C2=A0 What assertion?=C2=A0 I don=E2=80=99t th=
ink I want to add an
>> assertion that exactly one of bs_name or alias_map is NULL, because that
>> would complicate the code.=C2=A0 The caller would have to pass NULL for
>> bs_name, and then add_bitmaps_to_list() would need to fetch the node
>> name again.=C2=A0 That seems redundant to me.
>=20
> I mean something like
>=20
> =C2=A0=C2=A0 assert(!alias_map || !strcmp(alias_map, bdrv_get_node_name(b=
s));

Ah, OK, sure.  (with s/alias_map/bs_name/ in the strcmp(), I presume)

> I am afraid of interfaces with redundant parameters, it seems strange
> and unsafe to pass node_name together with bs, which has bs->node_name
> which is (and must be, in case of new semantics with alias_map) the same.
>=20
> Still, I don't mind keeping it as is, I can think of some refactoring
> (if any) later.
>=20
>>
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (node_alias[0] =3D=3D '#') {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_rep=
ort("Bitmap '%s' in a node with auto-generated "
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "name=
 '%s' can't be migrated",
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bdrv_dirty_bitmap_name(=
bitmap), bs_name);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_name, node_alias=
);
>>>
>>> OK, this should not relate to mapped case, as aliases are well-formed.
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -1=
;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FOR_EACH_DIRTY_BITMAP(bs, =
bitmap) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bdrv_dirty_bitmap_nam=
e(bitmap)) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitmap_name =3D bdrv_dirty=
_bitmap_name(bitmap);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!bitmap_name) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 continue;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 @@ -302,12 +486,24 @@ static int
>>>> add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return -1;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> =C2=A0=C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (bitmap_al=
iases) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bi=
tmap_alias =3D g_hash_table_lookup(bitmap_aliases,
>>>> bitmap_name);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (!bitmap_alias) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report("Bitmap '%s' with no alias on node '%s'
>>>> cannot be "
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 "migrated", bitmap_name, bs_name);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return -1;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bi=
tmap_alias =3D bitmap_name;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>
>>> Hmm, we don't error-out if we didn't find a bitmap, specified in
>>> alias-map. But it seems to be an error from the user point-of-view (the
>>> required action can't be done).
>>>
>>> So, probably, we want loop through the alias-map (and in this case we
>>> don't need a map, but can work with QAPI list), find corresponding
>>> bitmaps and migrate them, and fail if some specified in the alias-map
>>> bitmap is not found.
>>
>> Do we?
>>
>> I don=E2=80=99t consider setting an alias an action request like =E2=80=
=9CMigrate this
>> bitmap=E2=80=9D.=C2=A0 I just consider it establishing a mapping.=C2=A0 =
If some elements
>> are not used, so be it.
>=20
> OK. This non-strict behavior is in good relation with ignoring
> not-mapped bitmaps which I've proposed.

I think so, too.

> We can add any kind of restrictions as an option later.

Oh, yes, that, too.  Like you proposed in the RFC, we could add e.g. a
block-bitmap-mapping-strictness migration parameter at a later point if
there=E2=80=99s a use for something like it.

>> I don=E2=80=99t know if doing it differently would actually be beneficia=
l for
>> anyone, but OTOH naively it seems like a more invasive code change.
>>
>=20
> I don't see real benefits, we can go either way, so, not worth rewriting
> the patch.
>=20
> =3D=3D=3D
>=20
> I feel like a stupid reviewer :)

Huh?  If anything, a stupid review on a design-changing patch would be a
plain =E2=80=9CR-b=E2=80=9D without having actually considered the impact. =
 You do
consider the impact and question it in all places.

I don=E2=80=99t think I need to mention this, but that=E2=80=99s a very goo=
d and
important thing to do, because it forces me to reason why we=E2=80=99d want=
 this
or that design.  Without being questioned, I wouldn=E2=80=99t have to reaso=
n
about that.  (Which may be a problem in our patch workflow =E2=80=93 author=
s
don=E2=80=99t need to reason unless questioned.[1])

Sorry if I gave the impression of dismissing your comments.  It should
be my burden to reason why I took certain design decisions.

Max


[1] I suppose I should address this for my own patches by meticulously
writing down everything where I had to question myself and then always
include my reasoning in the patch notes somewhere.


--Sh97Awi3zkRIIFNzJ6oNCfJ2GkxkPqXVD--

--9xfmWceFuZaZ4ZeU5KiTr1qfb4UZLu7u4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl79q9MACgkQ9AfbAGHV
z0CVaQf5AR0w/3q+2tKECBSkK8GzKveN0mETrIN1RaU9/+32Vm2W9vfZGMSXYn19
oHB4TpkTQmVzpgbMc29FSk9iBxz/bto8odmJ/Xwf2FWHcLO409WA9CGrAO0Fzssm
UosE11QN9uayTyyxJVMZ8O7tk3UyD+EvZOM9FiWZVnx6U3Lw1TfQ+cd2H1dKnd2f
ihWPlKS9idR9tt5smftK4NbSjYh7czPh/espWocntOHegCQsVuh65L4B4ZDyk8Zv
m2GBTqPhrrIHHFOHHZxlj0UH1L23vCMM+Q2RUlasUMUpSqqAd03PTHCUg/x9eBDH
qlalAUlAtN0vRPiGfOnh6hPGW0nBMg==
=LvBQ
-----END PGP SIGNATURE-----

--9xfmWceFuZaZ4ZeU5KiTr1qfb4UZLu7u4--


