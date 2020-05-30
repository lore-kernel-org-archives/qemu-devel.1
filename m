Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C23C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 17:26:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA0C220723
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 17:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBkyVsbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA0C220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jf5FD-0004hW-Th
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 13:26:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57324)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jf5Ed-0004D4-MR
 for qemu-devel@nongnu.org; Sat, 30 May 2020 13:25:27 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49302
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jf5Ec-0007Qw-BM
 for qemu-devel@nongnu.org; Sat, 30 May 2020 13:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590859524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=+Lp8UyUfZGWp/JtelO0zUKQdScBiLCqoPkGHMnQON1w=;
 b=bBkyVsbA2DxBOCqJKHULGWw52tQE+r8bWnyxCKGkhMoiUQ1u4AlBgiS0AhcUQv0fBDf8Sn
 PZh5f43UgNdnS4AU4lOgI4coUYACAUw5YqBfdDa2l7O/wpjtco4bTL7djXCRIGP9YiwgwW
 IKpJbzutSXfdsGjm9DzQUhTaTi5n9Qg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-Xrphb0gzMq6LZOVn9AP8MA-1; Sat, 30 May 2020 13:25:22 -0400
X-MC-Unique: Xrphb0gzMq6LZOVn9AP8MA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE755460;
 Sat, 30 May 2020 17:25:20 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-47.ams2.redhat.com [10.36.112.47])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B88F65D9C5;
 Sat, 30 May 2020 17:25:14 +0000 (UTC)
Subject: Re: [PATCH] tests/acceptance: Add boot tests for sh4 QEMU advent
 calendar image
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200515164337.4899-1-thuth@redhat.com>
 <CAHiYmc72cA9Va_JCbzq+E0M3wUuxedH2=BdE-YqAqWF8DBD_kA@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <658ce012-150d-40ee-0689-0262971e20b4@redhat.com>
Date: Sat, 30 May 2020 19:25:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc72cA9Va_JCbzq+E0M3wUuxedH2=BdE-YqAqWF8DBD_kA@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 12:00:48
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 30/05/2020 10.54, Aleksandar Markovic wrote:
> 18:44 Pet, 15.05.2020. Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> је написао/ла:
>>
>> Now that we can select the second serial console in the acceptance tests
>> (see commit 746f244d9720 "Allow to use other serial consoles than
> default"),
>> we can also test the sh4 image from the QEMU advent calendar 2018.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com <mailto:thuth@redhat.com>>
>> ---
>>  I've split my original patch that also added yet another mips64 test...
>>  I hope it's easier to review/ack/merge this way this only addresses
> sh4 here.
>>
> 
> It makes sense to me, Thomas. If I were you, I would do the same.
> 
> But, sorry, do you intend to send mips64 counterpart in future, or it is
> already sent, but I somehow missed it?

 Hi Aleksandar,

I was planning to send a separate patch, but then I noticed that there
are already quite a lot of tests for the various flavors of the
mips-malta machine in tests/acceptance/boot_linux_console.py ... so I
currently doubt that the malta advent calendar image will add much value
here?

 Thomas


