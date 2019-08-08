Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE7BC0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 05:39:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E7BA2089E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 05:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E7BA2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvb9C-000860-Rn
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 01:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59927)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jasowang@redhat.com>) id 1hvb8o-0007gs-ND
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1hvb8n-0006JI-Lc
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:39:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54976)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hvb8n-0006Ft-Gh
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:39:09 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C047308FC4D;
 Thu,  8 Aug 2019 05:39:06 +0000 (UTC)
Received: from [10.72.12.139] (ovpn-12-139.pek2.redhat.com [10.72.12.139])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA0D5600C8;
 Thu,  8 Aug 2019 05:38:56 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <12dbfcd1-8d9d-f564-fb90-767943eca874@redhat.com>
Date: Thu, 8 Aug 2019 13:38:54 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 08 Aug 2019 05:39:06 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Is network backend netmap worth keeping?
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
 Vincenzo Maffione <v.maffione@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/8/8 =E4=B8=8B=E5=8D=8812:48, Markus Armbruster wrote:
> Please excuse the attention-grabbing subject.
>
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
>> On 8/7/19 10:16 PM, Markus Armbruster wrote:
> [...]
>>> Can you tell me offhand what I have to install so configure enables
>>> CONFIG_NETMAP?
>> The steps are listed in tests/docker/dockerfiles/debian-amd64.docker,
>> but you can get to this point running:
>>
>>    $ make docker-image-debian-amd64 V=3D1 DEBUG=3D1
>>
>> This will build the docker image with netmap (so you don't have to mes=
s
>> with your workstation setup), then build QEMU within the image.
> So, to make use of QEMU's netmap backend (CONFIG_NETMAP), you have to
> build and install netmap software from sources.  Which pretty much
> ensures nobody uses it.  It was added in commit 58952137b0b (Nov 2013).
> The commit message points to <http://info.iet.unipi.it/~luigi/netmap/>,
> which gives me "connection timed out" right now.
>
> On the other hand, it's covered in MAINTAINERS, and has seen
> non-janitorial activity as late as Dec 2018 (commit c693fc748a).
>
> Luigi, Giuseppe, Vincenzo, what's the status of the netmap project?
>
> Why is the QEMU netmap backend worth keeping?
>
> Who is using the netmap backend?


Netmap was supported by freebsd:=20
https://www.freebsd.org/cgi/man.cgi?query=3Dnetmap&sektion=3D4. So I gues=
s=20
there should be real users.


>
> How do they obtain a netmap-enabled QEMU?  Compile it from sources
> themselves?


Yes.


>
> Would it make sense to have netmap packaged in common Linux distros?
>

It requires Linux kernel support which is tough task especially Linux=20
has AF_XDP support recently.

Thanks


