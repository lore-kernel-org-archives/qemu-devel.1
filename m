Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBBAC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B3282078D
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fAFgY6Gd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B3282078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlsT9-0004SH-Qp
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 07:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1jlsSZ-0003un-Mt
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:11:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33207
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cdupontd@redhat.com>)
 id 1jlsSW-0006Ws-9r
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 07:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592478709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=PhFFqOE/6NiuAC73kE6e+Oel9jLWbcjfi5sNyrUNwWo=;
 b=fAFgY6Gdtkyj/AidEtEareZejLmgVjsYItk9WfNdkXLRBss+ZYhonHq4cmQ8Yqfgd8aFMS
 FYaxNal5NXxo3ukdlNuGF31gFugio2sdz5KzvLiv4wrtLpXpGRgEf0y6ymdHP9EiHKX/D4
 3qg8k3d5cPqMO++tUiToiUS3GscI07Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-TBj1MG41Oj6rj9F_3Hw7Lg-1; Thu, 18 Jun 2020 07:11:47 -0400
X-MC-Unique: TBj1MG41Oj6rj9F_3Hw7Lg-1
Received: by mail-wr1-f71.google.com with SMTP id s17so2645807wrt.7
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 04:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:content-transfer-encoding:mime-version
 :subject:message-id:date:cc:to;
 bh=qBFVAZj9ES6dIVHV/vnB6qtnuHPavYFhg2YUi4Nrf3Q=;
 b=MEfeosuoY7LhtqnDVi3U5CvHmlIrObu/tyYo9vtc9qJ8R/bb8Bjn2CSR7sA/V/E5EA
 qRFrnUn0RuIiXClzn3EUglHZmta+tbrjdF/Qvy2AHA+hDzgxpghmv6YTur6e9OFQf0DN
 cxt+YC2Il0G7ukXJ262P8H18rBPSR1d6BZOxNrsfOgGkvkSNzdjqFFkO2b4kX//hzMKD
 hXknzpvXrVFw1W9oecRCoOO6tSw0tKe3TM4BJh/9G1ec+Uz+DoxcyPorU+y6eeTHAtoy
 we5lROxsbSDAIA33MUWUS1Uj6avsb+X9abtu63slaZnrh/HSdg2ZwWhSlmQiKxA5nH7y
 parQ==
X-Gm-Message-State: AOAM5308eMgkV5QoODGf1Iu8c8yeU3svVqN+dYXbs3kqSzSpKa4kdgdq
 sLHef3UxNX4mvCay1l5F31DR97cP9MSaQMLOscQ+HOEBghWbKOL0Gn3XWQ5N+A/ihL6jrNXNfcJ
 wnsqIh/EHkYJ54hg=
X-Received: by 2002:a05:600c:2f17:: with SMTP id
 r23mr1581784wmn.167.1592478706831; 
 Thu, 18 Jun 2020 04:11:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlxiugsqmNo3PJHjvnUVmEHEBzQ1wEuHQySeRUXGirUuT90jLmBVHNce0dajou2isN/PtLsw==
X-Received: by 2002:a05:600c:2f17:: with SMTP id
 r23mr1581764wmn.167.1592478706584; 
 Thu, 18 Jun 2020 04:11:46 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:466:71c0:2c54:ca9a:7576:7f1b?
 ([2a01:e0a:466:71c0:2c54:ca9a:7576:7f1b])
 by smtp.gmail.com with ESMTPSA id s72sm3269006wme.35.2020.06.18.04.11.45
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 18 Jun 2020 04:11:45 -0700 (PDT)
From: Christophe de Dinechin <cdupontd@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Understanding initialization order for spice in qemu
Message-Id: <1D26F746-92AA-4BA4-BF92-A498DA2C67C9@redhat.com>
Date: Thu, 18 Jun 2020 13:11:44 +0200
To: Gerd Hoffmann <kraxel@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cdupontd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 00:57:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Gerd,


When I build qemu on master with moduels enabled, and run with spice, I occ=
asionally see:

 qemu-system-x86_64: util/module.c:136: module_load_file: Assertion `QTAILQ=
_EMPTY(&dso_init_list)' failed.

Interestingly, I seem to have seen that only on master, but not on my own b=
ranch. Have you ever seen the same problem? Could there be a race condition=
 here explaining why I sometimes see it, sometimes not? Or do you think it'=
s more likely to be a missing build dependency? Asking because I don't reca=
ll ever seeing that on a clean build.

Command line:
% qemu-system-x86_64  -display spice-app /data/VMs/deb9.qcow2



Thanks
Christophe


