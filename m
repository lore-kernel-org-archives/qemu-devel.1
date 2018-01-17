Received: from eggs.gnu.org ([2001:4830:134:3::10]:41110)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebgx7-0002ZA-Nv
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:12:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ebgx4-00076D-J6
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 01:12:01 -0500
References: <1516034665-27606-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516034665-27606-5-git-send-email-walling@linux.vnet.ibm.com>
	<6e4c6445-0b78-1709-b724-e35daeefb1c1@redhat.com>
	<e92dd0a3-422a-57a5-f0a4-c9fbb620a1c4@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <79634fce-eebe-4377-ef62-df8ef53b22d9@redhat.com>
Date: Wed, 17 Jan 2018 07:11:51 +0100
MIME-Version: 1.0
In-Reply-To: <e92dd0a3-422a-57a5-f0a4-c9fbb620a1c4@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v3 4/8] s390-ccw: interactive
 boot menu for eckd dasd (menu setup)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: alifm@linux.vnet.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, frankja@linux.vnet.ibm.com

On 16.01.2018 20:37, Collin L. Walling wrote:
> On 01/16/2018 01:23 PM, Thomas Huth wrote:
>> On 15.01.2018 17:44, Collin L. Walling wrote:
>>> Reads boot menu flag and timeout values from the iplb and
>>> sets the respective fields for the menu.
>>>
>>> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
>>> ---
>> [...]
>>> diff --git a/pc-bios/s390-ccw/iplb.h b/pc-bios/s390-ccw/iplb.h
>>> index fe909d2..da29e6e 100644
>>> --- a/pc-bios/s390-ccw/iplb.h
>>> +++ b/pc-bios/s390-ccw/iplb.h
>>> @@ -81,6 +81,9 @@ extern IplParameterBlock iplb
>>> __attribute__((__aligned__(PAGE_SIZE)));
>>> =C2=A0 #define S390_IPL_TYPE_CCW 0x02
>>> =C2=A0 #define S390_IPL_TYPE_QEMU_SCSI 0xff
>>> =C2=A0 +#define LOADPARM_PROMPT "PROMPT=C2=A0 "
>>> +#define LOADPARM_EMPTY=C2=A0 "........"
>> I've got a question: Is there a (public) specification document
>> available somewhere for the loadparm field?
>=20
> Unfortunately there does not seems to be any kind of documentation
> regarding loadparm for
> KVM on IBM z.=C2=A0 Most of the information available on the IBM Knowle=
dge
> Center focuses on
> z/VM, which isn't very helpful in this case :(

Ok, too bad :-(

> Are there any specific questions that I can help with?

I was just wondering whether there are pre-defined values for this
field, e.g. is "PROMPT" something you came up with, or is this a value
that has been documented in a specification somewhere? ... I'm just
curious: If there is a list of pre-defined values somewhere, what are
the other values that the s390-ccw bios does not support yet?

 Thomas
