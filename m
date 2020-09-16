Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C80C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:27:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 516962223E
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 13:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bWmvOZGM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516962223E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIXTL-00076B-Ba
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 09:27:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIXRe-0005bz-BS
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:25:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIXRb-0004hp-Og
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 09:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600262753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V8Hqb0q2UyvbXLft6ookLNGvVr/XJgNcwznRwyFnQyg=;
 b=bWmvOZGM9RosOvFSSkRM2cUmlRhnPbIQQ89095kUzZHnvh5lmWDqaltn37vC6Mz52FdyM4
 chQ4QixFuxLfSCGLjV52m002acXIeTHSrsr+kjdhoQpMqRd8tutMA6m2+mXswiwNctL2Mp
 QzSSXZsKt+DQwdqPKD+r+SS55hITNE8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-8xN-cBl2ODCAoa4wFpCRVw-1; Wed, 16 Sep 2020 09:25:49 -0400
X-MC-Unique: 8xN-cBl2ODCAoa4wFpCRVw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D81E9802B7E;
 Wed, 16 Sep 2020 13:25:48 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-19.ams2.redhat.com [10.36.113.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AC01E5DE86;
 Wed, 16 Sep 2020 13:25:46 +0000 (UTC)
Subject: Re: About 'qemu-security' mailing list
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <nycvar.YSQ.7.78.906.2009111910280.36374@xnncv>
 <CAFEAcA_9BVbqFCHJqS8jj6L3OqVNc60NCjAjRs516VyLH2EFfw@mail.gmail.com>
 <20200914101517.GD579094@stefanha-x1.localdomain>
 <nycvar.YSQ.7.78.906.2009151536090.10832@xnncv>
 <20200916111025.GA756728@stefanha-x1.localdomain>
 <CAFEAcA8FD9HNKvsGs0q6YpSdX8gsoBaNtAPXuvv+e35O33Jbmg@mail.gmail.com>
 <20200916130525.GL1535709@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a799a303-c54f-82ee-0a6b-3fd06a98b10a@redhat.com>
Date: Wed, 16 Sep 2020 15:25:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200916130525.GL1535709@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 02:35:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 16/09/2020 15.06, Daniel P. Berrangé wrote:
> On Wed, Sep 16, 2020 at 01:33:38PM +0100, Peter Maydell wrote:
>> On Wed, 16 Sep 2020 at 12:10, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>>> I think it's worth investigating whether GitLab Issues can be configured
>>> in a secure-enough way for security bug reporting. That way HTTPS is
>>> used and only GitLab stores the confidential information (this isn't
>>> end-to-end encryption but seems better than unencrypted SMTP and
>>> plaintext emails copied across machines).
>>
>> Given that we currently use launchpad for bugs we should also look
>> at whether launchpad's "private security" bug classification would
>> be useful for us (currently such bug reports effectively go to /dev/null
>> but this can be fixed).

I've somehow managed to subscribe myself to our private LP bugs, so I
get notified if there is a new one.

> Using a bug tracker has the notable advantage over direct email CC's
> that if the security triage team needs to pull in a  domain specific
> expert, that newly added person can still see the full history of
> discussion on the bug.
> 
> With individual email CC's, the previous discussions are essentially
> a information blackhole until the security triage team is good enough
> to forward the full discussion history (this essentially never happens
> in IME). Mailing list also has that easy archive access benefit.
> 
> Is it possible to setup people to be able to view launchpad private
> bugs, without also making them full admins for the QEMU launchpad
> project ?

Honestly, I'd rather like use to move to the gitlab bug tracker instead
of extending our use of the launchpad tracker. LP is IMHO a really ugly
bug tracking tool.

> Does launchpad still send clear text email notifications to the
> permitted admins for private bugs ? I recall I used to get clear
> text emails for private bugs in the past for non-QEMU projects.

IIRC, yes, the email notifications for the private bugs are still send
without encryption.

 Thomas


