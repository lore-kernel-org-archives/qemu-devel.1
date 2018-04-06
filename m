Received: from eggs.gnu.org ([2001:4830:134:3::10]:45239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f4V9n-0006Na-O4
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f4V9j-0002MS-EM
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:28:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53554 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f4V9j-0002La-9t
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 13:28:07 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 448ED406E8A4
	for <qemu-devel@nongnu.org>; Fri,  6 Apr 2018 17:28:06 +0000 (UTC)
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<20180307151836.GK20201@redhat.com>
	<20180308075245.lgzredyhn2paawg4@sirius.home.kraxel.org>
	<20180308101728.GG4718@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f30635f1-5773-2046-1efd-fc37a0a49753@redhat.com>
Date: Fri, 6 Apr 2018 19:28:01 +0200
MIME-Version: 1.0
In-Reply-To: <20180308101728.GG4718@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, Eric Blake <eblake@redhat.com>

On 03/08/18 11:17, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Mar 08, 2018 at 08:52:45AM +0100, Gerd Hoffmann wrote:
>>   Hi,
>>
>>>> [*] Open question: Who, between QEMU and libvirt, should define the =
said
>>>> firmware metadata format and file?
>>>
>>> IMHO QEMU should be defining the format, because the file will contai=
n
>>> info about certain QEMU features associated with the firmware (eg smm=
).
>>> Also there are potentially other non-libvirt mgmt apps that spawn QEM=
U
>>> which would like this info (eg libguestfs), so having libvirt define =
the
>>> format is inappropriate.
>>>
>>> I'd suggest we just need something in docs/specs/firmware-metadata.rs=
t
>>> for QEMU source tree.
>>>
>>> Potentially QEMU could even use the metadata files itself for finding
>>> the default firmeware images, instead of compiling this info into its
>>> binaries. I wouldn't suggest we need todo that right away, but bear i=
t
>>> in mind as a potential use case.
>>
>> With qemu using this itself in mind it probably makes sense to specify
>> this as qapi schema.  That'll simplify parsing and using these files i=
n
>> qemu, and possibly simplifies things on the libvirt side too.
>=20
> I was thinking of an 'ini' style format, similar to that used by system=
d
> unit files, but a JSON format file is a nicer fit with QEMU & Libvirt i=
f
> we describe it with qapi.

I've created an RFC-level "qapi/firmware.json" schema file, based on
this discussion. It "builds", and the generated documentation looks
acceptable, superficially speaking.

Before I post "qapi/firmware.json" for getting comments, I'd like to
write JSON text that (a) describes firmware that I use, and (b) conforms
to the schema. IOW, I'd like to validate whether the schema is good
enough for describing at least such firmware that I know.

Is there a tool that generates example JSON objects from a given schema?
I vaguely recall there used to be one. Otherwise, writing the examples
manually looks arduous (and I wouldn't know how to verify them against
the schema).

Thanks!
Laszlo
