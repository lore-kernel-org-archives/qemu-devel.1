Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1222C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:20:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B4B2206F5
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 13:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I1CpdJHv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4B2206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJzlb-0000He-My
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 09:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1jJzkw-0008JW-Mq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1jJzkv-00065K-Lm
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:19:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36348
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1jJzkv-00062S-HT
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 09:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585833576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E8/7ShEvmlJ1UIyxCIO/Ocy6l+gMF8c0uOgYtxGasJ8=;
 b=I1CpdJHvOMepAaNgdjUxq7aKeXdPn09vcBqP8gTqayyi1mYI7rmc+vAQKxecWRxoCKMCDN
 Cn2e9cpwLhunliXnGKTsHSFk+FsR8c1VjeY7gSPHFk5HpnNlQQFhvb7BmND1Lx4un7N6W9
 v5c9eZN1qjP5IvvXZntOdBeNKZKp3Bs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-eDd-Ws4IOxK2mHkvUwiS5w-1; Thu, 02 Apr 2020 09:19:34 -0400
X-MC-Unique: eDd-Ws4IOxK2mHkvUwiS5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95A6680574E;
 Thu,  2 Apr 2020 13:19:33 +0000 (UTC)
Received: from [10.3.113.246] (ovpn-113-246.phx2.redhat.com [10.3.113.246])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 131801001DC2;
 Thu,  2 Apr 2020 13:19:32 +0000 (UTC)
Subject: Re: [PATCH] qobject: json-streamer: Remove double test
From: Eric Blake <eblake@redhat.com>
To: Simran Singhal <singhalsimran0@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20200402121313.GA5563@simran-Inspiron-5558>
 <c955d844-9d39-930a-fb92-75fd97bb0330@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <7acf8be6-62cc-0630-d633-691f9b6869a0@redhat.com>
Date: Thu, 2 Apr 2020 08:19:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <c955d844-9d39-930a-fb92-75fd97bb0330@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 8:12 AM, Eric Blake wrote:
> On 4/2/20 7:13 AM, Simran Singhal wrote:
>> Remove the duplicate test "parser->bracket_count >=3D 0".
>>
>> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
>> ---
>> =A0 qobject/json-streamer.c | 2 +-
>> =A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>

>>
>> (brace > 0 || bracket > 0) && brace >=3D 0 && bracket >=3D 0
>>
>=20
> What I missed was the typo: we checked bracket >=3D 0 twice, instead of=
=20
> the intended brace >=3D 0 && bracket >=3D 0.=A0 This needs a v2.

Effect of the bug:

Note that we can diagnose when we have unbalanced ] with no matching [=20
while inside {}:

$ qemu-kvm --nodefaults --nographic --qmp stdio
{"QMP": {"version": {"qemu": {"micro": 91, "minor": 2, "major": 4},=20
"package": "v5.0.0-rc1-1-gf6ce4a439a08"}, "capabilities": ["oob"]}}
{]
{"error": {"class": "GenericError", "desc": "JSON parse error, expecting=20
value"}}

but that we fail to diagnose unbalanced } with no matching { while=20
inside []:

[}


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


