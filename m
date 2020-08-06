Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93647C433E1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EF4B221E2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 11:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zmqo1aWv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EF4B221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3eYb-0003fE-MK
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58222)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3eY2-0003DJ-5X
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:59:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20516
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k3eXy-0008EQ-Bu
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596715137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=CCq/+yAMxF7E+Rr55HOBl8bdnV26i/+2GG//rZ190Ls=;
 b=Zmqo1aWvYsk3ukOpeU1gxhGcnvfNJ+eBUzN5aMBoFxaUfYAngqJnrhRW/WywYlJZ65hrFC
 71SIbyE0NXnhB9EYFhnmKhItJl+BkK+HaW9WsRsbqcmeOAJzOODQatxGppjpNbGGCiOI7y
 J8J50M78C5cp6WZZAZwJELKPt1gf2EQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-hIfiXKw4P_uHlkHa9KIPig-1; Thu, 06 Aug 2020 07:58:53 -0400
X-MC-Unique: hIfiXKw4P_uHlkHa9KIPig-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3C9ED18C63E0;
 Thu,  6 Aug 2020 11:58:52 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-229.ams2.redhat.com [10.36.112.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 783495C6D9;
 Thu,  6 Aug 2020 11:58:49 +0000 (UTC)
Subject: Re: [PATCH for-5.2 v2 9/9] tests/qtest/cdrom: Add more s390x-related
 boot tests
To: Cornelia Huck <cohuck@redhat.com>
References: <20200806105349.632-1-thuth@redhat.com>
 <20200806105349.632-10-thuth@redhat.com>
 <20200806132344.4a34178e.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <51c2b736-4b30-84d7-492d-a7963d79ec27@redhat.com>
Date: Thu, 6 Aug 2020 13:58:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200806132344.4a34178e.cohuck@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: "Jason J . Herne" <jjherne@linux.ibm.com>,
 Collin Walling <walling@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/08/2020 13.23, Cornelia Huck wrote:
> On Thu,  6 Aug 2020 12:53:49 +0200
> Thomas Huth <thuth@redhat.com> wrote:
> 
>> Let's add two new tests:
>>
>> 1) Booting with "bootindex" is the architected default behavior on the
>> s390x target, so we should have at least one test that is using the
>> "bootindex" property.
>>
>> 2) The s390-ccw bios used to fail when other unbootable devices have
>> been specified before the bootable device (without "bootindex"). Now
>> that the s390-ccw bios is a little bit smarter here, we should test
>> this scenario, too, to avoid regressions.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  tests/qtest/cdrom-test.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/tests/qtest/cdrom-test.c b/tests/qtest/cdrom-test.c
>> index 833a0508a1..13e22f57c1 100644
>> --- a/tests/qtest/cdrom-test.c
>> +++ b/tests/qtest/cdrom-test.c
>> @@ -163,6 +163,18 @@ static void add_s390x_tests(void)
>>      qtest_add_data_func("cdrom/boot/virtio-scsi",
>>                          "-device virtio-scsi -device scsi-cd,drive=cdr "
>>                          "-blockdev file,node-name=cdr,filename=", test_cdboot);
>> +    qtest_add_data_func("cdrom/boot/with-bootindex",
>> +                        "-device virtio-serial -device virtio-scsi "
>> +                        "-device virtio-blk,drive=d1 "
>> +                        "-drive driver=null-co,read-zeroes=on,if=none,id=d1 "
>> +                        "-device virtio-blk,drive=d2,bootindex=1 "
>> +                        "-drive if=none,id=d2,media=cdrom,file=", test_cdboot);
>> +    qtest_add_data_func("cdrom/boot/without-bootindex",
>> +                        "-device virtio-scsi -device virtio-serial "
>> +                        "-device x-terminal3270 -device virtio-blk,drive=d1 "
> 
> Any special reason for that 3270 device here? Or just to add more
> variety? :)

Yes, there is a reason:

 https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg07231.html

... so this is a check that this does not happen again.

 Thomas


