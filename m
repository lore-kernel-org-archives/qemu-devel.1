Received: from eggs.gnu.org ([209.51.188.92]:50796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghIg8-00013l-RT
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:34:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghIg7-0004MM-SG
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 13:34:12 -0500
Date: Wed, 9 Jan 2019 19:34:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190109193406.616fcf66.cohuck@redhat.com>
In-Reply-To: <729790ec-a74a-2e6e-89ed-3d450c95f54f@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
	<1544623878-11248-11-git-send-email-jjherne@linux.ibm.com>
	<20181213182100.6da37a95.cohuck@redhat.com>
	<bfde1bd3-0725-1085-8a98-eeaf2b0694ed@linux.ibm.com>
	<729790ec-a74a-2e6e-89ed-3d450c95f54f@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH 10/15] s390-bios: Support for
 running format-0/1 channel programs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Wed, 9 Jan 2019 13:10:26 -0500
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> On 1/7/19 2:02 PM, Jason J. Herne wrote:
> >>> +
> >>> =C2=A0=C2=A0/*
> >>> =C2=A0=C2=A0=C2=A0*=C2=A0sense-id=C2=A0response=C2=A0buffer=C2=A0layo=
ut
> >>> =C2=A0=C2=A0=C2=A0*/
> >>> @@=C2=A0-205,6=C2=A0+265,61=C2=A0@@=C2=A0typedef=C2=A0struct=C2=A0sen=
seid=C2=A0{
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct=C2=A0ciw=C2=A0ciw[62];
> >>> =C2=A0=C2=A0}=C2=A0=C2=A0__attribute__=C2=A0((packed,=C2=A0aligned(4)=
))=C2=A0SenseId;
> >>> +/*=C2=A0architected=C2=A0values=C2=A0for=C2=A0first=C2=A0sense=C2=A0=
byte=C2=A0*/
> >>> +#define=C2=A0SNS0_CMD_REJECT=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00x80
> >>> +#define=C2=A0SNS0_INTERVENTION_REQ=C2=A0=C2=A0=C2=A00x40
> >>> +#define=C2=A0SNS0_BUS_OUT_CHECK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=
x20
> >>> +#define=C2=A0SNS0_EQUIPMENT_CHECK=C2=A0=C2=A0=C2=A0=C2=A00x10
> >>> +#define=C2=A0SNS0_DATA_CHECK=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A00x08
> >>> +#define=C2=A0SNS0_OVERRUN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x04
> >>> +#define=C2=A0SNS0_INCOMPL_DOMAIN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x01 =
=20
> >>
> >> IIRC,=C2=A0only=C2=A0byte=C2=A00=C2=A0is=C2=A0device=C2=A0independent,=
=C2=A0and=C2=A0the=C2=A0others=C2=A0below=C2=A0are
> >> (ECKD)=C2=A0dasd=C2=A0specific?
> >> =20
> >>> +
> >>> +/*=C2=A0architectured=C2=A0values=C2=A0for=C2=A0second=C2=A0sense=C2=
=A0byte=C2=A0*/
> >>> +#define=C2=A0SNS1_PERM_ERR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A00x80
> >>> +#define=C2=A0SNS1_INV_TRACK_FORMAT=C2=A0=C2=A0=C2=A00x40
> >>> +#define=C2=A0SNS1_EOC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x20
> >>> +#define=C2=A0SNS1_MESSAGE_TO_OPER=C2=A0=C2=A0=C2=A0=C2=A00x10
> >>> +#define=C2=A0SNS1_NO_REC_FOUND=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A00x08
> >>> +#define=C2=A0SNS1_FILE_PROTECTED=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x04
> >>> +#define=C2=A0SNS1_WRITE_INHIBITED=C2=A0=C2=A0=C2=A0=C2=A00x02
> >>> +#define=C2=A0SNS1_INPRECISE_END=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=
x01
> >>> +
> >>> +/*=C2=A0architectured=C2=A0values=C2=A0for=C2=A0third=C2=A0sense=C2=
=A0byte=C2=A0*/
> >>> +#define=C2=A0SNS2_REQ_INH_WRITE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=
x80
> >>> +#define=C2=A0SNS2_CORRECTABLE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00x40
> >>> +#define=C2=A0SNS2_FIRST_LOG_ERR=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=
x20
> >>> +#define=C2=A0SNS2_ENV_DATA_PRESENT=C2=A0=C2=A0=C2=A00x10
> >>> +#define=C2=A0SNS2_INPRECISE_END=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00=
x04
> >>> +
> >>> +/*=C2=A024-byte=C2=A0Sense=C2=A0fmt/msg=C2=A0codes=C2=A0*/
> >>> +#define=C2=A0SENSE24_FMT_PROG_SYS=C2=A0=C2=A0=C2=A0=C2=A00x0
> >>> +#define=C2=A0SENSE24_FMT_EQUIPMENT=C2=A0=C2=A0=C2=A00x2
> >>> +#define=C2=A0SENSE24_FMT_CONTROLLER=C2=A0=C2=A00x3
> >>> +#define=C2=A0SENSE24_FMT_MISC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A00xF
> >>> +
> >>> +#define=C2=A0SENSE24_FMT0_MSG_RESET_NOTIFICATION=C2=A00x16
> >>> +
> >>> +/*=C2=A0basic=C2=A0sense=C2=A0response=C2=A0buffer=C2=A0layout=C2=A0=
*/
> >>> +typedef=C2=A0struct=C2=A0senseData=C2=A0{
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t=C2=A0status[3];
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t=C2=A0res_count;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t=C2=A0phys_drive_id;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t=C2=A0low_cyl_addr;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t=C2=A0head_high_cyl_addr;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t=C2=A0fmt_msg;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint64_t=C2=A0fmt_dependent_info[2];
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t=C2=A0reserved;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t=C2=A0program_action_code;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint16_t=C2=A0config_info;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t=C2=A0mcode_hicyl;
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0uint8_t=C2=A0cyl_head_addr[3];
> >>> +}=C2=A0=C2=A0__attribute__=C2=A0((packed,=C2=A0aligned(4)))=C2=A0Sen=
seData; =20
> >>
> >> And=C2=A0this=C2=A0looks _really_=C2=A0dasd=C2=A0specific.
> >> =20
> >=20
> > Yep, I glossed over those details while I was furiously tracking down t=
he reset bug. I'll=20
> > take=C2=A0a=C2=A0look=C2=A0at=C2=A0redesigning=C2=A0this. =20
>=20
> All of my information for creating these data structures came from an int=
ernal ECKD DASD=20
> reference. There are probably some things that could stand a bit of clean=
up or renaming.=20
> Aside from that, considering this is in a DASD only (ECKD DASD only at th=
e moment) code=20
> path are you okay with my renaming the struct to senseDataECKD or somethi=
ng similar?

Renaming this makes sense.

> I'm not sure what value there is in abstracting sense at the moment. I'm =
not even sure=20
> what other device's sense data looks like. Since my description of the SE=
NSE CCW comes=20
> from an ECKD reference I have not been able to verify any areas of the da=
ta that are=20
> common across device types. Thoughts?

There's SA22-7204-01 ("Common I/O Device Commands"), which is from 1992
(this is what I have on my disk -- is there anything newer?). It
specifies what bits 0-5 of byte 0 mean and states that bytes 1-31 are
optional and device-specific.

Maybe some other bits have been specified after 1992, but I have not
come across documentation for them.
