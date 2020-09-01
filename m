Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10B5C433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:03:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AF9F206A5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 10:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="VAm85e5a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AF9F206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=anisinha.ca
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD38J-0003BE-LP
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 06:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD2vK-0003bE-Vh
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:49:55 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42533)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ani@anisinha.ca>) id 1kD2vJ-0002vs-8D
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 05:49:54 -0400
Received: by mail-pl1-x642.google.com with SMTP id j11so269405plk.9
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 02:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=4834Yl5zUq4lYqLurBCzdM7FK/8XcDOr5NIl4flgx7c=;
 b=VAm85e5aaGV6PkvqK7C/+B4DNTQ+CYV7KRUC2+8rG33mz2DCy/eS64c7af1E0Z7giL
 llWP1qpB3ykMKYKaTFU8RmwjNE0m1e4AFlTv2Hw0N2ASVxYjy3qya7GkMqI/UpOwNum1
 Hf2zuDyzwqg8uPuNz8+9i9DxBCdnaM3Qyw2KRdIajyN9ZECEyOFRd1ljdfQabo8D4rBg
 Wq68DYW+uC+n/yO58q8lqkLHjLFhjvRiXvPOyP0HO5NqeWALXBofOzqSgHeiEr2W3JdR
 /TxjAtTjAd7PNfoZN0Hsr+uAuB4lWnPhRIadaNpts4QX5Ujcp8oeaF/xhUd3R8WCVTub
 en5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=4834Yl5zUq4lYqLurBCzdM7FK/8XcDOr5NIl4flgx7c=;
 b=p0hCeuZ1vqIIAPjAYLz9JrZeep1TmWX/NHilD10xKz2cjhecJnjmjUgKGDvdGsnW7R
 1Pvnhsz+RUfgFq/6qRYdzZO33nUNj3qrLDT4O5zB5Dxe84yJOgHP59/vLb+iAR0WQsU7
 Q8mwDVYNxsaozYhlVSGd6FoWJvw+TonvLJxaI3QO9n0gDDweFNh4RwveZ/cTtFEBwTPD
 oJf26IrptfnjJAY2a8ZGStIgrAog7+1g9CJN1mG0YZBjBhiMV46QpS+qAHQK70fIov4Z
 WjgmURRZy63ev8UmeJFV9EPNKBn1Cz0bS3ksxSp9simraoYEW9W/C+5HvcNCwhgiv72e
 ZH0g==
X-Gm-Message-State: AOAM5331zfOh4w1WnQVYHiMq+2DUDzbva0m2uvMP7hY3x1y+XIVfn3to
 MJNi7xoDmRU47+B9ScoUttnd+Ad14+RROQK1
X-Google-Smtp-Source: ABdhPJxjWydadiIgoLy6xNi9HJhUhb7vOvE07JQJnvZla7sRXX8gH2RbOGQcDlPGMpHKvkeOK9R7OQ==
X-Received: by 2002:a17:902:708c:: with SMTP id
 z12mr689672plk.258.1598953791024; 
 Tue, 01 Sep 2020 02:49:51 -0700 (PDT)
Received: from localhost.localdomain ([203.163.237.89])
 by smtp.googlemail.com with ESMTPSA id o63sm1081872pfb.190.2020.09.01.02.49.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2020 02:49:50 -0700 (PDT)
From: Ani Sinha <ani@anisinha.ca>
To: qemu-devel@nongnu.org
Subject: RFC [PATCH] piix4: don't reserve hw resources when hotplug is off 
Date: Tue,  1 Sep 2020 15:19:21 +0530
Message-Id: <20200901094922.25514-1-ani@anisinha.ca>
X-Mailer: git-send-email 2.17.1
Received-SPF: none client-ip=2607:f8b0:4864:20::642;
 envelope-from=ani@anisinha.ca; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, jusual@redhat.com,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a RFC patch. This patch attempts to disable all acpi hotplug related hardware
initialization and amls when hotplug for both pci root port and pci bridges are
disabled on i440fx machines.

Thanks for looking at it and please provide comments. I will add unit tests when the final
patch is ready and accepted.

--Ani



