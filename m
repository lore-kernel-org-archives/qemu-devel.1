Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1271CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:31:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12B1206A1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:31:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+C3U52K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12B1206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrI2R-0006PI-3L
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38172)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jrI19-00049o-7N
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:29:59 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jrI16-0002UW-Nj
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593768594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EXgod+d2i0Tpnigf7w75BwWGrsN+poBRbb0W3phdHWQ=;
 b=V+C3U52KTh0Kt17bZ9veU9X+smYCZ4qcGFNFskF1tLA6rbvV35h/XD9VsXSs8okqNTK8cw
 Eml/mPJBVvWzidVyYlx4njlqBbds1cxIxkrVf5TPtj9Z8kiZEo3GoEiHN+/YSwbWAuydu9
 VnmV5Upw41U8yHXzO9/X0npuvjA1v+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-Rz7UzlH-Mde96j0XcTKTZw-1; Fri, 03 Jul 2020 05:29:52 -0400
X-MC-Unique: Rz7UzlH-Mde96j0XcTKTZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3BDBB18A8220;
 Fri,  3 Jul 2020 09:29:51 +0000 (UTC)
Received: from [10.72.13.231] (ovpn-13-231.pek2.redhat.com [10.72.13.231])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F216C1002393;
 Fri,  3 Jul 2020 09:29:49 +0000 (UTC)
Subject: Re: [PATCH V2 0/2] net/colo-compare.c: Expose "max_queue_size" to
 users and clean up
To: "Zhang, Chen" <chen.zhang@intel.com>
References: <20200624012042.29355-1-chen.zhang@intel.com>
 <15d75b295b7b482db3ef2428aee87a6d@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d729b847-3983-d303-8a81-3c1177d9c14a@redhat.com>
Date: Fri, 3 Jul 2020 17:29:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <15d75b295b7b482db3ef2428aee87a6d@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 01:34:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-dev <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2020/7/3 下午5:27, Zhang, Chen wrote:
> Hi Jason,
>
> Maybe missed this updated series?
>
> Thanks
> Zhang Chen


Nope :)

It's in my queue. Since I only have those two patches so I don't plan to 
send pull request this week.

(Anyway it's not a feature, so we don't need to worry about soft freeze).

Thanks


>
>> -----Original Message-----
>> From: Zhang, Chen <chen.zhang@intel.com>
>> Sent: Wednesday, June 24, 2020 9:21 AM
>> To: Jason Wang <jasowang@redhat.com>
>> Cc: Zhang Chen <zhangckid@gmail.com>; qemu-dev <qemu-
>> devel@nongnu.org>; Zhang, Chen <chen.zhang@intel.com>
>> Subject: [PATCH V2 0/2] net/colo-compare.c: Expose "max_queue_size" to
>> users and clean up
>>
>> From: Zhang Chen <chen.zhang@intel.com>
>>
>> This series make a way to config COLO "max_queue_size" parameters
>> according to user's scenarios and environments and do some clean up for
>> descriptions.
>>
>> V2:
>>   - Rebase on upstream code.
>>
>> Zhang Chen (2):
>>    net/colo-compare.c: Expose compare "max_queue_size" to users
>>    qemu-options.hx: Clean up and fix typo for colo-compare
>>
>>   net/colo-compare.c | 43
>> ++++++++++++++++++++++++++++++++++++++++++-
>>   qemu-options.hx    | 33 +++++++++++++++++----------------
>>   2 files changed, 59 insertions(+), 17 deletions(-)
>>
>> --
>> 2.17.1


