Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1009C4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16B1523A1E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 06:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1/scSwm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B1523A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcEY-0002kh-1R
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 02:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKcCn-00022E-VX
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:55:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45926)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKcCm-0003gQ-3q
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 02:55:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600757711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hd/mWNqWkuJuRbSHZg3aDOtMrjc5I5NcJqYIA1sSqNI=;
 b=S1/scSwmwYupeF6yrRzuMIbWxo4P/e1d0T/7Hyd5ODQzK6uveW3oWQzHQkpIQS5hhDrnXo
 KronlyWx+uUtiEqeANlORgeVvQdAVdxzh2/k8XHQFCNEe+qGXDIqYut6VmpCCHYcBoC431
 4KbFhSyetyu6Idg8/bfEriuN0MYWidk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-rjhgnIfpN6qNdSDUJX3Y4A-1; Tue, 22 Sep 2020 02:55:07 -0400
X-MC-Unique: rjhgnIfpN6qNdSDUJX3Y4A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5AEF01084D6A;
 Tue, 22 Sep 2020 06:55:06 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-122.ams2.redhat.com [10.36.113.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB0DF78832;
 Tue, 22 Sep 2020 06:55:04 +0000 (UTC)
Subject: Re: [PATCH 5/6] travis.yml: Update Travis to use Bionic and Focal
 instead of Xenial
To: Cleber Rosa <crosa@redhat.com>
References: <20200918103430.297167-1-thuth@redhat.com>
 <20200918103430.297167-6-thuth@redhat.com>
 <20200921233951.GC15763@localhost.localdomain>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7332fce1-6355-9102-bc9b-59afa38e95a5@redhat.com>
Date: Tue, 22 Sep 2020 08:55:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200921233951.GC15763@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22/09/2020 01.39, Cleber Rosa wrote:
> On Fri, Sep 18, 2020 at 12:34:29PM +0200, Thomas Huth wrote:
>> According to our support policy, we do not support Xenial anymore.
>> Time to switch the bigger parts of the builds to Focal instead.
>> Some few jobs have to be updated to Bionic instead, since they are
>> currently still failing on Focal otherwise. Also "--disable-pie" is
>> causing linker problems with newer versions of Ubuntu ... so remove
>> that switch from the jobs now (we still test it in a gitlab CI job,
>> so we don't lose much test coverage here).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  .travis.yml | 24 +++++++++++++-----------
>>  1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 1fc49b0746..80da4ebc8e 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -2,7 +2,7 @@
>>  # Additional builds with specific requirements for a full VM need to
>>  # be added as additional matrix: entries later on
>>  os: linux
>> -dist: xenial
>> +dist: focal
>>  language: c
>>  compiler:
>>    - gcc
>> @@ -10,7 +10,7 @@ cache:
>>    # There is one cache per branch and compiler version.
>>    # characteristics of each job are used to identify the cache:
>>    # - OS name (currently only linux)
>> -  # - OS distribution (for Linux, xenial, trusty, or precise)
>> +  # - OS distribution (for Linux, bionic or focal)
>>    # - Names and values of visible environment variables set in .travis.yml or Settings panel
>>    timeout: 1200
>>    ccache: true
>> @@ -27,7 +27,7 @@ addons:
>>        - libattr1-dev
>>        - libbrlapi-dev
>>        - libcap-ng-dev
>> -      - libgcc-4.8-dev
>> +      - libgcc-7-dev
>>        - libgnutls28-dev
>>        - libgtk-3-dev
>>        - libiscsi-dev
>> @@ -211,8 +211,10 @@ jobs:
>>  
>>      # gprof/gcov are GCC features
>>      - name: "GCC gprof/gcov"
>> +      dist: bionic
>>        env:
>> -        - CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=${MAIN_SOFTMMU_TARGETS}"
>> +        - CONFIG="--enable-gprof --enable-gcov --disable-libssh
>> +                  --target-list=${MAIN_SOFTMMU_TARGETS}"
> 
> While the commit message describes the reason for dropping
> '--disable-pie', it doesn't talk about why it adds '--disable-libssh'.

Ah, well, right. I should have mentioned that... but we've hit that
problem in the past so often that my mind apparently sorted it into the
well-known category and did not came up with the idea that it would be
good to mention it ;-)

The problem is that libssh is very much broken in Bionic. Ubuntu
backported some patches into that version so that QEMU's configure
script thinks that it is a newer version, but they did not backport some
other important patches so that compilation later fails. Since it's
rather a bug in the distro and not in QEMU, we never "fixed" this issue,
so libssh can not be used in Bionic. See also:

 https://bugs.launchpad.net/qemu/+bug/1838763

> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> Tested-by: Cleber Rosa <crosa@redhat.com>

 Thanks!
  Thomas


