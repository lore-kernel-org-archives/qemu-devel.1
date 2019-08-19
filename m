Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EA0C3A59D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9536E2085A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 11:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9536E2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzgH5-0007EW-GN
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 07:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33694)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1hzgFs-00063N-IH
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1hzgFq-0003H7-LB
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 07:55:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1hzgFn-0003FH-4L; Mon, 19 Aug 2019 07:55:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 60E61106E96C;
 Mon, 19 Aug 2019 11:55:13 +0000 (UTC)
Received: from [10.36.117.56] (ovpn-117-56.ams2.redhat.com [10.36.117.56])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 006101C0;
 Mon, 19 Aug 2019 11:55:11 +0000 (UTC)
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Cornelia Huck <cohuck@redhat.com>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <8fb538f3-dfdd-b427-727a-2e7c2120da09@gmail.com>
 <20e800e8-846b-a9c3-f840-826238b0818f@redhat.com>
 <f94cb9f0-32cb-9fad-dff1-5e3261d3bfb6@vivier.eu>
 <1d5e9145-42d7-8ab3-cc9f-7ec4eb00758c@redhat.com>
 <bd7bb802-c4fa-181b-c7d0-bf67a0f2bb31@vivier.eu>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <d1b63727-a718-4789-5ba7-be9ed2e94da6@redhat.com>
Date: Mon, 19 Aug 2019 13:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <bd7bb802-c4fa-181b-c7d0-bf67a0f2bb31@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Mon, 19 Aug 2019 11:55:13 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] linux-user: s390x issue on Fedora 30
 (dynamic library loader?)
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19.08.19 12:32, Laurent Vivier wrote:
> Le 17/08/2019 =C3=A0 18:51, David Hildenbrand a =C3=A9crit=C2=A0:
>> On 17.08.19 18:22, Laurent Vivier wrote:
>>> Le 17/08/2019 =C3=A0 18:14, David Hildenbrand a =C3=A9crit=C2=A0:
>>>> On 17.08.19 17:59, David Hildenbrand wrote:
>>>>> Hi everybody,
>>>>>
>>>>> I was just trying to run qemu-s390x (linux-user) with a very simple
>>>>> binary (gzip + lib/ld64.so.1, compiled under Fedora 27). This used =
to
>>>>> work just fine a while ago (especially when I was working on vector
>>>>> instructions using QEMU v3.1). However, now I can't get past a SEGF=
AULT
>>>>> in the dynamic library loader (I assume it is trying to locate glib=
c). I
>>>>> tried a couple of other binaries that definitely used to work (from
>>>>> Fedora 30).
>>>>>
>>>>> I checked QEMU v4.1, v4.0 and v3.1. All are broken for me. Which is
>>>>> weird - because it used to work :/
>>>>>
>>>>> I remember that I was running Fedora 29 the last time I had it runn=
ing,
>>>>> so my gut feeling is that this is related to some other system libr=
ary
>>>>> (but which?). I am running on an up-to-date Fedora 30 x86-64 now.
>>>>>
>>>>> Any ideas? Has this been reported already? (not sure if this is a F=
edora
>>>>> 30 issue)
>>>>>
>>>>> LANG=3DC ~/git/qemu/s390x-linux-user/qemu-s390x -d in_asm -L . gzip=
 --help
