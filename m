Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557E3C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:14:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3233225722
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 08:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3233225722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59398 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXi74-0006Px-Cl
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 04:14:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hXi5p-0005ls-Eq
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:13:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hXhuh-000759-54
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:01:53 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hXhuf-0006Pn-LW
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 04:01:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so6091938wre.7
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 01:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=wfNe27NMx0zlUqSQRCaCNlc+UkMhiTNJEksUZxsq4B8=;
	b=gLYVYuwjt+47Da8oVEuuzny3d1WU+lQf8hJurjbDr2yrlW0dAB24X/vJGrMja9TnIS
	hgU5VvMo5nxhvPqC1wcN7c4DbTRUb7TqVMs+MNtDA1KKrqV05Lq1sPifgWz3ljsDHO/t
	yytPoTrn3/ZfA00W7OJUK+lVkTyrtG8rMI+xJxrFAv7Gr1WQPiQ3rHxBwV7hL5bWnpvc
	f5oHQDny06YlZPcRUU0x7/ioGEKS/ZBHVOAoy1pvtVTOxtIqPNFagvPklWLnUjuuNBpg
	4Rtzm6kKoTLgHqe/eQWX/BkshoLWZCkkVz9R7Ft7QEi/l6Uc/1SC5r8uSBZLATYZYuLF
	zbFA==
X-Gm-Message-State: APjAAAWEV9FJqtcv0qNhvDy6BZIYRDcW0u/87ABLzMCQFyp0PfVOQSOr
	u3Iq2Ur1znYZaSmBB6WsDdyVrw==
X-Google-Smtp-Source: APXvYqz+7OeOEWDtN49krHdV5c+zH0Trxykik5sooePcCNFSfvkJ82pWc+oWNFZABRcRTCPdtigx9Q==
X-Received: by 2002:adf:fa03:: with SMTP id m3mr16011275wrr.21.1559548887006; 
	Mon, 03 Jun 2019 01:01:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d43d:6da3:9364:a775?
	([2001:b07:6468:f312:d43d:6da3:9364:a775])
	by smtp.gmail.com with ESMTPSA id
	v13sm10498139wmj.46.2019.06.03.01.01.25
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 01:01:26 -0700 (PDT)
To: Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>
References: <20190530092919.26059-1-peterx@redhat.com>
	<20190530092919.26059-2-peterx@redhat.com> <87r28eok96.fsf@trasno.org>
	<20190603062142.GA31512@xz-x1>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d11825ea-c46a-f734-6a47-ecc3250f1259@redhat.com>
Date: Mon, 3 Jun 2019 10:01:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603062142.GA31512@xz-x1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v3 01/12] checkpatch: Allow
 SPDX-License-Identifier
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
	"Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/06/19 08:21, Peter Xu wrote:
> On Fri, May 31, 2019 at 02:56:21PM +0200, Juan Quintela wrote:
>> Peter Xu <peterx@redhat.com> wrote:
>>> According to: https://spdx.org/ids-how, let's still allow QEMU to use
>>> the SPDX license identifier:
>>>
>>> // SPDX-License-Identifier: ***
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>
>> Althought this patch don't belong to the series O:-)
> 
> Right. :)  And Paolo should have queued the patch.
> 
> To make life easier, I plan to simply drop this patch in next spin and
> change the only user of "// SPDX-License-Identifier" patch in the
> series to simply use "/* ... */" since I just noticed vast codes in
> QEMU is using that... then we don't have to depend on this patch.

No problem, I'll send a pull request today.

Paolo

