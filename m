Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BDBC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE20B2082E
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 12:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y1rNFZp2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE20B2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02Pr-0002Rt-5E
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 07:07:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41863)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j02O8-0000oH-G4
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j02O6-0001dm-5q
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:05:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52309
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j02O5-0001ZT-7H
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 07:05:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581077132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j9Qkui0iShpfn/9QisNA8GjsUjl3Q6LtqcvlkFgcIv4=;
 b=Y1rNFZp2S8timeuJdydozDOrVM5nyiz3bOBkhTF0N39MdvHOOCYTI3Smpdvmob1NxBTs2C
 bYYlLNnJqsW+HjwCEgwVfz55V0AGtf6EU3XZTJTASWGKl/Uvzywg4+LQ35KH7Dl2OWcpCx
 I2pzdQdEN2dIU+kZj2+o/Knev07ldCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-39-uIeB8Ks2MT-HCPyqgeVb9A-1; Fri, 07 Feb 2020 07:05:18 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9731802700;
 Fri,  7 Feb 2020 12:05:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-96.gru2.redhat.com
 [10.97.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5CB4D60BEC;
 Fri,  7 Feb 2020 12:05:10 +0000 (UTC)
Subject: Re: [PATCH v2 28/29] tests/acceptance/version: Default to -nodefaults
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-29-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <318d039a-af30-be53-460d-a7d49c8aaf17@redhat.com>
Date: Fri, 7 Feb 2020 10:05:08 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-29-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: uIeB8Ks2MT-HCPyqgeVb9A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
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
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/29/20 7:23 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> We don't need the default options to run this test.
>
> This fixes errors when running a binary built with
> --without-default-devices such:
>
>    ERROR: qemu-system-arm: Unsupported NIC model: virtio-net-pci
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/version.py | 1 +
>   1 file changed, 1 insertion(+)

My comments in [1] also applies for this change. So:

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg675104.html


>
> diff --git a/tests/acceptance/version.py b/tests/acceptance/version.py
> index 67c2192c93..79b923d4fc 100644
> --- a/tests/acceptance/version.py
> +++ b/tests/acceptance/version.py
> @@ -17,6 +17,7 @@ class Version(Test):
>       :avocado: tags=3Dquick
>       """
>       def test_qmp_human_info_version(self):
> +        self.vm.add_args('-nodefaults')
>           self.vm.launch()
>           res =3D self.vm.command('human-monitor-command',
>                                 command_line=3D'info version')


