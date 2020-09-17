Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E3AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49C5722208
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cvNdR/99"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C5722208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIvzj-0002pq-90
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIvqU-0002rF-W7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIvqR-0006bg-VT
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:29:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600356550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j6AQ108w21LAK39mep8AOEBBvM+iDOpoRFlIol4D9Qc=;
 b=cvNdR/99K98BGtGbyXyYQCQSRMwS2Q269vH453rmQs/WnwOOIs/DRYs87gAwvcc/9WK6mc
 tP/0L0XvS/RKL6diHY+jNuLY33mK4v11Mfvcpk6SJDkIlHO+dH8qenhWYtA1MZnCVo8fr3
 6sL28WPlrGX5PNPcRALgrRvK7x9ZQP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-LqSHVl1LNMOLtKK1Txbvbg-1; Thu, 17 Sep 2020 11:29:02 -0400
X-MC-Unique: LqSHVl1LNMOLtKK1Txbvbg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 063EA8BF143;
 Thu, 17 Sep 2020 15:29:01 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 30C0F55767;
 Thu, 17 Sep 2020 15:28:59 +0000 (UTC)
Subject: Re: [PULL 00/24] qtests, unit tests and Cirrus-CI fixes / improvements
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200916114731.102080-1-thuth@redhat.com>
 <CAFEAcA8VyUYJnE3aji6zPQGPD-K+iVGwVNbygYypr+NpSzZBPw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7c21af54-342f-2a29-f700-3b1d3bbd5bc6@redhat.com>
Date: Thu, 17 Sep 2020 17:28:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8VyUYJnE3aji6zPQGPD-K+iVGwVNbygYypr+NpSzZBPw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Yonggang Luo <luoyonggang@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/2020 17.14, Peter Maydell wrote:
> On Wed, 16 Sep 2020 at 12:47, Thomas Huth <thuth@redhat.com> wrote:
>> ----------------------------------------------------------------
>> * Fix "readlink -f" problem in iotests on macOS (to fix the Cirrus-CI tests)
>> * Some minor qtest improvements
>> * Fix the unit tests to work on MSYS2, too
>> * Enable building and testing on MSYS2 in the Cirrus-CI
>> * Build FreeBSD with one task again in the Cirrus-CI
>> ----------------------------------------------------------------
> 
> After merging this one I tried installing GNU sed on my local
> box so it could run the iotests, but they fail like this
> because they assume readarray, which doesn't exist in
> OSX bash
Ok, sounds like I should respin my patch here:

https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg04476.html

... and could you install a newer version of bash via homebrew on your
system?

 Thomas


