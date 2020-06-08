Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC18C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 05:06:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4C952076A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 05:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G6VwwDaO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4C952076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji9zr-0004Fk-WD
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 01:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54626)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ji9yt-0003ib-NW
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 01:05:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52599
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ji9ys-0001lT-1r
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 01:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591592750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=CPMxd5l4w+1Nu7ibZQbJjc3qMzFpoEGM8aFr1GNlvys=;
 b=G6VwwDaOMqaU7gL6R7V3iVijg6zYXYUB1KMpKaxcEeQo0qhbTkH+t1fwOfzEKpbIu32O0D
 U82Us2WRyP0quuRs+R6TDgr4ZTgHScoFZ+amA/jVIfj+wVq65/BtLyGi7zwtZijqxqwo/u
 H+j6kZCZcBCMhLjWjICYdSM5I+DEBDY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-Pfoy0we1O_WDoVlEkoCxhQ-1; Mon, 08 Jun 2020 01:05:44 -0400
X-MC-Unique: Pfoy0we1O_WDoVlEkoCxhQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B773D835B41;
 Mon,  8 Jun 2020 05:05:42 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-119.ams2.redhat.com [10.36.112.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C0BB1A92C;
 Mon,  8 Jun 2020 05:05:40 +0000 (UTC)
Subject: Re: [PULL 00/19] Linux user for 5.1 patches
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200605114700.1052050-1-laurent@vivier.eu>
 <CAFEAcA9f3jLSnf=M_V4tuWjjY12QFqzp5_PvkdbG38AmEK6dAw@mail.gmail.com>
 <67f3b206-6bf1-65c3-1054-3aded4c69a23@vivier.eu>
 <CAFEAcA_TFYV=+f=NNib4dO2WTxaaN4wjwcdQPie2biAs2REk-g@mail.gmail.com>
 <0e188008-88dd-e6b3-a4b4-321bdbc39ba6@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3d3c14c4-c0a5-be84-c756-f9458828e54e@redhat.com>
Date: Mon, 8 Jun 2020 07:05:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <0e188008-88dd-e6b3-a4b4-321bdbc39ba6@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 01:05:50
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/06/2020 23.48, Richard Henderson wrote:
> On 6/5/20 1:32 PM, Peter Maydell wrote:
>> On Fri, 5 Jun 2020 at 20:20, Laurent Vivier <laurent@vivier.eu> wrote:
>>> I was thinking this kind of problem would be detected by the travis-ci
>>> builds, but in fact ppc64 and s390 builds don't build other architecture
>>> linux-user targets.
>>
>> That's an unfortunate gap in the CI -- we should ideally cover
>> the whole tree with at least one big-endian platform.
> 
> Indeed.  Hopefully we can do this with our pending gitlab setup.
> 
> For travis, IIRC we only build this restricted set because we had problems with
> timeouts on those machines.

Right. But we could add one more tests with
--target-list-exclude=${MAIN_SOFTMMU_TARGETS} --enable-user in Travis
... I'll have a look...

 Thomas


