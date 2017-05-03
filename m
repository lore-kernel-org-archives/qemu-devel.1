Received: from eggs.gnu.org ([2001:4830:134:3::10]:42261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d5vUP-0000JP-Hx
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:42:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1d5vUM-0004UV-Eq
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:42:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49336)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1d5vUM-0004Ti-5Y
	for qemu-devel@nongnu.org; Wed, 03 May 2017 10:42:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v43Eds0U033728
	for <qemu-devel@nongnu.org>; Wed, 3 May 2017 10:42:44 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a7g25kta4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 10:42:44 -0400
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 3 May 2017 08:42:43 -0600
References: <CAJ+F1C+gLTVpZZeKtxuLFUgs6nJ0KbgnJp4VdAuuM4JK2RbYMA@mail.gmail.com>
	<38a2aa2e-6270-63af-3dec-bd666d56780d@linux.vnet.ibm.com>
	<CAJ+F1CKcZvWE4OQOMKuDqNvKGEQK3DdihM6Eyx-piqtQtSbXGQ@mail.gmail.com>
	<5ee48b85-0404-a810-95b5-4b19b197373e@linux.vnet.ibm.com>
	<1493749518.4241.225.camel@intel.com>
	<CAJ+F1CK4jN2Nb6eKB1x9Km0xnurs976=Kb0idFpPgtH+JHYTcQ@mail.gmail.com>
	<b6e0d6d2-d276-c66d-ae5e-c6502cbe0b5c@linux.vnet.ibm.com>
	<20170503084136.GC4121@redhat.com> <20170503111659.GA2077@work-vm>
	<CAJ+F1CJ2JnLS2BbMWES0HQ3-iJUzXrrj21RVPo70d04xpWbgDQ@mail.gmail.com>
	<20170503112948.GA3985@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 3 May 2017 10:42:38 -0400
MIME-Version: 1.0
In-Reply-To: <20170503112948.GA3985@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <14dc8420-0a21-b92e-4e50-a92676d35b96@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Amarnath Valluri <amarnath.valluri@intel.com>, Patrick Ohly <patrick.ohly@intel.com>, qemu-devel@nongnu.org

On 05/03/2017 07:29 AM, Daniel P. Berrange wrote:
> On Wed, May 03, 2017 at 11:24:42AM +0000, Marc-Andr=C3=A9 Lureau wrote:
>> Hi
>>
>> On Wed, May 3, 2017 at 3:17 PM Dr. David Alan Gilbert <dgilbert@redhat=
.com>
>> wrote:
>>
>>> * Daniel P. Berrange (berrange@redhat.com) wrote:
>>>> On Tue, May 02, 2017 at 03:35:48PM -0400, Stefan Berger wrote:
>>>>> On 05/02/2017 02:50 PM, Marc-Andr=C3=A9 Lureau wrote:
>>>>>> Hi
>>>>>>
>>>>>> On Tue, May 2, 2017 at 10:25 PM Patrick Ohly <patrick.ohly@intel.c=
om
>>>>>> <mailto:patrick.ohly@intel.com>> wrote:
>>>>>>
>>>>>>      On Tue, 2017-05-02 at 13:19 -0400, Stefan Berger wrote:
>>>>>>      > On 05/02/2017 01:09 PM, Marc-Andr=C3=A9 Lureau wrote:
>>>>>>      > > On Tue, May 2, 2017 at 8:59 PM Stefan Berger
>>>>>>      <stefanb@linux.vnet.ibm.com <mailto:stefanb@linux.vnet.ibm.co=
m>>
>>>>>>      > > wrote:
>>>>>>      > >
>>>>>>      > >> And who is going to implement that qemu-swtpm? Obviously
>>> this
>>>>>>      discussion
>>>>>>      > >> doesn't contribute to progress if nobody is doing that i=
n
>>> the
>>>>>>      end.
>>>>>>      > >>
>>>>>>      > > The same persons who try to push for that emulated TPM co=
de.
>>>>>>      The easiest
>>>>>>      > > approach would be to copy/adapt the swtpm code in qemu, i=
f
>>> the
>>>>>>      licence is
>>>>>>      > > compatible. I can help with that if there is a consensus =
it's
>>>>>>      a better
>>>>>>      > > approach.
>>>>>>      >
>>>>>>      >
>>>>>>      > It's a matter of time and at least I don't have time for th=
at.
>>>>>>
>>>>>>      Neither do I, and nor (I believe) does Amarnath. The approach
>>> with
>>>>>>      using
>>>>>>      the existing swtpm project seemed attractive to us exactly
>>> because it
>>>>>>      avoids having to write and maintain more than just the glue c=
ode
>>>>>>      between
>>>>>>      the two projects.
>>>>>>
>>>>>>
>>>>>> The main argument is not about having more or less code in qemu to
>>>>>> maintain, but yes this is a concern (although giving up that
>>> maintenance
>>>>>> to a seperate project with mostly Stefan-alone isn't a much better
>>>>>> alternative). btw, is the project actually used by something else
>>> than
>>>>>> qemu? (I am not talking about developpers/testing). If not, then i=
t
>>>>>> makes sense to make it part of qemu.
>>>>> The intention would be to use it for RunC as well (plus higher laye=
rs
>>>>> afterwards): https://github.com/opencontainers/runc/pull/1082
>>>>>
>>>>>> But it's mostly a technical reason, to avoid having to rely on a
>>> foreign
>>>>>> protocol and project with all the compatibility constrains.
>>>>> I understand. Ideally swtpm-0.1 would be equivalent to 1.0 with all
>>> features
>>>>> available and no further protocol extensions necessary. In practice
>>> that may
>>>>> look different.
>>>>>
>>>>>> In the end, we may decide to start with a separate project, and
>>> change
>>>>>> it in the future if it's problematic (that would break some cases,
>>> such
>>>>>> as being able to freely switch the helper). Tbh, I am not so happy
>>> with
>>>>>> the code quality of swtpm, and I haven't looked closely at libtpms.
>>>>>> Having a qemu-swtpm as part of qemu would probably help improve it
>>> too,
>>>>>> and bring a few more developers for maintainance...
>>>>> libtpms combines a few source codes with some glue around it. The
>>> coding
>>>>> style is different for TPM 1.2 and TPM 2 code for example and the c=
ode
>>> bases
>>>>> are in the 10s of thousands of line. In the case of TPM 2 it 'lives
>>> from'
>>>>> TCG code drops and thus there is no reformatting of source code etc.
>>>>>
>>>>> If someone wants to get started on qemu-swtpm that's certainly cool
>>> but over
>>>>> the years it's just been quite difficult to find developers for it =
to
>>> share
>>>>> the burden. All that said, someone should state whether this series=
 is
