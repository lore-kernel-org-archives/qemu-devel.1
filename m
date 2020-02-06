Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE40C33CAC
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A50420838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:04:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tr+TFk3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A50420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izjeD-0000Xq-Eb
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 11:04:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32801)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izjd2-0007wf-Sb
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:03:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izjd1-0003Lm-Qr
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:03:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29818
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izjd1-0003KY-Mp
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 11:03:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581005023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=jNh5aEQEETtpnl6lhSH+r07cOkwBeGsgEkTGpRCsf50=;
 b=Tr+TFk3cBmD8eiGq7mKMroTkC7jXN2ES7cVnSWoXY2jTQUUQAb92/EnCBZ2wMXOu7U12Lz
 TPw+Tbh8clfeiMxGH5YEVWj17ckcuLkHa0VHVp+0skq5Pc/1AuGapFEzZMIKAwXfn1uzid
 x+4UyQTfSPlQt16e1FRqnOyFTfO2ZEU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-qLAMijNqMTqQqn7adjIzxA-1; Thu, 06 Feb 2020 11:03:41 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1FBF7801A04;
 Thu,  6 Feb 2020 16:03:40 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7B66D790E1;
 Thu,  6 Feb 2020 16:03:33 +0000 (UTC)
Subject: Re: [PATCH v2 27/29] tests/acceptance/migration: Default to
 -nodefaults
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Denis Plotnikov <dplotnikov@virtuozzo.com>, qemu-devel@nongnu.org
References: <20200129212345.20547-1-philmd@redhat.com>
 <20200129212345.20547-28-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d287cf16-ce85-2619-2c17-fe6fc18300e4@redhat.com>
Date: Thu, 6 Feb 2020 17:03:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200129212345.20547-28-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: qLAMijNqMTqQqn7adjIzxA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 29/01/2020 22.23, Philippe Mathieu-Daud=C3=A9 wrote:
> We don't need the default options to run this test.
>=20
> This fixes errors when running a binary built with
> --without-default-devices such:
>=20
>   ERROR: qemu-system-arm: Unsupported NIC model: virtio-net-pci
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/acceptance/migration.py | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/tests/acceptance/migration.py b/tests/acceptance/migration.p=
y
> index a44c1ae58f..d09e5d3fe7 100644
> --- a/tests/acceptance/migration.py
> +++ b/tests/acceptance/migration.py
> @@ -32,10 +32,12 @@ class Migration(Test):
> =20
> =20
>      def test_migration_with_tcp_localhost(self):
> -        source_vm =3D self.get_vm()
>          dest_uri =3D 'tcp:localhost:%u' % self._get_free_port()
>          dest_vm =3D self.get_vm('-incoming', dest_uri)
> +        dest_vm.add_args('-nodefaults')
>          dest_vm.launch()
> +        source_vm =3D self.get_vm()
> +        source_vm.add_args('-nodefaults')
>          source_vm.launch()
>          source_vm.qmp('migrate', uri=3Ddest_uri)
>          wait.wait_for(
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>


