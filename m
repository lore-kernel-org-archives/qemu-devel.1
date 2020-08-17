Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BD7C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:48:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B466720789
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 14:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IT7t/oMV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B466720789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7gR3-0005nT-Vm
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 10:48:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGk-0003ig-QN
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:50 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:39219)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <paolo.bonzini@gmail.com>)
 id 1k7gGj-000640-8Q
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 10:37:50 -0400
Received: by mail-wr1-x42d.google.com with SMTP id a5so15257010wrm.6
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=z41Kpgt+yU4SOPCuSOOqqnFemAYvfNxaLEX2fcjYGAc=;
 b=IT7t/oMVNHUp260IHFCt0kgpddtSDPEyfcqdiZskhcuBFyEVLJtd+BJptsFjfI27gD
 wGdITdda0LUUqq6DZfPeR7V/fIvpNDsVWmLQ/NCppIpZeSrtyibwAcOjJpWZw8v9Ha/E
 2rSLmoW3smRUVO5WZHEg+9U5aOsDbVBfIGb7IFzoDUO0ck7hOPBQvoynJBoGRMHXjSEk
 ksprmxATFcPRL0UHLC+zVftGxMiAzrvB/hPFrG83z2bKPbtP6f/tuOhKmAN5+BBghXHL
 xm8O12ayYcHzR513bomh7U/Z8gikDd4fFZ7aHY9EYwoBoZaxcj83tvrQX5/c6pRz7gdr
 7E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=z41Kpgt+yU4SOPCuSOOqqnFemAYvfNxaLEX2fcjYGAc=;
 b=LK3GTW43AAj/YYZQdfA3/4ZM6/Z68osSrR6asdvwdH6Qt75nU+j2YO70FpmAdkixQ8
 iA1h/pA+VMMwsjrcD5Y+D3mmY7687rQx+EP7oezA3LF3OJG/htht2EAzUylpX0A+QhPi
 H/YtmeKt8+Bju2dtHceYEQi5pSKeF427K6WZ//KBlDs7zTqlmrU6IS7pcDi5gEIvbmx+
 Gm2uydR9IA2aUQuGsHwpz6yEb65YX0tPXza4obJVaau2uLFIcHDmytAsRQIH4+SFBDm/
 +31d9qGJ0g4FNLRY5iFFtWvjxOgPqzMTE98MexKI8LztFUe0VC8LD5DbFpAafIveFYbN
 uOCg==
X-Gm-Message-State: AOAM530Fy59Q1e2qm1g/sMwzh/kmYCWD+CFMTaXa2j1J+aGjHnFYsBs/
 XSD/FGam6oDww9pF2RjFJO5/oVx3/ZM=
X-Google-Smtp-Source: ABdhPJzqQ3ZVvyegasg01Nk1sUapLtcIpTCEWAwr1k0YymnY2fYU7qfp12xt4iGJVtgdv0rlUs5PyA==
X-Received: by 2002:adf:e647:: with SMTP id b7mr16942384wrn.220.1597675067740; 
 Mon, 17 Aug 2020 07:37:47 -0700 (PDT)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:a0d1:fc42:c610:f977])
 by smtp.gmail.com with ESMTPSA id
 i22sm34966603wrb.45.2020.08.17.07.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 07:37:47 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 020/150] meson: enable pie
Date: Mon, 17 Aug 2020 16:35:13 +0200
Message-Id: <20200817143723.343284-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200817143723.343284-1-pbonzini@redhat.com>
References: <20200817143723.343284-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=paolo.bonzini@gmail.com; helo=mail-wr1-x42d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index 7bcc9704d8..dcdf7312c8 100755
--- a/configure
+++ b/configure
@@ -8464,6 +8464,7 @@ NINJA=$PWD/ninjatool $meson setup \
         -Ddebug=$(if test "$debug_info" = yes; then echo true; else echo false; fi) \
         -Dwerror=$(if test "$werror" = yes; then echo true; else echo false; fi) \
         -Dstrip=$(if test "$strip_opt" = yes; then echo true; else echo false; fi) \
+        -Db_pie=$(if test "$pie" = yes; then echo true; else echo false; fi) \
         $cross_arg \
         "$PWD" "$source_path"
 
-- 
2.26.2



