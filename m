Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C91C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9D7F20866
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 12:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9D7F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k41Av-00034u-Tu
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 08:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36642)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k41AG-0002c0-Pk
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 08:08:00 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42767)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k41AF-0005VV-12
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 08:08:00 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MXH3Y-1kESNI2nFe-00Yjfj; Fri, 07 Aug 2020 14:07:54 +0200
Subject: Re: [PATCH 3/6] linux-user: Update SO_TIMESTAMP to
 SO_TIMESTAMP_OLD/NEW
To: Shu-Chun Weng <scw@google.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <cover.1595461447.git.scw@google.com>
 <945da0d5e224e70c42bd7085d44bb2440168f60d.1595461447.git.scw@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <fbdc32be-b439-77b0-83a5-f0a08efe5071@vivier.eu>
Date: Fri, 7 Aug 2020 14:07:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <945da0d5e224e70c42bd7085d44bb2440168f60d.1595461447.git.scw@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:N2e1jIf4YSEG5TGg9IyaHNgmcF2L8HU6gDX639NSxIhTos8a1vu
 ihXRbfYMej+Lvzq+Fu2vyw4hSDjAVtWAGbK3WH6TjGKXF8Ec4i46TdOlD8IWb8q7895pE/x
 eYhDeZFKOk9/CZY28kgQFxFcVi7WNLwPIByuA1msyWiNw1o1tqrls2eZAhDGahojghErk5t
 1PzeEqGNtLqZCVUtw1O9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sJ72Ihvr2wg=:X0u8yclpRvJ/6vmH3mL6+y
 xtRT/OAQCfZRdPk6Cv0fuxfsCUYDXqh/m63ODYwVJYLBmy0FrFJW4CGQdmQf1A+vMwjIp0NgQ
 ug8knzwVYZT6m2rvePAYrse5p9/NwGUaCwS+VoZeUMZPv8C01EIDnq1maawHfth8/ojg/XMZ6
 PQMFtA3cDamutcwmUWN7ZUBbS1objN5WfS/U1BhCZznTjFVHxsxXfc6fKN/ZdYZvGxKFyZriw
 0NLCgyf5LOeXFaTKTn3Si7ti4lDJ5RCTeKttknOpl7z4k/J720kYnhEOcVHkT4lc5kPtgipk3
 8J8uR0pOJwtJEKSRxcT8rrWkWpxhlevbW0Jfv+hQxrbQ64cwwPk69wIpheYx1HqVaDU3bWCD9
 uRMMtYgGbWjhQNZh2oxHiEZLn0CXTVA0xe/r711hNRTG/QH2CVt+bs4zxc3RmdtFnYTJlEogo
 Qle07wu8KBGldL+tAKpp0jTH1Q3+sPtgMDCyZ5+VIO7yQavkD30iAJXI1zAyVRR8S6SvRjtt6
 2LrkSvV0bjc1kU+XWeYZxj/MKiqKX0Q1gFFqmCFAa5bvOZth0xNHRkKOyRu27FoVHKxcKgA4W
 kqZeQahb+7rkjO39WN06ZfuIpIQ8wBPTRktL3/hELEXmIXPy5WgUs0PY4o3S9sDDOEbi3lYvn
 mQCLqgRXkMyelNhmSnlg6e8/0ScSbWHBMR6pFqAZLwjbsHNFN6wDdgHZJHowpwmil8krBE+V0
 l0pTona9eSob400muP4OR9QVV8gd1HlLjdmJD8v+hyQvN6OwHWUXhQ2Pph2Mn7a6dWZNsQvGL
 kt33pJKCFIS2rt4SB+nRZgLiActHtajePjDWsxJCdrtyY4BKDXFXQVdC8bXR9+RtJHfRxfI
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 07:17:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 23/07/2020 à 02:19, Shu-Chun Weng a écrit :
> Both guest options map to host SO_TIMESTAMP while keeping a bit in
> fd_trans to remember if the guest expects the old or the new format.

I don't think we need to keep this information for each fd.

Once a program has used the _NEW version it will always use the _NEW
version. It's possible to mix, but I don't think we have to support
this. This adds too much complexity.

> Added a multiarch test to verify.
> 
> Signed-off-by: Shu-Chun Weng <scw@google.com>
> ---
>  linux-user/alpha/sockbits.h            |   8 +-
>  linux-user/fd-trans.h                  |  41 +++-
>  linux-user/generic/sockbits.h          |   9 +-
>  linux-user/hppa/sockbits.h             |   8 +-
>  linux-user/mips/sockbits.h             |   8 +-
>  linux-user/sparc/sockbits.h            |   8 +-
>  linux-user/strace.c                    |   7 +-(fd)
>  linux-user/syscall.c                   |  69 ++++--
>  tests/tcg/multiarch/socket_timestamp.c | 292 +++++++++++++++++++++++++
>  9 files changed, 419 insertions(+), 31 deletions(-)
>  create mode 100644 tests/tcg/multiarch/socket_timestamp.c
> 

Thanks,
Laurent

