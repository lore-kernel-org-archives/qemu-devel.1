Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E519ACA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 14:56:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC23C20650
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 14:56:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC23C20650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQYLK-0003lM-Pc
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 10:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <samuel.thibault@gnu.org>) id 1iQYK5-0002rc-EF
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:54:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <samuel.thibault@gnu.org>) id 1iQYK4-0001Ie-I2
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:54:45 -0400
Received: from hera.aquilenet.fr ([2a0c:e300::1]:56808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <samuel.thibault@gnu.org>)
 id 1iQYK4-0000yz-Bp
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 10:54:44 -0400
Received: from localhost (localhost [127.0.0.1])
 by hera.aquilenet.fr (Postfix) with ESMTP id 9D33364D8;
 Fri,  1 Nov 2019 15:54:40 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
 by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id d8yx9E4OkEUG; Fri,  1 Nov 2019 15:54:38 +0100 (CET)
Received: from function (unknown [IPv6:2a01:cb19:979:800:9eb6:d0ff:fe88:c3c7])
 by hera.aquilenet.fr (Postfix) with ESMTPSA id 9DFDC63C4;
 Fri,  1 Nov 2019 15:54:38 +0100 (CET)
Received: from samy by function with local (Exim 4.92.3)
 (envelope-from <samuel.thibault@gnu.org>)
 id 1iQYJx-0004uW-EN; Fri, 01 Nov 2019 15:54:37 +0100
Date: Fri, 1 Nov 2019 15:54:37 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
To: Jordi Pujol <jordipujolp@gmail.com>
Subject: Re: [PATCH v3] smb daemon get additional command line parameters
 from env variable
Message-ID: <20191101145437.tr4gervnn2m5qvci@function>
References: <CACTE=gpFbUSxXeTwu6_tzSeoh_9Yp905aMdzCPCUz3h7kcgeyw@mail.gmail.com>
 <144c1b0a-5cd4-b657-025b-f44d5e812e06@vivier.eu>
 <CACTE=goN=Nw8b5RN8sWhX9mRNWEU0fhuc=HnD3MJW59BET=hkA@mail.gmail.com>
 <20191031161547.pipit5hxzjnf6jmt@function>
 <CACTE=godCrD7GiPbOnds3uRgrVhrZYBY+Ojsa85EVd31pd6h1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACTE=godCrD7GiPbOnds3uRgrVhrZYBY+Ojsa85EVd31pd6h1A@mail.gmail.com>
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a0c:e300::1
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
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Jordi Pujol, le ven. 01 nov. 2019 15:38:19 +0100, a ecrit:
> +    options = g_getenv("SMBDOPTIONS");
> +    if (options) {
> +        smb_cmdline = g_strdup_printf("%s %s", smb_cmdline, options);
> +    }
> +    g_free(options);

But then do not free it :)

Samuel

