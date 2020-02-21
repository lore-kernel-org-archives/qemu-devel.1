Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747FAC3565B
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:33:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406C2206E2
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 18:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IZyYCMJ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406C2206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34948 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5D73-0000PX-CA
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 13:33:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j5D5m-00083F-D6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j5D5l-00062u-C6
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:32:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23586
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j5D5l-00062g-7V
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 13:32:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582309919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9YdVxzlrPil0x15rzUCXXf2M11bXcpg55nRuwi41lvI=;
 b=IZyYCMJ/2uTj3u5JapgXl2gI0Pi6YzeUEKhEB/a+a4Tj3gKiCUKMxuJjv+v643V4XR75ZT
 KVROrudOwcmXq95Bnm6cRrmhDlXtMt0AVckbDeIm9Y1y17GdHrXCLDY5OcJkG0TImAzG9E
 x7M8GAXGd30qgmotdnDKPxU6VvhMEpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-kuXJ6WMVP1KhvnKaN16j3g-1; Fri, 21 Feb 2020 13:31:47 -0500
X-MC-Unique: kuXJ6WMVP1KhvnKaN16j3g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2AE5E8017DF
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-92.gru2.redhat.com
 [10.97.116.92])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 619285C105;
 Fri, 21 Feb 2020 18:31:44 +0000 (UTC)
Subject: Re: [PATCH v1 3/4] Acceptance test: provides new functions
To: Oksana Vohchana <ovoshcha@redhat.com>, qemu-devel@nongnu.org
References: <20200214145235.4378-1-ovoshcha@redhat.com>
 <20200214145235.4378-4-ovoshcha@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <875891d8-23f7-2603-2c51-9a734cf148b6@redhat.com>
Date: Fri, 21 Feb 2020 15:31:42 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200214145235.4378-4-ovoshcha@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: philmd@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Oksana,

On 2/14/20 12:52 PM, Oksana Vohchana wrote:
> Adds functions to check if service RDMA is enabled and gets the interface
> where it was configured
>
> Signed-off-by: Oksana Vohchana <ovoshcha@redhat.com>
> ---
>   tests/acceptance/migration.py | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.py
> index 8209dcf71d..bbd88f8dda 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -11,12 +11,16 @@
>   
>   
>   import tempfile
> +import re
> +import netifaces

Since netifaces isn't a standard Python library that import might fail.

The tests dependencies are listed in tests/requirements.txt, and 
installed in the environment created by `make check-acceptance`. If you 
want to ensure the test behaves well even when executed manually (i.e. 
not via `make check-acceptance`), you can add runtime checks as can be 
seen in tests/acceptance/machine_m68k_nextcube.py

>   from avocado_qemu import Test
>   from avocado import skipUnless
>   
>   from avocado.utils import network
>   from avocado.utils import wait
>   from avocado.utils.path import find_command
> +from avocado.utils import service
> +from avocado.utils import process
>   
>   
>   class Migration(Test):
> @@ -58,6 +62,19 @@ class Migration(Test):
>               self.cancel('Failed to find a free port')
>           return port
>   
> +    def _if_rdma_enable(self):
> +        rdma_stat = service.ServiceManager()
> +        rdma = rdma_stat.status('rdma')
> +        return rdma


Above function is used on patch04, but actually I don't think it needs 
to check this service for RoCE. It would be needed if it was using the 
rxe_cfg to configure the rdma link. Or am I missing something?


> +
> +    def _get_ip_rdma(self):
> +        get_ip_rdma = process.run('rdma link show').stdout.decode()
> +        for line in get_ip_rdma.split('\n'):
> +            if re.search(r"ACTIVE", line):
> +                interface = line.split(" ")[-2]
> +                ip = netifaces.ifaddresses(interface)[netifaces.AF_INET][0]['addr']
> +                return ip
> +

I suggest that it explicitly returns None if none is found.

Thanks!

- Wainer

>   
>       def test_migration_with_tcp_localhost(self):
>           dest_uri = 'tcp:localhost:%u' % self._get_free_port()


