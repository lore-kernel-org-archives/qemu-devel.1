Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5B4C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:48:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97ED42166E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 19:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IhsnZw18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97ED42166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSnlA-00042e-Qa
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 14:48:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iSnjo-0003Q2-Vf
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:46:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iSnjn-0002PM-JP
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:46:36 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34673
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iSnjg-0002FY-Be
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 14:46:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573155987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/wM6ugIMOkqHWn2UncXelZY1lnOwkwSgWC4PvgFY0SU=;
 b=IhsnZw18bbK2Ijx0Q4sXCkEp78VG3dplhLy9HWZa7ynrziPR2pG1vZXOFNL755+/4eOWj1
 c3EZy7RCPA75LLrEFdVRtFd+GywSTfO3ZTjOZjrMEyAZIcmThyxO7n/Sw8MNL9S24i4pPi
 ze6sJqioLJ/9+eDV6XL2e3DIcuAooyw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-346-B2W4YtXxNgq9G51Nz42JAQ-1; Thu, 07 Nov 2019 14:46:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9CF11800D6B;
 Thu,  7 Nov 2019 19:46:21 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-91.gru2.redhat.com
 [10.97.116.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4DC05DA76;
 Thu,  7 Nov 2019 19:46:14 +0000 (UTC)
Subject: Re: [PATCH v7 6/8] Acceptance tests: add the build directory to the
 system PATH
To: Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org
References: <20191104151323.9883-1-crosa@redhat.com>
 <20191104151323.9883-7-crosa@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <0660a16e-2ffc-fd3f-bfc7-cb0c43f1aef9@redhat.com>
Date: Thu, 7 Nov 2019 17:46:13 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191104151323.9883-7-crosa@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: B2W4YtXxNgq9G51Nz42JAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Beraldo Leal <bleal@redhat.com>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, qemu-ppc@nongnu.org,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 11/4/19 1:13 PM, Cleber Rosa wrote:
> So that when binaries such as qemu-img are searched for, those in the
> build tree will be favored.  As a clarification, SRC_ROOT_DIR is
> dependent on the location from where tests are executed, so they are
> equal to the build directory if one is being used.
>
> The original motivation is that Avocado libraries such as
> avocado.utils.vmimage.get() may use the matching binaries, but it may
> also apply to any other binary that test code may eventually attempt
> to execute.
>
> Signed-off-by: Cleber Rosa <crosa@redhat.com>
> ---
>   tests/acceptance/avocado_qemu/__init__.py | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/acceptance=
/avocado_qemu/__init__.py
> index 17ce583c87..a4bb796a47 100644
> --- a/tests/acceptance/avocado_qemu/__init__.py
> +++ b/tests/acceptance/avocado_qemu/__init__.py
> @@ -110,6 +110,12 @@ class Test(avocado.Test):
>           return None
>  =20
>       def setUp(self):
> +        # Some utility code uses binaries from the system's PATH.  For
> +        # instance, avocado.utils.vmimage.get() uses qemu-img, to
> +        # create a snapshot image.  This is a transparent way of

Because PATH is changed in a transparent way, wouldn't be better to also=20
self.log.info() that fact?

> +        # making sure those utilities find and use binaries on the
> +        # build tree by default.
> +        os.environ['PATH'] =3D '%s:%s' % (SRC_ROOT_DIR, os.environ['PATH=
'])

I think PATH should be set only once at class initialization. Perhaps in=20
setUpClass()?

- Wainer

>           self._vms =3D {}
>  =20
>           self.arch =3D self.params.get('arch',


