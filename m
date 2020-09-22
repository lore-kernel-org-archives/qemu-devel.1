Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F4CC2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41B5123A1E
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:09:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BT4fnjxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41B5123A1E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcQc-0004wz-63
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKcO7-0003Vd-0o
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:06:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59006
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kKcO5-0005R7-5v
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600758412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sH66C2TNYQEllFyMCMzWSpUfL/dXm7fNW50MdW6cCCI=;
 b=BT4fnjxIrCzYv0JNimpBtRw4MSyg+lwMKSBYFZJcbsMNkQWyAEIXsF6TPbFhwQ3z3MpWQ2
 gT64y0pkHbeadbZ3teF002hoOsH9Ib5iXNO2W+qlSeQAlu6p09x1/9OpbsUuv2oi3L/mUD
 mpMbp/vFoR5i/VjMRh5sRGL7TJUuIvI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-KffxUZqKPRO7uVJRH9EcUg-1; Tue, 22 Sep 2020 03:06:50 -0400
X-MC-Unique: KffxUZqKPRO7uVJRH9EcUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B7001074655;
 Tue, 22 Sep 2020 07:06:49 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-122.ams2.redhat.com [10.36.113.122])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 46B845C1DC;
 Tue, 22 Sep 2020 07:06:41 +0000 (UTC)
Subject: Re: [PATCH 0/7] Do not support Debian 9 and Python 3.5 anymore
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200921174320.46062-1-thuth@redhat.com>
 <87r1qvngsg.fsf@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <4b78dd56-c94d-5720-4f57-ac251526f461@redhat.com>
Date: Tue, 22 Sep 2020 09:06:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <87r1qvngsg.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 21/09/2020 20.09, Alex Bennée wrote:
> 
> Thomas Huth <thuth@redhat.com> writes:
> 
>> Debian 9 is EOL now, and according to our support policy, we do not
>> support it anymore. Let's switch the corresponding CI builds to
>> either Fedora (for a more recent version of the MinGW compilers) or
>> Debian 10 instead.
>>
>> Together with the Travis patch series that I recently posted ("Update
>> Travis from Xenial to Bionic and Focal"), our CI should now be free of
>> distros that we do not support anymore. And all supported build systems
>> now use at least Python 3.6, so we can drop the support for Python 3.5.
>>
>> Based-on: <20200918103430.297167-1-thuth@redhat.com>
> 
> I'm inclined to take all of these but I'll take all the CI based ones
> now and add the 3.6 bump if there is more review/acks for it.

Thanks! ... but I just noticed that I missed to send out the patch that
removes the Python 3.5 job in .travis.yml. I just sent it out now, title
is "[PATCH 7/6] travis.yml: Drop the Python 3.5 build" ... please make
sure to also queue it if you include the patch that bumps the Python
version.

 Thomas


