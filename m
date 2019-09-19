Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B758FC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:12:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B09205F4
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B09205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAxAc-0007BH-Ug
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAwxA-0007b5-5E
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAwqn-0002Aw-M0
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:52:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44106)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAwqn-00029Z-Gi
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:52:01 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 47FB164132
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 13:52:00 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id t11so1104389wro.10
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 06:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2I/QFFNOpwYufZDIchbsJ8ibuXr+OBeCA/S1C9KAdqU=;
 b=LKMUXd46mXN2+DYh7XE8HAivUeqqBIhP7g18mlmq4ZkVTaZW3W3SbEFLXIVhmQOIS1
 RF/nB1LWP8C+g2d99+uFHY3jPaDVV34QXdqB9scoddIJfY+7NCCFo0/pFiQeaxWFGQbf
 U9OF1yLc2iNwV2+/ps9516LZFBMUNMCQFpVVznOIpvarTVlGZsJAh+kfV3+49CvhBFwb
 HJk7RLXe7tRzVYrJ9uYX1yLurgBtg9tx2KM3ucmmxyBDPxMZY0CnFpBv7CEsFoXHnN2i
 aTjZkN9rT0pupGP+8WMox9p5hWo3SLQcx56HqNMyhqmz7dhMf0RFR+49R8S3tCcFG8Qi
 63ag==
X-Gm-Message-State: APjAAAUakaUOikRM+G9y4/Ec4RRMJTx3UGDOvtVSSCKS33T1EVvBBjwi
 0krlDnKmlaRIiFIO4UE6FMCYGB0Ya63s5A9KTP3fkpcdf8oqNeovHSVGrF0wJG3uONo7plVG4Rj
 /JBuPWEMGITm6qkQ=
X-Received: by 2002:a7b:c956:: with SMTP id i22mr3202481wml.90.1568901119108; 
 Thu, 19 Sep 2019 06:51:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxZNvXKZBCSX5MgThTZyfCI0xyHD32HgbrFUGXW/2OJfmoNfUWDwZyA0aYZQB9YFOozC39HuQ==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr3202459wml.90.1568901118924; 
 Thu, 19 Sep 2019 06:51:58 -0700 (PDT)
Received: from [192.168.1.115] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id i73sm3844687wmg.33.2019.09.19.06.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Sep 2019 06:51:58 -0700 (PDT)
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20190912231202.12327-1-mdroth@linux.vnet.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <4d90ff88-07ad-b456-bae4-bd635e192d02@redhat.com>
Date: Thu, 19 Sep 2019 15:51:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190912231202.12327-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] Fix tarball builds of UEFI/EDK2
 firmware
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
Cc: lersek@redhat.com, brogers@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/13/19 1:12 AM, Michael Roth wrote:
> Bruce noticed that we cannot build `make efi` target from the v4.1.0
> tarball. This is due to a failure on the part of the make-release scrip=
t
> to pull in submodules nested under other submodules, as well as
> Makefile.edk2's assumptions about being in a git tree.

Hmm I'd expect distributions interested in building EDK2, build it
properly tuned, outside of QEMU. I consider what is here as default
config useful for testing, not for production use. I might be wrong.

Meanwhile, it is true 'make efi' should not fail.

> Suggestions for more robust solutions are definitely welcome, but for
> now this series takes what seems to be the most direct approach.

This is fine:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

I'll queue these patches in my edk2-next branch since I'm preparing a
pull request.

Thanks,

Phil.

