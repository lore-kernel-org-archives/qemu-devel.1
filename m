Received: from eggs.gnu.org ([2001:4830:134:3::10]:57613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g0K88-0003DJ-GO
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 01:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1g0K85-0003aG-81
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 01:25:28 -0400
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-9-git-send-email-jjherne@linux.ibm.com>
	<7e74ef35-e925-30d9-b81d-33fa5a9ce468@redhat.com>
	<74536138-61d8-3003-c5cc-360e9ecc9d67@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ce0d3b85-91ab-81ed-2469-866d97b58a99@redhat.com>
Date: Thu, 13 Sep 2018 07:25:19 +0200
MIME-Version: 1.0
In-Reply-To: <74536138-61d8-3003-c5cc-360e9ecc9d67@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC 08/15] s390-bios: Map low core
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jjherne@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 2018-09-10 16:17, Jason J. Herne wrote:
> On 07/17/2018 02:10 PM, Thomas Huth wrote:
>> On 05.07.2018 19:25, Jason J. Herne wrote:
>>> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
>>>
>>> Create a new header for basic architecture specific definitions and
>>> add a
>>> mapping of low core memory. This mapping will be used by the real
>>> dasd boot
>>> process.
>>>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>> ---
>>> =C2=A0 pc-bios/s390-ccw/main.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 2 +
>>> =C2=A0 pc-bios/s390-ccw/s390-arch.h | 100
>>> +++++++++++++++++++++++++++++++++++++++++++
>>> =C2=A0 2 files changed, 102 insertions(+)
>>> =C2=A0 create mode 100644 pc-bios/s390-ccw/s390-arch.h
>>>
> ...
>=20
> ...
>>> +=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ccw2[2];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x010 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pad1[0x80 - 0x18];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x=
018 */
>>> +=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ext_params;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* 0x080 */
>>> +=C2=A0=C2=A0=C2=A0 uint16_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 cpu_addr;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x084 */
>>> +=C2=A0=C2=A0=C2=A0 uint16_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ext_int_code;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* 0x086 */
>>> +=C2=A0=C2=A0=C2=A0 uint16_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 svc_ilen;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x088 */
>>> +=C2=A0=C2=A0=C2=A0 uint16_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 svc_code;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x08a */
>>> +=C2=A0=C2=A0=C2=A0 uint16_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pgm_ilen;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x08c */
>>> +=C2=A0=C2=A0=C2=A0 uint16_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 pgm_code;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x08e */
>>> +=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 data_exc_code;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* 0x090 */
>>> +=C2=A0=C2=A0=C2=A0 uint16_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 mon_class_num;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* 0x094 */
>>> +=C2=A0=C2=A0=C2=A0 uint16_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 per_perc_atmid;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 0x096 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 per_address;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* 0x098 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 exc_access_id;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* 0x0a0 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 per_access_id;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* 0x0a1 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 op_access_id;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* 0x0a2 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ar_access_id;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* 0x0a3 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pad2[0xA8 - 0xA4];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x=
0a4 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 trans_exc_code;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 /* 0x0a8 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 monitor_code;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* 0x0b0 */
>>> +=C2=A0=C2=A0=C2=A0 uint16_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 subchannel_id;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* 0x0b8 */
>>> +=C2=A0=C2=A0=C2=A0 uint16_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 subchannel_nr;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* 0x0ba */
>>> +=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 io_int_parm;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* 0x0bc */
>>> +=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 io_int_word;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* 0x0c0 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pad3[0xc8 - 0xc4];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x=
0c4 */
>>> +=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 stfl_fac_list;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* 0x0c8 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pad4[0xe8 - 0xcc];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x=
0cc */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 mcic;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x0e8 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pad5[0xf4 - 0xf0];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x=
0f0 */
>>> +=C2=A0=C2=A0=C2=A0 uint32_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 external_damage_code;=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x0f4 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 failing_storage_address;=C2=A0 /* 0x0f8 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pad6[0x110 - 0x100];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x100 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 per_breaking_event_addr;=C2=A0 /* 0x110 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pad7[0x120 - 0x118];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x118 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 restart_old_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* 0x120 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 external_old_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* 0x130 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 svc_old_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x140 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 program_old_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* 0x150 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 mcck_old_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x160 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 io_old_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x170 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pad8[0x1a0 - 0x180];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x180 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 restart_new_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* 0x1a0 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 external_new_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 /* 0x1b0 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 svc_new_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x1c0 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 program_new_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* 0x1d0 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 mcck_new_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x1e0 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 io_new_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x1f0 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x200 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 irb[64];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x210 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 sync_enter_timer;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x2=
50 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 async_enter_timer;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x258 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 exit_timer;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* 0x260 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 last_update_timer;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x268 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 user_timer;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* 0x270 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 system_timer;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 /* 0x278 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 last_update_clock;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x280 */
>>> +=C2=A0=C2=A0=C2=A0 uint64_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 steal_clock;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 /* 0x288 */
>>> +=C2=A0=C2=A0=C2=A0 PSW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return_mcck_psw;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* 0x290 */
>>> +=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pad9[0xc00 - 0x2a0];=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* 0x2a0 */
>>
>> The names of the fields look exactly the same as in the Linux kernel .=
..
>> maybe credit them at least in the patch description?
>=20
> Due to some internal issues and bug hunting this has been on the back
> burner for a while. Getting back into it now...
>=20
> I took lowcore from Qemu code, not the kernel. target/s390x/internal.h.

Ok, fair, then never mind.

Just another thought: We've got a couple of structs and defines already
that we share between the s390-ccw bios and the "normal" QEMU code ...
maybe we should define a common set of headers that could be used by
both parts? And put these in includes/hw/s390x/ and let the s390-ccw
bios code include headers from that folder, too? Or would that be too
confusing and we better should keep everything separated (and duplicated)=
?

 Thomas
