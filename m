Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B7F5C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:19:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93B420855
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 19:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTyvVv/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93B420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXVVh-0004Px-0u
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 14:19:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44846)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iXVT2-0008I7-By
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iXVSz-0002N0-T1
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:16:43 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21904
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iXVSy-0002JC-Kt
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 14:16:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574277390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JOl+2e36xf7irAuB7BM5W74HubWafG1anw4Wt7ovj3g=;
 b=KTyvVv/Zcuo93DqsuRX6pRccmU8rf5eDBhEZbOCPb6MlnMjathZkQxh/zHGyfPcAI3wTkb
 GjDXMmTGj2dF79E5+pFTXbj+DbxNSyNqaNrYNR6Eu9SFzIKC+WG/IHbx4959DUzpadAY7X
 PqisZnMRN8nHJwRopvo1SZY6+lbCMLo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-Yi5vflBvNMWRnqNG3IdghA-1; Wed, 20 Nov 2019 14:16:24 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2271C1883524;
 Wed, 20 Nov 2019 19:16:23 +0000 (UTC)
Received: from [10.3.116.221] (ovpn-116-221.phx2.redhat.com [10.3.116.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A112451C7B;
 Wed, 20 Nov 2019 19:16:22 +0000 (UTC)
Subject: Re: [PATCH 2/6] tests/Makefile.include: Fix missing
 test-qapi-emit-events.[ch]
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20191120182551.23795-1-armbru@redhat.com>
 <20191120182551.23795-3-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <32d24b89-a897-f4e3-71a3-b6a67254bb51@redhat.com>
Date: Wed, 20 Nov 2019 13:16:22 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191120182551.23795-3-armbru@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: Yi5vflBvNMWRnqNG3IdghA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
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
Cc: mdroth@linux.vnet.ibm.com, kwolf@pond.sub.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/20/19 12:25 PM, Markus Armbruster wrote:
> Commit 5d75648b56 "qapi: Generate QAPIEvent stuff into separate files"
> added tests/test-qapi-emit-events.[ch] to the set of generated files,
> but neglected to update tests/.gitignore and tests/Makefile.include.
> Commit a0af8cee3c "tests/.gitignore: ignore test-qapi-emit-events.[ch]
> for in-tree builds" fixed the former.  Now fix the latter.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   tests/Makefile.include | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


