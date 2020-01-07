Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FD2C33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D13D20656
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 10:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8LLCYp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D13D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioloB-00033h-47
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 05:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ioliN-00066u-6X
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:03:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ioliK-0002fC-O7
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:03:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52241
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ioliK-0002f1-K6
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 05:03:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578391432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=3pA9hprEcqlk7xqqIFHWewip/xdNWWqBhtCjMK712K8=;
 b=M8LLCYp93Ddfv2C9zXlbFfPQDqgXbBCuM7Rg8IR3CseUdDVS6xaQi1vZvvEVm32STpz62A
 E6OafHi0k1lW8TaI4poU+Vn8hja9sL99sNktQXC+qw/up7Y1oQjCcNlv3WGX8g1WQPTu/h
 tTWpDfIA5fnxehB2iF8LQl/9XcLPaoQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-rf21LxklOFyr55dbHQP56g-1; Tue, 07 Jan 2020 05:03:49 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CED3A1807463;
 Tue,  7 Jan 2020 10:03:47 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-116.ams2.redhat.com [10.36.116.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 813BC60BE2;
 Tue,  7 Jan 2020 10:03:41 +0000 (UTC)
Subject: Priority of -accel (was: [PATCH] tests/qemu-iotests: Update tests to
 recent desugarized -accel option)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20200106130951.29873-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c493e693-13a7-7dc4-eb2d-5dbc7b3053f1@redhat.com>
Date: Tue, 7 Jan 2020 11:03:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200106130951.29873-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: rf21LxklOFyr55dbHQP56g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/01/2020 14.09, Philippe Mathieu-Daud=C3=A9 wrote:
> Commit 6f6e1698a6 desugarized "-machine accel=3D" to a list
> of "-accel" options. Since now "-machine accel" and "-accel"
> became incompatible, update the iotests to the new format.
>=20
> Error reported here:
> https://gitlab.com/qemu-project/qemu/-/jobs/385801004#L3400
>=20
> Reported-by: GitLab CI
> Fixes: 6f6e1698a6 (vl: configure accelerators from -accel options)
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  tests/qemu-iotests/235   | 2 +-
>  tests/qemu-iotests/check | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/235 b/tests/qemu-iotests/235
> index fedd111fd4..3d7533980d 100755
> --- a/tests/qemu-iotests/235
> +++ b/tests/qemu-iotests/235
> @@ -49,7 +49,7 @@ qemu_img_create('-f', iotests.imgfmt, '-o', 'preallocat=
ion=3Dmetadata', disk,
>                  str(size))
> =20
>  vm =3D QEMUMachine(iotests.qemu_prog)
> -vm.add_args('-machine', 'accel=3Dkvm:tcg')
> +vm.add_args('-accel', 'kvm', '-accel', 'tcg')

Looking at this, I wonder whether we really want the "-accel" option to
prioritize the accelerators in the order of appearance? A lot of other
CLI tools give the highest priority to the last parameter instead, e.g.
"gcc -O3 -O1" compiles with -O1, and not with -O3.

Also I think it might be quite common that there are shell scripts which
call "qemu-system-xxx -accel xyz $*" ... and if we don't invert the
priorities of -accel, it will be impossible to override -accel in that
case...

 Thomas


