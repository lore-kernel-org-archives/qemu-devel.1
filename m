Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22D6C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9217420730
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 15:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OsTd/eS3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9217420730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyzxT-0000i0-QW
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 10:17:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36932)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iyzwV-0008Gi-5W
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iyzwU-0005lS-0z
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:16:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28382
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iyzwT-0005fN-TZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 10:16:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580829405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L8CrNrhBDrEK7OFjhoGeldkhzYhJDK7VVrXkAcE3CJU=;
 b=OsTd/eS3CJsChxDSlDN0zAdrAPUdc7OmmOdqZyWEHrkhhZFDCq9jMJCR60yz4AFbvmGjbH
 C5oiSrY3B80KetI+SF/83y2kVvRQ2OHllPhnzNi31Ux0Gm4hJGn/DKuA07Z/MWmlQzKuwR
 zA6dGGeEoHk1aq6cKLnwgy70bHvSj58=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-7S1ry94oND6CGTZU5I85Fg-1; Tue, 04 Feb 2020 10:16:24 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44A068010E6;
 Tue,  4 Feb 2020 15:16:23 +0000 (UTC)
Received: from [10.3.116.181] (ovpn-116-181.phx2.redhat.com [10.3.116.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9A761001920;
 Tue,  4 Feb 2020 15:16:22 +0000 (UTC)
Subject: Re: [PATCH 04/17] block: Improve documentation of .bdrv_has_zero_init
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
References: <20200131174436.2961874-1-eblake@redhat.com>
 <20200131174436.2961874-5-eblake@redhat.com>
 <b223356c-8c90-e4c9-2db0-4a08717d559d@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <ea8a5d97-95bf-4d2d-59a5-e61c9d171678@redhat.com>
Date: Tue, 4 Feb 2020 09:16:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <b223356c-8c90-e4c9-2db0-4a08717d559d@virtuozzo.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: 7S1ry94oND6CGTZU5I85Fg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: david.edmondson@oracle.com, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/4/20 9:03 AM, Vladimir Sementsov-Ogievskiy wrote:
> 31.01.2020 20:44, Eric Blake wrote:
>> Several drivers supply .bdrv_has_zero_init that returns 1, but lack
>> the .bdrv_has_zero_init_truncate callback (parallels and qed outright,
>> vdi in some scenarios).=C2=A0 A literal reading of the existing
>> documentation says such drivers are broken, because
>> bdrv_has_zero_init_truncate() defaults to zero if the callback is
>> missing; but in practice, the tie between the two functions is only
>> relevant when truncate is supported.=C2=A0 Clarify the documentation to
>> make it obvious that this is okay.
>>
>> Fixes: 1dcaf527
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>> =C2=A0 include/block/block_int.h | 3 ++-
>> =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 640fb82c789e..77ab45dc87cf 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -444,7 +444,8 @@ struct BlockDriver {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Returns 1 if newly created images=
 are guaranteed to contain only
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * zeros, 0 otherwise.
>> -=C2=A0=C2=A0=C2=A0=C2=A0 * Must return 0 if .bdrv_has_zero_init_truncat=
e() returns 0.
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * Must return 0 if .bdrv_co_truncate is set an=
d
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * .bdrv_has_zero_init_truncate() returns 0.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int (*bdrv_has_zero_init)(BlockDriverStat=
e *bs);
>>
>=20
> I doubt, shouldn't 1dcaf527 be fixed by adding all needed=20
> bdrv_has_zero_init_truncate functions?

That was my original thought. But looking at callers of=20
bdrv_has_zero_init_truncate() shows that they all plan to perform=20
bdrv_co_truncate(PREALLOC_MODE_OFF) and want to know if that will leak=20
non-zero data; if you can't truncate, it doesn't matter what=20
init_truncate() returns, but since init_truncate() defaults to 0, it=20
shouldn't invalidate init() returning 1 - fixing the docs was easier=20
than adding useless callbacks to parallels, qed, and vdi just to rip=20
them back out again in patch 9.

As you noted later, sheepdog was the only driver that violated this rule=20
(and it is fixed in patch 8).  I could reorder the series to get the bug=20
fix in before the documentation change, if that would help.

>=20
> (sorry, I started to dig in the code and patches around=20
> bdrv_has_zero_init_truncate and tired :(.,
>  =C2=A0hope Max will comment this).
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


