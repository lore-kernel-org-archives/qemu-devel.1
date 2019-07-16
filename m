Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B63C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:10:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 069B52173B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069B52173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnP6X-0006Bp-Qr
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55475)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hnP6J-0005Xv-Al
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hnP6H-0002h1-RB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:10:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:58092)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hnP6H-0002gS-Kc
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:10:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hnP6G-0006DQ-Ho
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 15:10:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 797702E80C8
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 15:10:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jul 2019 15:02:52 -0000
From: =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: linux-user ppc
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ajbennee alex-bennee pmaydell scherft
X-Launchpad-Bug-Reporter: Daan Scherft (scherft)
X-Launchpad-Bug-Modifier: =?utf-8?q?Alex_Benn=C3=A9e_=28ajbennee=29?=
References: <156318593102.28533.3075291509963886255.malonedeb@chaenomeles.canonical.com>
 <20190716140133.8578-1-alex.bennee@linaro.org>
 <CAFEAcA8V2h3pqC_g5aaD2gsv08c18YZKRcxLM+hDNuMv_C55=Q@mail.gmail.com>
Message-Id: <87blxuuin7.fsf@zen.linaroharston>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: a043e5bc1a2efdad7515578246ea738bbda1ff4d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836558] Re: [RFC PATCH for 4.1] linux-user:
 unparent CPU object before unref
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
Reply-To: Bug 1836558 <1836558@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190716150252.z54rMT9OgBQABHYAWdfLiyn3QM0V0gD4cZf9byllEkU@z>

Peter Maydell <peter.maydell@linaro.org> writes:

> Ccing the QOM maintainers to make sure we have the
> QOM lifecycle operations right here...
>
> On Tue, 16 Jul 2019 at 15:02, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> When a CPU object is created it is parented during it's realize stage.
>> If we don't unparent before the "final" unref we will never finzalize
>> the object leading to a memory leak. For most setups you probably
>> won't notice but with anything that creates and destroys a lot of
>> threads this will add up. This goes especially for architectures which
>> allocate a lot of memory in their CPU structures.
>>
>> Fixes: https://bugs.launchpad.net/qemu/+bug/1836558
>> Cc: 1836558@bugs.launchpad.net
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  linux-user/syscall.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 39a37496fed..4c9313fd9d0 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -7183,6 +7183,7 @@ static abi_long do_syscall1(void *cpu_env, int num=
, abi_long arg1,
>>                            NULL, NULL, 0);
>>              }
>>              thread_cpu =3D NULL;
>> +            object_unparent(OBJECT(cpu));
>>              object_unref(OBJECT(cpu));
>>              g_free(ts);
>>              rcu_unregister_thread();
>
> I think (as I mentioned on IRC) that we also need to unrealize
> the CPU object, because target/ppc at least does some freeing
> of memory in its unrealize method. I think we do that by
> setting the QOM "realize" property back to "false" -- but that
> might barf if we try it on a CPU that isn't hotpluggable...

I have tried:

             thread_cpu =3D NULL;
+            object_unparent(OBJECT(cpu));
+            object_property_set_bool(OBJECT(cpu), false, "realized", NULL);
             object_unref(OBJECT(cpu));

but it didn't manifestly change anything (i.e. both with and without
setting realized the thread allocated stuff is freed). Valgrind still
complains about:

=3D=3D22483=3D=3D 6,656 bytes in 26 blocks are possibly lost in loss record=
 1,639 of 1,654
=3D=3D22483=3D=3D    at 0x483577F: malloc (vg_replace_malloc.c:299)
=3D=3D22483=3D=3D    by 0x4D7F8D0: g_malloc (in /usr/lib/x86_64-linux-gnu/l=
ibglib-2.0.so.0.5800.3)
=3D=3D22483=3D=3D    by 0x27D692: create_new_table (translate_init.inc.c:92=
52)
=3D=3D22483=3D=3D    by 0x27D7CD: register_ind_in_table (translate_init.inc=
.c:9291)
=3D=3D22483=3D=3D    by 0x27D975: register_dblind_insn (translate_init.inc.=
c:9337)
=3D=3D22483=3D=3D    by 0x27DBBB: register_insn (translate_init.inc.c:9384)
=3D=3D22483=3D=3D    by 0x27DE4E: create_ppc_opcodes (translate_init.inc.c:=
9449)
=3D=3D22483=3D=3D    by 0x27E79C: ppc_cpu_realize (translate_init.inc.c:981=
8)
=3D=3D22483=3D=3D    by 0x2C6FE8: device_set_realized (qdev.c:834)
=3D=3D22483=3D=3D    by 0x2D1E3D: property_set_bool (object.c:2076)
=3D=3D22483=3D=3D    by 0x2D00B3: object_property_set (object.c:1268)
=3D=3D22483=3D=3D    by 0x2D3185: object_property_set_qobject (qom-qobject.=
c:26)

But I don't know if that is just because the final exit_group of the
main CPU just exits without attempting to clean-up. However it is better
than it was.

--
Alex Benn=C3=A9e

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836558

Title:
  Qemu-ppc Memory leak creating threads

Status in QEMU:
  Confirmed

Bug description:
  When creating c++ threads (with c++ std::thread), the resulting binary
  has memory leaks when running with qemu-ppc.

  Eg the following c++ program, when compiled with gcc, consumes more
  and more memory while running at qemu-ppc. (does not have memory leaks
  when compiling for Intel, when running same binary on real powerpc CPU
  hardware also no memory leaks).

  (Note I used function getCurrentRSS to show available memory, see
  https://stackoverflow.com/questions/669438/how-to-get-memory-usage-at-
  runtime-using-c; calls commented out here)

  Compiler: powerpc-linux-gnu-g++ (Debian 8.3.0-2) 8.3.0 (but same problem =
with older g++ compilers even 4.9)
  Os: Debian 10.0 ( Buster) (but same problem seen on Debian 9/stetch)
  qemu: qemu-ppc version 3.1.50


  ---

  #include <iostream>
  #include <thread>
  #include <chrono>

  =

  using namespace std::chrono_literals;

  // Create/run and join a 100 threads.
  void Fun100()
  {
  //    auto b4 =3D getCurrentRSS();
  //    std::cout << getCurrentRSS() << std::endl;
      for(int n =3D 0; n < 100; n++)
      {
          std::thread t([]
          {
              std::this_thread::sleep_for( 10ms );
          });
  //        std::cout << n << ' ' << getCurrentRSS() << std::endl;
          t.join();
      }
      std::this_thread::sleep_for( 500ms ); // to give OS some time to wipe=
 memory...
  //    auto after =3D getCurrentRSS();
      std::cout << b4 << ' ' << after << std::endl;
  }

  =

  int main(int, char **)
  {
      Fun100();
      Fun100();  // memory used keeps increasing
  }

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836558/+subscriptions

