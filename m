Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5308C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 08:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8109F2077C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 08:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W8wagWaG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8109F2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ippTK-0006Qv-CQ
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 03:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ippRt-0005Oa-V2
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:15:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ippRs-0003Rh-VY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:15:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47819
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ippRs-0003Q7-Qb
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 03:15:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578644116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=EKcbDBofYWHBg3b6jwmkyh1qRf6xzkQBzSj7MJyIkXQ=;
 b=W8wagWaG6H//3HLn+f/QajQT1I4p/mAoG1S0r/OybtFbMq5gyn/+YaIa1rwkd6JMyfnwnj
 fR/hvtKJpmjKA+f5Nc6fp67IItwmelwQ8SBTXHr8TFTouWiOF6tXwvf1fDSijcndg8XCEi
 w+1h6V0cEzlNF8z+Bta2YhcIwCi2jTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-Tb06N_77OKq5MpD_sTsuYw-1; Fri, 10 Jan 2020 03:15:15 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9F298DB22;
 Fri, 10 Jan 2020 08:15:13 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-154.ams2.redhat.com [10.36.116.154])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BFD525C1B5;
 Fri, 10 Jan 2020 08:15:07 +0000 (UTC)
Subject: Re: [PATCH 4/4] Makefile: Remove unhelpful comment
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200109153939.27173-1-philmd@redhat.com>
 <20200109153939.27173-5-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7a6aea2c-8057-d616-6b7b-0075c7cb13e6@redhat.com>
Date: Fri, 10 Jan 2020 09:15:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200109153939.27173-5-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: Tb06N_77OKq5MpD_sTsuYw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/01/2020 16.39, Philippe Mathieu-Daud=C3=A9 wrote:
> It is pointless to keep qapi/ object separate from the other
> common-objects. Drop the comment.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  Makefile.objs | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/Makefile.objs b/Makefile.objs
> index 395dd1e670..c6321d0465 100644
> --- a/Makefile.objs
> +++ b/Makefile.objs
> @@ -71,11 +71,9 @@ qemu-seccomp.o-libs :=3D $(SECCOMP_LIBS)
> =20
>  common-obj-$(CONFIG_FDT) +=3D device_tree.o
> =20
> -######################################################################
> -# qapi
> -
>  common-obj-y +=3D qapi/
> -endif
> +
> +endif # CONFIG_SOFTMMU
> =20
>  #######################################################################
>  # Target-independent parts used in system and user emulation
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>


