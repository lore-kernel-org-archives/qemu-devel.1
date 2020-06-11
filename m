Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B61C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2732420760
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 12:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KFV4y1iX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2732420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjLyl-0002Ap-F7
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 08:06:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjLxu-0001jl-1U
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:05:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jjLxt-0007KX-14
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 08:05:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591877147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=+YxikwyBN/m2BhCUnvH/OenyO1qL/92glYKAAWhVE5M=;
 b=KFV4y1iXvGd4PX9C2Agw2I97qFIQor28YJ10QEDPpZ3QcVvykpwlXKRwJ7AHp+5HiZwhwj
 F2A2PdXwpJhQswUU/v3yJYdK2Y4g++5SAxWAylqeyOaT8sD8q9h5ZLxm+xAkpjYvSZGKjb
 V1DVrBw//UcR6c3xQd3Tgx+MsefRRvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-7Try50uVPpSqOZOG9p4Cyw-1; Thu, 11 Jun 2020 08:05:45 -0400
X-MC-Unique: 7Try50uVPpSqOZOG9p4Cyw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABF698015CB;
 Thu, 11 Jun 2020 12:05:44 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-175.ams2.redhat.com [10.36.114.175])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CF8AE2B5B7;
 Thu, 11 Jun 2020 12:05:38 +0000 (UTC)
Subject: Re: [RFC PATCH 8/8] tpm: Move backend code under the 'backends/'
 directory
To: Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200610200247.21378-1-philmd@redhat.com>
 <20200610200247.21378-9-philmd@redhat.com>
 <ed92c76e-c20c-1ac1-04c7-66cef6b3eabc@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <0e1be827-0420-8bcc-c16e-3c2abd0727ba@redhat.com>
Date: Thu, 11 Jun 2020 14:05:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <ed92c76e-c20c-1ac1-04c7-66cef6b3eabc@linux.ibm.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/06/2020 14.00, Stefan Berger wrote:
> On 6/10/20 4:02 PM, Philippe Mathieu-Daudé wrote:
>> TPM subsytem is split into backends (see commit f4ede81eed2)
>> and frontends (see i.e. 3676bc69b35). Keep the emulated
>> hardware 'frontends' under hw/tpm/, but move the backends
>> in the backends/ directory.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>> ---
>> RFC due to a FIXME in tpm_tis_common.c, it uses
>> TRACE_TPM_UTIL_SHOW_BUFFER which is now generated
>> by backends/trace-events...
>> ---
>>   Makefile                               |  2 +-
>>   {hw/tpm => backends}/tpm_int.h         |  6 ++---
>>   {hw/tpm => backends}/tpm_ioctl.h       |  0
>>   {hw/tpm => backends}/tpm_emulator.c    |  0
>>   {hw/tpm => backends}/tpm_passthrough.c |  0
>>   {hw/tpm => backends}/tpm_util.c        |  0
> 
> I don't understand this move. Why not keep everything TPM related in one
> directory even though there may be a backend directory where 'nothing
> else fits but the name.' All we need to remember is that 'emulator' and
> 'passthrough' are the backends.

We try to have a clean separation between frontends and backends in
QEMU. The concepts have been mixed in the past (see e.g. the -drive
parameter) and that led only to confusion and trouble later. The hw/
directory is clearly for emulated hardware device frontends only, we
should not include any backend code here.

 Thomas


