Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD8AC433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D55A25308
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJv2q5UP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D55A25308
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNgW-0002NA-8k
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kSNeo-0001Kq-K0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24343)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kSNek-0006qC-Pr
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 13:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602608407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AFAOkksUaRscK+PoEpnGI5a8Em34jjAyfqz+kVHeP+E=;
 b=QJv2q5UPA9Y3x7yjcEYr6Of/eaK8h40bhPA2WtlI9owbfXw13LmSglqL5u0CUESUCb60x7
 4ipIFsEaHZ8e1fjho2pR43IdKzH65WtasrPOYVpBXnmlFm3Hi1yaqx+fOOCGCh5+O/PQnH
 f+oe9eznhOBTMJ8to0T2ipHImhEUe7Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-BktKrwsrPPWG1QA7u9JsGA-1; Tue, 13 Oct 2020 13:00:05 -0400
X-MC-Unique: BktKrwsrPPWG1QA7u9JsGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40832800C60;
 Tue, 13 Oct 2020 17:00:04 +0000 (UTC)
Received: from [10.10.117.231] (ovpn-117-231.rdu2.redhat.com [10.10.117.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C6517665A;
 Tue, 13 Oct 2020 17:00:00 +0000 (UTC)
Subject: Re: [PATCH 1/3] python: add mypy config
To: Bin Meng <bmeng.cn@gmail.com>
References: <20201009175123.249009-1-jsnow@redhat.com>
 <20201009175123.249009-2-jsnow@redhat.com>
 <CAEUhbmWJ62viai9C7_zfx-do7DW0Mh_xjT7G8a8p+mdi9tCfkw@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <ed658177-4310-e2ba-2670-b37f0d337829@redhat.com>
Date: Tue, 13 Oct 2020 13:00:00 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAEUhbmWJ62viai9C7_zfx-do7DW0Mh_xjT7G8a8p+mdi9tCfkw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/13/20 5:15 AM, Bin Meng wrote:
> On Sat, Oct 10, 2020 at 1:54 AM John Snow <jsnow@redhat.com> wrote:
>>
>> Formalize the options used for checking the python library. You can run
>> mypy from the directory that mypy.ini is in by typing `mypy qemu/`.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   python/mypy.ini | 4 ++++
>>   1 file changed, 4 insertions(+)
>>   create mode 100644 python/mypy.ini
>>
>> diff --git a/python/mypy.ini b/python/mypy.ini
>> new file mode 100644
>> index 00000000000..7a70eca47c6
>> --- /dev/null
>> +++ b/python/mypy.ini
>> @@ -0,0 +1,4 @@
>> +[mypy]
>> +strict = True
>> +python_version = 3.6
>> +warn_unused_configs = True
>> \ No newline at end of file
> 
> Missing "\n" at the end of file
> 
> Regards,
> Bin
> 

Easily fixed, thanks!


