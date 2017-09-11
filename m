Received: from eggs.gnu.org ([2001:4830:134:3::10]:58904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1drPx2-0003jZ-M6
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:44:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@linux.vnet.ibm.com>) id 1drPwy-0002ZI-NI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:44:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@linux.vnet.ibm.com>)
	id 1drPwy-0002Yg-E2
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 10:44:36 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8BEiDSC005085
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 10:44:34 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cwt0tv3u8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 10:44:34 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@linux.vnet.ibm.com>;
	Mon, 11 Sep 2017 15:44:32 +0100
References: <1505126027-1704-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<c5ca72c2-4e5c-1a64-ded6-bf2e1cd7cefd@redhat.com>
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Mon, 11 Sep 2017 16:44:29 +0200
MIME-Version: 1.0
In-Reply-To: <c5ca72c2-4e5c-1a64-ded6-bf2e1cd7cefd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Message-Id: <ab76a6dc-ff46-a95e-5c79-1fae7039fc4f@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] s390: set DHCP client architecure id for
 netboot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com

On 11.09.2017 15:58, Thomas Huth wrote:
> On 11.09.2017 12:33, Viktor Mihajlovski wrote:
>> Setting the client architecture DHCP option to 0x001f (s390 Basic) [1]
>> allows the DHCP server to return a s390-specific bootfile if wanted.
>> DHCP servers not configured for the option (or not yet recognizing the
>> option value) will continue to work as they have done before.
>>
>> [1] https://www.iana.org/assignments/dhcpv6-parameters
>=20
> Ah, nice, you already registered a value for s390x :-)
> May I ask what's the difference between "Basic" and "Extended" there?
>=20
sure, "Basic" stands for the "classic netboot", i.e. a single binary
file is designated by the bootfile in the DHCP reply.
"Extended" is the mode implemented by Dynamic Partition Manager, where
the bootfile is some sort of configuration file.
[...]

--=20

Mit freundlichen Gr=C3=BC=C3=9Fen/Kind Regards
   Viktor Mihajlovski

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Martina K=C3=B6deritz
Gesch=C3=A4ftsf=C3=BChrung: Dirk Wittkopp
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294
