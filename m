Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605D2C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:48:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3EDF206B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 15:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiZtITs8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3EDF206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIw8m-000490-OU
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 11:48:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIw2k-0008N6-3y
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38885)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kIw2h-0000f4-Q5
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 11:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600357310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/kSRq5z7NW0AgIx7J74U3hALo34LWI5deLTt4wFme4=;
 b=hiZtITs8WQwyAvRMM5SQfHWS6ZkwiCFdln91oS8wK9V+I0JWImOvJFj5TRzppYCwkFQsBZ
 hBI/Yz6JLd4tEnhA6es3aAg/8QNtMuJ/VirW3zM0W/krKZiqbPhpvSFQfZJMIxiRD4SLFO
 v90j7jWgBXcZxu6u7mq/bXokMN4eERQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-L4SWC0RzOb6RbvZI2yAJmw-1; Thu, 17 Sep 2020 11:41:46 -0400
X-MC-Unique: L4SWC0RzOb6RbvZI2yAJmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A80756C2F;
 Thu, 17 Sep 2020 15:41:45 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-113-38.ams2.redhat.com [10.36.113.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DC3A99142;
 Thu, 17 Sep 2020 15:41:35 +0000 (UTC)
Subject: Re: Python 3.5 EOL; when can require 3.6?
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <875z8eupyp.fsf@dusky.pond.sub.org>
 <CAFEAcA8q8J1n2UqsNbHgNwEedA8pZ6fNA7obCR1REN-33nvmkg@mail.gmail.com>
 <d07189e2-0683-2eb9-44e0-a275688fa8b4@redhat.com>
 <9d4363e8-7bb8-8255-9914-6d9bc36cec79@redhat.com>
 <20200917145512.GF1597829@redhat.com>
 <37d8203d-e4f8-f9dd-828c-2d754a3695eb@redhat.com>
 <20200917153915.GJ1597829@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <33ffd671-ede6-a8c8-2d2c-92b690acca52@redhat.com>
Date: Thu, 17 Sep 2020 17:41:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200917153915.GJ1597829@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:01:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 17/09/2020 17.39, Daniel P. Berrangé wrote:
> On Thu, Sep 17, 2020 at 05:24:15PM +0200, Thomas Huth wrote:
>> On 17/09/2020 16.55, Daniel P. Berrangé wrote:
>>> On Thu, Sep 17, 2020 at 04:10:55PM +0200, Thomas Huth wrote:
>>>> On 16/09/2020 16.00, Thomas Huth wrote:
>>>>> On 16/09/2020 14.30, Peter Maydell wrote:
>>>>>> On Wed, 16 Sep 2020 at 08:43, Markus Armbruster <armbru@redhat.com> wrote:
>>>>>>> We require Python 3.5.  It will reach its "end of life" at the end of
>>>>>>> September 2020[*].  Any reason not to require 3.6 for 5.2?  qemu-iotests
>>>>>>> already does for its Python parts.
>>>>> [...]
>>>>>> The default should be
>>>>>> "leave the version dependency where it is", not "bump the version
>>>>>> dependency as soon as we can".
>>>>>
>>>>> OTOH, if none of our supported build systems uses python 3.5 by default
>>>>> anymore, it also will not get tested anymore, so bugs might creep in,
>>>>> which will of course end up in a bad experience for the users, too, that
>>>>> still try to build with such an old version. So limiting the version to
>>>>> the level that we also test is IMHO very reasonable.
>>>>>
>>>>> Let's have a look at the (older) systems that we support and the python
>>>>> versions according to repology.org:
>>>>>
>>>>> - RHEL7 / CentOS 7 : 3.6.8
>>>>> - Ubuntu 18.04 (Bionic) : >= 3.6.5
>>>>> - openSUSE Leap 15.0 : >= 3.6.5
>>>>> - OpenBSD Ports : >= 3.7.9
>>>>> - FreeBSD Ports : >= 3.5.10 - but there is also 3.6 or newer
>>>>> - Homebrew : >= 3.7.9
>>>>>
>>>>> ... so I think it should be fine to retire 3.5 nowadays.
>>>>
>>>> Sorry, I forgot to check Debian. If I got that right, Debian 9 still
>>>> uses Python 3.5 by default. So I guess that means we can not deprecate
>>>> Python 3.5 yet?
>>>
>>> FWIW, Debian 9 EOL was July this year, if you only count the regular
>>> lifetime, not the LTS.
>>
>> Do we support Debian LTS? ... If not, we should maybe add a proper
>> remark about that to our support policy...?
> 
> I didn't define Debian situation very well in the support policy
> because I didn't realize it had separate normal and LTS EOL
> dates. I had originally thought it was LTS only.
> 
> In libvirt we have since clarified the language I originally
> wrote (and then copied to QEMU), to remove the LTS distinction.
> Instead libvirt now says:
> 
>  "The project aims to support the most recent major version at all
>   times. Support for the previous major version will be dropped 2
>   years after the new major version is released or when the vendor
>   itself drops support, whichever comes first. In this context,
>   third-party efforts to extend the lifetime of a distro are not
>   considered, even when they are endorsed by the vendor (eg. Debian
>   LTS)."
> 
> I'd suggest we copy this updated terminolgy into QEMU as it simplifies
> the current language used.

Sounds good, could you (or Markus) please provide a patch?

 Thanks,
  Thomas


