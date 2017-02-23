Received: from eggs.gnu.org ([2001:4830:134:3::10]:54014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1cgwyI-0000g7-3a
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 12:14:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xyjxie@linux.vnet.ibm.com>) id 1cgwyD-0000oY-1f
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 12:14:26 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43283
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xyjxie@linux.vnet.ibm.com>)
	id 1cgwyC-0000oH-S7
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 12:14:20 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1NHBkL7152777
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 12:14:19 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28t1a1rcxw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 12:14:19 -0500
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <xyjxie@linux.vnet.ibm.com>;
	Thu, 23 Feb 2017 10:14:18 -0700
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
	<fdcb2b07-aae8-69bf-ee94-a43777009c3a@redhat.com>
	<CAFEAcA--bSo7PJH0Px9ytQspaYuS55CSsM_EN6zt0djhkqKNPw@mail.gmail.com>
	<5a0773de-6bc7-474a-82ab-2edd37ce8a93@redhat.com>
	<CAFEAcA99xi4k57h2XGw2deGO24E95AS5jyGL+4GzjqNgMb9wcg@mail.gmail.com>
	<92580ca9-47fe-a943-7720-d3cb1fc6d2eb@redhat.com>
	<CAFEAcA8769a_8xwk57FS6Ko+Lioud20+70JRSafeEic6GB_RAw@mail.gmail.com>
	<3d5e7b5e-4501-86b7-093d-47fb09af585e@redhat.com>
	<CAFEAcA9gcArSqhbRi6-YdR=5eE9dtq66C7N0qTbCuBiY_Zr+tA@mail.gmail.com>
	<41630a89-e645-7d7e-b7c2-356fd6dcadee@redhat.com>
	<CAFEAcA_Mh9ZrJeu4f==ko1k2yLkfPe2AwNbUHcxkmS6Lzuvk0Q@mail.gmail.com>
	<2565ef99-9c16-e836-08c6-0915f5d4b0f8@redhat.com>
	<CAFEAcA_BgiXrjW9aRNFkXEEjS+kjibJ_UisJtiLgrPh=0re5qA@mail.gmail.com>
	<c76578aa-ec76-f904-b0fc-72676e4ce515@redhat.com>
	<CAFEAcA_waGB88XyzGxFbE_OyLAPnY70aEVQYzbS0k3KR+FF9DA@mail.gmail.com>
	<dac5dcb6-7beb-1c33-0a4e-b7977fce69b6@redhat.com>
From: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Date: Fri, 24 Feb 2017 01:14:09 +0800
MIME-Version: 1.0
In-Reply-To: <dac5dcb6-7beb-1c33-0a4e-b7977fce69b6@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Message-Id: <df4e14ad-acd9-151e-f4a1-9cab24063b83@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, zhong@linux.vnet.ibm.com, David Gibson <david@gibson.dropbear.id.au>, Paul Mackerras <paulus@samba.org>

on 2017/2/24 0:15, Paolo Bonzini wrote:

>
> On 23/02/2017 17:08, Peter Maydell wrote:
>> On 23 February 2017 at 15:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>> However, DEVICE_NATIVE_ENDIAN would have to be paired with tswap, which
>>> the current code does not do, hence the bug.  To have no swap at all,
>>> you'd need DEVICE_HOST_ENDIAN.
>> Yes, I agree that the current ramdevice code has this bug (and
>> that we can fix it by any of the various options).
> Good. :)
>
>>>> AIUI what we want for this VFIO case is "when the guest does
>>>> a 32-bit write of 0x12345678 then the bytes are 0x12 0x34 0x56 0x78
>>>> regardless of whether TARGET_BIG_ENDIAN or not".
>>> No, I don't think so.  This is not specific to VFIO.  You can do it with
>>> any device, albeit VFIO is currently the only one using ramd regions.
>> The commit message in the patch that started this thread off
>> says specifically that "VFIO PCI device is little endian".
>> Is that wrong?
> Yes, I think it's a red herring.  Hence my initial confusion, when I
> asked "would Yongji's patch just work if it used DEVICE_BIG_ENDIAN and
> beNN_to_cpu/cpu_to_beNN".
>

Thank you for the great discussion. I have a better understanding of the
endianness now.:-)

And for the commit message, I was wrong to assume the same endianness
as vfio. That's my fault. This bug should happen when target and host
endianness are different regardless of the device endianness.

To fix it, introducing DEVICE_HOST_ENDIAN for the ram device seems to be
more reasonable than other ways. I think I'll update the patch with this 
way.

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index bd15853..eef74df 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -36,6 +36,12 @@ enum device_endian {
      DEVICE_LITTLE_ENDIAN,
  };

+#if defined(HOST_WORDS_BIGENDIAN)
+#define DEVICE_HOST_ENDIAN DEVICE_BIG_ENDIAN
+#else
+#define DEVICE_HOST_ENDIAN DEVICE_LITTLE_ENDIAN
+#endif
+
  /* address in the RAM (different from a physical address) */
  #if defined(CONFIG_XEN_BACKEND)
  typedef uint64_t ram_addr_t;
diff --git a/memory.c b/memory.c
index ed8b5aa..17cfada 100644
--- a/memory.c
+++ b/memory.c
@@ -1180,7 +1180,7 @@ static void memory_region_ram_device_write(void 
*opaque, hwaddr addr,
  static const MemoryRegionOps ram_device_mem_ops = {
      .read = memory_region_ram_device_read,
      .write = memory_region_ram_device_write,
-    .endianness = DEVICE_NATIVE_ENDIAN,
+    .endianness = DEVICE_HOST_ENDIAN,
      .valid = {
          .min_access_size = 1,
          .max_access_size = 8,

Thanks,
Yongji
