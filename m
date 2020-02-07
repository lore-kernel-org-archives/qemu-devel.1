Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8332EC352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:58:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5032A20715
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:58:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9jiRLdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5032A20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j02HM-0001DQ-EY
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1j02Gl-0000jD-3e
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:57:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1j02Gi-00076m-Mq
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:57:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59333
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1j02Gi-00075a-H9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581076675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jlauhR/1fik8m2JZxi86zl5NitqQtFvAhH6VT298rkI=;
 b=W9jiRLdSGahDMyG7NSBFrh/88fSnsieIdTtSLW35702LrT9HvMCkoa2BoMracCT2+060Z3
 el6sS8ukTf2nElWnQknzhpQA8MCkqa6iziz12w+73ello/0aB5a0NTPXo2QeYnTJrgODkR
 6kKVu75ervfClp1b/+1a1f9nPflh4qM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-e_IpaCzGOM-OxtcLhJAPFw-1; Fri, 07 Feb 2020 06:57:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 943AFDBA5;
 Fri,  7 Feb 2020 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-96.gru2.redhat.com
 [10.97.116.96])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B975787B11;
 Fri,  7 Feb 2020 11:57:46 +0000 (UTC)
Subject: Re: [PATCH v2 27/29] tests/acceptance/migration: Default to
 -nodefaults
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-28-philmd@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <e1acc8e0-f334-dd01-e8b0-57d9100c9bea@redhat.com>
Date: Fri, 7 Feb 2020 09:57:43 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-28-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: e_IpaCzGOM-OxtcLhJAPFw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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


If you look at all the other acceptance tests the majority is going to=20
fail with --without-default-devices. So could we do better on this problem?

Although I would prefer a solution that cover all the tests, nothing is=20
wrong with this change:

Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>


>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>   tests/acceptance/migration.py | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index a44c1ae58f..d09e5d3fe7 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -32,10 +32,12 @@ class Migration(Test):
>  =20
>  =20
>       def test_migration_with_tcp_localhost(self):
> -        source_vm =3D self.get_vm()
>           dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
>           dest_vm =3D self.get_vm('-incoming', dest_uri)
> +        dest_vm.add_args('-nodefaults')
>           dest_vm.launch()
> +        source_vm =3D self.get_vm()
> +        source_vm.add_args('-nodefaults')
>           source_vm.launch()
>           source_vm.qmp('migrate', uri=3Ddest_uri)
>           wait.wait_for(


