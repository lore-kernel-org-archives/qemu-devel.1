Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0DBC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 07:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E49C206BE
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 07:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgqsvQ9c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E49C206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZ8XE-0002Vq-Ar
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 03:44:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZ8Wd-00020j-4n
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:43:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52047
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jZ8Wb-0008UD-4H
 for qemu-devel@nongnu.org; Thu, 14 May 2020 03:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589442203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wClWG2b4KEx+33FxZIo29iYWD/5FOVZTtenAYze0vps=;
 b=NgqsvQ9cZBMPNi7Cvj94lRWOlX7vcQ6RGuWU74JvngtltCM0Is7squFj4PeeqXES3BjOAa
 SXkwC1tfkUOxYtklLbs0daqEe2O3Jz6u8tLSR+M5iDDfJXJexucxvo0otUnVR4TxVOoreI
 js1qCoLhBcY6BINzxxrJ+qxc4/FCRVg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-Z7kTByWRPsCMTrl_mwIJnA-1; Thu, 14 May 2020 03:42:58 -0400
X-MC-Unique: Z7kTByWRPsCMTrl_mwIJnA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B233461;
 Thu, 14 May 2020 07:42:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 47EE360C05;
 Thu, 14 May 2020 07:42:55 +0000 (UTC)
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <20200513145610.1484567-1-mreitz@redhat.com>
 <6a82008b-d272-82f2-a8a1-615437abcda7@virtuozzo.com>
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
Message-ID: <17a0ed56-7f34-b137-7aa4-3ad5a02da8c0@redhat.com>
Date: Thu, 14 May 2020 09:42:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6a82008b-d272-82f2-a8a1-615437abcda7@virtuozzo.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ZNSvblIIByERjzz0qWzwuomLopdIAullh"
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 22:25:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Krempa <pkrempa@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ZNSvblIIByERjzz0qWzwuomLopdIAullh
Content-Type: multipart/mixed; boundary="VhW63HxtkoEZVkIdjSrpqw10aBB47sYJ5"

--VhW63HxtkoEZVkIdjSrpqw10aBB47sYJ5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.05.20 22:09, Vladimir Sementsov-Ogievskiy wrote:
> 13.05.2020 17:56, Max Reitz wrote:
>> This command allows mapping block node names to aliases for the purpose
>> of block dirty bitmap migration.
>>
>> This way, management tools can use different node names on the source
>> and destination and pass the mapping of how bitmaps are to be
>> transferred to qemu (on the source, the destination, or even both with
>> arbitrary aliases in the migration stream).
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> Branch: https://github.com/XanClic/qemu.git
>> migration-bitmap-mapping-rfc-v2
>> Branch: https://git.xanclic.moe/XanClic/qemu.git
>> migration-bitmap-mapping-rfc-v2
>>
>> (Sorry, v1 was just broken.=C2=A0 This one should work better.)
>>
>> Vladimir has proposed something like this in April:
>> https://lists.nongnu.org/archive/html/qemu-block/2020-04/msg00171.html
>>
>> Now I=E2=80=99ve been asked by my manager to look at this, so I decided =
to just
>> write a patch to see how it=E2=80=99d play out.
>=20
> Great! Sometimes I remember about this thing, but never start
> implementing :)
>=20
>>
>> This is an RFC, because I=E2=80=99d like to tack on tests to the final v=
ersion,
>> but I=E2=80=99m not sure whether I can come up with something before the=
 end of
>> the week (and I=E2=80=99ll be on PTO for the next two weeks).
>>
>> Also, I don=E2=80=99t know whether migration/block-dirty-bitmap.c is the=
 best
