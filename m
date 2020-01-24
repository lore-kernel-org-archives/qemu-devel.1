Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A45C2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:56:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E98F20702
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 19:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUvT5Q2B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E98F20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv54a-0000AO-Df
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 14:56:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wainersm@redhat.com>) id 1iv53v-0008B5-Vh
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <wainersm@redhat.com>) id 1iv53r-0008Cl-Nk
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:56:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27743
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1iv53r-0008C5-CP
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 14:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579895770;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LU+95+MxRODU7EmfL/VH2msq12zdmadWA+kBB9sy0JI=;
 b=PUvT5Q2B+J6jXQyGLe8QhwBQJ7JiA79x1vr6L+ELDT2a1JMojt6TLFXzvjRZ4PbdPH0029
 znxo+9oyxDS82syaYHNFF96zPRadv7/AHioj//A9csRNVpvqjBeKlh2TsTv1VQ+54xlcUH
 vslTA0uGy19pcbEHiyO38pBRDlmx7gI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-zWtH9qSoMeSpHUuwsadzPg-1; Fri, 24 Jan 2020 14:56:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B1F25800D41;
 Fri, 24 Jan 2020 19:56:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-27.gru2.redhat.com
 [10.97.116.27])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B58D8DC18;
 Fri, 24 Jan 2020 19:56:00 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] travis.yml: Enable acceptance KVM tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, alex.bennee@linaro.org
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-5-wainersm@redhat.com>
 <e500a1ce-d2b6-b372-b1cb-f9bddcbf8334@redhat.com>
 <e9461b25-14d6-900c-1558-78a7aa910f92@redhat.com>
 <e5689532-cfa7-1db7-ade2-c3a274083b25@redhat.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <86ba7b67-a69a-bfc3-2d70-d4328acda2de@redhat.com>
Date: Fri, 24 Jan 2020 17:55:58 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <e5689532-cfa7-1db7-ade2-c3a274083b25@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: zWtH9qSoMeSpHUuwsadzPg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 1/24/20 7:54 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/24/20 10:44 AM, Thomas Huth wrote:
>> On 24/01/2020 10.38, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 1/22/20 2:27 AM, Wainer dos Santos Moschetta wrote:
>>>> Some acceptance tests require KVM or they are skipped. Travis
>>>> enables nested virtualization by default with Ubuntu
>>>> 18.04 (Bionic) on x86_64. So in order to run the kvm tests, this
>>>> changed the acceptance builder to run in a Bionic VM. Also
>>>> it was needed to ensure the current user has rw permission
>>>> to /dev/kvm.
>>>>
>>>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>>> ---
>>>> =C2=A0=C2=A0 .travis.yml | 7 ++++++-
>>>> =C2=A0=C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/.travis.yml b/.travis.yml
>>>> index 6c1038a0f1..c3edd0a907 100644
>>>> --- a/.travis.yml
>>>> +++ b/.travis.yml
>>>> @@ -2,6 +2,7 @@
>>>> =C2=A0=C2=A0 # Additional builds with specific requirements for a full=
 VM=20
>>>> need to
>>>> =C2=A0=C2=A0 # be added as additional matrix: entries later on
>>>> =C2=A0=C2=A0 dist: xenial
>>>> +sudo: true
>>>> =C2=A0=C2=A0 language: c
>>>> =C2=A0=C2=A0 compiler:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - gcc
>>>> @@ -83,6 +84,9 @@ git:
>>>> =C2=A0=C2=A0 =C2=A0 before_script:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - if command -v ccache ; then ccache --zero-s=
tats ; fi
>>>> +=C2=A0 - if [[ -e /dev/kvm ]] && ! [[ -r /dev/kvm && -w /dev/kvm ]]; =
then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sudo chmod o+rw /dev/kvm ;
>>>> +=C2=A0=C2=A0=C2=A0 fi


Philippe, anwsering here your question about 'sudo'.

The above statement runs on before_script for all the builders. As far=20
as I know only on Bionic-based builders 'chmod' (that needs sudo) will=20
be executed, so technically 'sudo' should=C2=A0 be enabled only on those=20
builders. But I thought that would be error-prone not enable it globally=20
since the code requiring it is globally declared too. All in all, I=20
don't have a strong option for this.


>>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFI=
G} || { cat
>>>> config.log && exit 1; }
>>>> =C2=A0=C2=A0 script:
>>>> @@ -272,12 +276,13 @@ matrix:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TEST_CM=
D=3D"make check-acceptance"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 after_script:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - python3=
 -c 'import json; r =3D
>>>> json.load(open("tests/results/latest/results.json"));
>>>> [print(t["logfile"]) for t in r["tests"] if t["status"] not in
>>>> ("PASS", "SKIP")]' | xargs cat
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dist: bionic
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addons:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apt:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 packages:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - python3-pil
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - python3-pip
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - =
python3.5-venv
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - =
python3.6-venv
>>>
>>> This line doesn't seem related to the patch.
>>
>> "dist:" has been switched from xenial to bionic, so I think it is
>> required to update to python3.6 here, too?


Thomas is right, python3.5-venv isn't available on Ubuntu Bionic.


>>
>
> OK, I got confused because line 4 is still "dist: xenial".


I'm about to send a proposal to bump dist to bionic. There are some=20
non-acceptance tests being skipped because of the lack of nested kvm on=20
Travis's xenial VMs, so that would be beneficial to them as well.

Thomas mentioned in another email thread that there is a build problem=20
with the libssh version of Bionic (I hope that can be worked out). Other=20
than that, do you see any impediment to switch all builders completely?


>
>
> Wainer can you add a comment about this in the commit description?


Sure, actually I should have done it. Thanks for raising that point too.

- Wainer

>
>
> I'm still not convinced we should enable "sudo: true" on all our jobs.
>


