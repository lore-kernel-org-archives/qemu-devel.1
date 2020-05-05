Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1821CC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:08:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F06206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 11:08:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJIkz7mN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F06206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVvQs-0003dJ-1I
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 07:08:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jVvQF-0003Dr-RK
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:07:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32437
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1jVvQF-0004mF-7F
 for qemu-devel@nongnu.org; Tue, 05 May 2020 07:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588676854;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type: content-transfer-encoding:content-transfer-encoding;
 bh=m3bA68ec7aJml5ryrkpGt9Ig1LpeVBADh46vzuQRoAA=;
 b=VJIkz7mN39O97HTLwt/rt26hHlc0yEsN8cXvPc4JchD+RKSFJ6bXNnXH35mNNuoIiK1tT8
 viKEzO3Zlq11sF5ffh4uaYLA4aEe9thM6h40NVps+U5cqDaI3FGAt1V/qNVawb7Ond+uSj
 JlR7qkSeQFpfTSNLr0h0oOEUNoc3674=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-IhBEfQZxNpG8ShCbeFIczA-1; Tue, 05 May 2020 07:07:32 -0400
X-MC-Unique: IhBEfQZxNpG8ShCbeFIczA-1
Received: by mail-wr1-f70.google.com with SMTP id y4so1044254wrt.4
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 04:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:user-agent:reply-to:date
 :message-id:mime-version;
 bh=m3bA68ec7aJml5ryrkpGt9Ig1LpeVBADh46vzuQRoAA=;
 b=CQLoU7RKD4bRb/yWsWdhuEIQrGNe0399odOZo1KQ8L9Jkt6X8iPNkMBXsZanQrUr8f
 A4z9ocWGkafeSMA/23t9KxuZtaeIzqJGS50I/dPPGgUssmLSN1oymrbq40hs1/TmYFhS
 tJHYMwhD9ritvxQI3/f1Vl8oYRnszjiEZNwkX+CSRf/2V0VzL/gDYFOnBqg9UNe93xqh
 n/fk5cBYvTg+5A9Yjd1flkGFSrvFDEbbcftOViBn+JKXUVt3MHWpWwx6nHVNHi3UXaUN
 hP+oFYcK+c9N+WGyWIGGjDGDRQSknN7weHer6UD5jJbU6gccOk+sT2W6bbqDVDim5LRb
 iinw==
X-Gm-Message-State: AGi0PuaX3+955gFHNOSEWtdr058nPZVtCySmuwekAUxd/2RlkX+oQ+K4
 S1EhBFV5wONEqGJewwPBhiwZxXe1VpELq6GxJzy5le05y4iEn3bhvD26JWfCwKHNzDrhxGYRoE4
 cefPKA0HQ5K42sr8=
X-Received: by 2002:a1c:bc05:: with SMTP id m5mr2531718wmf.143.1588676851647; 
 Tue, 05 May 2020 04:07:31 -0700 (PDT)
X-Google-Smtp-Source: APiQypILdwtkxnuPE3FDz6NiBdV3FIPkHW9bo4jcwFh56XElEqBE0ePyzvx4rn6ssrZ8iH+8iAiT9Q==
X-Received: by 2002:a1c:bc05:: with SMTP id m5mr2531702wmf.143.1588676851460; 
 Tue, 05 May 2020 04:07:31 -0700 (PDT)
Received: from localhost (trasno.trasno.org. [83.165.45.250])
 by smtp.gmail.com with ESMTPSA id x6sm2722021wrv.57.2020.05.05.04.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 04:07:30 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: kvm-devel <kvm@vger.kernel.org>, qemu-devel@nongnu.org
Subject: Today KVM external call canceled
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
Date: Tue, 05 May 2020 13:07:29 +0200
Message-ID: <87sgge4p3i.fsf@secure.mitica>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Hi

As there are no topics, we cancel that call.

Happy hacking.