>> place to put qmp_migrate_set_bitmap_mapping(), but it appears we already
>> have some QMP handlers in migration/, so I suppose it isn=E2=80=99t too =
bad.
>> ---
>> =C2=A0 qapi/migration.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 36 ++++++++++++++++++++
>> =C2=A0 migration/block-dirty-bitmap.c | 60 +++++++++++++++++++++++++++++=
+++--
>> =C2=A0 2 files changed, 94 insertions(+), 2 deletions(-)
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index d5000558c6..97037ea635 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -1621,3 +1621,39 @@
>> =C2=A0 ##
>> =C2=A0 { 'event': 'UNPLUG_PRIMARY',
>> =C2=A0=C2=A0=C2=A0 'data': { 'device-id': 'str' } }
>> +
>> +##
>> +# @MigrationBlockNodeMapping:
>> +#
>> +# Maps a block node name to an alias for migration.
>> +#
>> +# @node-name: A block node name.
>> +#
>> +# @alias: An alias name for migration (for example the node name on
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the opposite site).
>> +#
>> +# Since: 5.1
>> +##
>> +{ 'struct': 'MigrationBlockNodeMapping',
>> +=C2=A0 'data': {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'node-name': 'str',
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'alias': 'str'
>> +=C2=A0 } }
>> +
>> +##
>> +# @migrate-set-bitmap-node-mapping:
>> +#
>> +# Maps block node names to arbitrary aliases for the purpose of dirty
>> +# bitmap migration.=C2=A0 Such aliases may for example be the correspon=
ding
>> +# node names on the opposite site.
>> +#
>> +# By default, every node name is mapped to itself.
>> +#
>> +# @mapping: The mapping; must be one-to-one, but not necessarily
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 complete.=
=C2=A0 Any mapping not given will be reset to the
>> +#=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 default (=
i.e. the identity mapping).
>> +#
>> +# Since: 5.1
>> +##
>> +{ 'command': 'migrate-set-bitmap-node-mapping',
>> +=C2=A0 'data': { 'mapping': ['MigrationBlockNodeMapping'] } }
>=20
> Hm. I like it, it's simpler and clearer than what I was thinking about.
>=20
> 1. So, you decided to make only node-mapping, not bitmap-mapping, so we
> can't rename bitmaps in-flight and can't migrate bitmaps from one node
> to several and visa-versa. I think it's OK, nothing good in such
> possibilities, and this simplifies things.

If it turns out that we=E2=80=99d want it, I suppose we can also still alwa=
ys
extend MigrationBlockNodeMapping by another mapping array for bitmaps.

> 2. If I understand correctly, default to node-name matching doesn't make
> real sense for libvirt.. But on the other hand, libvirt should not be
> considered as the ony user of Qemu. Still, the default seems unsafe..
> Could we make it optional? Or add an option to disable this default for
> absolutely strict behavior?

It was my understanding that libvirt (which should know about all
bitmaps on all nodes) would and could ensure itself that all nodes are
mapped according to what it needs.  (But that=E2=80=99s why Peter is CC=E2=
=80=99d, to
get his input.)

But your idea seems simple, so why not.

> May be, add a parameter
>=20
> fallback: node-name | error | drop
>=20
> where
> =C2=A0 node-name: use node-name as an alias, if found bitmap on the node =
not
> mentioned in @mapping [should not be useful for libvirt, but may be for
> others]
> =C2=A0 error: just error-out if such bitmap found [libvirt should use it,=
 I
> propose it as a default value for @fallback]

You mean error out during migration?  Hm.  I suppose that=E2=80=99s OK, if =
some
mapping erroneously isn=E2=80=99t set and the node name doesn=E2=80=99t exi=
st in the
destination, we=E2=80=99ll error out, too, so...

Shouldn=E2=80=99t be too difficult to implement, just put the enum in
dirty_bitmap_mig_state, and then do what it says when no entry can be
found in the mapping QDict.

> =C2=A0 drop: just ignore such bitmap - it will be lost [just and idea, I
> doubt that it is really useful]
>=20
> =3D=3D=3D=3D=3D=3D=3D
>=20
> Also, we should understand (and document here), that default behavior of
> this command and default behavior of bitmap migration (without this
> command) are different things:
>=20
> if command is not called, device names may be used instead of node-names.

Ah, yes.  Well, that=E2=80=99s actually a real problem with my current
implementation then, too, because...

