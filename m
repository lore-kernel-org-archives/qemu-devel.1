Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB48C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:37:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF001206E5
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZODSdOix"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF001206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV0KQ-0008C4-QS
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 16:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1iV0Fg-0005uH-SZ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:32:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1iV0Ff-0002N2-Ub
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:32:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39322
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>) id 1iV0Ff-0002LW-QU
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:32:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573680755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QiZ70SSpZyBY6QtbyxaANW+/w1bsBLb4RtRjuvPREKo=;
 b=ZODSdOix5lo3GsY6ehHAEWXMCVimZSIjSFowIEPjZKZfqlkAACTeIhCPLbSg0CHgGRE2mF
 lSCPAJ5ACJeu7hHvS18TGIVzyjHL332P2rWcgAyDBzKsqEFJLkWEBFHq6+/2JmEp7clxdN
 gXML2/Rkd/M8ifV+v6G32yVSw0gZQsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-CCxjtZ0QMpaxkBTsG5UWSQ-1; Wed, 13 Nov 2019 16:32:31 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03F13800EBE;
 Wed, 13 Nov 2019 21:32:30 +0000 (UTC)
Received: from [10.3.116.242] (ovpn-116-242.phx2.redhat.com [10.3.116.242])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A69611036C64;
 Wed, 13 Nov 2019 21:32:26 +0000 (UTC)
Subject: Re: [PATCH 0/2] Introducing QMP query-netdevs command
To: Alexey Kirillov <lekiravi@yandex-team.ru>,
 Jason Wang <jasowang@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20191113212516.13606-1-lekiravi@yandex-team.ru>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <f906f303-54ec-79e2-1943-d172c81d7055@redhat.com>
Date: Wed, 13 Nov 2019 15:32:26 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191113212516.13606-1-lekiravi@yandex-team.ru>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: CCxjtZ0QMpaxkBTsG5UWSQ-1
X-Mimecast-Spam-Score: 0
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 yc-core@yandex-team.ru, Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/13/19 3:25 PM, Alexey Kirillov wrote:
> This patch introduces a new QMP command "query-netdevs" to get informatio=
n
> about currently attached network devices.
> Potentially, this patch makes the "info_str" field of "struct NetClientSt=
ate"
> and HMP command "info network" obsolete as new command gives out more
> information in a structured way.

Can we rewrite the existing HMP command to call into the new QMP command?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


