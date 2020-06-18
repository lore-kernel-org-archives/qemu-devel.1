Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C04C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E01920888
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:45:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E01920888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46302 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlvnW-0006ow-FB
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 10:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jlvmZ-00061x-Br
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:44:47 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:58991)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jlvmX-0004iu-FS
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:44:47 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MplPf-1j71vT3YgX-00qCEt; Thu, 18 Jun 2020 16:44:43 +0200
Subject: Re: [PATCH v2 2/2] linux-user: Add strace support for printing
 arguments of ioctl()
To: Filip Bozuta <filip.bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200616105147.21736-1-filip.bozuta@syrmia.com>
 <20200616105147.21736-3-filip.bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <0d2d6a32-f10f-4dd7-548a-aef005b031e5@vivier.eu>
Date: Thu, 18 Jun 2020 16:44:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616105147.21736-3-filip.bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ekNBrfS1rfn5VEHG3dtLNo1w+vJQPXIjYyO5vbam2z2viHcihGu
 tupinYgktmsY9pMYjOlFXIwRIZMrnnLj8rAuZD34KgbpVO5bPBCvUdT9sqN00obPmBZjOaD
 EAkANzJYwIuXRx8agm+jko6BDv/UNkUpD2ulyTUF2MctU3a3YiyQ97a21WDjzcyVjc8rsQr
 SnBCbggBK1Yy1olDvG64g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ImfYZs+zgpI=:VPvqR6op4ieCW5V6NSQT6I
 GFiZ19/3tiYl9hLMWw4ggEmz2xNKeBnj3ef9ImsZarWhIrYdQPH5W1wjcWayEWR6Y7eju8wlh
 pulXjh3Nw/nWjUUSy9kEKX1ZFxUclyX8FcZySOdVp8EmB99qaw4DjbgFBEyJ4lqKD2dbJ8fDf
 fRJtv6CLPOVFMr7iGs72nLD6XbAw5d5Fq/qxKEhvALlGpKscc3q9IUizs3UF17X5cA7TcYa2a
 TRC8QQyBW3a7MSYfoff7lvXBi0LYDJ4yZxxP4Kal3GrXrmWg0qhtasIrYrOXek+3y/xEjBSu/
 GZ8bp3UguzP+PCzhNZJ512iMRy0S4PGvQggZG+LwktaJCf+BF4/f0wf8dm4VWbdmwvDIP1X8j
 4z1U2XgMF0C98Sge+mxQtrl0Cc3+djCUc8CYX9InciShzF8KNb0jCiXzKMbPKglmxij3TmIFM
 c1YBsuZxfEVqFDhtTxnxzi+TuFUf8TzgvjMsRuPgL9VCFCNfJRG1cqojaP9Db7CNejT6f0fOe
 RMixV7eAnj+VyPSxEsu+U2J9ngB2IOrK9HUfFybbibDs2grwuAD8Kf5Np4IaQneJQbPU2BrjJ
 s8BLP+Hn5sVs6ilpn0eH0MOprkVqR2KEeo3uQivAMdbRfuwadUyOLvEgpqMXgfffY0k+pVx+W
 lc45Hcvpt+S3WlbvzXJGp/n2LbZDvFRspiqp0hEjNNt8I1BeXG1Y5yrvP8E77hiFleZQHvaaP
 2l5C/7hXMPMfRyPyBFQaHKdHj7Q63qGx4C5qRHdFgB0GjZuNYVDs6NsxuLliY4mhQPQBMC6Ym
 pIZ+tdmHYa+kWEKYInkkVTWB+qabGuxgMcYwWh069QLAq9JUSQ=
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 10:24:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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

Le 16/06/2020 à 12:51, Filip Bozuta a écrit :
> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
> 
> This patch implements functionality for strace argument printing for ioctls.
> When running ioctls through qemu with "-strace", they get printed in format:
> 
>     "ioctl(fd_num,0x*,0x*) = ret_value"
> 
> where the request code an the ioctl's third argument get printed in a hexadicemal
> format. This patch changes that by enabling strace to print both the request code
> name and the contents of the third argument. For example, when running ioctl
> RTC_SET_TIME with "-strace", with changes from this patch, it gets printed in
> this way:
> 
>     "ioctl(3,RTC_SET_TIME,{12,13,15,20,10,119,0,0,0}) = 0"
> 
> In case of IOC_R type ioctls, the contents of the third argument get printed
> after the return value, and the argument inside the ioctl call gets printed
> as pointer in hexadecimal format. For example, when running RTC_RD_TIME with
> "-strace", with changes from this patch, it gets printed in this way:
> 
>     "ioctl(3,RTC_RD_TIME,0x40800374) = 0 ({22,9,13,11,5,120,0,0,0})"
> 
> In case of IOC_RW type ioctls, the contents of the third argument get printed
> both inside the ioctl call and after the return value.
> 
> Implementation notes:
> 
>     Functions "print_ioctl()" and "print_syscall_ret_ioctl()", that are defined
>     in "strace.c", are listed in file "strace.list" as "call" and "result"
>     value for ioctl. Structure definition "IOCTLEntry" as well as predefined
>     values for IOC_R, IOC_W and IOC_RW were cut and pasted from file "syscall.c"
>     to file "qemu.h" so that they can be used by these functions to print the
>     contents of the third ioctl argument. Also, the "static" identifier for array
>     "ioctl_entries[]" was removed and this array was declared as "extern" in "qemu.h"
>     so that it can also be used by these functions. To decode the structure type
>     of the ioctl third argument, function "thunk_print()" was defined in file
>     "thunk.c" and its definition is somewhat simillar to that of function
>     "thunk_convert()".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> Based-on: <20200616103927.20222-1-filip.bozuta@syrmia.com>

To work, I think the Based-on tag must be set in the cover-letter of the
series.

> ---
>  include/exec/user/thunk.h |   1 +
>  linux-user/qemu.h         |  20 +++++
>  linux-user/strace.c       | 107 ++++++++++++++++++++++++++
>  linux-user/strace.list    |   3 +-
>  linux-user/syscall.c      |  20 +----
>  thunk.c                   | 154 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 285 insertions(+), 20 deletions(-)
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


