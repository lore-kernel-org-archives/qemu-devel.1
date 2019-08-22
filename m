Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD35C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:48:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2EAB205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 22:48:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2EAB205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48480 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0vsm-0002G8-Q2
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 18:48:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i0voV-0006og-7G
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:44:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i0voT-0007VN-6X
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:44:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41358)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i0voT-0007U5-18
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 18:44:13 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 108FCC057FA6
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 22:44:12 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id v4so2368514wmh.9
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2019 15:44:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:openpgp:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=4r8DGozLmpYo3Rn1qUJI/+ygRuvz98L8ycGH8Hf7ed8=;
 b=Sazq9envHPU2V/c25sf1QnC6uqTzX0k1t1b8rRGxyqm1uWLP42Ov5oSaLFrS9HMNkF
 7PAO6b4GxHfmumovVLFE5/dpTRLW6ieRcQcfdqJhkS/iBIP7yJtavnFGHyPfsH6NaO+f
 24b39nT8WWHcqNPCXVbIQKnEV+hnbJCu2RuP1Ej4icNM5T37BObWac5M6awriH0pZ6Ys
 f47cq1mqrXC8HZlh1/wlQVEeZGFuGwnCZW8u6f5AOTqNMGD8mNFddcdJy0HaH2/eKLvA
 Nsr95Zgq1pzN097+PUcAL4BJUBzftHcA3srJ8Uz81mVBo72NcZQDO1zR0jzJEionN8wv
 cLaQ==
X-Gm-Message-State: APjAAAWghQ5BUSVVqXfud8GR1BNwBk9puA6JycQFwZpbbFrmbuGg6aO4
 vmQUALVZqcJWpXB+ilhWwmCMvC+JUaPDiTcwCAwZ0viDOk9B3dzTitG7aj1JMGfcuD+9M/OLzqn
 kW1pOprBdA2eHXWQ=
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr1138898wrs.200.1566513850865; 
 Thu, 22 Aug 2019 15:44:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqySX9A33kWlnSxQAA0eLhlbVy1fvezope02dy/hGKs4hjnMK7Bbj7X4NC6e1qP3kuobFYscbw==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr1138893wrs.200.1566513850700; 
 Thu, 22 Aug 2019 15:44:10 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id t8sm2486541wra.73.2019.08.22.15.44.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2019 15:44:10 -0700 (PDT)
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3be10e98-f2db-60e1-d846-40c16c70da7b@redhat.com>
Date: Fri, 23 Aug 2019 00:44:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] contrib/gitdm: Add group map for RT-RK?
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar,

I noticed this list of contributors:

Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Dejan Jovicevic <dejan.jovicevic@rt-rk.com>
Lena Djokic <Lena.Djokic@rt-rk.com>
Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>
Milo=C5=A1 Stojanovi=C4=87 <Milos.Stojanovic@rt-rk.com>
Petar Jovanovic <petar.jovanovic@rt-rk.com>
Stefan Brankovic <stefan.brankovic@rt-rk.com>

I see most of the commits are MIPS related (a few are PPC).

Should we add these emails to contrib/gitdm/group-map-wavecomp or should
we rather add a new group-map file for this company?

Thanks,

Phil.

