Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E103C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:28:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 169172075D
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:28:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169172075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=qindel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv7R4-00076t-7g
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 17:28:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44641)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <salvador@qindel.com>) id 1iv7QC-0006Bi-Or
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:27:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <salvador@qindel.com>) id 1iv7QB-0008VA-8Q
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:27:24 -0500
Received: from smtp.qindel.com ([89.140.90.34]:48402 helo=thor.qindel.com)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <salvador@qindel.com>)
 id 1iv7QA-0008Sv-WE; Fri, 24 Jan 2020 17:27:23 -0500
Received: from localhost (localhost [127.0.0.1])
 by thor.qindel.com (Postfix) with ESMTP id 596146068A;
 Fri, 24 Jan 2020 23:27:21 +0100 (CET)
Received: from thor.qindel.com ([127.0.0.1])
 by localhost (thor.qindel.com [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id KI7bDLL54LY3; Fri, 24 Jan 2020 23:27:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by thor.qindel.com (Postfix) with ESMTP id 2136D6068C;
 Fri, 24 Jan 2020 23:27:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at thor.qindel.com
Received: from thor.qindel.com ([127.0.0.1])
 by localhost (thor.qindel.com [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id o8WKc5YtLEzB; Fri, 24 Jan 2020 23:27:20 +0100 (CET)
Received: from [192.168.20.140] (unknown [82.213.225.96])
 by thor.qindel.com (Postfix) with ESMTPSA id D35176068A;
 Fri, 24 Jan 2020 23:27:20 +0100 (CET)
Subject: Re: [PATCH] bsd-user: improve support for sparc syscall flags
To: qemu-devel@nongnu.org
References: <157989507891.23531.10374377357103915501@f6d1ed32ca6b>
From: =?UTF-8?Q?Salvador_Fandi=c3=b1o?= <salvador@qindel.com>
Message-ID: <6cb0886b-2b28-6dd2-92d4-7b524a6b4bf7@qindel.com>
Date: Fri, 24 Jan 2020 23:27:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <157989507891.23531.10374377357103915501@f6d1ed32ca6b>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 89.140.90.34
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
Cc: qemu-trivial@nongnu.org, sfandino@yahoo.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 24/1/20 20:44, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20200124183113.58039-1-salvador@qindel.com/
>
>
>
> Hi,
>
> This series seems to have some coding style problems. See output below for
> more information:

A new patch is coming fixing the errors found by patchew in bsd-user/main.c

I am not changing any of the new code in bsd-user/netbsd/syscall_nr.h as 
it has been copied from NetBSD source, in the same way it was done for 
bsd-user/openbsd/syscall_nr.h.



