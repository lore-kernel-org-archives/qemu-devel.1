Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70992C43461
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 12:30:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC39208E4
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 12:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjtLYBoY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC39208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kH4fJ-0000oL-15
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 08:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kH4cw-0006oi-VU
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 08:27:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43669
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kH4cu-0006oG-GK
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 08:27:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599913651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G1NJPcfZ1+RruB9oSwFTYH+/6zT1IUu5Ds5KYTZJbMA=;
 b=cjtLYBoYobeALy8uvQnMg2clWNQy8TuFOOfm8TZMpJtUD9YSeq90aFq1Er4VSRiWn7kH5s
 tMCiKH5E9ZWk9gQfHjuGl3O8+wS1O7epN0FplQdwidj/Fs3jPKuEJdaSbsDxKq2Sn1J5Z6
 GvJRFcJTnhQcWTNnpl8Hr0ITiEGZbSc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-XCfIQKCsOwaz2PwV-pLBqg-1; Sat, 12 Sep 2020 08:27:27 -0400
X-MC-Unique: XCfIQKCsOwaz2PwV-pLBqg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CEE58030CC;
 Sat, 12 Sep 2020 12:27:26 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-6.ams2.redhat.com [10.36.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8FD5D5D9CC;
 Sat, 12 Sep 2020 12:27:25 +0000 (UTC)
Subject: Re: [PULL v2] Block layer patches
To: Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200908115322.325832-1-kwolf@redhat.com>
 <CAFEAcA-wrgOC9oqdqBuVSTiidaRcwbgQWF08zD=TSetSwn_tjA@mail.gmail.com>
 <480db253-9aa4-39c3-592f-bc5cfea1997b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <06214b2c-adc7-1e3b-a15f-fe3c16ff0983@redhat.com>
Date: Sat, 12 Sep 2020 14:27:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <480db253-9aa4-39c3-592f-bc5cfea1997b@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/12 08:00:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.543, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/09/2020 00.09, Eric Blake wrote:
> On 9/9/20 4:55 PM, Peter Maydell wrote:
> 
>>
>> This fails 'make check' on NetBSD and OpenBSD:
>>
>> ./check: line 47: realpath: command not found
>> ./check: line 60: /common.env: No such file or directory
>> check: failed to source common.env (make sure the qemu-iotests are run
>> from tests/qemu-iotests in the build tree)
>> gmake: *** [/home/qemu/qemu-test.vcb7nz/src/tests/Makefile.include:144:
>> check-block] Error 1
> 
> BSD has 'readlink -f' (and so does coreutils on Linux), which does the
> same thing as the Linux-only realpath.

Seems like readlink -f does not work on macOS:

 https://cirrus-ci.com/task/5735398972325888?command=main#L7038

Any ideas what to use instead?

Peter, why did this slip through your merge tests, do you still skip the
iotests there?

 Thomas


