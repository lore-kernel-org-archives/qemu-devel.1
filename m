Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5D6CA9EA0
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:41:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7CF72053B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 02:41:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkAZQCN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7CF72053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iN6ag-0005x9-Ux
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 22:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iN6Zn-0005VS-N7
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:40:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iN6Zj-0003gw-IG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:40:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47460
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iN6Zj-0003gB-EE
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 22:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571798438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8fmR0cOo4AHT81iWrbRvTOF66FHkZSiRHwuPLCQxK7E=;
 b=BkAZQCN2hTm2ooTBwynrSQCYi4q4W0PMFhg0JMMNhJcRZW2/vzn5saVHLd1H1DGAuBNYKm
 z33WLHbIpO3+g/lcNK/24zGVfjRUvHgmB45aaTlVIpLpMkYmPaxzu1Ooqc0WDjOSWTHjVz
 782CQnpADCr4uTqOC8wA9FvXB8RAoLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-163-y-LZUQX9NE63eN4Q16Igiw-1; Tue, 22 Oct 2019 22:40:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 938DF47B;
 Wed, 23 Oct 2019 02:40:35 +0000 (UTC)
Received: from [10.3.117.0] (ovpn-117-0.phx2.redhat.com [10.3.117.0])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6CE95DC18;
 Wed, 23 Oct 2019 02:40:31 +0000 (UTC)
Subject: Re: [RFC PATCH] iothread: add set_iothread_poll_* commands
To: Zhenyu Ye <yezhenyu2@huawei.com>
References: <5DAEB9D3.3080503@huawei.com>
 <95fde68e-9730-ce22-b59d-c5e20f86d0c1@redhat.com>
 <5DAFBAD5.9040409@huawei.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <db460e9c-8bd5-d08b-fc06-3f0d1e11b75b@redhat.com>
Date: Tue, 22 Oct 2019 21:40:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <5DAFBAD5.9040409@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: y-LZUQX9NE63eN4Q16Igiw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Markus Armbruster <armbru@redhat.com>, dgilbert@redhat.com,
 xiexiangyou@huawei.com, qemu-devel@nongnu.org,
 jiangyiwen <jiangyiwen@huawei.com>, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/22/19 9:28 PM, Zhenyu Ye wrote:

> I will change the name argument to ENUM, such as,
>=20
>      { 'enum': 'IothreadPollProperty',
>        'data': [ 'max-ns', 'grow', 'shrink' ] }
>=20

>=20
> ok, I will correct it, such as,
>=20
>      { 'command': 'set-iothread-poll-param',
>      'data': {'iothread-id': 'str', 'name': 'IothreadPollProperty', 'valu=
e': 'int'} }
>=20

That's one approach.  But another approach would be:

{ 'command': 'set-iothread-poll-params',
   'data': { 'iothread-id': 'str',
             '*max-ns': 'int', '*grow': 'int', '*shrink': 'int' } }

The difference on the wire is between:

{ "execute": "set-iothread-poll-param",
   "arguments": { "iothread-id": "thr1",
     "name": "max-ns", "value": 1000 } }
{ "execute": "set-iothread-poll-param",
   "arguments": { "iothread-id": "thr1",
     "name": "grow", "value": 100 } }

vs.

{ "execute": "set-iothread-poll-params",
   "arguments': { "iothread-id": "thr1",
      "max-ns": 1000, "grow": 100 } }

I'll leave it up to Markus to give guidance on which style is nicer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


