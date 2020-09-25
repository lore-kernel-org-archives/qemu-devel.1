Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45672C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9AF620936
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 17:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5/7mSbG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9AF620936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLrEL-0002dS-KW
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 13:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLrDa-0002EA-8r
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:09:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kLrDX-0004oC-GG
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 13:09:09 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601053746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/DFBAfLXzyOfwwv/J/9Vtv571OZeJbmyjqDlj1zx1HU=;
 b=S5/7mSbGKqSYob1D5TtNYPdVxsev2JTyzUQZ0l6LQkt7DsXapfSKI+2SzEA4gIrPHs9OuZ
 geqs+OOVxl8DCmPpxRznWrts9Qd0ubrVywWZ4M4Mu2vYbXgzpC4sGJZM7kUHZ1b+OfwFOa
 xqSbtu7JPcmqxkvemKmhL8TRmotAcu0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-Fuvp2hiqNDOaiWYwnTxohg-1; Fri, 25 Sep 2020 13:09:04 -0400
X-MC-Unique: Fuvp2hiqNDOaiWYwnTxohg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFE831084C8A;
 Fri, 25 Sep 2020 17:09:03 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 36CD455786;
 Fri, 25 Sep 2020 17:09:03 +0000 (UTC)
Subject: Re: [PATCH v6 00/21] Convert QAPI doc comments to generate rST
 instead of texinfo
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <5d9726b1-e4f7-f9a3-02ca-9f893925c6ce@redhat.com>
 <CAFEAcA_yZ8D6SsryA_ZEFdKDXxHAFE3gD6+LUzDKSbzXwY_W1A@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cdad1a98-782a-e3e1-d9a7-d9e772e76447@redhat.com>
Date: Fri, 25 Sep 2020 13:09:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_yZ8D6SsryA_ZEFdKDXxHAFE3gD6+LUzDKSbzXwY_W1A@mail.gmail.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 02:48:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.238, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 1:02 PM, Peter Maydell wrote:
> On Fri, 25 Sep 2020 at 17:54, John Snow <jsnow@redhat.com> wrote:
>>
>> On 9/25/20 12:22 PM, Peter Maydell wrote:
>>>    * although there are HTML anchors on all the command/object/etc
>>>      headings, they are not stable but just serial-number based
>>>      tags like '#qapidoc-35', so not suitable for trying to link
>>>      to from other parts of the docs
>>
>> I suppose this answers my question if qmp commands were going to be able
>> to be cross-referenced yet.
>>
>> I'd love to get that working so I can make smart references in the
>> bitmaps doc.
>>
>> We could even amend the QMP code parser to insert cross-references to
>> the function names, which would be *extremely* slick.
> 
> If you'd like to have a closer look into Sphinx's indexing
> support, be my guest :-)
> 
Yeah, I am *absolutely* not suggesting this for this series.

I did start taking a look at Sphinx's default_role. As an exercise for 
the Python cleanup, I looked at what would happen if I set our default 
role to "Any" to be able to cross-reference using `backticks`.

I used this to test my docstring consistency for the QAPI module 
cleanup. It involved me converting a few usages of single backticks in 
./docs proper to double-backticks, but it wasn't too bad.

(See the "DO-NOT-MERGE" commits on my part1 V3.)

I'll look into how we *add* reference targets; that part I still have no 
clue on. but adding a qmp reference scope would be *delightful*.

> -- PMM
> 


