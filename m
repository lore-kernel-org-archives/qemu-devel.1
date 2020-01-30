Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA97DC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:43:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C9C820661
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 17:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dRvc4h44"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C9C820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixDqh-0000A8-N7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 12:43:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1ixDpm-0007i2-HG
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1ixDpk-0004wf-0K
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:42:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24820
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1ixDpj-0004vR-Qj
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 12:42:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580406147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xG3ikGTPGMKKwyg4YoB2dQ/JvOfroiKQNrywJHEUrNM=;
 b=dRvc4h44e0npUuf1iAmqQjTPtjuPpK/M/SNP9SxDrWJVjSqKAQAZu8lEsMYzsr6RWaCMcl
 voGMa0wZgwjmBXQx7erEvPuu7oLB3ran2BeyXdAvxKppi/0MLQLL9mbQX9wt5iEV8PARPv
 EhWg2RHzS6sqDa5U/yaNLIIJ0axD9rE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-Xff2SBOFN42w4vdUAuhWkA-1; Thu, 30 Jan 2020 12:42:10 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1826A0CC7;
 Thu, 30 Jan 2020 17:42:08 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-40.gru2.redhat.com
 [10.97.116.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 107945C1B2;
 Thu, 30 Jan 2020 17:41:59 +0000 (UTC)
Subject: Re: [PATCH 1/6] tests/boot_linux_console: add microvm acceptance test
To: Liam Merwick <liam.merwick@oracle.com>, alex.bennee@linaro.org,
 fam@euphon.net, philmd@redhat.com
References: <1580142994-1836-1-git-send-email-liam.merwick@oracle.com>
 <1580142994-1836-2-git-send-email-liam.merwick@oracle.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <a968cbba-911c-ac0b-6b7e-d50e83e877e3@redhat.com>
Date: Thu, 30 Jan 2020 15:41:58 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1580142994-1836-2-git-send-email-liam.merwick@oracle.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Xff2SBOFN42w4vdUAuhWkA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, slp@redhat.com,
 sgarzare@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/27/20 2:36 PM, Liam Merwick wrote:
> Refactor test_x86_64_pc() to test_x86_64_machine() so that separate
> functions which specify the Avocado tag of ':avocado: tags=3Dmachine:'
> as being either 'pc' or 'microvm' can be used to test booting a
> compressed kernel using either machine class.
>
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> ---
>   tests/acceptance/boot_linux_console.py | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/bo=
ot_linux_console.py
> index e40b84651b0b..aa5b07b1c609 100644
> --- a/tests/acceptance/boot_linux_console.py
> +++ b/tests/acceptance/boot_linux_console.py
> @@ -51,10 +51,9 @@ class BootLinuxConsole(Test):
>           os.chdir(cwd)
>           return self.workdir + path
>  =20
> -    def test_x86_64_pc(self):
> +    def do_test_x86_64_machine(self):
>           """
>           :avocado: tags=3Darch:x86_64
> -        :avocado: tags=3Dmachine:pc
>           """
>           kernel_url =3D ('https://archives.fedoraproject.org/pub/archive=
/fedora'
>                         '/linux/releases/29/Everything/x86_64/os/images/p=
xeboot'
> @@ -70,6 +69,18 @@ class BootLinuxConsole(Test):
>           console_pattern =3D 'Kernel command line: %s' % kernel_command_=
line
>           self.wait_for_console_pattern(console_pattern)
>  =20
> +    def test_x86_64_pc(self):
> +        """
> +        :avocado: tags=3Dmachine:pc
> +        """

The test method won't inherit the 'arch' tag from=20
`do_test_x86_64_machine()`, so you need to explicitly 'arch' tag each=20
test you created in this series. If you don't do so, Avocado won't=20
filter out those x86_64 tests in case QEMU is built with non-x86_64 targets=
.

Follows an example, I built QEMU with '--target-list=3Darm-softmmu'. I got:

```

(02/18)=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc:=20
CANCEL: No QEMU binary defined or found in the source tree (0.00 s)
 =A0(03/18)=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_x86_64_microvm=
:=20
CANCEL: No QEMU binary defined or found in the source tree (0.00 s)
 =A0(04/18)=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_virt:=20
PASS (1.25 s)

```

OK, avocado_qemu was smart enough to skip the tests, but ideally it=20
should not even consider running them in the first place.

Thanks!

- Wainer

> +        self.do_test_x86_64_machine()
> +
> +    def test_x86_64_microvm(self):
> +        """
> +        :avocado: tags=3Dmachine:microvm
> +        """
> +        self.do_test_x86_64_machine()
> +
>       def test_mips_malta(self):
>           """
>           :avocado: tags=3Darch:mips


