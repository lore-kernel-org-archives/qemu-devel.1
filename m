Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93109C3F68F
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:46:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6261D22464
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 09:46:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HGHhEY8L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6261D22464
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuvXM-000130-IL
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 04:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34936)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iuvWZ-0000T5-H3
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iuvWY-0008Ap-8v
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:45:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22599
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iuvWY-00089b-5D
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 04:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579859109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=cpg2ZhFWw31mI5+aqIw6kvTCPoCixdYxCEpbSijCHBY=;
 b=HGHhEY8L02Visj/ApSgXvAzA3gWra2L+qaYcXGM7obCUO+9jkiF7Rqdx8dQg6T2D0VgKOG
 0qt7E8WM8K0LUMYQIyBRcIEH9jn12VpbbJo4d0kPfVghh0nxE6DOEAEOKdE5BdiHv41jxD
 YDB60264UVej4nSQZzEAOxQatMm+79M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-ABnFjdmJOSi67D8qj_-q3A-1; Fri, 24 Jan 2020 04:45:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1DC8F100550E;
 Fri, 24 Jan 2020 09:45:07 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-156.ams2.redhat.com [10.36.116.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E23595DA60;
 Fri, 24 Jan 2020 09:44:59 +0000 (UTC)
Subject: Re: [PATCH v3 4/4] travis.yml: Enable acceptance KVM tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org
References: <20200122012753.9846-1-wainersm@redhat.com>
 <20200122012753.9846-5-wainersm@redhat.com>
 <e500a1ce-d2b6-b372-b1cb-f9bddcbf8334@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <e9461b25-14d6-900c-1558-78a7aa910f92@redhat.com>
Date: Fri, 24 Jan 2020 10:44:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e500a1ce-d2b6-b372-b1cb-f9bddcbf8334@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: ABnFjdmJOSi67D8qj_-q3A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.81
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
Cc: alex.bennee@linaro.org, ehabkost@redhat.com, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/01/2020 10.38, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/22/20 2:27 AM, Wainer dos Santos Moschetta wrote:
>> Some acceptance tests require KVM or they are skipped. Travis
>> enables nested virtualization by default with Ubuntu
>> 18.04 (Bionic) on x86_64. So in order to run the kvm tests, this
>> changed the acceptance builder to run in a Bionic VM. Also
>> it was needed to ensure the current user has rw permission
>> to /dev/kvm.
>>
>> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>> ---
>> =C2=A0 .travis.yml | 7 ++++++-
>> =C2=A0 1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/.travis.yml b/.travis.yml
>> index 6c1038a0f1..c3edd0a907 100644
>> --- a/.travis.yml
>> +++ b/.travis.yml
>> @@ -2,6 +2,7 @@
>> =C2=A0 # Additional builds with specific requirements for a full VM need=
 to
>> =C2=A0 # be added as additional matrix: entries later on
>> =C2=A0 dist: xenial
>> +sudo: true
>> =C2=A0 language: c
>> =C2=A0 compiler:
>> =C2=A0=C2=A0=C2=A0 - gcc
>> @@ -83,6 +84,9 @@ git:
>> =C2=A0 =C2=A0 before_script:
>> =C2=A0=C2=A0=C2=A0 - if command -v ccache ; then ccache --zero-stats ; f=
i
>> +=C2=A0 - if [[ -e /dev/kvm ]] && ! [[ -r /dev/kvm && -w /dev/kvm ]]; th=
en
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sudo chmod o+rw /dev/kvm ;
>> +=C2=A0=C2=A0=C2=A0 fi
>> =C2=A0=C2=A0=C2=A0 - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
>> =C2=A0=C2=A0=C2=A0 - ${SRC_DIR}/configure ${BASE_CONFIG} ${CONFIG} || { =
cat
>> config.log && exit 1; }
>> =C2=A0 script:
>> @@ -272,12 +276,13 @@ matrix:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - TEST_CMD=3D"mak=
e check-acceptance"
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 after_script:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - python3 -c 'imp=
ort json; r =3D
>> json.load(open("tests/results/latest/results.json"));
>> [print(t["logfile"]) for t in r["tests"] if t["status"] not in
>> ("PASS", "SKIP")]' | xargs cat
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dist: bionic
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 addons:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 apt:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 packa=
ges:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - python3-pil
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 - python3-pip
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - py=
thon3.5-venv
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - py=
thon3.6-venv
>=20
> This line doesn't seem related to the patch.

"dist:" has been switched from xenial to bionic, so I think it is
required to update to python3.6 here, too?

 Thomas


