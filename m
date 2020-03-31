Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DC0C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:21:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65C5A20786
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 15:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65C5A20786
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJIi6-0000vs-K8
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 11:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60697)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jJIhJ-0000Uq-8V
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:21:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jJIhH-0007Sw-Q7
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:21:00 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:49288)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1jJIhH-0007Rn-1k
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 11:20:59 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 88F4E746383;
 Tue, 31 Mar 2020 17:20:57 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 6545E74637F; Tue, 31 Mar 2020 17:20:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 63A13745953;
 Tue, 31 Mar 2020 17:20:57 +0200 (CEST)
Date: Tue, 31 Mar 2020 17:20:57 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Eric Blake <eblake@redhat.com>
Subject: Re: deprecation of in-tree builds
In-Reply-To: <d447cca0-44b2-392b-3be6-32f17c255dea@redhat.com>
Message-ID: <alpine.BSF.2.22.395.2003311715110.73689@zero.eik.bme.hu>
References: <CAFEAcA8E6goDHb-7kKCTp=wSpBsuJcfjMmLP0EgymiEL348r4A@mail.gmail.com>
 <87v9mmug73.fsf@dusky.pond.sub.org>
 <CAFEAcA-9U=EAXAtPDh_AnO3eUbM_jcRBuf4x=0Rec0EC-v2mNA@mail.gmail.com>
 <20200330134212.GO236854@redhat.com> <20200330143759.GD6139@linux.fritz.box>
 <c0a1dc94-c3f2-696e-743f-aa15ef995094@redhat.com>
 <20200331120220.GA7030@linux.fritz.box>
 <d447cca0-44b2-392b-3be6-32f17c255dea@redhat.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-15?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020, Eric Blake wrote:
> On 3/31/20 7:02 AM, Kevin Wolf wrote:
>> Am 31.03.2020 um 09:48 hat Paolo Bonzini geschrieben:
>>> On 30/03/20 16:37, Kevin Wolf wrote:
>>>> If manually dealing with separate build directories is inconvenient
>>>> today, it will still be inconvenient with Meson, so this would mean
>>>> introducing the automatic directly creation together with the other
>>>> changes to enable Meson. Which is fine by me, as long as it is really
>>>> done when the external directory becomes mandatory, so that people won't
>>>> have to switch back and forth between directories.
>>> 
>>> Serious question: why is automatic directly creation more convenient for
>>> developers?  Even if "./configure" generates a "build" directory for
>>> you, you would still have to invoke the QEMU binary as
>>> "build/x86_64-softmmu/qemu-system-x86_64".  That is less convenient than
>>> doing "mkdir build" in the first place.
>> 
>> Mainly because it allows me to start everything (most importantly: my
>> editor, git and make) from the same directory.
>> 
>> I guess the automatic directory creation is the less important part
>> compared to a Makefile in the source tree that calls the Makefile in the
>> build directory, because creation the directory is a one-time thing, but
>> I call make all the time.
>
> If we make in-tree ./configure create a GNUmakefile shim that auto-forwards 
> to build/, it would also be possible to create symlinks to the various 
> targets that will live in build.  I recently switched my qemu playground to 
> use VPATH builds, but with symlinks such as qemu-img -> build/qemu-img, I can 
> still use my muscle memory of an in-tree build for normal development.
>
>> 
>> Creating it automatically is nice especially for those who build QEMU
>> for the first time and expect that the ./configure; make; make install
>> sequence they are used to just works.
>> 
>> Prefixing build/ when using the binaries is a change, too, but I guess
>> tab completion means that it's not much worse than prefixing ./
>
> With symlinks, it is possible to give much more than 'make' the illusion of 
> working in-tree.  It then boils down to a question of how many symlinks are 
> worth creating.

Also creating symlinks, while nice, is probably added maintainance burden 
because it's something that only needs to be done in in-tree runs so it 
will likely get broken by those using only out of tree. I think getting 
results in a build dir is acceptable (most results are already in some 
subdir at least for system emulation) and just adding convenience Makefile 
is not much complexity while preserving symlinks for build results would 
be so that's probably not much maintenance improvement over current 
situarion.

Regards,
BALATON Zoltan

