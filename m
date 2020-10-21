Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF1FC561F8
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:06:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1450E2224B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 12:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OPJ6Bcv3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1450E2224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVCsn-0003JJ-Qv
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 08:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37692)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kVCrx-0002oG-QE
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:05:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lersek@redhat.com>) id 1kVCrt-0001j1-AR
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 08:05:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603281924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i0dc4X0I/ihCvXwcKjpyCfWklPF7goKThvXhL8UqU00=;
 b=OPJ6Bcv3SJfqPHG0V8bIRVnxx5Rgse7PWw7rcRxhJTwBvyx6ydRQdGLqD59re1l1EICDco
 cBJrvOGdfitcxucy3o12eaWYDnPI4Xnu9BgiUh6fkpQYZC5aZ3fgg7UI3y75TO95FVQgYw
 RN94pzAyPSqjiJ/hlcN5i8IOz3Xnzek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-FCLjc36dNrShO5iWKTQ4dQ-1; Wed, 21 Oct 2020 08:05:22 -0400
X-MC-Unique: FCLjc36dNrShO5iWKTQ4dQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A55C18CBC41;
 Wed, 21 Oct 2020 12:05:21 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-113-111.ams2.redhat.com
 [10.36.113.111])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A16545B4A3;
 Wed, 21 Oct 2020 12:05:19 +0000 (UTC)
Subject: Re: roms/efirom, tests/uefi-test-tools: update edk2's own submodules
 first
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
References: <20201020091605.GA2301@aepfle.de>
 <3fc07eb7-f99a-516b-9bb9-e48049547928@redhat.com>
 <20201020094419.GF287149@redhat.com>
 <0e196d48-6735-5116-ade5-a9b138020aea@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <46f7af9f-4a18-4352-dad2-cc176ed890e1@redhat.com>
Date: Wed, 21 Oct 2020 14:05:18 +0200
MIME-Version: 1.0
In-Reply-To: <0e196d48-6735-5116-ade5-a9b138020aea@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lersek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=lersek@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Olaf Hering <olaf@aepfle.de>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/20 11:54, Philippe Mathieu-Daudé wrote:
> On 10/20/20 11:44 AM, Daniel P. Berrangé wrote:
>> On Tue, Oct 20, 2020 at 11:29:01AM +0200, Philippe Mathieu-Daudé wrote:
>>> Hi Olaf,
>>>
>>> On 10/20/20 11:16 AM, Olaf Hering wrote:
>>>> This is about qemu.git#ec87b5daca761039bbcf781eedbe4987f790836f
>>>>
>>>> On Mon, Sep 07, Laszlo Ersek wrote:
>>>>
>>>>> In edk2 commit 06033f5abad3 ("BaseTools: Make brotli a submodule",
>>>>> 2020-04-16), part of edk2-stable202005, the Brotli compressor /
>>>>> decompressor source code that edk2 had flattened into BaseTools was
>>>>> replaced with a git submodule.
>>>>>
>>>>> This means we have to initialize edk2's own submodules before building
>>>>> BaseTools not just in "roms/Makefile.edk2", but in "roms/Makefile"
>>>>> (for
>>>>> the sake of the "efirom" target) and
>>>>> "tests/uefi-test-tools/Makefile" as
>>>>> well.
>>>>
>>>>> +++ b/roms/Makefile
>>>>>    edk2-basetools:
>>>>> +    cd edk2/BaseTools && git submodule update --init --force
>>>>>    build-edk2-tools:
>>>>> +    cd $(edk2_dir)/BaseTools && git submodule update --init --force
>>>>
>>>>
>>>> This change can not possibly be correct.
>>>>
>>>> With current qemu.git#master one is forced to have network access to
>>>> build the roms. This fails with exported (and complete) sources in an
>>>> offline environment.
>>>
>>> The EDK2 roms are only used for testing, we certainly don't want them
>>> to be used by distributions. I suppose the question is "why is this
>>> rule called if tests are not built?".
>>
>> I don't believe that is correct - the pc-bios/edk*  ROMs and the
>> corresponding  pc-bios/descriptor files are there for real world
>> end user consumption.   roms/edk2 should (must) match / reflect
>> the content used to build the pci-bios/edk* blobs.
>>
>> Many distros have a policy requiring them to build everything
>> from source, so they will ignore the pre-built edk2 ROMs, but
>> regular end users taking QEMU directly from upstream can certainly
>> use our edk2 ROMs.
> 
> Well I'm lost (and I don't think mainstream QEMU have the
> bandwidth to follow mainstream EDK2 security fixes) so I'm
> giving up, waiting for clarification from Laszlo.

I definitely don't have time for keeping the edk2 blobs bundled with
QEMU fresh wrt. security fixes in upstream edk2, so anyone expecting
that is in for a bad surprise. The blobs are provided, from my
perspective, (a) for some tests in the test suite (such as
bios-tables-test for the aarch64 target), (b) as a convenience for
end-users that desire to build QEMU from source, without wanting to
build OVMF from source.

I don't understand the particular problem (or rather: use case) that
Olaf is reporting (and this is not the first time). I see four classes
of people here:

(1) end-users described above, in point (b) -- then, there is no need
for rebuilding the bundled edk2 binaries using the QEMU build infrastructure

(2) end-users building everything from source (genuine standalone clones
/ checkouts), for themselves

(3) distributors building everything from source (genuine, standalone
clones / checkouts), for their users

(4) QEMU co-maintainers that sometimes refresh the binaries -- this is
the only group that the build infra *needs* to work for (in the future,
the edk2 build infra should actually target a remote build system, but
we're not there yet -- and even in that case, the edk2 build scripts
inside the QEMU tree will only have to work for *that* environment)

Olaf: if you build QEMU from source, why don't you build SeaBIOS, iPXE,
edk2 etc *also* from their corresponding pristine upstream clones /
checkouts, using your own dedicated build scripts / packagings?

... On the technical side, I guess the problem is that edk2, unlike some
other submodules of QEMU, has its own submodules (meaning that, from the
QEMU superproject's perspective, edk2 creates recusrive submodules). I
have really zero idea how to deal with that (or more precisely, what the
grander impact of that would be); but importantly, it does not *matter*,
in my opinion. If you don't co-maintain the edk2 binaries bundled with
QEMU, then the edk2 build stuff present in QEMU is not *required* to
work for you.

If you don't like that, feel free to post patches, or I can quit even
this level of maintenance for the bundled edk2 binaries. I will
absolutely not consider downstream packaging needs with *how* the
bundled edk2 binaries are built.

Thanks
Laszlo


