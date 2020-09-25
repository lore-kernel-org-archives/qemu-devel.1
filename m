Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF87C4346E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:15:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C050C20791
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 01:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsafwkEd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C050C20791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLcKJ-0006e3-TL
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 21:15:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbyb-0000kk-DD
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLbyZ-0002wq-Km
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 20:52:41 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600995159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YN6mZJI1y5ewSRgtQA/mZEma6fAqDrQQ25FNuLusaL8=;
 b=WsafwkEdYyKp57pEvgBnKFQvwv4LwjDetqV1Zb6B2Q3GAY8JN1/O0fNUetZ+bdY90J0DKK
 6ag5+T0k/gYO2kD7GzNTvf2hKpsMwt8acZEB/7L7rCnaskJQWi+gGE9bOYHFWGRZmizS8t
 nWAFtrTP+RvD4ldxYyfmjlaoBxY3dF4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-u7CU6DW4N7W2VYJSoccZdg-1; Thu, 24 Sep 2020 20:52:37 -0400
X-MC-Unique: u7CU6DW4N7W2VYJSoccZdg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47D6C186DD4D;
 Fri, 25 Sep 2020 00:52:36 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 95E325576B;
 Fri, 25 Sep 2020 00:52:35 +0000 (UTC)
Subject: Re: [PATCH 12/16] qapi/expr.py: Add docstrings
To: Eduardo Habkost <ehabkost@redhat.com>
References: <20200922211313.4082880-1-jsnow@redhat.com>
 <20200922211313.4082880-13-jsnow@redhat.com>
 <20200923201627.GH3717385@habkost.net>
From: John Snow <jsnow@redhat.com>
Message-ID: <5aea4e5d-5229-c83a-0536-06d914c9f8d7@redhat.com>
Date: Thu, 24 Sep 2020 20:52:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200923201627.GH3717385@habkost.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 4:16 PM, Eduardo Habkost wrote:
> On Tue, Sep 22, 2020 at 05:13:09PM -0400, John Snow wrote:
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
> [...]
>> @@ -160,6 +244,18 @@ def check_type(value: Optional[object],
>>                  source: str,
>>                  allow_array: bool = False,
>>                  allow_dict: Union[bool, str] = False) -> None:
>> +    """
>> +    Check the QAPI type of `value`. [RW]
>> +
>> +    Python types of `str` or `None` are always allowed.
>> +
>> +    :param value:       The value to check.
>> +    :param info:        QAPI Source file information.
>> +    :param source:      Human readable string describing "what" the value is.
>> +    :param allow_array: Allow a `List[str]` of length 1,
>> +                        which indicates an Array<T> type.
>> +    :param allow_dict:  Allow a dict, treated as an anonymous type.
> 
> I was hoping the docstring would explain what happens when
> allow_dict is a string.
> 

Reasonable request!


