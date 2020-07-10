Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6701C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91AF420748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 11:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zp/Ca4kS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91AF420748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtrS7-0004Rn-T5
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 07:44:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtrRE-0003zR-P3
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:43:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58006
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jtrRC-0005Gs-2w
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 07:43:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594381408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=ML75WD+90Fett/Dr2JwiOxAyRTCdyuGSUrI6n8p+3wg=;
 b=Zp/Ca4kSmR145A51e4s/M3vWV+WG83Pgezv26XdPgar4XNv86GubmpsNTzG9SCXA9ZBFT7
 y6UjR8e4otRwDYGGPTyhjf4jrYJY2HulTbqxmkH1dOlTc9qjspwO2xVP8UuPnOfPhcgRjA
 yAxcBEDsWYmpRXp3SS2BkOzPihUWGQg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-HbwiFkZsMb2dLLJ9kRz8xA-1; Fri, 10 Jul 2020 07:43:26 -0400
X-MC-Unique: HbwiFkZsMb2dLLJ9kRz8xA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AD4C100CC84;
 Fri, 10 Jul 2020 11:43:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-68.ams2.redhat.com [10.36.112.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C211574F5F;
 Fri, 10 Jul 2020 11:43:16 +0000 (UTC)
Subject: Re: Separate notifications from list messages?
To: Liviu Ionescu <ilg@livius.net>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <E646BE29-B46F-4B56-ADF5-B0DC6CCEF422@livius.net>
 <0a3689e1-001a-76ec-894d-0bb63115ecdd@redhat.com>
 <CAFEAcA-Y_e9V2UTEZoVbxOWQcs_eP96cMQ1J2BtC6Y0AAUTgSA@mail.gmail.com>
 <FF6A540C-7C16-4FFC-9A6D-FAB9EFE56B7F@livius.net>
 <CAFEAcA_c3M-NQcXMt7pnA1qn9B8AYSnFMP1zHx3i_cU2cqpnSQ@mail.gmail.com>
 <008CCEB6-D3F4-4F1A-80DE-83F47873851F@livius.net>
 <20200710085454.GD4017912@redhat.com>
 <94ACA177-24F6-461F-B12E-79958D713BF1@livius.net>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <663720e1-7ee1-8d0b-df6e-ada96bfc3e8a@redhat.com>
Date: Fri, 10 Jul 2020 13:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <94ACA177-24F6-461F-B12E-79958D713BF1@livius.net>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/09 23:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Qemu Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/07/2020 11.24, Liviu Ionescu wrote:
> 
> 
>> On 10 Jul 2020, at 11:54, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> This wasn't a mistake - it was very delibrate, precisely so that all
>> involved in QEMU development will see the failures, instead of expecting
>> a handful of people to take all the work of dealing with failures. In
>> general anyone who's a regular contributor has a shared responsibility
>> to help keep QEMU building reliably.
> 
> Yes, sure, but the typical workflow allows anyone to submit contributions, these contributions are automatically checked by CI, and if they pass, someone with administrative rights merges them into the repo.
> 
> Thus the main responsibility for dealing with failures goes to the contributor, there is little the community can do to fix the failures.

Ok, I think here's the misunderstanding: The Gitlab messages that you
can see currently on the list are from the main repository, not from a
contributor's private repo! Yes, there is currently quite a bit broken
in master, and that's why you get all these messages via the mailing
list. Before Philippe turned them on, they went almost unnoticed, apart
from some few people who used gitlab on their own. Now these problems
get at least some more attention ;-)

 Thomas


