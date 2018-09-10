Received: from eggs.gnu.org ([2001:4830:134:3::10]:38751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fzN89-0003ww-5D
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:25:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fzN0H-00028f-6Y
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:17:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33730)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fzN0G-00026v-Tw
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 10:17:25 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w8AE8CZj100967
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 10:17:22 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2mdrgudujg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Sep 2018 10:17:22 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Mon, 10 Sep 2018 08:17:21 -0600
Reply-To: jjherne@linux.ibm.com
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
	<1530811543-6881-9-git-send-email-jjherne@linux.ibm.com>
	<7e74ef35-e925-30d9-b81d-33fa5a9ce468@redhat.com>
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Mon, 10 Sep 2018 10:17:13 -0400
MIME-Version: 1.0
In-Reply-To: <7e74ef35-e925-30d9-b81d-33fa5a9ce468@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <74536138-61d8-3003-c5cc-360e9ecc9d67@linux.ibm.com>
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

On 07/17/2018 02:10 PM, Thomas Huth wrote:
> On 05.07.2018 19:25, Jason J. Herne wrote:
>> From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
>>
>> Create a new header for basic architecture specific definitions and add a
>> mapping of low core memory. This mapping will be used by the real dasd boot
>> process.
>>
>> Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>> ---
>>   pc-bios/s390-ccw/main.c      |   2 +
>>   pc-bios/s390-ccw/s390-arch.h | 100 +++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 102 insertions(+)
>>   create mode 100644 pc-bios/s390-ccw/s390-arch.h
>>
...

...
>> +    uint32_t        ccw2[2];                  /* 0x010 */
>> +    uint8_t         pad1[0x80 - 0x18];        /* 0x018 */
>> +    uint32_t        ext_params;               /* 0x080 */
>> +    uint16_t        cpu_addr;                 /* 0x084 */
>> +    uint16_t        ext_int_code;             /* 0x086 */
>> +    uint16_t        svc_ilen;                 /* 0x088 */
>> +    uint16_t        svc_code;                 /* 0x08a */
>> +    uint16_t        pgm_ilen;                 /* 0x08c */
>> +    uint16_t        pgm_code;                 /* 0x08e */
>> +    uint32_t        data_exc_code;            /* 0x090 */
>> +    uint16_t        mon_class_num;            /* 0x094 */
>> +    uint16_t        per_perc_atmid;           /* 0x096 */
>> +    uint64_t        per_address;              /* 0x098 */
>> +    uint8_t         exc_access_id;            /* 0x0a0 */
>> +    uint8_t         per_access_id;            /* 0x0a1 */
>> +    uint8_t         op_access_id;             /* 0x0a2 */
>> +    uint8_t         ar_access_id;             /* 0x0a3 */
>> +    uint8_t         pad2[0xA8 - 0xA4];        /* 0x0a4 */
>> +    uint64_t        trans_exc_code;           /* 0x0a8 */
>> +    uint64_t        monitor_code;             /* 0x0b0 */
>> +    uint16_t        subchannel_id;            /* 0x0b8 */
>> +    uint16_t        subchannel_nr;            /* 0x0ba */
>> +    uint32_t        io_int_parm;              /* 0x0bc */
>> +    uint32_t        io_int_word;              /* 0x0c0 */
>> +    uint8_t         pad3[0xc8 - 0xc4];        /* 0x0c4 */
>> +    uint32_t        stfl_fac_list;            /* 0x0c8 */
>> +    uint8_t         pad4[0xe8 - 0xcc];        /* 0x0cc */
>> +    uint64_t        mcic;                     /* 0x0e8 */
>> +    uint8_t         pad5[0xf4 - 0xf0];        /* 0x0f0 */
>> +    uint32_t        external_damage_code;     /* 0x0f4 */
>> +    uint64_t        failing_storage_address;  /* 0x0f8 */
>> +    uint8_t         pad6[0x110 - 0x100];      /* 0x100 */
>> +    uint64_t        per_breaking_event_addr;  /* 0x110 */
>> +    uint8_t         pad7[0x120 - 0x118];      /* 0x118 */
>> +    PSW             restart_old_psw;          /* 0x120 */
>> +    PSW             external_old_psw;         /* 0x130 */
>> +    PSW             svc_old_psw;              /* 0x140 */
>> +    PSW             program_old_psw;          /* 0x150 */
>> +    PSW             mcck_old_psw;             /* 0x160 */
>> +    PSW             io_old_psw;               /* 0x170 */
>> +    uint8_t         pad8[0x1a0 - 0x180];      /* 0x180 */
>> +    PSW             restart_new_psw;          /* 0x1a0 */
>> +    PSW             external_new_psw;         /* 0x1b0 */
>> +    PSW             svc_new_psw;              /* 0x1c0 */
>> +    PSW             program_new_psw;          /* 0x1d0 */
>> +    PSW             mcck_new_psw;             /* 0x1e0 */
>> +    PSW             io_new_psw;               /* 0x1f0 */
>> +    PSW             return_psw;               /* 0x200 */
>> +    uint8_t         irb[64];                  /* 0x210 */
>> +    uint64_t        sync_enter_timer;         /* 0x250 */
>> +    uint64_t        async_enter_timer;        /* 0x258 */
>> +    uint64_t        exit_timer;               /* 0x260 */
>> +    uint64_t        last_update_timer;        /* 0x268 */
>> +    uint64_t        user_timer;               /* 0x270 */
>> +    uint64_t        system_timer;             /* 0x278 */
>> +    uint64_t        last_update_clock;        /* 0x280 */
>> +    uint64_t        steal_clock;              /* 0x288 */
>> +    PSW             return_mcck_psw;          /* 0x290 */
>> +    uint8_t         pad9[0xc00 - 0x2a0];      /* 0x2a0 */
> 
> The names of the fields look exactly the same as in the Linux kernel ...
> maybe credit them at least in the patch description?

Due to some internal issues and bug hunting this has been on the back 
burner for a while. Getting back into it now...

I took lowcore from Qemu code, not the kernel. target/s390x/internal.h.


-- 
-- Jason J. Herne (jjherne@linux.ibm.com)
