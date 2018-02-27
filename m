Received: from eggs.gnu.org ([2001:4830:134:3::10]:33504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqbTE-0000VD-Rp
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:22:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eqbTB-00054T-No
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 04:22:48 -0500
References: <1519641757-12396-1-git-send-email-thuth@redhat.com>
	<1519641757-12396-7-git-send-email-thuth@redhat.com>
	<20180226194857.01ce4a8c.cohuck@redhat.com>
	<b6664df2-eec4-7e35-1498-be27b5cc3e79@linux.vnet.ibm.com>
	<dcfd4bf5-fd36-52cc-8b66-87a68e80cc48@linux.vnet.ibm.com>
	<20180227101240.761cc93f.cohuck@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <06458ee3-030e-5635-1893-004adedf6151@redhat.com>
Date: Tue, 27 Feb 2018 10:22:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180227101240.761cc93f.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PULL-for-s390x 06/14] s390-ccw:
 parse and set boot menu options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, "Collin L. Walling" <walling@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On 27.02.2018 10:12, Cornelia Huck wrote:
> On Mon, 26 Feb 2018 14:44:45 -0500
> "Collin L. Walling" <walling@linux.vnet.ibm.com> wrote:
>=20
>> On 02/26/2018 02:29 PM, Collin L. Walling wrote:
>>> On 02/26/2018 01:48 PM, Cornelia Huck wrote: =20
>>>> On Mon, 26 Feb 2018 11:42:29 +0100
>>>> Thomas Huth <thuth@redhat.com> wrote:
[...]
>>>>> +=C2=A0=C2=A0=C2=A0 switch (ipl->iplb.pbt) {
>>>>> +=C2=A0=C2=A0=C2=A0 case S390_IPL_TYPE_CCW:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>>> +=C2=A0=C2=A0=C2=A0 default:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("boot menu=
 is not supported for this device=20
>>>>> type."); =20
>>>> If I specify both a bootindex for a device and a -kernel parameter, =
I
>>>> get this error message. Looks a tad odd, but not sure how to avoid i=
t. =20
>>>
>>> Hmm... perhaps an additional check if no IPLB, then skip trying to se=
t
>>> any boot menu data?
[...]
> How shall we proceed? I'd be willing to pull this now and then apply
> fixups on top, or we can have a respin. Thomas?

Since this is about a change in hw/s390x/ and not about
pc-bios/s390-ccw/ (i.e. no need to rebuild the firmware binaries for
this), I think I'd rather prefer a fix-up patch on top instead of a re-sp=
in.

 Thomas
