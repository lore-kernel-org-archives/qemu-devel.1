Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3274AC43218
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:30:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0212082E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0212082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49488 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haQvn-0006Wl-MJ
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 16:30:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42356)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1haQtt-000544-Fz
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1haQtC-0002eJ-6t
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:27:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1haQt6-0002YY-Fz
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08058C0586D8;
 Mon, 10 Jun 2019 20:27:16 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-147.rdu2.redhat.com
 [10.10.123.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1ACF8608CD;
 Mon, 10 Jun 2019 20:27:06 +0000 (UTC)
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190607152223.9467-1-crosa@redhat.com>
 <20190607152223.9467-6-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <0d622c97-02a4-7991-81e2-8974ca697a37@redhat.com>
Date: Mon, 10 Jun 2019 17:27:05 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190607152223.9467-6-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Mon, 10 Jun 2019 20:27:21 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 5/8] VNC Acceptance test: use UNIX domain
 sockets to avoid port collisions
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
> While running in parallel, the VNC tests that use a TCP port easily
> collide.  There's a number of possibilities to reduce the probability
> of collisions, but none that completely prevents it from happening.
>
> So, to avoid those collisions, and given that the scope of the tests
> are really not related to nature of the socket type, let's switch to
> UNIX domain sockets created in temporary directories.
>
> Note: the amount of boiler plate code is far from the ideal, but it's
> related to the fact that a test "workdir"[1] attribute can not be used
> here, because of the 108 bytes limitation of the UNIX socket path (see
> ad9579aaa16). There's a fair assumption here that the temporary
> directory returned by Python's tempfile.mkdtemp() won't be anywhere
> close to 100 bytes.
>
> [1] https://avocado-framework.readthedocs.io/en/68.0/api/test/avocado.html#avocado.Test.workdir
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/vnc.py | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> index 064ceabcc1..675fd507ed 100644
> --- a/tests/acceptance/vnc.py
> +++ b/tests/acceptance/vnc.py
> @@ -8,6 +8,10 @@
>   # This work is licensed under the terms of the GNU GPL, version 2 or
>   # later.  See the COPYING file in the top-level directory.
>   
> +import os
> +import tempfile
> +import shutil
> +
>   from avocado_qemu import Test
>   
>   
> @@ -34,8 +38,16 @@ class Vnc(Test):
>           self.assertEqual(set_password_response['error']['desc'],
>                            'Could not set password')
>   
> +class VncUnixSocket(Test):
> +
> +    def setUp(self):
> +        super(VncUnixSocket, self).setUp()
> +        self.socket_dir = tempfile.mkdtemp()
> +        self.socket_path = os.path.join(self.socket_dir, 'vnc-socket')
> +
>       def test_vnc_change_password_requires_a_password(self):
> -        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0')
> +        self.vm.add_args('-nodefaults', '-S',
> +                         '-vnc', 'unix:%s' % self.socket_path)
>           self.vm.launch()
>           self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
>           set_password_response = self.vm.qmp('change',
> @@ -49,7 +61,8 @@ class Vnc(Test):
>                            'Could not set password')
>   
>       def test_vnc_change_password(self):
> -        self.vm.add_args('-nodefaults', '-S', '-vnc', ':0,password')
> +        self.vm.add_args('-nodefaults', '-S',
> +                         '-vnc', 'unix:%s,password' % self.socket_path)
>           self.vm.launch()
>           self.assertTrue(self.vm.qmp('query-vnc')['return']['enabled'])
>           set_password_response = self.vm.qmp('change',
> @@ -57,3 +70,6 @@ class Vnc(Test):
>                                               target='password',
>                                               arg='new_password')
>           self.assertEqual(set_password_response['return'], {})
> +
> +    def tearDown(self):
> +        shutil.rmtree(self.socket_dir)

You missed to call super's tearDown in order to gently shutdown all VM 
created in by the tests. Other than that, it looks good to me.

- Wainer



