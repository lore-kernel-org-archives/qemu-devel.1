Received: from eggs.gnu.org ([2001:4830:134:3::10]:52662)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f9QtU-0004B0-Pu
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1f9QtQ-0001cK-Sc
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:55:44 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49440
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1f9QtQ-0001Zn-E8
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:55:40 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3K7tXtA028750
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 03:55:38 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hfarwv0xj-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 03:55:36 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Fri, 20 Apr 2018 08:54:32 +0100
References: <1524054707-20663-1-git-send-email-thuth@redhat.com>
	<1524054707-20663-4-git-send-email-thuth@redhat.com>
	<bc5533dc-9471-7dac-6aba-9014e9961376@linux.vnet.ibm.com>
	<b0bb6918-0047-9a53-b03f-bff5669daaaa@redhat.com>
	<2d59a139-3bdd-4b4e-882c-5cf845488eda@linux.vnet.ibm.com>
	<475ea222-cc03-16e4-0f50-f89cf2bfae6f@redhat.com>
	<0b6af02e-6e5b-76bb-a0d0-30038ad5a265@linux.vnet.ibm.com>
	<a001b146-7091-63e6-a845-e276494cc518@redhat.com>
From: Viktor VM Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Fri, 20 Apr 2018 09:54:28 +0200
MIME-Version: 1.0
In-Reply-To: <a001b146-7091-63e6-a845-e276494cc518@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Message-Id: <ca20b91c-e92f-e539-590b-fcaa229a57d5@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [qemu-s390x] [PATCH v1 for-2.13 3/4]
 pc-bios/s390-ccw/net: Add support for pxelinux-style config files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Cc: Collin Walling <walling@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org

On 20.04.2018 09:36, Thomas Huth wrote:
> On 20.04.2018 08:53, Viktor VM Mihajlovski wrote:
>> On 19.04.2018 18:55, Thomas Huth wrote:
[...]
>> Well, if we don't add another identifier, and I feel reluctant about it
>> as well for the reasons you wrote, we may stick with 0x1f and consider
>> the additional capabilities as being optional (for special needs only).
> 
> I tend to stay with 0x1f, since booting binaries is still the "primary"
> interface (the first check for the "default" or "# " magic keywords is
> not 100% reliable, since the config file could also start with another
> command, and the probing of pxelinux.cfg/* files is only tried afterwards).
> 
Good. It would be important though to define and document the best way
to configure a pxelinux setup: empty bootfile name, bootfile empty (or
not existent) or a special file format for the bootfile content (like
'PXE0' in EBCDIC). The former two carry the danger of accidentally
enabling the pxe-style boot process.
>  Thomas
> 


-- 
Regards,
  Viktor Mihajlovski
