Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE87C43218
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:44:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BFA206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BFA206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49610 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haR9m-0007TG-RW
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 16:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48525)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1haR8X-0006i3-0W
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:43:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1haR8V-00054l-2H
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:43:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1haR8T-00051L-Mo
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:43:23 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 928463082133;
 Mon, 10 Jun 2019 20:43:20 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-147.rdu2.redhat.com
 [10.10.123.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DEE719C68;
 Mon, 10 Jun 2019 20:43:16 +0000 (UTC)
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190607152223.9467-1-crosa@redhat.com>
 <20190607152223.9467-8-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <7c77609f-2d5c-45e8-c14e-982bdbcc09ea@redhat.com>
Date: Mon, 10 Jun 2019 17:43:15 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190607152223.9467-8-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 10 Jun 2019 20:43:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 7/8] VNC Acceptance test: check protocol
 version
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
> This goes a bit further than the other tests, and does a basic (read
> only) interaction with the VNC protocol.
>
> This is not a enough to perform a handshake, but enough to make sure
> that the socket is somewhat operational and that the expected initial
> step of the handshake is performed by the server and that the version
> matches.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/vnc.py | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> index d32ae46685..b000446d7c 100644
> --- a/tests/acceptance/vnc.py
> +++ b/tests/acceptance/vnc.py
> @@ -11,6 +11,7 @@
>   import os
>   import tempfile
>   import shutil
> +import socket
>   
>   from avocado_qemu import Test
>   
> @@ -71,5 +72,16 @@ class VncUnixSocket(Test):
>                                               arg='new_password')
>           self.assertEqual(set_password_response['return'], {})
>   
> +    def test_protocol_version(self):
> +        self.vm.add_args('-nodefaults', '-S',
> +                         '-vnc', 'unix:%s' % self.socket_path)
> +        self.vm.launch()
> +        self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])

I will advocate for the use QEMUMachine.command() instead of qmp(). The 
former do some checks on the qmp response and raises a more gently 
exception if something went wrong. This patch looks good to me though.

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

> +        client = socket.socket(socket.AF_UNIX)
> +        client.connect(self.socket_path)
> +        expected = b'RFB 003.008'
> +        actual = client.recv(len(expected))
> +        self.assertEqual(expected, actual, "Wrong protocol version")
> +
>       def tearDown(self):
>           shutil.rmtree(self.socket_dir)


