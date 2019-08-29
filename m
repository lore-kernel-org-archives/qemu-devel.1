Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8619C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:09:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E31E2073F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 16:09:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E31E2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3MzG-0004cx-NP
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 12:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36873)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3My1-00039i-Fm
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3My0-0004Yc-GJ
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:08:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56310)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3My0-0004Y6-An
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 12:08:08 -0400
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8CB5F51EF9
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 16:08:07 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id g2so1401888wmk.5
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 09:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7WP6VtFAxTtheR4ssGOO+dTmQnwcnAA/AlFcKxktReo=;
 b=VJM4o7hnAZrQSQLYLIJT4T2J/C8p926JVFXGlpyt7DquGFJlii1zHXDz3D9jzt7Qor
 JNPhyR7EWvXzaJjZDi4fO+CvkqZ/NssTGrle7CMK4i2EZOKF/CENvnBFvDeveromE23u
 MhjZu478ll9uoVbjc1QvSj/dxRbsQ7OQcceJld95uYbDHCMwDNrs05UomnT+jcMLNHEC
 KkVAtGK1OWEX9B7Qix0Z1aoeYprd+fER+ULLahWpvV+vn0Nw1OxmPCrdRTHcoiySBbgb
 bryrbcWSxzmxI+vsNPpaLFs88NgYiRkjndnJahYK83tzjgVhdw0oZ5CpBDL72BDgSO+v
 keYA==
X-Gm-Message-State: APjAAAUTTeS1uz4g7wRR1B7QuhoqK2+feCAY0ABuTZMUOMErS7HtRxyn
 JMPsSqsgjiWYXvs+7+ZVp4DNJtQk7UXczHhKcfxXG0ItHrwZRyVvSDnFwDGUYNLAc2/RlhuXkC9
 efqZ1Lc6hEQnMQcQ=
X-Received: by 2002:a05:600c:2411:: with SMTP id
 17mr11605017wmp.171.1567094886245; 
 Thu, 29 Aug 2019 09:08:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzj3ouTb9A5JmFHFaUQ+WnX5zZAAH9DK32HQq4pKm92ouvlMAGSamfqUEOFzYDbgkknszD8Uw==
X-Received: by 2002:a05:600c:2411:: with SMTP id
 17mr11604990wmp.171.1567094886076; 
 Thu, 29 Aug 2019 09:08:06 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id t14sm3262446wrv.12.2019.08.29.09.08.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 09:08:05 -0700 (PDT)
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
References: <20190829100521.12143-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e198cc91-bb53-e817-1145-4a4d2ec822b0@redhat.com>
Date: Thu, 29 Aug 2019 18:08:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190829100521.12143-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] git.orderfile: Order Python/shell
 scripts before unordered files
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oops Cc'ing qemu-trivial@nongnu.org

On 8/29/19 12:05 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> This series update the git.orderfile to order Python and shell
> scripts before unordered files.
> This is particularly useful for changes in tests/qemu-iotests.
>=20
> Regards,
>=20
> Phil.
>=20
> Philippe Mathieu-Daud=C3=A9 (2):
>   scripts/git.orderfile: Order Python files before unordered ones
>   scripts/git.orderfile: Order shell scripts before unordered files
>=20
>  scripts/git.orderfile | 5 +++++
>  1 file changed, 5 insertions(+)

