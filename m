Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E7DC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:36:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3712083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 04:36:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3712083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42121 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRUbV-0004Gx-1W
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 00:36:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hRUaW-0003sS-Lx
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hRUaT-0001jC-3d
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:35:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hRUaS-0001gc-UO
	for qemu-devel@nongnu.org; Fri, 17 May 2019 00:35:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2EFCB3082163;
	Fri, 17 May 2019 04:35:13 +0000 (UTC)
Received: from [10.72.12.67] (ovpn-12-67.pek2.redhat.com [10.72.12.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1F7075D6A9;
	Fri, 17 May 2019 04:35:08 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	<877eat6xgm.fsf@dusky.pond.sub.org>
	<e562c5f5-9d01-59b0-5a4c-d040fa8b8962@redhat.com>
	<87lfz88bva.fsf@dusky.pond.sub.org>
	<1089f272-838f-e3e0-3b50-5a33cce95030@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a44c8068-406e-be4d-0e72-5cfe15ba22b3@redhat.com>
Date: Fri, 17 May 2019 12:35:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1089f272-838f-e3e0-3b50-5a33cce95030@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Fri, 17 May 2019 04:35:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/6] qemu-bridge-helper: Fix misuse of
 isspace()
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
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/5/15 =E4=B8=8B=E5=8D=889:35, Paolo Bonzini wrote:
> On 15/05/19 08:34, Markus Armbruster wrote:
>>>> qemu-bridge-helper should have a manual page, and its handling of er=
rors
>>>> in ACL include files needs work.  There's probably more; I just glan=
ced
>>>> at it.  I'm not volunteering, though.  It lacks a maintainer.  Shoul=
d we
>>>> add it to Jason's "Network device backends"?
>>>
>>> Yes.
>>>
>>>> -netdev's helper parameter is seriously underdocumented.  Document o=
r
>>>> deprecate?
>>>
>>> I believe management should only use fd parameter of TAP. If we have
>>> other, it should be a duplication. So I suggest to deprecate the
>>> bridge helper and -netdev bridge.
>> Objections, anyone?
> Yes, your honor. :)  The helper is the only way for unprivileged users
> to set up TAP networking, which is basically the only really way to hav=
e
> *working* network.  It's widely used in the wild, it's self-contained
> and the only alternative for users is the S-word (hint, it's five
> letters long and ends with LIRP).


The issue is it can't deal with e.g vhost-net and multiqueue. We can=20
have a simple privileged launcher to do network configuration and pass=20
the fds to unprivileged qemu.

Thanks


>
> However, I have no problem with deprecating the helper argument of
> "-netdev tap", which is a useless duplication with "-netdev bridge".
>
> Paolo
>

