Received: from eggs.gnu.org ([2001:4830:134:3::10]:38878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBjSM-0002vI-Re
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fBjSI-0002ZN-Kq
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:09:14 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:53792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fBjSI-0002YZ-CB
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 12:09:10 -0400
Received: by mail-wm0-x22f.google.com with SMTP id 66so13859823wmd.3
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 09:09:10 -0700 (PDT)
References: <20180425153343.24023-1-alex.bennee@linaro.org>
	<cb41b3a5-0e3b-f30b-a02c-1cc333d38ab1@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <cb41b3a5-0e3b-f30b-a02c-1cc333d38ab1@redhat.com>
Date: Thu, 26 Apr 2018 17:09:07 +0100
Message-ID: <87604ekl0c.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] hw/core: expand description of
 null-machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, peter.maydell@linaro.org, Eduardo Habkost <ehabkost@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> On 25.04.2018 17:33, Alex Benn=C3=A9e wrote:
>> People following old instructions for QEMU get the message "No machine
>> specified, and there is no default" and run -machine help to pick a
>> new machine. Lay people might consider the null-machine to be such a
>> basic starting point but they won't get far. This leads to confusion,
>> see https://bugs.launchpad.net/qemu/+bug/1766896 as an example.
>>
>> I'm open to better words - I figured "THIS PROBABLY ISN'T WHAT YOU
>> WANT" seemed less helpful though.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  hw/core/null-machine.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
>> index cde4d3eb57..72f0815045 100644
>> --- a/hw/core/null-machine.c
>> +++ b/hw/core/null-machine.c
>> @@ -50,7 +50,7 @@ static void machine_none_init(MachineState *mch)
>>
>>  static void machine_none_machine_init(MachineClass *mc)
>>  {
>> -    mc->desc =3D "empty machine";
>> +    mc->desc =3D "empty machine (for probing/QMP)";
>
> Actually, with certain CPUs, you can really use the "none" machine as a
> pure instruction set testing system. For example, on m68k, there used to
> be an explicit "dummy" machine for this job, and we removed it in favour
> of the "none" machine:
>
> https://git.qemu.org/?p=3Dqemu.git;a=3Dcommitdiff;h=3D22f2dbe7eaf3e12e38c=
9c210

Ahh OK. Do you know what other CPUs can be used in this way?

> So I'd rather not add such wording. We should rather fix those segfaults
> instead (QEMU should never segfault - in case a device can not be used
> with the "none" machine, there rather should be an error message instead).

Hmm the ARM world is complicated by peripherals that are on-chip but not
part of the "CPU". I wonder if this is a edge case for our modelling?
Should for example -cpu cortex-m3 imply additional peripherals and how
do we handle that in the -m none case?

--
Alex Benn=C3=A9e
