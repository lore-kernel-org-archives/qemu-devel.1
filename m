Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88412C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C60420663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C60420663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJxeJ-0002xJ-IW
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42668)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iJxcz-0002TB-2G
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:31:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iJxcw-0001p6-DC
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:31:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:49824)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iJxcw-0001mb-7A
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:30:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iJxcu-0008AI-Nm
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 10:30:56 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B27FF2E80C8
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 10:30:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Oct 2019 10:22:11 -0000
From: David Hildenbrand <1847232@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: s390x
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: davidhildenbrand ivmn
X-Launchpad-Bug-Reporter: Ivan Warren (ivmn)
X-Launchpad-Bug-Modifier: David Hildenbrand (davidhildenbrand)
References: <157053356610.22354.6751604707489617887.malonedeb@gac.canonical.com>
 <61ce859f-0817-0eba-7eb8-2c16b3e73889@redhat.com>
 <7a661e58-72df-94bc-4712-f306ce5ee7c6@vmfacility.fr>
 <8ada8acb-d2ce-a09d-6c9a-b758360edcb2@redhat.com>
Message-Id: <4115ee76-8f74-cce2-348b-44752cd402ed@redhat.com>
Subject: Re: [Bug 1847232] [NEW] qemu TCG in s390x mode issue with calculating
 HASH
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="af2eefe214bd95389a09b7c956720881bab16807";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a9b07e664cd0a7ad86320f6e5f98ff7568469379
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1847232 <1847232@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20191014102211.S15TIf-xA3XnVaAllmCyP20WXyapTlVKccrDOKWmn-g@z>

On 14.10.19 11:53, David Hildenbrand wrote:
> On 08.10.19 16:11, Ivan Warren wrote:
>>
>> On 10/8/2019 3:35 PM, David Hildenbrand wrote:
>>> On 08.10.19 14:11, Cornelia Huck wrote:
>>>> On Tue, 08 Oct 2019 11:19:25 -0000
>>>> Ivan Warren via <qemu-devel@nongnu.org> wrote:
>>>>
>>>>> Public bug reported:
>>>>>
>>>>> When using go on s390x on Debian x64 (buster) (host) and debian s390x
>>>>> (sid) (guest) I run into the following problem :
>>>>>
>>>>> The following occurs while trying to build a custom project :
>>>>>
>>>>> go: github.com/FactomProject/basen@v0.0.0-20150613233007-fe3947df716e:
>>>>> Get
>>>>> https://proxy.golang.org/github.com/%21factom%21project/basen/@v/v0.0=
.0-20150613233007-fe3947df716e.mod:
>>>>> local error: tls: bad record MAC
>>>>>
>>>>> Doing a git bisect I find that this problem only occurs on and after
>>>>> commit 08ef92d556c584c7faf594ff3af46df456276e1b
>>>>>
>>>>> Before that commit, all works fine. Past this commit, build always
>>>>> fails.
>>>> What version are you using? Current master?
>>>>
>>>> Can you please share your command line?
>>>>
>>>>> Without any proof, It looks like a hash calculation bug related to us=
ing
>>>>> z/Arch vector facilities...
>>>> Not an unreasonable guess, cc:ing David in case he has seen that befor=
e.
>>>>
>>> Can you reproduce with "-cpu qemu,vx=3Doff" added to the QEMU command
>>> line? Could be some fallout from vector instruction support. Currently
>>> ill, will have a look when I'm feeling better.
>>
>> Reposted with a reply all... (sorry for the duplicates)
>>
>> So it does !
>>
>>
>> My qemu command line is now (forget the odd funny networking things..)
>>
>> qemu-system-s390x \
>>    =C2=A0=C2=A0=C2=A0 -drive
>> file=3DDEB002.IMG.NEW,discard=3Dunmap,cache=3Dwriteback,id=3Ddrive-0,if=
=3Dnone \
>>    =C2=A0=C2=A0=C2=A0 -device virtio-scsi-ccw,id=3Dvirtio-scsi-0 \
>>    =C2=A0=C2=A0=C2=A0 -device scsi-hd,id=3Dscsi-hd-0,drive=3Ddrive-0 \
>>    =C2=A0=C2=A0=C2=A0 -m 8G \
>>    =C2=A0=C2=A0=C2=A0 -net nic,macaddr=3D52:54:00:00:00:02 \
>>    =C2=A0=C2=A0=C2=A0 -net tap,ifname=3Dtaparm,script=3Dno \
>>    =C2=A0=C2=A0=C2=A0 -nographic -accel tcg,thread=3Dmulti \
>>    =C2=A0=C2=A0=C2=A0 -monitor unix:ms,server,nowait \
>>    =C2=A0=C2=A0=C2=A0 -cpu qemu,vx=3Doff \=C2=A0 ##### THAT WAS ADDED as=
 instructed - without it
