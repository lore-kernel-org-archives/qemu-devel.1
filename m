Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB77C04AA7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 04:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7BD2084F
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 04:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7BD2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58979 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQlAr-0004J8-9X
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 00:05:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54136)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hQlA0-0003vi-Jz
	for qemu-devel@nongnu.org; Wed, 15 May 2019 00:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hQl9x-0000bd-PY
	for qemu-devel@nongnu.org; Wed, 15 May 2019 00:04:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hQl9w-0000Ps-9Y
	for qemu-devel@nongnu.org; Wed, 15 May 2019 00:04:52 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 613938665A;
	Wed, 15 May 2019 04:04:49 +0000 (UTC)
Received: from [10.72.12.103] (ovpn-12-103.pek2.redhat.com [10.72.12.103])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 364BA60BE5;
	Wed, 15 May 2019 04:04:44 +0000 (UTC)
To: Markus Armbruster <armbru@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>
References: <20190418145355.21100-1-armbru@redhat.com>
	<20190418145355.21100-2-armbru@redhat.com>
	<2679829b-cc1d-83ce-9949-2b80d970ddec@redhat.com>
	<875zqe7b10.fsf@dusky.pond.sub.org>
	<CAFEAcA-vqnucYKuV3QKf4wBsfuXMZiC1kqrnaVcA+BEaud__Bw@mail.gmail.com>
	<877eat6xgm.fsf@dusky.pond.sub.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e562c5f5-9d01-59b0-5a4c-d040fa8b8962@redhat.com>
Date: Wed, 15 May 2019 12:04:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <877eat6xgm.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Wed, 15 May 2019 04:04:49 +0000 (UTC)
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/5/14 =E4=B8=8B=E5=8D=888:18, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Mon, 13 May 2019 at 14:21, Markus Armbruster <armbru@redhat.com> wr=
ote:
>>> Perhaps I should do it just for this file while I touch it anyway.  T=
he
>>> question to ask: should parse_acl_file() obey the locale for whitespa=
ce
>>> recognition?
>> I vote for "no".
>>
>> Q: do we document the format of the ACL file anywhere ?
> Support for it was added in commit bdef79a2994, v1.1.  Just code, no
> documentation.
>
> Grepping for qemu-bridge-helper finds just qemu-options.hx.  Contains
> -help output and some .texi that goes into qemu-doc and the manual page=
.
> None of it mentions how qemu-bridge-helper is run, or the ACL file
> feature, let alone what its format might be.
>
> I'm afraid all we have is the commit message.  Which doesn't really
> define the file format, it merely gives a bunch of examples.
>
> As far as I can tell, qemu-bridge-helper is for use with -netdev tap an=
d
> -netdev bridge.
>
> Both variations of -netdev call net_bridge_run_helper() to run the
> helper.  First argument is -netdev parameter "helper", default usually
> "$prefix/libexec/qemu-bridge-helper".  Second argument is parameter
> "br", default "br0".
>
> If @helper contains space or tab, net_bridge_run_helper() guesses its a
> full command, else it guesses its the name of the executable.  Bad
> magic.
>
> If it guesses name of executable, it execv()s this executable with
> arguments "--use-vnet", "--fd=3DFD", "--br=3D@bridge".
>
> If it guesses full command, it appends "--use-vnet --fd=3DFD", where FD=
 is
> the helper's half of the socketpair used to connect QEMU and the helper=
.
> It further appends "--br=3D@bridge", unless @helper contains "--br=3D".
> More bad magic.
>
> It executes the resulting string with sh -c.  Magic cherry on top.
>
> When the helper fails, netdev creation fails.
>
> The helper we ship with QEMU unconditionally tries to read
> "$prefix/etc/bridge.conf".  Fatal error if this file doesn't exist.
> Errors in this file are fatal.  Errors in files it includes are not
> fatal; instead, the remainder of the erroneous file is ignored.
> *Boggle*
>
> As far as I can tell, libvirt runs qemu-bridge-helper itself (Paolo's
> commit 2d80fbb14df).  Makes sense, because running QEMU with the
> necessary privileges would be unwise, and so would be letting it execut=
e
> setuid helpers.  Also bypasses the bad magic in QEMU's
> net_bridge_run_helper().


I don't notice this before. Is this only for the convenience of=20
development? I guess libvirt should have native support like adding port=20
to bridge/OVS without the help any external command or script.


>
> qemu-bridge-helper should have a manual page, and its handling of error=
s
> in ACL include files needs work.  There's probably more; I just glanced
> at it.  I'm not volunteering, though.  It lacks a maintainer.  Should w=
e
> add it to Jason's "Network device backends"?


Yes.


>
> -netdev's helper parameter is seriously underdocumented.  Document or
> deprecate?


I believe management should only use fd parameter of TAP. If we have=20
other, it should be a duplication. So I suggest to deprecate the bridge=20
helper and -netdev bridge.

Thanks


