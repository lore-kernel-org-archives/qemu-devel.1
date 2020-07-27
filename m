Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB210C433EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:57:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFF732072E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 19:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPPB9ryT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFF732072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09FD-00027N-QV
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 15:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50094)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k09BA-0002b1-OR
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:52:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25305
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k09B9-0004v3-2f
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 15:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595879574;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V2MWuTAM3RtL8UFBs368jGyD/owBI/fNCsO4fD/G0Wk=;
 b=LPPB9ryTZ4pggF79EcUMDdCqm9VPajrf1tMQuafQhxGyh124y46ocu9VSqGHnwk8q5HQfV
 eHjA1QPoHUCPVvVrV/QCu9eu1k85l+NDjkYm50o6fBDV5rjWIAbjJlsv8pzM5yxbS8sAbu
 sE/n0aRY5SsHu5iTXOVLuYdaPpUFLjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-CkEo3LiMNRioZ3LUs_hE4Q-1; Mon, 27 Jul 2020 15:52:50 -0400
X-MC-Unique: CkEo3LiMNRioZ3LUs_hE4Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52BA0101C8A5;
 Mon, 27 Jul 2020 19:52:49 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-119-72.rdu2.redhat.com [10.10.119.72])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3B9B5DA33;
 Mon, 27 Jul 2020 19:52:44 +0000 (UTC)
Subject: Re: [PATCH for 5.1] docs: fix trace docs build with sphinx 3.1.1
To: Andreas Schwab <schwab@linux-m68k.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200714162659.1017432-1-berrange@redhat.com>
 <87blk257eg.fsf@igel.home>
From: John Snow <jsnow@redhat.com>
Message-ID: <94143f30-d646-763d-5b10-ef0ca8b246ca@redhat.com>
Date: Mon, 27 Jul 2020 15:52:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87blk257eg.fsf@igel.home>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 15:02:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/26/20 4:49 PM, Andreas Schwab wrote:
> On Jul 14 2020, Daniel P. Berrangé wrote:
> 
>> In Fedora 33 rawhide, we now have sphinx 3.1.1, as opposed
>> to previous 2.2.2. This new version generates a warning on
>> the source:
>>
>> docs/qemu-option-trace.rst.inc:4:Malformed option description
>>    '[enable=]PATTERN', should look like "opt", "-opt args",
>>    "--opt args", "/opt args" or "+opt args"
>>
>> This turns into an error when QEMU passes -W to sphinx-build
>>
>> Strangely the previous 2.2.2 code has the exact same logic
>> for checking the syntax, but it is not being triggered. While
>> it is only complaining about the first option, I changed all
>> the options to give consistency.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Running Sphinx v1.7.6
> [...]
> Warning, treated as error:
> ../qemu-5.0.0/docs/qemu-option-trace.rst.inc:21:Duplicate explicit target name: "cmdoption-qemu-img-trace".
> 
> Andreas.
> 

I ran into this before, I forget what causes it, or how I fixed it ...

Oh, it was part of the research I was doing into why we can't support 
Sphinx prior to 1.6; and it's documented in conf.py:

# Sphinx 1.5 and earlier can't build our docs because they are too 

# picky about the syntax of the argument to the option:: directive 

# (see Sphinx bugs #646, #3366). 

needs_sphinx = '1.6'

... Should we say goodbye to Sphinx 1.7.x, or is there a workaround that 
keeps support from 1.6.1 through to 3.1.1?

--js


