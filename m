Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F10AC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 20:36:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36DA92075A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 20:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="suJxtYlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36DA92075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnTAj-00027q-EC
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 16:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jnT89-0008HP-2y
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 16:33:25 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d]:45542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jandryuk@gmail.com>)
 id 1jnT87-00031C-5I
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 16:33:24 -0400
Received: by mail-lf1-x12d.google.com with SMTP id d7so10395428lfi.12
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 13:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=4mVoyL2zNAqGyZ2Atn/eutyBqxa/yw21nCBslNZLJdY=;
 b=suJxtYlckZvugRErHhopXGyvzHiGcRVutgVuU6LAyvY5obkxUo9d5YvFy2FH6VIf+h
 6HUb42wgZ9QVWgySM7Y2/kfUMqHeB99U7nuJHiK1dFjpvtL7T9+xa1eqUAZVwV3tPIob
 KEVlQGduAdP++XpMZjmet+dd26ipYaZq4jDWQ4rdIoHYMIJn/Cp0crgb9HOjLUjTWAOU
 TLeMeJp3dGAHXRoBvEaNLvMDr1h5U7NBrakXkg95GIrxpgkdp4MSnJ/xV2pHgz2o4zol
 HC0+/9s+rMPJqs2yzYPVGEr0y3VCyFqgcMUypdonGwGLKarw5Kb5Q5qqtkzV2k2r8SAe
 paAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=4mVoyL2zNAqGyZ2Atn/eutyBqxa/yw21nCBslNZLJdY=;
 b=SPtZwYNpq9WYdqCOe2R0ZYeQk2afs3Fw3D2YnQTFwuQmqH7ASCx6ZO/l+5+SCvGMVL
 R9wZ6TFDZXCTNqxHJ+BkZvNEa6UKK1SVe8fpf4Rjuep/Kea32pusGQJfE0PJ2MIj3rEt
 kG43rTciHRw3RGZEflyfzt6FTzhauR7jRkQMucq66QyhFxqLqbEcF/BWybpIMEgLUxEl
 UQCUecxbAO9UXv8L19leb7ywpnoWDJ0qs1hjS/h7SolYDpO7s8qMHtmxgRcxf5yqidSs
 LCzqvYUVv1e9p6ZqyK3H42zdEiX5iKXnGav2oDMnXdxtes7jygUHYQeoAw03TYrJE9Bf
 OCdg==
X-Gm-Message-State: AOAM533z7fJqSbKB7FmgPjC/pxgSPYAD3MMogW6DGfyM3W4D2WxHm5HB
 SsfpCnxA/syGo1fV0Ze8cnSVY9IRSZZYRwc+Wpa9WzwD
X-Google-Smtp-Source: ABdhPJyEtjtgqI457ZpiHwadW+wM55mq6wUWDwE/hJk43J7BbO+VFenO9m7QvkMe8EQ9JuKmhBBlfP7JPenXEqkW8gw=
X-Received: by 2002:a05:6512:3049:: with SMTP id
 b9mr10668922lfb.44.1592858000356; 
 Mon, 22 Jun 2020 13:33:20 -0700 (PDT)
MIME-Version: 1.0
From: Jason Andryuk <jandryuk@gmail.com>
Date: Mon, 22 Jun 2020 16:33:09 -0400
Message-ID: <CAKf6xpuSD3NC2bLPQN75e2pR8asu9Ey1xTGxTNeCR_1MGsnPOg@mail.gmail.com>
Subject: sysbus failed assert for xen_sysdev
To: QEMU <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>, 
 xen-devel <xen-devel@lists.xenproject.org>,
 Anthony PERARD <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=jandryuk@gmail.com; helo=mail-lf1-x12d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

Running qemu devel for a Xen VM is failing an assert after the recent
"qdev: Rework how we plug into the parent bus" sysbus changes.

qemu-system-i386: hw/core/qdev.c:102: qdev_set_parent_bus: Assertion
`dc->bus_type && object_dynamic_cast(OBJECT(bus), dc->bus_type)'
failed.

dc->bus_type is "xen-sysbus" and it's the
`object_dynamic_cast(OBJECT(bus), dc->bus_type)` portion that fails
the assert.  bus seems to be "main-system-bus", I think:
(gdb) p *bus
$3 = {obj = {class = 0x55555636d780, free = 0x7ffff7c40db0 <g_free>,
properties = 0x5555563f7180, ref = 3, parent = 0x5555563fe980}, parent
= 0x0, name = 0x5555563fec60 "main-system-bus", ...

The call comes from hw/xen/xen-legacy-backend.c:706
sysbus_realize_and_unref(SYS_BUS_DEVICE(xen_sysdev), &error_fatal);

Any pointers on what needs to be fixed?

Thanks,
Jason

