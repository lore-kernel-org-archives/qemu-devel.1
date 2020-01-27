Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7569BC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41A88207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 10:02:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VLXD8E8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A88207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw1DX-00018r-FB
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 05:02:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iw1CJ-0000Fj-5k
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:00:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iw1CH-00025u-Uf
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:00:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50497
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iw1CH-00025f-RG
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 05:00:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580119245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=JwBkiKWZapv4BNiv8U3he7xDhJW5sOZE5dfzvUA/7UQ=;
 b=VLXD8E8hfd18TCDgv5UwerxR+LE7afTMh1FQAwLLWYY5k92RPZtuQXVFlYxrh6jBNAWbD8
 /5LwWZcxWTxI3fM/6+XgqjxOrXHkWJJD7JVAij2ulCxDF5jel3gVR2WyR91wr+s/IMvcuZ
 1RdUrPMdXSb0c3Pvqh4kmXRB5inKqLc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-p4cjI3h5N5e2veEFkv278Q-1; Mon, 27 Jan 2020 05:00:43 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2354184BBBD;
 Mon, 27 Jan 2020 10:00:42 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-94.ams2.redhat.com [10.36.117.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 53B6060BF4;
 Mon, 27 Jan 2020 10:00:30 +0000 (UTC)
Subject: Re: [qemu-web PATCH v2] Add "Security Process" information to the
 main website
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200123171150.12782-1-thuth@redhat.com>
 <b24abc8e-032c-c95f-89ae-c6480cee8b3c@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a0b6986c-3732-9326-e383-675596dc61aa@redhat.com>
Date: Mon, 27 Jan 2020 11:00:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b24abc8e-032c-c95f-89ae-c6480cee8b3c@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: p4cjI3h5N5e2veEFkv278Q-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: sstabellini@kernel.org, pmatouse@redhat.com,
 "Michael S . Tsirkin" <mst@redhat.com>, mdroth@linux.vnet.ibm.com,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 pjp@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/01/2020 20.43, Eric Blake wrote:
> On 1/23/20 11:11 AM, Thomas Huth wrote:
>> One reporter of a security issue recently complained that it might not
>> be the best idea to store our "Security Process" in the Wiki. Well, whil=
e
>> the page in the Wiki is protected (so that only some few people can edit
>> it), it is still possible that someone might find a bug in the Wiki
>> software to alter the page contents...
>> Anyway, it looks more trustworthy if we present the "Security Process"
>> information in the static website instead. Thus this patch adds the
>> information from the wiki to the Jekyll-based website now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 v2: Improved some sentences as suggested by Paolo
>>
>=20
>> +### Publication embargo
>> +
>> +As a security issue reported, that is not already publically disclosed
>=20
> publicly
>=20
>> +elsewhere, has an embargo date assigned and communicated to reporter.
>> Embargo
>=20
> Reads awkwardly. I'd suggest:
>=20
> If a security issue is reported that is not already publicly disclosed,
> an embargo date may be assigned and communicated to the reporter.

Ok, thanks, I've added your suggestions and pushed the changes now to
the website.

To the people on CC: ... could someone please update the wiki page
(https://wiki.qemu.org/SecurityProcess) to point to
https://www.qemu.org/contribute/security-process/ instead? ... I don't
have write access to that page, so I can not do that on my own.

 Thomas


