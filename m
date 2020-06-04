Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31FAEC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:43:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA6F6206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 13:43:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PM+L6gDZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA6F6206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgq9V-0004N8-81
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 09:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgq8f-0003vb-Pr
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:42:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43847
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jgq8e-0007NB-2Z
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 09:42:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591278150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=1T1XM9ifNxoJSzo7T6JwmmsPSsBaAK3KKlweP9rGUbQ=;
 b=PM+L6gDZ3kxivI3TAmqN7nye3KHHN4ays3MLSunJBvQm32wnyQay8H9+A73sVqZWqlIh9B
 i5Wj4TdrofWCy9uwXIijA2kR8B4mUSLBHjU0VbIG3TaHyaSsv9r7qdspc6FoOJRYfNmrNM
 /Q9j7nek2VyTYqBOhsPsLovYIGNRkkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-mBPBjJOpM_eOcHcIbBboBQ-1; Thu, 04 Jun 2020 09:42:27 -0400
X-MC-Unique: mBPBjJOpM_eOcHcIbBboBQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 46C1E80058E;
 Thu,  4 Jun 2020 13:42:26 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-105.ams2.redhat.com [10.36.112.105])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 012467A1EF;
 Thu,  4 Jun 2020 13:42:21 +0000 (UTC)
Subject: Re: [PATCH v6 4/4] new qTest case to test the vhost-user-blk-server
To: Coiby Xu <coiby.xu@gmail.com>, qemu-devel@nongnu.org
References: <20200530171441.660814-1-coiby.xu@gmail.com>
 <20200530171441.660814-5-coiby.xu@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e28c954b-3125-223a-441b-c713a7a6e644@redhat.com>
Date: Thu, 4 Jun 2020 15:42:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200530171441.660814-5-coiby.xu@gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:12:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, bharatlkmlkvm@gmail.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/05/2020 19.14, Coiby Xu wrote:
> This test case has the same tests as tests/virtio-blk-test.c except for
> tests have block_resize. Since vhost-user server can only server one
> client one time, two instances of qemu-storage-daemon are launched
> for the hotplug test.
> 
> In order to not block scripts/tap-driver.pl, vhost-user-blk-server will
> send "quit" command to qemu-storage-daemon's QMP monitor. So a function
> is added to libqtest.c to establish socket connection with socket
> server.
> 
> Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
> ---
>  tests/Makefile.include              |   3 +-
>  tests/qtest/Makefile.include        |   2 +
>  tests/qtest/libqos/vhost-user-blk.c | 126 +++++
>  tests/qtest/libqos/vhost-user-blk.h |  44 ++
>  tests/qtest/libqtest.c              |  44 +-
>  tests/qtest/libqtest.h              |  38 ++
>  tests/qtest/vhost-user-blk-test.c   | 741 ++++++++++++++++++++++++++++
>  7 files changed, 966 insertions(+), 32 deletions(-)
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.c
>  create mode 100644 tests/qtest/libqos/vhost-user-blk.h
>  create mode 100644 tests/qtest/vhost-user-blk-test.c
[...]
>  qos-test-obj-y += tests/qtest/virtio-scsi-test.o
> diff --git a/tests/qtest/libqos/vhost-user-blk.c b/tests/qtest/libqos/vhost-user-blk.c
> new file mode 100644
> index 0000000000..ec46b7ddb4
> --- /dev/null
> +++ b/tests/qtest/libqos/vhost-user-blk.c
> @@ -0,0 +1,126 @@
> +/*
> + * libqos driver framework
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

Don't you want to add a remark here for you, too?

> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2 as published by the Free Software Foundation.

Could you please change "version 2" into "verion 2.1" ? There never was
a "version 2" of the LGPL, only version 2.1 (or 3.x).

(I know, we still got these wrong in a lot of other files, but at least
we should try to get it right in new files..)

> + * This library is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * Lesser General Public License for more details.
> + *
> + * You should have received a copy of the GNU Lesser General Public
> + * License along with this library; if not, see <http://www.gnu.org/licenses/>
> + */

> diff --git a/tests/qtest/libqos/vhost-user-blk.h b/tests/qtest/libqos/vhost-user-blk.h
> new file mode 100644
> index 0000000000..ef4ef09cca
> --- /dev/null
> +++ b/tests/qtest/libqos/vhost-user-blk.h
> @@ -0,0 +1,44 @@
> +/*
> + * libqos driver framework
> + *
> + * Copyright (c) 2018 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>
> + *
> + * This library is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU Lesser General Public
> + * License version 2 as published by the Free Software Foundation.

dito.

 Thanks,
  Thomas


