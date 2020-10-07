Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BA6C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 321C420872
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJTf06HM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 321C420872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ7Et-0004dN-5I
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50016)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1kQ78a-0005tU-5I
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1kQ78X-0002OG-8R
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 06:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602068252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vWoT+zlytxuuLomAyV/YzZgIjXGDlXmtJn6YKN1cw4=;
 b=fJTf06HMi8CWBqQqJipTVuUKMRogc2qctK43X5g/IV4spfT4JOD+A5xRGdHyV+eWNW8Zfh
 HPh0i2S6FEf/ikKQv1ZwedJz2NHU/USeXwVry8VhtbTvTs9t5mRWq478CpnhXTTJKPIFeD
 jCvi3Te7GwlSvg2PeDrtli97IT43Kqk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-CB8XKEYVPFm6Og1owuCL7g-1; Wed, 07 Oct 2020 06:57:28 -0400
X-MC-Unique: CB8XKEYVPFm6Og1owuCL7g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E5C018829DA;
 Wed,  7 Oct 2020 10:57:27 +0000 (UTC)
Received: from [10.40.194.82] (unknown [10.40.194.82])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8CE9419C4F;
 Wed,  7 Oct 2020 10:57:26 +0000 (UTC)
Subject: Re: [PULL v8 00/86] Misc QEMU patches for 2020-09-24
To: Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20200930195850.278104-1-pbonzini@redhat.com>
 <a0b8e23a-cccb-3c5d-dbf7-f489c0d95f93@redhat.com>
 <5c9a0783-f7ea-7872-f5f4-44ba9e65a1b2@redhat.com>
 <20201002182457.GE7303@habkost.net>
From: Michal Privoznik <mprivozn@redhat.com>
Message-ID: <830c0f59-41dc-05ca-3713-6fb10027c8e5@redhat.com>
Date: Wed, 7 Oct 2020 12:57:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201002182457.GE7303@habkost.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mprivozn@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/2/20 8:24 PM, Eduardo Habkost wrote:
> On Fri, Oct 02, 2020 at 06:27:35PM +0200, Paolo Bonzini wrote:
>> On 02/10/20 17:58, Michal Prívozník wrote:
>>>>
>>>
>>> cd442a45db60a1a72fcf980c24bd1227f13f8a87 is the first bad commit
>>>
>>> Sorry for noticing this earlier, but is this known? The build starts
>>> failing for me after this commit:
>>>
>>> /usr/bin/sphinx-build -Dversion=5.1.50 -Drelease= -W
>>> -Ddepfile=docs/devel.d -Ddepfile_stamp=docs/devel.stamp -b html -d
>>> /home/zippy/work/qemu/qemu.git/build/docs/devel.p
>>> /home/zippy/work/qemu/qemu.git/docs/devel
>>> /home/zippy/work/qemu/qemu.git/build/docs/devel
>>> Running Sphinx v3.2.1
>>> building [mo]: targets for 0 po files that are out of date
>>> building [html]: targets for 20 source files that are out of date
>>> updating environment: [new config] 20 added, 0 changed, 0 removed
>>> reading sources... [100%] testing
>>
>> No, this is new.  It works with older versions of Sphinx (I have 2.2.2
>> despite being on Fedora 32 which is pretty recent).
>>
>> For now Sphinx 3 is not supported by kerneldoc, we probably should apply
>> a patch like
>>
>> https://www.spinics.net/lists/linux-doc/msg83277.html
> 
> We already have Sphinx 3.x hacks inside our fork of kernel-doc,
> see commit 152d1967f650 ("kernel-doc: Use c:struct for Sphinx 3.0
> and later").
> 
> If we want to keep deviating from upstream kernel-doc, the
> following patch seems to work.  Do we want to?
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 40ad782e342..03b49380426 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -838,6 +838,13 @@ sub output_function_rst(%) {
>   	$lineprefix = "";
>   	output_highlight_rst($args{'purpose'});
>   	$start = "\n\n**Syntax**\n\n  ``";
> +    } elsif ($args{'functiontype'} eq "") {
> +	# this is a macro, Sphinx 3.x requires c:macro::
> +	if ((split(/\./, $sphinx_version))[0] >= 3) {
> +		print ".. c:macro:: ";
> +	} else {
> +		print ".. c:function:: ";
> +	}
>       } else {
>   	print ".. c:function:: ";
>       }
>>
>> Paolo
>>
> 

I can confirm that this fixes the build for me.

Michal


