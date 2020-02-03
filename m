Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 181ECC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:44:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D750120721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:44:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igSlgjPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D750120721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyc1o-00067A-2E
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51660)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iyc1D-0005hw-5A
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:44:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iyc1B-0004me-Qn
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:44:03 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51491
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iyc1B-0004mF-N4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580737440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=v7BVoP5q1bx7LrSMb1WmDPoayQtUUmcEZ4S2b7UKaFw=;
 b=igSlgjPrs35ZDJ16OkBnNxz8yCT/73ogMJpExuF1fJ81N/r39i/9FGeAc9aVdCl89WdstM
 Sp/zwSNPEcgUPEHiQLq1vqMbU3NxIzOWEghEp7FPpxTfjwT0rwdn1amz6qBHNuUi2MfpCk
 YDAaARj9a+yDsgRMnOXHATsacJ3Fe1o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-8SZ4u-lmMrifDFCM_U9KKw-1; Mon, 03 Feb 2020 08:43:59 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AE64801E6C;
 Mon,  3 Feb 2020 13:43:58 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FBBA5D9CA;
 Mon,  3 Feb 2020 13:43:54 +0000 (UTC)
Subject: Re: [qemu-web PATCH] Update the documentation links to point to our
 generated docs
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200203131919.9972-1-thuth@redhat.com>
 <CAFEAcA8gzuukXwrLLAyYfP3kNVRNZCXwhPNNhWothXiWfqghOA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <31632598-1fbd-5cfb-a899-1c81a8c04c48@redhat.com>
Date: Mon, 3 Feb 2020 14:43:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8gzuukXwrLLAyYfP3kNVRNZCXwhPNNhWothXiWfqghOA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8SZ4u-lmMrifDFCM_U9KKw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/02/2020 14.28, Peter Maydell wrote:
> On Mon, 3 Feb 2020 at 13:19, Thomas Huth <thuth@redhat.com> wrote:
>>
>> We are now providing the generated QEMU documentation files directly
>> on our www.qemu.org webserver, so we should link to these files now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  _includes/footer.html |  2 +-
>>  documentation.md      | 14 +++++++++++---
>>  2 files changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/_includes/footer.html b/_includes/footer.html
>> index 1669ef7..e67ffd7 100644
>> --- a/_includes/footer.html
>> +++ b/_includes/footer.html
>> @@ -14,7 +14,7 @@
>>                 </ul>
>>                 <ul class="style">
>>                         <li><a href="/documentation">Documentation</a></li>
>> -                       <li><a href="https://qemu.weilnetz.de/qemu-doc.html">Manual</a></li>
>> +                       <li><a href="https://www.qemu.org/docs/master/qemu-doc.html">User manual</a></li>
> 
> This is the old texinfo user manual, and it no longer contains
> all the information it used to (as we have been moving parts of
> it out to the rST manuals). It's going to go away entirely
> at some point. The equivalent "here's the top level of the docs"
> in the new rST world is https://www.qemu.org/docs/master/,
> which has links to the various rST manuals (and also the
> qemu-doc.html).

Oh, ok, thanks, I see now your point in the previous thread.

I'll change this to point to https://www.qemu.org/docs/master/ ...
(but in the long run, I wonder whether we should keep this big footer on
each page at all, or whether we should rather replace it with something
smaller)

 Thomas


