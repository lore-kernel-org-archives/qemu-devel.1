Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E04ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:54:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 794AC2070B
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 15:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794AC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVKh-0007JZ-CZ
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 11:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iHV4n-0001Vy-C5
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:37:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iHV4i-0008HU-KC
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:37:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iHV4i-0008GI-4n
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 11:37:28 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B0C148AC6F6;
 Mon,  7 Oct 2019 15:37:26 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 53AD85EE1D;
 Mon,  7 Oct 2019 15:37:18 +0000 (UTC)
Subject: Re: [PATCH] netmap: support git-submodule build otption
To: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <874l13qmvb.fsf@dusky.pond.sub.org>
 <20191004130242.27267-1-g.lettieri@iet.unipi.it>
 <CAFEAcA8ut__ruS4yEMT7-qCKu+BFihFwhaNoq7L1cdoqxpXx6g@mail.gmail.com>
 <87pnj8ltih.fsf@dusky.pond.sub.org>
 <CAFEAcA9KLDruPS6o85H5XJnQjoSXV2+-d=dnNGPvc80jiBthiQ@mail.gmail.com>
 <87zhicg2ce.fsf@dusky.pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <aeeb3680-71fa-55ff-40df-7abfc5a57a5a@redhat.com>
Date: Mon, 7 Oct 2019 17:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <87zhicg2ce.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Mon, 07 Oct 2019 15:37:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>,
 Luigi Rizzo <rizzo@iet.unipi.it>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>,
 Stefan Hajnoczi <stefanha@redhat.com>, Ed Maste <emaste@freebsd.org>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 07/10/2019 14.35, Markus Armbruster wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>=20
>> On Mon, 7 Oct 2019 at 11:50, Markus Armbruster <armbru@redhat.com> wro=
te:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>> Basically new submodules are a pain so we seek to minimize
>>>> the use of them.
>>>
>>> I suggested making it a submodule upthread[*].  Let me try to distill
>>> the conversation into a rationale.  Giuseppe, please correct mistakes=
.
>>>
>>> To make use of QEMU's netmap backend (CONFIG_NETMAP), you have to bui=
ld
>>> and install netmap software from sources[**].  Which pretty much ensu=
res
>>> developers compile with CONFIG_NETMAP off, and the code rots.
>>>
>>> For other dependencies that aren't readily available on common
>>> development hosts (slirp, capstone), we use submodules to avoid such
>>> rot.  If the system provides, we use that, and if it doesn't, we fall
>>> back to the submodule.  This has served us well.
>>
>> I would put this differently. We don't use submodules to avoid
>> code-rot. We use submodules where a dependency is needed for us
>> to provide QEMU features that are sufficiently important that we
>> want to provide them to users even if those users don't have the
>> dependency available to them as a system library.
>>
>> There are lots of features of QEMU that only compile with sufficiently
>> recent versions of dependencies, and we don't try to submodule-ize
>> them because the features aren't really that important for the bulk
>> of our users. For instance, we provided pixman as a submodule for
>> a while because the features that require it (our graphics layer
>> code) are important to almost all users. But we didn't provide
>> spice as a module even when you pretty much needed to be
>> running bleeding-edge redhat to satisfy the version dependency
>> we had, because most users don't care about spice support.
>> Shipping our dependencies as submodules imposes real costs
>> on the project (for instance we then need to track the upstream
>> to see when we should be updating, including checking whether
>> we need to update to fix security issues). Submodules should be
>> the exception, not the rule.
>>
>>> For netmap, falling back to the submodule when the host doesn't provi=
de
>>> tends not to be useful beyond compile-testing.  Because of that, we f=
all
>>> back only when the user explicitly asks for it by passing
>>> --enable-netmap=3Dgit to configure.  CI should do that.
>>
>> This sounds like netmap is in the same position as most of our
>> dependencies: OK to compile if the system provides the library,
>> but if the system doesn't then almost all users won't care
>> that the feature isn't present. If CI of the QEMU code is useful,
>=20
> If CI of QEMU code isn't useful, then I suspect the QEMU code isn't
> useful, period.  Giuseppe assures us the netmap QEMU code *is* useful.
> It followe we better make sure our CI covers it.
>=20
> A submodule would make sure, but it looks like it won't fly.  So let's
> try another tack:
>=20
>> get the library supported by and shipped in distros. If you can't
>> get anybody in a distro (Linux or BSD) to care enough to ship the
>> library, this is a really niche feature, and up for consideration
>> for deprecate-and-drop from QEMU, I think.
>=20
> Giuseppe, you mentioned netmap is in FreeBSD, and getting it into Linux
> is unlikely, so let's focus on FreeBSD.
>=20
> We have a FreeBSD section in .patchew.yml, which makes me guess Patchew
> CI tests FreeBSD.  Does it test with CONFIG_NETMAP out of the box?  If
> not, how do we have to tweak its configuration to get CONFIG_NETMAP
> enabled?  Who could help with this?

I just tried this patch here:

diff --git a/.cirrus.yml b/.cirrus.yml
--- a/.cirrus.yml
+++ b/.cirrus.yml
@@ -8,7 +8,7 @@ freebsd_12_task:
     memory: 8G
   install_script: pkg install -y
     bash bison curl cyrus-sasl git glib gmake gnutls gsed
-    nettle perl5 pixman pkgconf png usbredir
+    nettle perl5 pixman pkgconf png usbredir netmap
   script:
     - mkdir build
     - cd build

... and looks like net/netmap.c now gets successfully compiled on
FreeBSD in the Cirrus-CI:

 https://api.cirrus-ci.com/v1/task/5669479475838976/logs/main.log

We can also add it to the vm-freebsd test:

diff --git a/tests/vm/freebsd b/tests/vm/freebsd
--- a/tests/vm/freebsd
+++ b/tests/vm/freebsd
@@ -54,6 +54,9 @@ class FreeBSDVM(basevm.BaseVM):
         # libs: opengl
         "libepoxy",
         "mesa-libs",
+
+        # libs: network
+        "netmap",
     ]

     BUILD_SCRIPT =3D """

... then it gets compiled succesfully during "make vm-build-freebsd".

So does that sound like a good way to keep netmap.c from bitrotting? If
so, I can send the above two diffs as a proper patch, if you like.

 Thomas



