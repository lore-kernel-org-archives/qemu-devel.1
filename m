Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5B5C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EBBF20820
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 11:32:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EBBF20820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCMaG-0007V9-6t
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 07:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iCMYE-0006ZS-22
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iCMYC-0000AY-6N
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 07:30:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39646)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1iCMYB-0000AR-VH; Mon, 23 Sep 2019 07:30:40 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E5EA3064FD2;
 Mon, 23 Sep 2019 11:30:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-117-142.ams2.redhat.com
 [10.36.117.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA36F5C1B2;
 Mon, 23 Sep 2019 11:30:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 75F80113864E; Mon, 23 Sep 2019 13:30:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Replace '-machine accel=xyz' with '-accel
 xyz'
References: <20190904052739.22123-1-thuth@redhat.com>
 <5e8d67e5-842f-7cea-28a5-f07050615c38@redhat.com>
Date: Mon, 23 Sep 2019 13:30:37 +0200
In-Reply-To: <5e8d67e5-842f-7cea-28a5-f07050615c38@redhat.com> (Paolo
 Bonzini's message of "Mon, 9 Sep 2019 19:06:26 +0200")
Message-ID: <87wodzp7vm.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 23 Sep 2019 11:30:39 +0000 (UTC)
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
Cc: qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 04/09/19 07:27, Thomas Huth wrote:
>> We've got a separate option to configure the accelerator nowadays, which
>> is shorter to type and the preferred way of specifying an accelerator.
>> Use it in the source and examples to show that it is the favored option.
>> (However, do not touch the places yet which also specify other machine
>> options or multiple accelerators - these are currently still better
>> handled with one single "-machine" statement instead)
>>=20
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>  python/qemu/qtest.py                | 2 +-
>>  qemu-deprecated.texi                | 3 +--
>>  qemu-options.hx                     | 2 +-
>>  tests/libqtest.c                    | 2 +-
>>  tests/migration/guestperf/engine.py | 2 +-
>>  tests/qemu-iotests/172              | 2 +-
>>  6 files changed, 6 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/python/qemu/qtest.py b/python/qemu/qtest.py
>> index eebcc233ed..3f1d2cb325 100644
>> --- a/python/qemu/qtest.py
>> +++ b/python/qemu/qtest.py
>> @@ -96,7 +96,7 @@ class QEMUQtestMachine(QEMUMachine):
>>      def _base_args(self):
>>          args =3D super(QEMUQtestMachine, self)._base_args()
>>          args.extend(['-qtest', 'unix:path=3D' + self._qtest_path,
>> -                     '-machine', 'accel=3Dqtest'])
>> +                     '-accel', 'qtest'])
>>          return args
>>=20=20
>>      def _pre_launch(self):
>> diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
>> index 00a4b6f350..0982e41698 100644
>> --- a/qemu-deprecated.texi
>> +++ b/qemu-deprecated.texi
>> @@ -26,8 +26,7 @@ The @option{enforce-config-section} parameter is repla=
ced by the
>>=20=20
>>  @subsection -no-kvm (since 1.3.0)
>>=20=20
>> -The ``-no-kvm'' argument is now a synonym for setting
>> -``-machine accel=3Dtcg''.
>> +The ``-no-kvm'' argument is now a synonym for setting ``-accel tcg''.
>>=20=20
>>  @subsection -usbdevice (since 2.10.0)
>>=20=20
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 09e6439646..e0bba2abd1 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -4156,7 +4156,7 @@ STEXI
>>  Enable FIPS 140-2 compliance mode.
>>  ETEXI
>>=20=20
>> -HXCOMM Deprecated by -machine accel=3Dtcg property
>> +HXCOMM Deprecated by -accel tcg
>>  DEF("no-kvm", 0, QEMU_OPTION_no_kvm, "", QEMU_ARCH_I386)
>>=20=20
>>  DEF("msg", HAS_ARG, QEMU_OPTION_msg,
>> diff --git a/tests/libqtest.c b/tests/libqtest.c
>> index 2713b86cf7..67e39c59e7 100644
>> --- a/tests/libqtest.c
>> +++ b/tests/libqtest.c
>> @@ -238,7 +238,7 @@ QTestState *qtest_init_without_qmp_handshake(const c=
har *extra_args)
>>                                "-qtest-log %s "
>>                                "-chardev socket,path=3D%s,id=3Dchar0 "
>>                                "-mon chardev=3Dchar0,mode=3Dcontrol "
>> -                              "-machine accel=3Dqtest "
>> +                              "-accel qtest "
>>                                "-display none "
>>                                "%s", qemu_binary, socket_path,
>>                                getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev=
/null",
>> diff --git a/tests/migration/guestperf/engine.py b/tests/migration/guest=
perf/engine.py
>> index f13dbea800..1dd04ce33b 100644
>> --- a/tests/migration/guestperf/engine.py
>> +++ b/tests/migration/guestperf/engine.py
>> @@ -287,7 +287,7 @@ class Engine(object):
>>              cmdline =3D "'" + cmdline + "'"
>>=20=20
>>          argv =3D [
>> -            "-machine", "accel=3Dkvm",
>> +            "-accel", "kvm",
>>              "-cpu", "host",
>>              "-kernel", self._kernel,
>>              "-initrd", self._initrd,
>> diff --git a/tests/qemu-iotests/172 b/tests/qemu-iotests/172
>> index ba7dad9057..d67997e5f6 100755
>> --- a/tests/qemu-iotests/172
>> +++ b/tests/qemu-iotests/172
>> @@ -55,7 +55,7 @@ do_run_qemu()
>>              done
>>          fi
>>          echo quit
>> -    ) | $QEMU -machine accel=3Dqtest -nographic -monitor stdio -serial =
none "$@"
>> +    ) | $QEMU -accel qtest -nographic -monitor stdio -serial none "$@"
>>      echo
>>  }
>>=20=20
>>=20
>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
>
> Thanks.  While "-accel kvm:tcg" is not going to be supported, the above
> replacement are all good.

-accel is yet another convenience option.  We have so many of them.  I
dislike the complexity they add to the CLI.  Here's how this one got in:

commit 8d4e9146b3568022ea5730d92841345d41275d66
Author: KONRAD Frederic <fred.konrad@greensocs.com>
Date:   Thu Feb 23 18:29:08 2017 +0000

    tcg: add options for enabling MTTCG
=20=20=20=20
    We know there will be cases where MTTCG won't work until additional work
    is done in the front/back ends to support. It will however be useful to
    be able to turn it on.
=20=20=20=20
    As a result MTTCG will default to off unless the combination is
    supported. However the user can turn it on for the sake of testing.
=20=20=20=20
    Signed-off-by: KONRAD Frederic <fred.konrad@greensocs.com>
    [AJB: move to -accel tcg,thread=3Dmulti|single, defaults]
    Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
    Reviewed-by: Richard Henderson <rth@twiddle.net>

Not a peep on why the existing options are so insufficient we must have
another one.

Our CLI will remain the steaming mess it has become until we reform the
habits that got us there.

No objection to your patch.

