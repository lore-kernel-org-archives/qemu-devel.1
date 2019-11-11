Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58253C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:21:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB1C206BA
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MDnTRIWG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB1C206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAZm-0000e2-AA
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 09:21:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53818)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iUAYq-000886-Co
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:20:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iUAYn-0000C1-KL
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:20:54 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47203
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iUAYn-0000Bu-9G
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573482052;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f9bSi1vfQg4FvcAoDaC2IfzinSKdkAbEFnsaCuDDx4Q=;
 b=MDnTRIWGiPet7fD58u2BKgF7G6713ZOgDWhxbnb8JsH2UqPRvcq4hn+3g55dqYxy8PJRLa
 wqQ03rgf/AqhsDuTl6Jt5UN64JKRzPpe3x4m81x/KzqOv5XmnTF9O3LmmTAErGxhJwzFfs
 xzz6VrdKviBRV7zzIU9mC0FNKgidL7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-GlxZpqw5P7G4kbddpkVZBQ-1; Mon, 11 Nov 2019 09:20:51 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91955915045;
 Mon, 11 Nov 2019 14:20:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-162.ams2.redhat.com
 [10.36.116.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 941A9289AB;
 Mon, 11 Nov 2019 14:20:34 +0000 (UTC)
Subject: Re: [PATCH v1 1/6] tests/vm: netbsd autoinstall, using serial console
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <20191104173654.30125-2-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <32ab995a-6c3e-e242-c72f-b0e3bdbcd217@redhat.com>
Date: Mon, 11 Nov 2019 15:20:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191104173654.30125-2-alex.bennee@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: GlxZpqw5P7G4kbddpkVZBQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: fam@euphon.net, berrange@redhat.com, Eduardo Habkost <ehabkost@redhat.com>,
 stefanb@linux.vnet.ibm.com, richard.henderson@linaro.org, f4bug@amsat.org,
 Kamil Rytarowski <kamil@netbsd.org>, cota@braap.org,
 Gerd Hoffmann <kraxel@redhat.com>, stefanha@redhat.com, pbonzini@redhat.com,
 marcandre.lureau@redhat.com, Kamil Rytarowski <n54@gmx.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 04/11/2019 18.36, Alex Benn=C3=A9e wrote:
> From: Gerd Hoffmann <kraxel@redhat.com>
>=20
> Instead of fetching the prebuilt image from patchew download the install
> iso and prepare the image locally.  Install to disk, using the serial
> console.  Create qemu user, configure ssh login.  Install packages
> needed for qemu builds.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Reviewed-by: Kamil Rytarowski <n54@gmx.com>
> Tested-by: Thomas Huth <thuth@redhat.com>
> [ehabkost: rebased to latest qemu.git master]
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Message-Id: <20191031085306.28888-2-kraxel@redhat.com>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/vm/netbsd | 189 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 179 insertions(+), 10 deletions(-)
[...]
> +        # shutdown
> +        self.ssh_root(self.poweroff)
> +        self.console_wait("entering state S5")
> +        self.wait()
> +
> +        if os.path.exists(img):
> +            os.remove(img)

What about removing the above two lines again?
(see commit fcd2060e8efff83b7bde)

 Thomas

>          os.rename(img_tmp, img)
> +        os.remove(iso)
> +        self.print_step("All done")
> =20
>  if __name__ =3D=3D "__main__":
>      sys.exit(basevm.main(NetBSDVM))
>=20


