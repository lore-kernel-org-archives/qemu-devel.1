Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A51C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:56:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44F1F22525
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fm0aie8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44F1F22525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFf33-0003n4-10
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 10:56:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFf2V-0003L0-Fv
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:56:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42147
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kFf2T-0002r2-Gz
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 10:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599576964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qRKyU1lobZZK82ekHLJnkcyMtqz+mRlx8jeIJo3pPsU=;
 b=fm0aie8TBU3Gvz5Goh28WoyrxAnSPqkCn0POhaCvM+HMsRyN9T9XakmtkphoaWUCtUSFhe
 Uh74GV/roS/fqpBK/Jw8xBMF/0gFDikn6FJRv1v8udf5cuS1ojADjaacBK7s9G7c4XcuyF
 wmY7AvJI3PHqls+iSsWw8tikUbLmXrw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-k8gA30QJOxC136tj59E-mA-1; Tue, 08 Sep 2020 10:56:00 -0400
X-MC-Unique: k8gA30QJOxC136tj59E-mA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D3B010BBED2;
 Tue,  8 Sep 2020 14:55:59 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-112-122.ams2.redhat.com
 [10.36.112.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F38B82463;
 Tue,  8 Sep 2020 14:55:54 +0000 (UTC)
Subject: Re: [PATCH for 5.1] docs: fix trace docs build with sphinx 3.1.1
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
References: <20200714162659.1017432-1-berrange@redhat.com>
 <20200729103719.GD37763@stefanha-x1.localdomain>
 <20200729113415.GB3451141@redhat.com>
 <20200729145534.GH52286@stefanha-x1.localdomain>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <15b8bac5-1d01-e5a4-e13b-14a05d0d08bf@redhat.com>
Date: Tue, 8 Sep 2020 16:55:53 +0200
MIME-Version: 1.0
In-Reply-To: <20200729145534.GH52286@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 03:00:34
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/29/20 16:55, Stefan Hajnoczi wrote:
> On Wed, Jul 29, 2020 at 12:34:15PM +0100, Daniel P. Berrangé wrote:
>> On Wed, Jul 29, 2020 at 11:37:19AM +0100, Stefan Hajnoczi wrote:
>>> On Tue, Jul 14, 2020 at 05:26:59PM +0100, Daniel P. Berrangé wrote:
>>>> In Fedora 33 rawhide, we now have sphinx 3.1.1, as opposed
>>>> to previous 2.2.2. This new version generates a warning on
>>>> the source:
>>>>
>>>> docs/qemu-option-trace.rst.inc:4:Malformed option description
>>>>   '[enable=]PATTERN', should look like "opt", "-opt args",
>>>>   "--opt args", "/opt args" or "+opt args"
>>>>
>>>> This turns into an error when QEMU passes -W to sphinx-build
>>>>
>>>> Strangely the previous 2.2.2 code has the exact same logic
>>>> for checking the syntax, but it is not being triggered. While
>>>> it is only complaining about the first option, I changed all
>>>> the options to give consistency.
>>>>
>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>> ---
>>>>  docs/qemu-option-trace.rst.inc | 6 +++---
>>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> Thanks, applied to my tracing tree:
>>> https://github.com/stefanha/qemu/commits/tracing
>>
>> I'm not sure this is a good idea to queue it, based on the other
>> part of this thread about incompatibilities with differnet sphinx
>> versions, and the patchew failures.
>>
>> I don't have a answer for how to fix this to make every versions happy.
> 
> Yes, thanks. I was playing around with it and considering Sphinx
> suppress_warnings.
> 
> Let's leave this patch for QEMU 5.1. Fedora rawhide is cutting-edge and
> has a smaller userbase than those using older Sphinx versions. At the
> moment we can keep the code as-is.

I've hit this today, in a python3 venv which has Sphinx 3.2.1 installed
with pip (from <https://pypi.org/project/Sphinx/>).

The latest pre-3.* python-sphinx packages in Koji seem to be
2.2.2-based; installing precisely "sphinx==2.2.2" with pip in the venv
seems to have done the trick.

Thanks,
Laszlo