>>> a go
>>>>> or no-go because of the external project it requires.
>>>> I think it is *good* that it uses the external swtpm project and do =
not
>>>> want to see it reimplemented inside QEMU, particularly with the inte=
rest
>>>> for swtpm to be used in container contexts via RunC. Such common
>>> infrastructure
>>>> for both containers & QEMU will be important given the increasing
>>> convergance
>>>> of technology across containers & VMs.
>>> I agree; there aren't that many people who understand the details of =
TPMs,
>>> reimplementing one in QEMU isn't something you'd want to do.
>>>
>> It's not about reimplementing TPM emulation. swtpm is a small utility
>> talking to libtpms doing the heavy work. swtpm could quite easily be
>> copied/adapted to fit in qemu if it's only meant to be used by qemu.
>> However, it seems the helper is going to be used by other projects, so=
 it
>> make sense to make it a seperate project. Nevertheless, I think we sho=
uld
>> carefully review the protocol and the compatibility situation before
>> committing this work, it's a major burden ahead..
> Yes, I agree that reviewing the protocol is a very neccessary step, to
> ensure it is going to be forwards compatible in a manner suitable for
> QEMU.
>
> In particular we need to understand what, if any, relationship there
> needs to be wrt machine types & live migration stability. eg if a
> VM is booted and the protocol negotiates version X, and we then live
> migrate to a host with a newer swtpm, we need to ensure that the
> protocol doesn't negotiate something that leads to guest OS incompatibl=
ity
> problems in accessing the TPM.
>
> basically similar scenario to that which we have had with vhost-user
> and version compatibility with external vhost-user server implementatio=
ns
> across live migration.

Ok, please have a look at the protocol.

As for the state of the TPM implementations:
  - the TPM 1.2 part is stable and besides openssl changes in the future=20
I would not expect any more changes to the core code. That means that=20
the state blobs the code is writing out and we are migrating are=20
'stable'. They are written in big endian format just like any other QEMU=20
device and thus are migratable between endianess.
  - the TPM 2 part , as stated before, is still somewhat in flux. I am=20
not sure when there will be a final TPM 2 from TCG. There the=20
possibility exists that the state blobs the TPM 2 is writing out still=20
change. I have added a version tag in front of the blobs so in case=20
something else gets added that that can be accommodated. Besides that=20
it's also adapted to write the state blobs in big endian format for the=20
same reason as above. Maybe at some point I'll just freeze the code and=20
don't follow the ongoing TPM 2 development anymore besides bug fixes to=20
exsting code, which then freezes the state blobs as well.

The issue on the swtpm and QEMU side then is the protocols to transfer 3=20
opaque (possibly encrypted) swtpm state blobs when suspending/resuming=20
or migrating the swtpm. I currently have 1 command to pull them out by=20
their 3 identifies (so run that command 3 times) and 1 commands to put=20
them back in by their identifier. When is comes to migration, this is=20
probably one of the most critical parts to look at.

    Stefan

>
> Regards,
> Daniel