>> diff --git a/migration/block-dirty-bitmap.c
>> b/migration/block-dirty-bitmap.c
>> index 7eafface61..73f400e7ea 100644
>> --- a/migration/block-dirty-bitmap.c
>> +++ b/migration/block-dirty-bitmap.c
>=20
> conflicts with my series "[PATCH v2 00/22] Fix error handling during
> bitmap postcopy"..Still, not too difficult to rebase my series if this
> goes first.
>=20
>> @@ -73,6 +73,8 @@
>> =C2=A0 #include "qemu/hbitmap.h"
>> =C2=A0 #include "qemu/cutils.h"
>> =C2=A0 #include "qapi/error.h"
>> +#include "qapi/qapi-commands-migration.h"
>> +#include "qapi/qmp/qdict.h"
>> =C2=A0 #include "trace.h"
>> =C2=A0 =C2=A0 #define CHUNK_SIZE=C2=A0=C2=A0=C2=A0=C2=A0 (1 << 10)
>> @@ -121,6 +123,9 @@ typedef struct DirtyBitmapMigState {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool bulk_completed;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool no_bitmaps;
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 QDict *node_in_mapping;
>> +=C2=A0=C2=A0=C2=A0 QDict *node_out_mapping;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* for send_bitmap_bits() */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BlockDriverState *prev_bs;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BdrvDirtyBitmap *prev_bitmap;
>> @@ -281,8 +286,13 @@ static int init_dirty_bitmap_migration(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.no_bitmaps =3D fal=
se;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (bs =3D bdrv_next_all_states(N=
ULL); bs; bs =3D
>> bdrv_next_all_states(bs)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const QDict *map =3D dirty_b=
itmap_mig_state.node_out_mapping;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *name =
=3D bdrv_get_device_or_node_name(bs);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (map) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name=
 =3D qdict_get_try_str(map, name) ?: name;

@name may be a device name, so it doesn=E2=80=99t match the interface
description.  We must use the node name for the map.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FOR_EACH_DIRTY_BI=
TMAP(bs, bitmap) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (!bdrv_dirty_bitmap_name(bitmap)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
>> @@ -600,6 +610,8 @@ static int dirty_bitmap_load_bits(QEMUFile *f,
>> DirtyBitmapLoadState *s)
>> =C2=A0 =C2=A0 static int dirty_bitmap_load_header(QEMUFile *f,
>> DirtyBitmapLoadState *s)
>> =C2=A0 {
>> +=C2=A0=C2=A0=C2=A0 const QDict *map =3D dirty_bitmap_mig_state.node_in_=
mapping;
>> +=C2=A0=C2=A0=C2=A0 const char *mapped_node =3D "(none)";
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *local_err =3D NULL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool nothing;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->flags =3D qemu_get_bitmap_flags(f);
>> @@ -612,7 +624,13 @@ static int dirty_bitmap_load_header(QEMUFile *f,
>> DirtyBitmapLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report("Unable to read node name string");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bs =3D bdrv_lookup_bs(s->=
node_name, s->node_name, &local_err);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapped_node =3D s->node_name=
;
>=20
> I think, we can rename s->node_name to alias.. as well as in other
> places in the code, including migration format specification in the
> comment at file top.

Why not.

>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (map) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mapp=
ed_node =3D qdict_get_try_str(map, mapped_node) ?:
>> mapped_node;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->bs =3D bdrv_lookup_bs(map=
ped_node, mapped_node, &local_err);
>=20
> Should we search by device name? I think, that if command set-mapping
> was called, it means that user is node-name oriented, and we should work
> only with node-names.

Yes, we shouldn=E2=80=99t.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->bs) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report_err(local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
>> @@ -634,7 +652,7 @@ static int dirty_bitmap_load_header(QEMUFile *f,
>> DirtyBitmapLoadState *s)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!s->bitmap &&=
 !(s->flags & DIRTY_BITMAP_MIG_FLAG_START)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 error_report("Error: unknown dirty bitmap "
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 "'%s' for block device '%s'",
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 s->bitmap_name, s->node_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 s->bitmap_name, mapped_node);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (!s->bitmap && !nothing) {
>> @@ -713,6 +731,44 @@ static bool dirty_bitmap_has_postcopy(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> =C2=A0 }
>> =C2=A0 +void
>> qmp_migrate_set_bitmap_node_mapping(MigrationBlockNodeMappingList
>> *mapping,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> +{
>=20
> Ok, so, here we don't check existing of the nodes or bitmaps in them,
> and the command may safely called before creating referenced nodes. It's
> only mapping, nothing more.

Yes.  That seemed simpler to me than, say, look up the BDSs and take
references on them (and keep them until migration).  I=E2=80=99m not sure
whether that=E2=80=99s an interface we=E2=80=99d want in the block layer (b=
ecause there
node names are to reference nodes at the time of invoking the command),
but this isn=E2=80=99t really the block layer, so I think/hope it should be=
 fine.

Max

>> +=C2=A0=C2=A0=C2=A0 QDict *in_mapping =3D qdict_new();
>> +=C2=A0=C2=A0=C2=A0 QDict *out_mapping =3D qdict_new();
>> +
>> +=C2=A0=C2=A0=C2=A0 for (; mapping; mapping =3D mapping->next) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MigrationBlockNodeMapping *e=
ntry =3D mapping->value;
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qdict_haskey(out_mapping=
, entry->node_name)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg(errp, "Cannot map node name '%s' twice",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry->node=
_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 fail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (qdict_haskey(in_mapping,=
 entry->alias)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg(errp, "Cannot use alias '%s' twice",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry->alia=
s);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto=
 fail;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdict_put_str(in_mapping, en=
try->alias, entry->node_name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qdict_put_str(out_mapping, e=
ntry->node_name, entry->alias);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 qobject_unref(dirty_bitmap_mig_state.node_in_mapping=
);
>> +=C2=A0=C2=A0=C2=A0 qobject_unref(dirty_bitmap_mig_state.node_out_mappin=
g);
>> +
>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.node_in_mapping =3D in_mappin=
g;
>> +=C2=A0=C2=A0=C2=A0 dirty_bitmap_mig_state.node_out_mapping =3D out_mapp=
ing;
>> +
>> +=C2=A0=C2=A0=C2=A0 return;
>> +
>> +fail:
>> +=C2=A0=C2=A0=C2=A0 qobject_unref(in_mapping);
>> +=C2=A0=C2=A0=C2=A0 qobject_unref(out_mapping);
>> +}
>> +
>> =C2=A0 static SaveVMHandlers savevm_dirty_bitmap_handlers =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .save_setup =3D dirty_bitmap_save_setup,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .save_live_complete_postcopy =3D dirty_bi=
tmap_save_complete,
>>
>=20
>=20



--VhW63HxtkoEZVkIdjSrpqw10aBB47sYJ5--

--ZNSvblIIByERjzz0qWzwuomLopdIAullh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl689n0ACgkQ9AfbAGHV
z0BUMQf/W6yy/s0RBXoTYJmCZeCUsxGLDbCn0hofa/x7sVgNB/hCMLpbDpAhgsef
XLLzljoUC3hmo9LVjR8+ZAJl/Ght4oJhj9oWLBkHwdZGa4yqkvv+GlN10tak+LQR
dSxSd7Y5qZdhIL6FN4UmXlXJzzHFy365pOut4GZu+YAb5eXmcwl1tQRtRqe2NnJh
q10ihbS9l4TkvkNi22LKK8Iz/Rd59j6tBJ+c3kimebBqp8EwPQJZfdaODIWcC1XU
SXaf1lJP+FbNKtmTdnOpBTIYnmhUpgQMPzfL+4+1DjQEB/rCNC+cCTZDrLlBbXXR
J5Vx8HQ6Yd0idQ4wVKDkZwIxpWPl4Q==
=PNIP
-----END PGP SIGNATURE-----

--ZNSvblIIByERjzz0qWzwuomLopdIAullh--


