Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B4AC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DD8620857
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 09:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="El+rawpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DD8620857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQp3o-0002oK-Mu
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 05:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33596)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQp38-0002LM-Vv
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:18:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQp38-00063V-9u
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:18:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21155
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQp37-00062a-S0
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 05:18:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587460716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=iSUVEwQkxoYgYDPdXZzV/jA+JVT5Fad+tUOa7NT5hTI=;
 b=El+rawpcY/1z/TBQ55x3E72nl33TwIVG1CAhZPEBsEJdVw03IttbY0h8luFuZAGodHuUX3
 /6S0faWt50nacCOM+tH9HmCxsfedkaky8NMnXhN0XNwEAkGIE9qaxXiFOL2Fw7vyQOni1/
 iGlKDAoG40GeDwH1gCQdssrbyLv2xQI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-5dnbC34gPVulrnOR9e87wg-1; Tue, 21 Apr 2020 05:18:31 -0400
X-MC-Unique: 5dnbC34gPVulrnOR9e87wg-1
Received: by mail-wr1-f70.google.com with SMTP id u4so7220544wrm.13
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 02:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
 :content-transfer-encoding;
 bh=iSUVEwQkxoYgYDPdXZzV/jA+JVT5Fad+tUOa7NT5hTI=;
 b=Mg2XbUIZm67PGkvbDMx7KmLvdXfk6PpZweeReky2hiqhuzfQweBNJ2uiBuZBw89f4F
 /c2nH1E8IdojEC8tlidlcgCfJcRl3ioLviUR2ok2BH8owDJc8899Kl9x7iv15sIprtth
 kqLjwWc9Ldrs5AuqOF/JuxhyjFpvwK3AiWAX8RhXch1N0gLjYD7ZR2I8yJietKsiCqoF
 3OfL37jLwYFT8dviAlCxSmnGxlcWWT+2jee51JISe0nilY6k8Q6ogLbFT4S0dGUtOY1g
 D7gcMYav7xqmMkarP4GgjNFdGe+fVudd0LCjlvcdcgorFJlV+hMiVvXxW18fUOn7AqBw
 Os9w==
X-Gm-Message-State: AGi0PuaWJaRZxzVIx9ceF1SPNpSlOuGYdT2jpJgblZ1QCyOUG4VwY4RC
 PuabIq3QpmKH8/krBWlxVfvzMrAlvJQchMV3A1t/50Ew5qjulCHkoOwdgWdjeBKy7XMbRW8MWU9
 +udbKznVLMpuEYp0ExIoFFYycbT184ZU=
X-Received: by 2002:a5d:420d:: with SMTP id n13mr25225964wrq.204.1587460710555; 
 Tue, 21 Apr 2020 02:18:30 -0700 (PDT)
X-Google-Smtp-Source: APiQypJc0SjTXzV5tt5wRg8o5NoTaonzgDHlLLl6LzhVsr1wg43hoJ++C1B3CdX9ikFNiSnEKxFPxqjVXUlSy6Gxko4=
X-Received: by 2002:a5d:420d:: with SMTP id n13mr25225941wrq.204.1587460710331; 
 Tue, 21 Apr 2020 02:18:30 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Tue, 21 Apr 2020 11:18:19 +0200
Message-ID: <CAP+75-UisNwFqedDPfuGt=HFEEnPSO7sNq9JxpUuLPVdYDryuw@mail.gmail.com>
Subject: SLiRP: use-afte-free in ip_reass() [CVE-2020-1983]
To: Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 Marc-Andre Lureau <marcandre.lureau@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 03:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Samuel and Marc-Andr=C3=A9,

Peter is going to tag 5.0-rc4 (final before release) today.
Do you have plans to send a last minute pull-request to fix CVE-2020-1983?

https://gitlab.freedesktop.org/slirp/libslirp/-/commit/9ac0371bb

Regards,

Phil.


