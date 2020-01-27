Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D084CC32771
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:35:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AC732071E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 09:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5iEjNFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC732071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw0o6-0000kP-Ot
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 04:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57920)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iw0nO-0008LK-PV
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:35:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iw0nN-0007KD-Rg
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:35:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26994
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iw0nN-0007Jh-Ot
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 04:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580117701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=8qMJwEsAD1jwv3Rtj+VEUtTykySlfqlaqN+8DG7ScLI=;
 b=N5iEjNFdB79O/SbEFKS448V5FDwuX9qdRghAX5CeIMRD9qAbUBAvSUyzF0I8pMFlXsCeXB
 NpecOCHxli/LmlZ33HSWGfiDkDHrXtQjdl6ebhPD6mlKW3tpzlROG+78ioCAzu66LqbKY0
 D/lZKT7xeffwzIpEx0cKfC461ORhK1I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-nP034O7VP320UAuhv7bcyw-1; Mon, 27 Jan 2020 04:34:59 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4DFE8184BBA3;
 Mon, 27 Jan 2020 09:34:58 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-117-94.ams2.redhat.com [10.36.117.94])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D2625C1D6;
 Mon, 27 Jan 2020 09:34:51 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] travis.yml: Enable acceptance KVM tests
To: Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-5-wainersm@redhat.com>
 <2425f078-578a-f76b-b815-945a58cd1309@redhat.com>
 <fa1b84dc-81c8-03bb-add8-032746f06d3b@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <6efa5656-8a37-237b-21ee-f934727d1194@redhat.com>
Date: Mon, 27 Jan 2020 10:34:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <fa1b84dc-81c8-03bb-add8-032746f06d3b@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: nP034O7VP320UAuhv7bcyw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: philmd@redhat.com, alex.bennee@linaro.org, ehabkost@redhat.com,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/01/2020 22.15, Wainer dos Santos Moschetta wrote:
>=20
> On 1/22/20 7:22 AM, Thomas Huth wrote:
>> On 22/01/2020 02.27, Wainer dos Santos Moschetta wrote:
>>> Some acceptance tests require KVM or they are skipped. Travis
>>> enables nested virtualization by default with Ubuntu
>>> 18.04 (Bionic) on x86_64. So in order to run the kvm tests, this
>>> changed the acceptance builder to run in a Bionic VM. Also
>>> it was needed to ensure the current user has rw permission
>>> to /dev/kvm.
>>>
>>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>> ---
>>> =C2=A0 .travis.yml | 7 ++++++-
>>> =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index 6c1038a0f1..c3edd0a907 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -2,6 +2,7 @@
>>> =C2=A0 # Additional builds with specific requirements for a full VM nee=
d to
>>> =C2=A0 # be added as additional matrix: entries later on
>>> =C2=A0 dist: xenial
>>> +sudo: true
>>> =C2=A0 language: c
>>> =C2=A0 compiler:
>>> =C2=A0=C2=A0=C2=A0 - gcc
>>> @@ -83,6 +84,9 @@ git:
>>> =C2=A0 =C2=A0 before_script:
>>> =C2=A0=C2=A0=C2=A0 - if command -v ccache ; then ccache --zero-stats ; =
fi
>>> +=C2=A0 - if [[ -e /dev/kvm ]] && ! [[ -r /dev/kvm && -w /dev/kvm ]]; t=
hen
>> By the way, in case you respin, could you please use singel "[" instead
>> of "[[" ... since that's what we use in almost all other shell
>> scripts, too.
>=20
> Like this? ->
>=20
> if [ -e /dev/kvm ] && [ ! -r /dev/kvm ] || [ ! -w /dev/kvm ]; then

If I get the man-page of bash right, && and || have equal precedence ...
so I'd maybe rather write it as:

 if [ -e /dev/kvm ]; then if [ ! -r /dev/kvm ] || [ ! -w /dev/kvm ]; ...

... ok, this is getting uglier ...maybe it's better to rather stick with
your original code...?

 Thomas

PS: You could also use -c instead -e in the first test.


