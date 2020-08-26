Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6764BC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34169208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 13:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URWT4LaR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34169208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAvvH-0007ca-GA
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 09:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35790)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblot.com@gmail.com>)
 id 1kAvuS-0006fy-2g
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:56:16 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:36304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <eblot.com@gmail.com>)
 id 1kAvuO-000159-Mr
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 09:56:15 -0400
Received: by mail-wm1-x32c.google.com with SMTP id z9so1868304wmk.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 06:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=i21jYN1rb1ssaRcH0pt9EWaKZ298pcauQwU2bsVQdCE=;
 b=URWT4LaRL+1YHjgcgS9d5NICqD2L1yM/7BLOI2Mmke8Riha1y3xOzXZQNkkaH7iZe8
 lze87mXAd3vyGOVJ/TFISELeM3PpirOAc6SKVn11/SiHeh6Dpg6QIYeIgwB+jc7wzvcH
 yXNmFAQztBTFRXRdNVPKHzIH9JmUsDpB4hmvvfOYJ0M183B8T7ZvFPeCZZefPSSIXJ3+
 RhkWLaRHT3UqTP3ZGMV3REsjqF9Y3cHg5EwyCsRE7qiuBUAinCrykMrWY6CLz17I7nmG
 X1GwlwW8jmgjYJXOyA3rJzzFDtxkgglWPQ58orzhd491LSkoC6bTOG0eNuGQhNuCMiof
 lLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i21jYN1rb1ssaRcH0pt9EWaKZ298pcauQwU2bsVQdCE=;
 b=omGrIPzU19D/PzMDQgSTtfydyy6RSczgQWfpdGStPPacMC04Ha5QI3z5Tqe6B33eua
 8TEFSUst6EmK8h/Epc0jEli9CS4HDXPWUvvC91pSqbE2hZsl6s5/FWmcbxLW3CazFljB
 1pdZ5Recp8qYarFpC85NfmAZCgCp2+7ccrzJHVnOzvs5aMr7M3yiviAxBB7H9lVdn08F
 NYFOpHklopE19ILm4WF7qzVqX2xXE2EyLMmfvKV/5jAl20gJkRJ5VeSYEiNIaUt1e/So
 A6jMzajLpmnTXA2IUfO0v9DngzQp3AIcBgxIqKAPB3/9tVCE+NiESKqMWDtb0bk24UHb
 axXA==
X-Gm-Message-State: AOAM533cuSZddpDk/OO6XnPYXFpsM8rKCzIWWuA3GTouFcOCcWBb060k
 l44y163TuyNdBD3MQEkidAk=
X-Google-Smtp-Source: ABdhPJxj6RF4YYyYV2lVECyHr5pqJlha22Czn8XV9702M72dnlTVzA6h/C/2BYYYTtYmjVBgZq0BOA==
X-Received: by 2002:a1c:105:: with SMTP id 5mr7675252wmb.83.1598450169856;
 Wed, 26 Aug 2020 06:56:09 -0700 (PDT)
Received: from [192.168.15.71] ([195.200.173.126])
 by smtp.gmail.com with ESMTPSA id v29sm6468007wrv.51.2020.08.26.06.56.08
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 26 Aug 2020 06:56:08 -0700 (PDT)
From: "Emmanuel Blot" <eblot.com@gmail.com>
To: "=?utf-8?q?Marc-Andr=C3=A9?= Lureau" <marcandre.lureau@gmail.com>
Subject: Re: Issue with submodules on macOS & meson
Date: Wed, 26 Aug 2020 15:56:07 +0200
X-Mailer: MailMate (1.13.1r5671)
Message-ID: <EC53DB3B-58D1-40CA-BE7C-845089C68567@gmail.com>
In-Reply-To: <CAJ+F1CKk_jYqPPsGUPLk+MLBUymSeMNjEKpqRR2e-xQry9N3=Q@mail.gmail.com>
References: <9AB9A3F5-8AA6-4F82-9693-D331251AA0CB@gmail.com>
 <CAJ+F1CKk_jYqPPsGUPLk+MLBUymSeMNjEKpqRR2e-xQry9N3=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=eblot.com@gmail.com; helo=mail-wm1-x32c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26 Aug 2020, at 15:50, Marc-André Lureau wrote:

H Marc-André,

>> You need to run 'make' (at least once - but still by preference for now).
> Submodule handling is done by Makefile.

Ok, thanks a lot for this tip.