>>>>>
>>>>> ----------------
>>>>> IN: _dl_load_cache_lookup
>>>>> 0x00000040008854c2:  larl       %r1,0x4000895030
>>>>> 0x00000040008854c8:  lg %r8,264(%r11)
>>>>> 0x00000040008854ce:  mvghi      0(%r1),-1
>>>>> 0x00000040008854d4:  la %r3,0(%r3,%r8)
>>>>> 0x00000040008854d8:  l  %r7,12(%r8)
>>>>> 0x00000040008854dc:  llgfr      %r2,%r7
>>>>> 0x00000040008854e0:  sllg       %r1,%r2,1
>>>>> 0x00000040008854e6:  agr        %r1,%r2
>>>>> 0x00000040008854ea:  sllg       %r1,%r1,2
>>>>> 0x00000040008854f0:  la %r6,16(%r1,%r8)
>>>>> 0x00000040008854f4:  sgr        %r3,%r6
>>>>> 0x00000040008854f8:  stg        %r3,256(%r11)
>>>>> 0x00000040008854fe:  ahi        %r7,-1
>>>>> 0x0000004000885502:  jl 0x40008850f0
>>>>>
>>>>> ----------------
>>>>> IN: _dl_load_cache_lookup
>>>>> 0x0000004000885506:  srak       %r10,%r7,1
>>>>> 0x000000400088550c:  lgfr       %r2,%r10
>>>>> 0x0000004000885510:  sllg       %r1,%r2,1
>>>>> 0x0000004000885516:  agr        %r1,%r2
>>>>> 0x000000400088551a:  sllg       %r1,%r1,2
>>>>> 0x0000004000885520:  l  %r1,20(%r1,%r8)
>>>>> 0x0000004000885524:  clrjhe     %r1,%r3,0x40008850f0
>>>>>
>>>>> Segmentation fault (Speicherabzug geschrieben)
>>>>>
>>>>>
>>>>> Core was generated by
>>>>> `/home/dhildenb/git/qemu/s390x-linux-user/qemu-s390x -d in_asm -L .=
 gzip
>>>>> --help'.
>>>>> Program terminated with signal SIGSEGV, Segmentation fault.
>>>>> #0  0x00007fdc5d7c3232 in sigsuspend () from /lib64/libc.so.6
>>>>> [Current thread is 1 (Thread 0x7fdc5d7127c0 (LWP 31072))]
>>>>> Missing separate debuginfos, use: dnf debuginfo-install
>>>>> glib2-2.60.6-1.fc30.x86_64 glibc-2.29-15.fc30.x86_64
>>>>> libgcc-9.1.1-1.fc30.x86_64 libstdc++-9.1.1-1.fc30.x86_64
>>>>> pcre-8.43-2.fc30.x86_64 zlib-1.2.11-16.fc30.x86_64
>>>>> (gdb) bt
>>>>> #0  0x00007fdc5d7c3232 in sigsuspend () from /lib64/libc.so.6
>>>>> #1  0x000055f826135a9c in dump_core_and_abort
>>>>> (target_sig=3Dtarget_sig@entry=3D11)
>>>>>     at /home/dhildenb/git/qemu/linux-user/signal.c:613
>>>>> #2  0x000055f826135e37 in handle_pending_signal
>>>>> (cpu_env=3Dcpu_env@entry=3D0x55f8292cec48, sig=3Dsig@entry=3D11,
>>>>>     k=3Dk@entry=3D0x55f8292d7df0) at
>>>>> /home/dhildenb/git/qemu/linux-user/signal.c:877
>>>>> #3  0x000055f826136edd in process_pending_signals
>>>>> (cpu_env=3Dcpu_env@entry=3D0x55f8292cec48)
>>>>>     at /home/dhildenb/git/qemu/linux-user/signal.c:953
>>>>> #4  0x000055f82613a13a in cpu_loop (env=3D0x55f8292cec48) at
>>>>> /home/dhildenb/git/qemu/linux-user/s390x/cpu_loop.c:150
>>>>> #5  0x000055f8260ce2ba in main (argc=3D<optimized out>,
>>>>> argv=3D0x7fff587a69d8, envp=3D<optimized out>)
>>>>>     at /home/dhildenb/git/qemu/linux-user/main.c:819
>>>>>
>>>>> Thanks!
>>>>>
>>>>
>>>> CCing QEMU-devel + use my proper dev mail address (I need more coffe=
e :))
>>>>
>>>
>>> I generally test qemu-s390x before my PR. Last time, I have tested wi=
th
>>> Fedora 30 x86_64 but my target are always debian.
>>
>> What puzzles me is that it used to work just fine about 3-4 months ago=
.
>> I still have the binaries/libs lying around that I used back then (whe=
n
>> debugging a vector instruction-related issue). Whatever binary/QEMU
>> version I try now, it keeps segfaulting.
>>
>> Via qemu-system-s390x, inside a Fedora guest, the binaries work
>> perfectly fine. So I really suspect that this has to do with my host s=
ystem.
>>
>>>
>>> So I guess the problem is with the target.
>>>
>>> I will have a look on Monday.
>>
>=20
> I'm not able to reproduce it. In a chroot or using "-L" with only
> /bin/gzip, /lib64/ld64.so.1 and /lib/libc.so.6 in the directory.
>=20
> My host is Fedora 30 (updated today) and the target directory is Fedora
> 30 too (from
> https://download-ib01.fedoraproject.org/pub/fedora-secondary/releases/3=
0/Container/s390x/images/Fedora-Container-Minimal-Base-30-1.2.s390x.tar.x=
z)
>=20
> Do you have more details?

Thanks for having a look!

I just tried with the Fedora 30 target files they seem to work just fine
indeed (chroot and -L after manually copying the two lib files).

Now, I took the same files from RHEL8 (everything is built with
z13/vector instruction support enforced under RHEL8). (I copied them
from a running guest using scp) - rhel-guest-image-8.0-1854.s390x.qcow2.


Trying to run them results in the reported issue.

~/git/qemu/s390x-linux-user/qemu-s390x  -L . gzip
Segmentation fault (Speicherabzug geschrieben)

I can spot one main difference:

/lib64/libc-2.28.so: ELF 64-bit MSB shared object, IBM S/390, version 1
(GNU/Linux), dynamically linked, interpreter /lib/ld64.so.1,
BuildID[sha1]=3Df2ed86061df0bad28270244424e58eb95f60c00c, for GNU/Linux
3.2.0, not stripped, too many notes (256)

/lib64/ld-2.28.so: ELF 64-bit MSB shared object, IBM S/390, version 1
(SYSV), dynamically linked,
BuildID[sha1]=3D6a58fd6ea86ec36455655ff718509ee4320cefc2, not stripped,
too many notes (256)

The libraries are not completely stripped. But even when stripping, I
get the same issue when trying to load them.

The binaries/libraries work perfectly fine within qemu-system-s390x.

--=20

Thanks,

David / dhildenb

