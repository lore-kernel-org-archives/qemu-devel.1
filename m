Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067C8C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C74CA2178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 15:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl0LDGXT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C74CA2178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSjqu-0004hw-1B
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 10:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60698)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iSjqC-0004Bs-B4
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:36:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iSjq9-0004Vj-QT
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:36:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iSjq9-0004VR-Jz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 10:36:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573141012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dK9tP6VheVPY+h5kOHvd2RIPpAhG5X32j11CjHrVhrw=;
 b=hl0LDGXT5UXBegoPa4u6Azhwe+17xIC1o3U5Ec9NcqsKA2My61jQ/iveShKyvGl6ddozpE
 65B/lhDKG16m8sGCPm3KPbVfTTn3qaqSsC2rVst+t60hPY1YA0o762cGRRLP8sYxJFpn4w
 Q+FP0sDuFB66yGk0cOKRDOe3Q/UEpc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-mBZu14sXMFatvZD82aUiBw-1; Thu, 07 Nov 2019 10:36:50 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A34B8017DD;
 Thu,  7 Nov 2019 15:36:50 +0000 (UTC)
Received: from [10.3.117.38] (ovpn-117-38.phx2.redhat.com [10.3.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E3A6F600F0;
 Thu,  7 Nov 2019 15:36:48 +0000 (UTC)
Subject: Re: [RFC PATCH 06/18] qemu-storage-daemon: Add --nbd-server option
To: Kevin Wolf <kwolf@redhat.com>
References: <20191017130204.16131-1-kwolf@redhat.com>
 <20191017130204.16131-7-kwolf@redhat.com>
 <25f74aa7-0856-a396-fb98-f6b7a337b965@redhat.com>
 <1bcb5419-183e-fd7b-e53c-fbb315f29703@redhat.com>
 <20191107083335.GA5007@linux.fritz.box>
 <b5f9a8d8-c548-db26-13a0-0494baf9dc30@redhat.com>
 <20191107152722.GD5007@linux.fritz.box>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <47962dd4-4c2a-257b-0bed-39ad1c143719@redhat.com>
Date: Thu, 7 Nov 2019 09:36:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191107152722.GD5007@linux.fritz.box>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: mBZu14sXMFatvZD82aUiBw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: qemu-devel@nongnu.org, pkrempa@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/7/19 9:27 AM, Kevin Wolf wrote:
> Am 07.11.2019 um 14:45 hat Eric Blake geschrieben:
>> On 11/7/19 2:33 AM, Kevin Wolf wrote:
>>> As a replacement nbd-server-add, I envisioned adding something like a
>>> block-export-add, which would work the way that --export already does.
>>> It would also come with query-block-exports and block-export-del, and i=
t
>>> wouldn't contain only NBD devices, but also vhost-user, FUSE, etc.
>>> exports.
>>>
>>> Now I'm wondering if the same would make sense for nbd-server-start.
>>> Maybe an API change would even allow us to start multiple NBD servers
>>> (e.g. listening on different IP addresses or using different tls-creds)=
.
>>
>> We want that (the ability to run multiple parallel NBD servers) anyway, =
to
>> allow parallel incremental backups from different points in time to
>> different clients.
>=20
> Can't you already have multiple exports on a single NBD server for
> multiple clients today? Or do you need a different server configuration
> for each client?

With our current code base, you can only run a single NBD server, with=20
multiple exports, but the TLS creds are shared among all exports.  It is=20
indeed technically possible to tweak things where the single server=20
changes _which_ exports are exposed based on _which_ creds were used by=20
the client (but only when TLS is used, and note that qemu-nbd currently=20
refuses to mix TLS and Unix sockets, although I need to post a v2 of a=20
patch I proposed a while back to improve that).  But it is easier still=20
to run two separate servers on different ports with two different creds,=20
and where there is no magic on which exports to show merely based on=20
which creds were presented (and this includes a plaintext connection=20
over Unix).  Either way, it requires code changes, and most likely for 5.0.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