>> everything goes kaput !
>>    =C2=A0=C2=A0=C2=A0 -smp 12
>>
>> And using the latest bleeding edge qemu from github, my build works (the
>> problem goes away).
>>
>> So the z/Arch vector instructions may have a glitch is a venue to
>> consider.. Probably one that couldn't be screened through conventional
>> methods.
>>
>> I'm not that versed into z/Arch vector instruction, but if there
>> anything I can help with, I will !
> =

> I'll have to reproduce, can you outline the steps needed to trigger
> this? (never had to build a go project before #luckyme ( ;) )). It looks
> like https://github.com/FactomProject/basen is getting pulled in from
> some other project?
> =


I just tried with Fedora 31 Nightly using "go get"

[root@f31 ~]# go get -v -d github.com/FactomProject/factom
github.com/FactomProject/factom (download)
github.com/FactomProject/btcutil (download)
github.com/FactomProject/ed25519 (download)
github.com/FactomProject/go-bip32 (download)
github.com/FactomProject/btcutilecc (download)
package golang.org/x/crypto/ripemd160: unrecognized import path "golang.org=
/x/crypto/ripemd160" (https fetch: Get https://golang.org/x/crypto/ripemd16=
0?go-get=3D1: local error: tls: bad record MAC)
github.com/FactomProject/go-bip39 (download)
package golang.org/x/crypto/pbkdf2: unrecognized import path "golang.org/x/=
crypto/pbkdf2" (https fetch: Get https://golang.org/x/crypto/pbkdf2?go-get=
=3D1: local error: tls: bad record MAC)
github.com/FactomProject/go-bip44 (download)
github.com/FactomProject/netki-go-partner-client (download)
github.com/FactomProject/go-simplejson (download)

With vx=3Doff:

[root@f31 ~]# go get -v -d github.com/FactomProject/factom
github.com/FactomProject/factom (download)
github.com/FactomProject/btcutil (download)
github.com/FactomProject/ed25519 (download)
github.com/FactomProject/go-bip32 (download)
github.com/FactomProject/basen (download)
github.com/FactomProject/btcutilecc (download)
get "golang.org/x/crypto/ripemd160": found meta tag get.metaImport{Prefix:"=
golang.org/x/crypto", VCS:"git", RepoRoot:"https://go.googlesource.com/cryp=
to"} at //golang.org/x/crypto/ripemd160?go-get=3D1
get "golang.org/x/crypto/ripemd160": verifying non-authoritative meta tag
golang.org/x/crypto (download)
github.com/FactomProject/go-bip39 (download)
github.com/FactomProject/go-bip44 (download)
github.com/FactomProject/netki-go-partner-client (download)
github.com/FactomProject/go-simplejson (download)


That should be sufficient to identify the instruction. Might take some time=
, though. E.g.,
the HASH calculation in the kernel works just fine.

--

Thanks,

David / dhildenb

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1847232

Title:
  qemu TCG in s390x mode issue with calculating HASH

Status in QEMU:
  New

Bug description:
  When using go on s390x on Debian x64 (buster) (host) and debian s390x
  (sid) (guest) I run into the following problem :

  The following occurs while trying to build a custom project :

  go: github.com/FactomProject/basen@v0.0.0-20150613233007-fe3947df716e:
  Get
  https://proxy.golang.org/github.com/%21factom%21project/basen/@v/v0.0.0-2=
0150613233007-fe3947df716e.mod:
  local error: tls: bad record MAC

  Doing a git bisect I find that this problem only occurs on and after
  commit 08ef92d556c584c7faf594ff3af46df456276e1b

  Before that commit, all works fine. Past this commit, build always
  fails.

  Without any proof, It looks like a hash calculation bug related to
  using z/Arch vector facilities...

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1847232/+subscriptions

