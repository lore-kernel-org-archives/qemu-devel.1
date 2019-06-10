Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FE7C43218
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53317206E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 20:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53317206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49522 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haR1P-0002UT-78
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 16:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43131)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <wainersm@redhat.com>) id 1haQua-0005YJ-DL
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1haQuY-00045F-Og
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:29:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55254)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1haQuY-00043u-FM
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 16:28:58 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 60C7B3082E58;
 Mon, 10 Jun 2019 20:28:57 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-147.rdu2.redhat.com
 [10.10.123.147])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 754305C1B4;
 Mon, 10 Jun 2019 20:28:52 +0000 (UTC)
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20190607152223.9467-1-crosa@redhat.com>
 <20190607152223.9467-7-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <070936b2-4c7f-9833-6582-1bb95c3bd519@redhat.com>
Date: Mon, 10 Jun 2019 17:28:51 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20190607152223.9467-7-crosa@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Mon, 10 Jun 2019 20:28:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 6/8] VNC Acceptance test: simplify test
 names
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
> The test name is composed of the class name and method name, so it
> looks like there's some redundancy here that we can eliminate.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/vnc.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

>
> diff --git a/tests/acceptance/vnc.py b/tests/acceptance/vnc.py
> index 675fd507ed..d32ae46685 100644
> --- a/tests/acceptance/vnc.py
> +++ b/tests/acceptance/vnc.py
> @@ -45,7 +45,7 @@ class VncUnixSocket(Test):
>           self.socket_dir = tempfile.mkdtemp()
>           self.socket_path = os.path.join(self.socket_dir, 'vnc-socket')
>   
> -    def test_vnc_change_password_requires_a_password(self):
> +    def test_change_password_requires_a_password(self):
>           self.vm.add_args('-nodefaults', '-S',
>                            '-vnc', 'unix:%s' % self.socket_path)
>           self.vm.launch()
> @@ -60,7 +60,7 @@ class VncUnixSocket(Test):
>           self.assertEqual(set_password_response['error']['desc'],
>                            'Could not set password')
>   
> -    def test_vnc_change_password(self):
> +    def test_change_password(self):
>           self.vm.add_args('-nodefaults', '-S',
>                            '-vnc', 'unix:%s,password' % self.socket_path)
>           self.vm.launch()


