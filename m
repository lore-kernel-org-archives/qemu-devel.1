Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A966CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 15:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022F9208FE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 15:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3un9NmT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022F9208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMuiu-0003li-2t
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 11:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kMuhv-0002wJ-D1
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 11:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kMuhr-0001ux-Hc
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 11:04:49 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601305486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8huOj2pB2E1Gau52ihS57DuDia1c2fR8llvH4ucTt1Q=;
 b=L3un9NmT4f7vOyfaUuHQePk9xlkFoij0Wc9R9aFTAenWQvLXs6OLtV2HEMFjnoET8pU/Ib
 i8TCLkc/pci/EbXuCKIvPTVINtfghC8Mrdz4JHsMH7EXsvKLyIs6WA08nlO9VSym9QWq+v
 Gmyy4KAomAN5ojsuI6i2/Wv+DO7nC4M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-7Hny-5TFMMa9I1jlixd_yw-1; Mon, 28 Sep 2020 11:04:42 -0400
X-MC-Unique: 7Hny-5TFMMa9I1jlixd_yw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 82F5410BBEEC;
 Mon, 28 Sep 2020 15:04:41 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D3C3619C4;
 Mon, 28 Sep 2020 15:04:40 +0000 (UTC)
Subject: Re: [PATCH v2 18/38] qapi/events.py: Move comments into docstrings
To: Markus Armbruster <armbru@redhat.com>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-19-jsnow@redhat.com>
 <20200923144819.GE3312949@habkost.net> <87k0wit5ef.fsf@dusky.pond.sub.org>
 <e9838231-f0b2-f953-448d-3c86e5b4f813@redhat.com>
 <877dsei0jg.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <9644c70d-3fdb-646b-8824-1b3b661f32df@redhat.com>
Date: Mon, 28 Sep 2020 11:04:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <877dsei0jg.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 03:29:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/28/20 7:49 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 9/25/20 8:19 AM, Markus Armbruster wrote:
>>> What about:
>>>       Generate a QAPI struct variable holding the event parameters,
>>>       initialized with the function's arguments.
>>
>> Line length and style-guide limitations; docstrings need a one-liner
>> summary.
> 
> They do!
> 
>> (Consistency is the hobgoblin, blah blah blah.)
>>
>> I am writing:
>>
>>      """
>>      Generate a QAPI struct variable with an initializer.
>>
>>      The QAPI struct describes the event parameters, and the initializer
>>      references the function arguments defined in `gen_event_send`.
>>      """
> 
> Better.
> 
> My second try:
> 
>        Generate a struct variable holding the event parameters.
> 
>        Initialize it with the function arguments defined in in
>        `gen_event_send`.
> 

You're the boss!

--js


