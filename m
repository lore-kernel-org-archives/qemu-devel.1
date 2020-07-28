Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B951BC433E4
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 23:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DEB2075D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 23:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hrzLzSLN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DEB2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0ZEf-0004FC-0k
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 19:42:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49872)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k0ZDb-0003ps-Lj
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 19:41:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:38630)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1k0ZDY-0000Fq-T3
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 19:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595979666;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=znjZ9sel4k/dKCZFj1Mz6lZtME9lwovF4ezKLIhaDCo=;
 b=hrzLzSLNkW/ZPQIasM6vAc6W2V+FlOOEuLCeb/G9pI4iW0BXmlc35vSZK8Q090/dQb9MiN
 DSuVW/zN999xLpXt7t42ZVnPXp49AWoMu6QwzGXXkO721CWw4sURNbDI7+xdPIqq0OMfZG
 cL+Wu7ocLGPn1aZcMkHtfcIQ6Yn7nN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-xA6Qtz7sM5-CXNDu3i0OPA-1; Tue, 28 Jul 2020 19:41:04 -0400
X-MC-Unique: xA6Qtz7sM5-CXNDu3i0OPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC9821005510;
 Tue, 28 Jul 2020 23:41:02 +0000 (UTC)
Received: from ibm-p8-OVS-01-fsp.mgmt.pnr.lab.eng.rdu2.redhat.com
 (ovpn-112-49.rdu2.redhat.com [10.10.112.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 700EA60E1C;
 Tue, 28 Jul 2020 23:40:58 +0000 (UTC)
Subject: Re: [PATCH for 5.1] docs: fix trace docs build with sphinx 3.1.1
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200714162659.1017432-1-berrange@redhat.com>
 <87blk257eg.fsf@igel.home> <94143f30-d646-763d-5b10-ef0ca8b246ca@redhat.com>
 <CAFEAcA8GyXLkt439aYTbNSO_CSoh_Fq0HJeMzYuAkB6RBOfdoQ@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6ec6a79f-fdf5-57b9-50f5-3c02ee9f11d5@redhat.com>
Date: Tue, 28 Jul 2020 19:40:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8GyXLkt439aYTbNSO_CSoh_Fq0HJeMzYuAkB6RBOfdoQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.74; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-74.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 16:54:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Andreas Schwab <schwab@linux-m68k.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 4:14 PM, Peter Maydell wrote:
> On Mon, 27 Jul 2020 at 20:52, John Snow <jsnow@redhat.com> wrote:
>> ... Should we say goodbye to Sphinx 1.7.x, or is there a workaround that
>> keeps support from 1.6.1 through to 3.1.1?
> 
> I think we need to keep 1.7.x because it's the Sphinx shipped
> by some LTS distros we support, don't we?
> 

Only if you feel it's important that doc building works using packages 
from the system repo. `pip3 install --user sphinx` works on all of these 
distros, too.

We already somewhat break our promise where Sphinx is concerned for the 
oldest distros on our support list.

> I do feel we probably need to defend our Sphinx-version-support
> more actively by having oldest-supported and bleeding-edge
> both tested in the CI setup...
> 

We could either:

A) Start using a "build venv" that uses specific sets of python packages 
for the build process to pin everyone's build at version 1.6.1

B) Add some sort of pytest/tox/whatever to add a test that does a sphinx 
doc build across multiple different versions, 1.6.1, 1.7.x, 2.0.x, etc.

(I don't think you liked the idea of a Python environment in QEMU taking 
responsibility of Sphinx, though ...)


