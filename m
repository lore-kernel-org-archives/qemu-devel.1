Received: from eggs.gnu.org ([2001:4830:134:3::10]:37510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpz9X-00023p-9c
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dpz9S-0000xP-JH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:55:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dpz9S-0000xD-D3
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 11:55:34 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1503602048-12268-1-git-send-email-armbru@redhat.com>
	<1503602048-12268-12-git-send-email-armbru@redhat.com>
	<CAJ+F1C+JyRBxc-cv0ko1zqNnNt6N0h5OhrLM2GdVT3yLocgNKw@mail.gmail.com>
	<87inh82anm.fsf@dusky.pond.sub.org>
	<898fa7aa-6923-04ab-637e-4232a6f4c9f4@linux.vnet.ibm.com>
Date: Thu, 07 Sep 2017 17:55:31 +0200
In-Reply-To: <898fa7aa-6923-04ab-637e-4232a6f4c9f4@linux.vnet.ibm.com> (Stefan
	Berger's message of "Thu, 7 Sep 2017 11:05:05 -0400")
Message-ID: <87o9qm1p1o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 11/16] qapi-schema: Collect TPM stuff in
 qapi/tpm.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org

Stefan Berger <stefanb@linux.vnet.ibm.com> writes:

> On 08/28/2017 07:29 AM, Markus Armbruster wrote:
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>>> On Thu, Aug 24, 2017 at 9:23 PM Markus Armbruster <armbru@redhat.com> w=
rote:
>>>
>>>> Sadly, we don't have a TPM maintainer, not even a MAINTAINERS entry.
>>>> Create one, and mark it orphaned.
>>>>
>>>>
>>> This is also proposed in:
>>> http://patchew.org/QEMU/20170728053610.15770-1-f4bug@amsat.org/
>> Forgot about that one.
>>
>> My patch additionally has "F: include/hw/acpi/tpm.h", and of course the
>> new "qapi/tpm.json", and it's not marked "RFC".
>>
>>> Stefan Berger, any chance you declare yourself a TPM maintainer?
>> Please?
>
> Ok, I'll do it.

Awesome!

Please send a patch adding M: and updating S: in the TPM stanza in
MAINTAINERS:

    TPM
    S: Orphan
    F: tpm.c
    F: hw/tpm/*
    F: include/hw/acpi/tpm.h
    F: include/sysemu/tpm*
    F: qapi/tpm.json
