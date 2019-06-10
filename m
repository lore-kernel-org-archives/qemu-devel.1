Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20996C4321A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDCD1206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDCD1206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haQNe-0004UZ-12
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 15:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1haQI9-0007bp-Qe
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1haQI7-000309-Nc
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:49:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42852)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1haQI5-0002vi-Kg
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:49:13 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E84D48110E;
 Mon, 10 Jun 2019 19:49:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-147.rdu2.redhat.com
 [10.10.123.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E56B19C59;
 Mon, 10 Jun 2019 19:48:57 +0000 (UTC)
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190607152223.9467-1-crosa@redhat.com>
 <20190607152223.9467-4-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <87df3206-f061-ad25-3fe9-2b185888f98d@redhat.com>
Date: Mon, 10 Jun 2019 16:48:54 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190607152223.9467-4-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Mon, 10 Jun 2019 19:49:08 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/8] Acceptance tests: drop left over usage
 of ":avocado: enable"
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 06/07/2019 12:22 PM, Cleber Rosa wrote:
> Commit 9531d26c10 removed all of ":avocado: enable" tags, but then
> a new entry was added with the introduction of migration.py.
>
> Let's remove it for consistency.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/migration.py | 3 ---
>   1 file changed, 3 deletions(-)

I was about to send a patch to remove it as well. :)

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
> index 6115cf6c24..a44c1ae58f 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -17,9 +17,6 @@ from avocado.utils import wait
>   
>   
>   class Migration(Test):
> -    """
> -    :avocado: enable
> -    """
>   
>       timeout = 10
>   


