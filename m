Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0AAC4321A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:53:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8103206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8103206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49334 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haQMF-00038z-Uw
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 15:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59726)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1haQHB-0007II-Vb
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1haQH4-0002Ks-Dk
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:48:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34958)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1haQGz-0002BB-6p
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:48:05 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 25E33307D91F;
 Mon, 10 Jun 2019 19:48:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-147.rdu2.redhat.com
 [10.10.123.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C1DF71001B14;
 Mon, 10 Jun 2019 19:47:56 +0000 (UTC)
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190607152223.9467-1-crosa@redhat.com>
 <20190607152223.9467-3-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <67974de6-81e6-d9af-410a-1d29d37de8fa@redhat.com>
Date: Mon, 10 Jun 2019 16:47:55 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190607152223.9467-3-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 10 Jun 2019 19:48:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/8] tests/requirements.txt: pin paramiko
 version requirement
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
> It's a good practice (I'd really say a must) to pin as much as
> possible of the software versions used during test, so let's apply
> that to paramiko.
>
> According to https://pypi.org/project/paramiko/, 2.4.2 is the latest
> released version.  It's also easily obtainable on systems such as
> Fedora 30.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/requirements.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>
> diff --git a/tests/requirements.txt b/tests/requirements.txt
> index 3ae0e29ad7..bd1f7590ed 100644
> --- a/tests/requirements.txt
> +++ b/tests/requirements.txt
> @@ -2,4 +2,4 @@
>   # in the tests/venv Python virtual environment. For more info,
>   # refer to: https://pip.pypa.io/en/stable/user_guide/#id1
>   avocado-framework==68.0
> -paramiko
> +paramiko==2.4.2


