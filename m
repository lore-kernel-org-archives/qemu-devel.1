Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A4CC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A792E20829
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 10:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fqy8QELv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A792E20829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHm5H-0003Ps-Qx
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 06:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHm46-0002Aj-HJ
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kHm45-0003bZ-0K
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 06:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600080628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ie+UPuHhY0zeyrJRExjhtGRGpcoHjvtLgxCoCutO8Cc=;
 b=fqy8QELvioBXs4tWOmxe0MiXHMZRPIkN0BO9uYkXF22pNbrb/2s1l1O8PQxnN5RuPzNA18
 OkUhj0Tk+EyNNr+HLxdrQeGjpPMygmePVuGbePyD9VgStZBYkIn126zbSlXZ2C7JSqz0sY
 2CxGNx86YbqPIrY38Wn/4QjlGNrr52o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-es80PvgQMvGPk0a7yh-utA-1; Mon, 14 Sep 2020 06:50:26 -0400
X-MC-Unique: es80PvgQMvGPk0a7yh-utA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A52DD1019625;
 Mon, 14 Sep 2020 10:50:25 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-134.ams2.redhat.com [10.36.112.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97773614F5;
 Mon, 14 Sep 2020 10:50:24 +0000 (UTC)
Subject: Re: [PATCH] tests/check-block: Do not run the iotests with old
 versions of bash
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200912121412.10999-1-thuth@redhat.com>
 <8e1a8f08-5fd1-b53e-07a4-70170e4451e0@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <532c3912-b18b-86bf-52a2-044aaacbbc81@redhat.com>
Date: Mon, 14 Sep 2020 12:50:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <8e1a8f08-5fd1-b53e-07a4-70170e4451e0@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.792,
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/09/2020 11.19, Max Reitz wrote:
> On 12.09.20 14:14, Thomas Huth wrote:
>> macOS is shipped with a very old version of the bash (3.2), which
>> is currently not suitable for running the iotests anymore. Add
>> a check to skip the iotests in this case - if someone still wants
>> to run the iotests on macOS, they can install a newer version from
>> homebrew, for example.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/check-block.sh | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/tests/check-block.sh b/tests/check-block.sh
>> index 8e29c868e5..bfe1630c1e 100755
>> --- a/tests/check-block.sh
>> +++ b/tests/check-block.sh
>> @@ -46,6 +46,11 @@ if ! command -v bash >/dev/null 2>&1 ; then
>>      exit 0
>>  fi
>>  
>> +if bash --version | grep 'GNU bash, version [123]' > /dev/null 2>&1 ; then
> 
> grep -q instead of the redirections, perhaps?
> 
> But more importantly, I think this needs a LANG=C prefix.  (If I expand
> the rejected major versions to [12345], it doesn’t skip without a
> prefix, because the string reads “GNU bash, Version 5...” here in
> LANG=de_DE.UTF-8.)

Ouch, ok. But actually, I'm not quite sure anymore whether the patch is
really required. I ran into the "readlink -f" problem and thought that
it occurred due to the ancient version of bash on macOS, but as a I now
know, readlink is a separate program and not a bash built-in, so it's a
different issue... thus let's skip this patch here for now until we hit
a real issue with bash again.

 Thomas


