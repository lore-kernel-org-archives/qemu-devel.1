Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78490C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:49:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D5922226
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KIyHPyh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D5922226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIx6L-00016J-Vg
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIwxj-0001CL-Af
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:40:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60895
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIwxg-0002X7-GS
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600360843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IkqUnweVV9ViKZorg3S9HelxN2raodOOs3UtjHpwB7k=;
 b=KIyHPyh5fcg+2Tv2Zc9kXBE1+HXaKKkbG+DvlfFUs85uE3Oj4Tx0a0KA++zDnO7mr+DhpX
 Et8LWxfnQHm75WYglgu1rZhQTQL1vBtkw121iL1GAcwD3eTAkbIsAmuyORrdNP360JxP4D
 xdY1GRSRMjdLizC+VL7lQBdSIS/ijhg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-556-th5r1dWpMoiy0XRLtCU_UQ-1; Thu, 17 Sep 2020 12:40:40 -0400
X-MC-Unique: th5r1dWpMoiy0XRLtCU_UQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C0E157240;
 Thu, 17 Sep 2020 16:40:39 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A4AEB1C4;
 Thu, 17 Sep 2020 16:40:35 +0000 (UTC)
Subject: Re: [PULL 00/24] qtests, unit tests and Cirrus-CI fixes / improvements
To: luoyonggang@gmail.com
References: <20200916114731.102080-1-thuth@redhat.com>
 <CAFEAcA8VyUYJnE3aji6zPQGPD-K+iVGwVNbygYypr+NpSzZBPw@mail.gmail.com>
 <7c21af54-342f-2a29-f700-3b1d3bbd5bc6@redhat.com>
 <CAE2XoE9xKJzfRUxQit+EFXii=q8XxUQUbcTMYJY-wkRUeZJkuQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <324931dc-3e98-7bd2-06a1-8b3f75a4b6b0@redhat.com>
Date: Thu, 17 Sep 2020 18:40:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE9xKJzfRUxQit+EFXii=q8XxUQUbcTMYJY-wkRUeZJkuQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 08:56:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/2020 18.33, 罗勇刚(Yonggang Luo) wrote:
> 
> 
> On Thu, Sep 17, 2020 at 11:29 PM Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> wrote:
>>
>> On 17/09/2020 17.14, Peter Maydell wrote:
>> > On Wed, 16 Sep 2020 at 12:47, Thomas Huth <thuth@redhat.com
> <mailto:thuth@redhat.com>> wrote:
>> >> ----------------------------------------------------------------
>> >> * Fix "readlink -f" problem in iotests on macOS (to fix the
> Cirrus-CI tests)
>> >> * Some minor qtest improvements
>> >> * Fix the unit tests to work on MSYS2, too
>> >> * Enable building and testing on MSYS2 in the Cirrus-CI
>> >> * Build FreeBSD with one task again in the Cirrus-CI
>> >> ----------------------------------------------------------------
>> >
>> > After merging this one I tried installing GNU sed on my local
>> > box so it could run the iotests, but they fail like this
>> > because they assume readarray, which doesn't exist in
>> > OSX bash
>> Ok, sounds like I should respin my patch here:
>>
>> https://lists.gnu.org/archive/html/qemu-devel/2020-09/msg04476.html
>>
>> ... and could you install a newer version of bash via homebrew on your
>> system?
> What's the reason to exclude these list on win32? That's didn't optimize
> the time much, and indeed they can be
> compiled.
> --target-list-exclude=i386-softmmu,arm-softmmu,ppc-softmmu,mips-softmmu"

The total run time of the job is already 50 minutes, so I was afraid
that it would hit the 1h time limit otherwise.
The targets that are excluded are just subsets of other targets, e.g.
i386-softmmu is a subset of x86_64-softmmu, so we don't lose much test
coverage by excluding them.

 Thomas


