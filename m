Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB8AC4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A286C20863
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A286C20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7KjP-0002w4-Px
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41870)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1i7Kih-0002VA-Hn
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:32:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1i7Kie-0000DZ-RE
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:32:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40632)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1i7Kie-0000D6-JJ
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:32:40 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9CA3110A1B
 for <qemu-devel@nongnu.org>; Mon,  9 Sep 2019 14:32:39 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id b1so7450786wru.4
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2019 07:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HjTLwCEq5podcgLdf5n7d4nWdOs5AGmWxq+/4zwIpUA=;
 b=WOXI3I+RHKivE5176MHm0MzUMwE57t9nCSXbhPkQgqAxVX2baDqvqlxtgDO4zoArye
 26CwEISqicin4D9VCHxPMilZS9SreinGTYc52N8DrdmSu4mwNVbyBx8r78gAGtsglE0q
 weePAl8pEqirjrrstLy7RSpscJJvYiJGeFbgsOfAn0caPdaH9aCvjSO7oS21vARHfUL1
 2hlJyXLk/TgtnulhsI4+4HDQqIV+QowVTyPN7IKft1jpy9qbGQsCCAnIjlFc8R4xw1dS
 OpSAax2WvsAuiiM2EKqNt6KOdXRIEa494L6nXxP8RK0LDxIDTBk9VScXgdR1LoV3Qs88
 hgHA==
X-Gm-Message-State: APjAAAW5Bpf5m0vZmMQ2JNqzEQ61aWIT0pLMeZt609NEN3cIHsbpudsF
 U7sUNvVnIWmumP20Ymr6w0lPYIWvena31yAOYjUSAHS6RD90SuJjfTLVYap+M8JCdY+F8Cqzq5A
 c+5Qaz2Ycvna/d3M=
X-Received: by 2002:adf:e3c4:: with SMTP id k4mr15447348wrm.157.1568039558317; 
 Mon, 09 Sep 2019 07:32:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxC52JLTSMcJYFmhEaZfWkxb7JmAumq8ganI7orBEY/oomV9u672IXLnq4yG/32XA95lDeb0A==
X-Received: by 2002:adf:e3c4:: with SMTP id k4mr15447331wrm.157.1568039558070; 
 Mon, 09 Sep 2019 07:32:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4580:a289:2f55:eec1?
 ([2001:b07:6468:f312:4580:a289:2f55:eec1])
 by smtp.gmail.com with ESMTPSA id c74sm14135217wme.46.2019.09.09.07.32.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2019 07:32:37 -0700 (PDT)
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190909135842.25469-1-alex.bennee@linaro.org>
 <20190909141100.GK24509@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <c652adb8-aa61-48fd-71e2-0ac83498852d@redhat.com>
Date: Mon, 9 Sep 2019 16:32:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909141100.GK24509@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-web PATCH v2] add support page
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 thuth@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/19 16:11, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Sep 09, 2019 at 02:58:42PM +0100, Alex Benn=C3=A9e wrote:
>> This is intended to be a useful page we can link to in the banner of
>> the IRC channel explaining the various support options someone might
>> have.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>
>> ---
>> v2
>>   - add cleanups suggested by Stefan
>> ---
>>  support.md | 40 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 40 insertions(+)
>>  create mode 100644 support.md
>=20
> I would have expected some other file to be modified to link to this
> page from elsewhere on the website too.

Indeed, can't we just link it from the navigation bar (_includes/nav.html=
)?

Paolo

>>
>> diff --git a/support.md b/support.md
>> new file mode 100644
>> index 0000000..9174bbb
>> --- /dev/null
>> +++ b/support.md
>> @@ -0,0 +1,40 @@
>> +---
>> +title: Support
>> +permalink: /support/
>> +---
>> +
>> +If you have a support question that is not answered by our
>> +[documentation](/documentation) you have a number of options availabl=
e
>> +to you.
>> +
>> +If the question is specifically about the integration of QEMU with th=
e
>> +rest of your Linux distribution you may be better served by asking
>> +through your distribution's support channels. This includes questions
>> +about a specifically packaged version of QEMU. The QEMU developers ar=
e
>> +generally concerned with the latest release and the current state of
>> +the [master branch](https://git.qemu.org/?p=3Dqemu.git) and do not
>> +provide support for QEMU binaries shipped by Linux distributions.
>> +
>> +Questions about complex configurations of networking and storage are
>> +usually met with a recommendation to use management tools like
>> +[virt-manager](https://virt-manager.org/) from the [libvirt
>> +project](https://libvirt.org/) to configure and run QEMU. Management
>> +tools handle the low-level details of setting up devices that most
>> +users should not need to learn.
>> +
>> +* There is a
>> +[qemu-discuss@nongnu.org](https://lists.nongnu.org/mailman/listinfo/q=
emu-discuss)
>> +mailing list for user focused questions<br>
>> +If your question is more technical or architecture specific you may
>> +want to send your question to another of [QEMU's mailing
>> +lists](https://wiki.qemu.org/MailingLists)
>> +
>> +* A lot of developers hang around on IRC (network: irc.oftc.net,
>> +channel #qemu)<br> QEMU developers tend to hold normal office hours
>> +and are distributed around the world. Please be patient as you may
>> +have to wait some time for a response. If you can't leave IRC open an=
d
>> +wait you may be better served by a mailing list.
>> +
>> +* If you think you have found a bug you can report it on [our bug
>> +  tracker](https://bugs.launchpad.net/qemu/)<br>
>> +Please see our guide on [how to report a bug](/contribute/report-a-bu=
g/)
>=20
> For this content though:
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
> Regards,
> Daniel
>=20


