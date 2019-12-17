Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF61C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:11:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53BF2067C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 18:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elez5hmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53BF2067C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihHK8-0007ss-LF
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 13:11:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39151)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ihHJT-0007Ph-0B
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:11:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ihHJP-00060u-JZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:11:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59150
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ihHJP-0005se-3T
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 13:11:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576606270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=wkIcpolS57vVS9fzxwArH0a1QlqpQA80PbbohhHK3QA=;
 b=elez5hmrypax/s5mbRefY4gnwgV45HUaJudPt9OcvSC7EmsyZQCmQ2dBLWTOlbcsAUuIvs
 VQ5FZB7CIjKOseWCsuLmDTDJAumrKSaO8RZcbaiKdy2ZbeAG4T+ZLUOw2jizr50wm/9/rb
 fqpC7aFokSI7F+UrlPPG/e5B22xhMcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-xkpdJ5YmODGctiMPoews1w-1; Tue, 17 Dec 2019 13:11:05 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 216A918A6ED3;
 Tue, 17 Dec 2019 18:11:04 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-149.ams2.redhat.com [10.36.116.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30A7B19427;
 Tue, 17 Dec 2019 18:10:56 +0000 (UTC)
Subject: Re: [PATCH-for-4.2] hw/mips: Deprecate the r4k machine
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191125104103.28962-1-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <691a359f-f923-5e2d-6beb-2f9c0a0aca8c@redhat.com>
Date: Tue, 17 Dec 2019 19:10:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191125104103.28962-1-philmd@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: xkpdJ5YmODGctiMPoews1w-1
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
Cc: libvir-list@redhat.com, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi,

On 25/11/2019 11.41, Philippe Mathieu-Daud=C3=A9 wrote:
[...]
> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> index 4b4b7425ac..05265b43c8 100644
> --- a/qemu-deprecated.texi
> +++ b/qemu-deprecated.texi
> @@ -266,6 +266,11 @@ The 'scsi-disk' device is deprecated. Users should u=
se 'scsi-hd' or
> =20
>  @section System emulator machines
> =20
> +@subsection mips r4k platform (since 4.2)

Since the patch has now been merged after the release of 4.2, the mips
4k platform will be deprecated in 5.0 instead. Could you send a patch to
fix it up?

 Thanks,
  Thomas


