Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E65C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:49:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07C85207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 20:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07C85207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCrkz-0000ni-CU
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 16:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iCriR-0007bh-WC
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iCriQ-0006lF-6m
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 16:47:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56032)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1iCriO-0006je-LI; Tue, 24 Sep 2019 16:47:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2EFCA3175296;
 Tue, 24 Sep 2019 20:47:15 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-118.rdu2.redhat.com
 [10.10.120.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8C6B95C21F;
 Tue, 24 Sep 2019 20:47:07 +0000 (UTC)
Subject: Re: [Qemu-devel] [PATCH 2/2] roms/Makefile.edk2: don't pull in
 submodules when building from tarball
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
References: <20190912231202.12327-1-mdroth@linux.vnet.ibm.com>
 <20190912231202.12327-3-mdroth@linux.vnet.ibm.com>
 <9659eaf9-65f8-b717-271c-e5941debdb2f@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b0cc54db-0917-d79d-923e-dbae341cce34@redhat.com>
Date: Tue, 24 Sep 2019 22:47:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9659eaf9-65f8-b717-271c-e5941debdb2f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 24 Sep 2019 20:47:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-stable@nongnu.org, brogers@suse.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/20/19 21:50, Philippe Mathieu-Daud=C3=A9 wrote:
> On 9/13/19 1:12 AM, Michael Roth wrote:
>> Currently the `make efi` target pulls submodules nested under the
>> roms/edk2 submodule as dependencies. However, when we attempt to build
>> from a tarball this fails since we are no longer in a git tree.
>>
>> A preceding patch will pre-populate these submodules in the tarball,
>> so assume this build dependency is only needed when building from a
>> git tree.
>>
>> Reported-by: Bruce Rogers <brogers@suse.com>
>> Cc: Laszlo Ersek <lersek@redhat.com>
>> Cc: Bruce Rogers <brogers@suse.com>
>> Cc: qemu-stable@nongnu.org # v4.1.0
>> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
>> ---
>>  roms/Makefile.edk2 | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/roms/Makefile.edk2 b/roms/Makefile.edk2
>> index c2f2ff59d5..33a074d3a4 100644
>> --- a/roms/Makefile.edk2
>> +++ b/roms/Makefile.edk2
>> @@ -46,8 +46,13 @@ all: $(foreach flashdev,$(flashdevs),../pc-bios/edk=
2-$(flashdev).fd.bz2) \
>>  # files.
>>  .INTERMEDIATE: $(foreach flashdev,$(flashdevs),../pc-bios/edk2-$(flas=
hdev).fd)
>> =20
>> +# Fetch edk2 submodule's submodules. If it is not in a git tree, assu=
me
>> +# we're building from a tarball and that they've already been fetched=
 by
>> +# make-release/tarball scripts.
>=20
> Annoying, without using the make-release tool in a fresh clone, I get
> qemu/roms/edk2/CryptoPkg/Library/OpensslLib/OpensslLibCrypto.inf(-1):
> error 000E: File/directory not found in workspace
>=20
> I vaguely remember there was a thread about not using 'git submodule
> update --init --recursive' in the root directory but can't find it, any
> idea?

I think that was a point made in the first patch of this series -- the
"--recursive" flag is unbounded, and it might pull in several unneeded
submodules.

For example, openssl itself appears to have three submodules (boringssl,
krb5, pyca-cryptography), and none of those is needed for building
openssl the way edk2 consumes it.

I seem to remember that patch#1 in this series stated: we'd be handling
the submodules on a case-by-case basis.

Thanks
Laszlo

>=20
>>  submodules:
>> -	cd edk2 && git submodule update --init --force
>> +	if test -d edk2/.git; then \
>> +		cd edk2 && git submodule update --init --force; \
>> +	fi
>> =20
>>  # See notes on the ".NOTPARALLEL" target and the "+" indicator in
>>  # "tests/uefi-test-tools/Makefile".
>>


