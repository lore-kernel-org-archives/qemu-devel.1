Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E096C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:22:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC3F24AEA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 07:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC3F24AEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47222 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hY3mO-00056g-Co
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 03:22:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:41204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY3ie-00027g-59
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:18:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hY3ex-0005PV-Cq
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:15:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44657)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hY3ex-0005KR-69
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 03:15:03 -0400
Received: by mail-wr1-f68.google.com with SMTP id w13so14549422wru.11
	for <qemu-devel@nongnu.org>; Tue, 04 Jun 2019 00:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=KRi/i1N/4P2VV953MQochTTyjojczxQ9fH+DHMvJGOc=;
	b=r3c5UC+kviDqzncPz//dOpeWWF4RxkWhQHVB1CaCZvoMp7QW6i27CsfibrLfun5/CF
	2mjxtQXScpRmO34OIN/G2+SzheNBV+CJYpB920nKG7CxgowQPpTdOfZeJGRoClwGXqp8
	dyvmjBwDiaZL3encc813LOVbab/X4YGR3x75NLvWg+yj15pISqiN4nmFtU348H92S8GS
	ihC1dZY6VHJTp3y5O9zbntLqn0L/LbCaTQpz6qlgy2+0MvBBnDKLMHaXIPv4Iql1BXT5
	Fvz7vqkdjrpUxqQ7nv2fSba6cILuXawzML+lsx4cSVDjSJ0Sdp0CjQex8TcF2VL7iltk
	da7w==
X-Gm-Message-State: APjAAAVs+lUBdMkhRi7SLdhqVavv0iFdBYJZFTwlzq1pPxoxU7PWtj7Q
	RvGLn20KnyH+K2RCvapgJveGXw==
X-Google-Smtp-Source: APXvYqx/zoG7R0aISnzGtmM/toQ4PcmlAROit2eYazK8L8Uazi//RVMfWS5V7BEMJLRtkl+rcwJVHQ==
X-Received: by 2002:adf:ce8f:: with SMTP id r15mr7409098wrn.122.1559632499564; 
	Tue, 04 Jun 2019 00:14:59 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
	[88.21.202.183]) by smtp.gmail.com with ESMTPSA id
	y184sm10501842wmg.14.2019.06.04.00.14.57
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 04 Jun 2019 00:14:58 -0700 (PDT)
To: Cornelia Huck <cohuck@redhat.com>, John Snow <jsnow@redhat.com>
References: <20190531192429.GH22103@habkost.net>
	<93e5101f-67f1-a416-5e80-f16371a35e6a@redhat.com>
	<871s0asvli.fsf@dusky.pond.sub.org>
	<236db86d-52df-5537-4f33-f3c09bbb6289@redhat.com>
	<20190603201629.0880a337.cohuck@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bea97ae8-ee73-46db-69cc-bb6fa57d5588@redhat.com>
Date: Tue, 4 Jun 2019 09:14:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190603201629.0880a337.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] Deprecation policy and build dependencies
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	"Daniel P. Berrange" <berrange@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
	Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/3/19 8:16 PM, Cornelia Huck wrote:
> On Mon, 3 Jun 2019 14:02:16 -0400
> John Snow <jsnow@redhat.com> wrote:
[...]
>> I would rather not support Python2 a day after the clock expires.
>>
>>> I didn't bother checking Debian, Ubuntu LTS and SLES.
>>>
>>> For hosts other than Linux, we're less ambitious.
>>>   
>>
>> That policy strikes me as weird, because RHEL7 is not going to be, in
>> general, using the latest and greatest QEMU. Usually stable versions of
>> distros stick with the versions of the programs that came out at the time.
> 
> I think the idea was that folks might actually develop on a 'stable'
> distro (in a previous life, I used to complain quite often that
> building QEMU on a stable distro broke... it was one of my main
> development machines, but not controlled by me).
> 
>>
>> What's the benefit of making sure that stable platforms can continue to
>> run the *newest* QEMU? Is this even a reasonable restriction? If you are
>> running RHEL7, how many projects do you expect to be able to git clone
>> and build and have that work with the rest of your legacy/stable
>> dependencies?
>>
>> RHEL7 uses a 1.5.3 based version. I don't think it matters if we update
>> 4.2 to be Python3 only, really.
> 
> It depends on how old the distro is and what update policy it
> uses... if parts of it are regularly updated, it might actually be
> usable. In this case, I think we really need to interpret our policy
> to include EPEL, or it is completely nuts.

Red Hat supports Docker on RHEL 7 and above.

Docker solved all my problems, as long as a host can install Docker, I
can build on old or edge images. I don't install plenty of dependencies
on my testing hosts, but in trashable docker images. For regular testing
I use image snapshots.

You need a sysadmin (or root access) to install the docker daemon however.

