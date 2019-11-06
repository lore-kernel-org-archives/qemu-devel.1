Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A11CC5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527162178F
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 17:42:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfVVEqBZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527162178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSPKA-0007Nj-F9
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 12:42:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48457)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iSPJA-0006TE-2C
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:41:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iSPJ6-0004I5-Sr
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:41:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43317
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iSPJ6-0004BH-Lj
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 12:41:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573062082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=53pklqszvRyd5s+ZrYqXGrVhlOJVXxeqPKu1faxg/g4=;
 b=PfVVEqBZy4fDyfjjRAyvwneq98RSIOKoxI/zt+r0Hzno121b4hSQTtVBtymu5n1jxkl2lW
 7zMBQe3cnTYVYFpTMRyz2TqL8AbznCHdZB/mVf55flOJAtswZHuLMdUO3b2a6E891TT7Jv
 1YAF6A6pSYkvAcNOocOOIBFJkaEWZAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-OJ50E7FnPiS3VNDfu2cg4w-1; Wed, 06 Nov 2019 12:41:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A5B9D800C72;
 Wed,  6 Nov 2019 17:41:17 +0000 (UTC)
Received: from [10.3.117.38] (ovpn-117-38.phx2.redhat.com [10.3.117.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 630B85D713;
 Wed,  6 Nov 2019 17:41:17 +0000 (UTC)
Subject: Re: Feature Recommendations?
To: Dinah A Baum <dinahbaum@utexas.edu>, qemu-devel@nongnu.org
References: <CAOyzTAivEpv1VXzPXVH3Za9Zcz1URFjnpFCZQrRB4K=Z-oy1Dw@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <cdcb88d9-2754-834e-0ff7-28b5f8adc6c5@redhat.com>
Date: Wed, 6 Nov 2019 11:41:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAOyzTAivEpv1VXzPXVH3Za9Zcz1URFjnpFCZQrRB4K=Z-oy1Dw@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: OJ50E7FnPiS3VNDfu2cg4w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/19 4:59 AM, Dinah A Baum wrote:
> Hello all,
>=20
> I am a university student whose Virtualization course has tasked me with
> contributing to an open source, virtualization related project. I have a
> little more than a month to complete this. I was wondering if you could
> recommend a feature you'd like added that could be done in this time fram=
e.

https://wiki.qemu.org/Contribute/BiteSizedTasks might be an interesting=20
place to start looking for an idea you are comfortable with.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


