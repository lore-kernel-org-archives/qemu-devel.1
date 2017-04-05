Received: from eggs.gnu.org ([2001:4830:134:3::10]:47790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cvonP-00026q-CU
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cvonK-0002qB-Fz
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:32:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1cvonK-0002oP-7C
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 13:32:34 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v35HJ27W100492
	for <qemu-devel@nongnu.org>; Wed, 5 Apr 2017 13:32:31 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29n30rpse7-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 13:32:31 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Wed, 5 Apr 2017 11:32:30 -0600
Received: from b03ledav001.gho.boulder.ibm.com
	(b03ledav001.gho.boulder.ibm.com [9.17.130.232])
	by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
	ESMTP id v35HWOEJ13959650
	for <qemu-devel@nongnu.org>; Wed, 5 Apr 2017 10:32:28 -0700
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1A296E045
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 11:32:28 -0600 (MDT)
Received: from sbct-3.watson.ibm.com (unknown [9.2.141.158])
	by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP id AF83F6E048
	for <qemu-devel@nongnu.org>; Wed,  5 Apr 2017 11:32:28 -0600 (MDT)
References: <1490965817-16913-1-git-send-email-amarnath.valluri@intel.com>
	<20170403170738.GC2768@redhat.com>
	<6a70868f-8831-54ce-5c67-c325acf03fec@intel.com>
	<b894f5b7-64ad-7696-b3fe-82941e2d6c5b@linux.vnet.ibm.com>
	<CAJ+F1C+XKOWyqse2L+4sYPOOnSfqX89+tVGtHhOqwc-GP0eZKQ@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Wed, 5 Apr 2017 13:32:27 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+XKOWyqse2L+4sYPOOnSfqX89+tVGtHhOqwc-GP0eZKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <090205a2-2246-5fd1-2d60-d78848eb8af5@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/7] Provide support for the software TPM
 emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 04/05/2017 11:08 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Wed, Apr 5, 2017 at 5:04 PM Stefan Berger <stefanb@linux.vnet.ibm.co=
m>
> wrote:
>
>> On 04/05/2017 03:09 AM, Amarnath Valluri wrote:
>>>
>>> On 03.04.2017 20 <03%2004%2020%2017%2020>:07, Daniel P. Berrange wrot=
e:
>>>> On Fri, Mar 31, 2017 at 04:10:09PM +0300, Amarnath Valluri wrote:
>>>>> Briefly, Theses set of patches introduces:
>>>>>    - new TPM backend driver to support software TPM emulators(swtpm=
(1)).
>>>>>    - and few supported fixes/enhancements/cleanup to existing tpm
>>>>> backend code.
>>>>>
>>>>> The similar idea was initiated earliar(2) by Stefan Berger(CCed)
>>>>> with slightly
>>>>> different approach, using CUSE. As swtpm has excellent support for
>>>>> unix domain
>>>>> sockets, hence this implementation uses unix domain sockets to
>>>>> communicate with
>>>>> swtpm.
>>>>>
>>>>> When Qemu is configured with 'emulator' tpm backend, it spawns
>>>>> 'swtpm' and
>>>>> communicates its via Unix domain sockets.
>>>> I'm not convinced that having QEMU spawning swtpm itself is a desira=
ble
>>>> approach, as it means QEMU needs to have all the privileges that swt=
pm
>>>> will need, so that swtpm can inherit them. At the very least I think=
 we
>>>> need to have a way to disable this spawning, so it can connect to a
>>>> pre-existing swtpm process that's been spawned ahead of time. This w=
ill
>>>> let us have stricter privilege separation.
>>> Both spawning inside qemu and connecting to already running swtpm has
>>> its own pros, Hence we can make this spawning as backend configuratio=
n
>>> detail, So it looks like this:
>>>
>>> -tpmdev
>>>
>> emulator,id=3Did,tpmstatedir=3Ddir[,spawn=3D[on|off],data-path=3Dpath,=
ctrl-path=3Dpath,logfile=3Dpath,loglevel=3Dnumber]
>>>    Options details:
>>>       tpmstatedir - Directory path, which swtpm should  use for
>>> storing  TPM state
>>>       *spawn      - should spawn new process, defaults to 'off'
>>>       *path         - swtpm binary path to spawn, ignored if spawn is=
 off
>>>       *data-path - Socket path to use/connect for data messages
>>>       *ctrl-path   - Socket path to use/connect for out-of-band contr=
ol
>>> messages
>> FD passing would work?
>>
> Could with /dev/fdset in theory, but it would be better to use chardevs
> instead.
>
> Is there any reason left to have 2 sockets? Couldn't the data be sent a=
s
> another message on the "ctrl-path" ?

Better to keep them separate so whatever comes out of a VM will never be=20
mistaken for a control command.

>
>
>>>       *logfile       - File path to use for swtpm logs
>>>       *loglevel    - log level number, defaults to 5 (ignored if no
>>> logfile provided)
>>>
>>> -  If spawn is off, data-path and ctrl-path must be provided to qemu,
>>> where to connect already running swtpm
>>> -  If spawn if on, both data-path and ctrl-path are optional. If not
>>> provided, qemu uses socket pairs to communicates with swptm, as it is
>>> doing now.
>>>
>>> Hope this satisfies all usecases, if everyone here happy with this i
>>> can submit the new patch with these changes.
>>>
>>> - Amarnath
>>>
>>
>> --
> Marc-Andr=C3=A9 Lureau
>
