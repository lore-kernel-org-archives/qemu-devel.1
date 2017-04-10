Received: from eggs.gnu.org ([2001:4830:134:3::10]:60721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cxbxQ-0004y0-SQ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:14:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1cxbxL-00025V-Tv
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:14:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59161)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1cxbxL-00025C-K2
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 12:14:19 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3AGDhjH123077
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 12:14:17 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29rcbwucxp-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 12:14:16 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 10 Apr 2017 12:14:15 -0400
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-10-git-send-email-amarnath.valluri@intel.com>
	<20170407144100.GL26896@redhat.com>
	<CAJ+F1CJ1wfP_RS25=gokRvk2y0+-_7pX8adzmBUMZPpaz=AOgw@mail.gmail.com>
	<094e28c1-b780-f8ff-fc6a-9f6dd3421a3a@intel.com>
	<CAJ+F1CKo=tAXKHzoY4mfZxc9V2N5+sszOJwPOVqkJZK2tD6vMA@mail.gmail.com>
	<1491818850.10884.99.camel@intel.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 10 Apr 2017 12:14:10 -0400
MIME-Version: 1.0
In-Reply-To: <1491818850.10884.99.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <df1081c7-7f3b-20df-0ff0-a2c2e6de9e43@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 9/9] tpm: Added support for TPM emulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Patrick Ohly <patrick.ohly@intel.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Amarnath Valluri <amarnath.valluri@intel.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org

On 04/10/2017 06:07 AM, Patrick Ohly wrote:
> On Mon, 2017-04-10 at 09:54 +0000, Marc-Andr=C3=A9 Lureau wrote:
>
>> By "public protocol", I mean qemu communication with a foreign
>> project, swtpm or other.
>>
>> If qemu grows new needs, or if the protocol is found limited or buggy,
>> it may change. Subtle interactions may break between various
>> implementations.  The minimum would be some versioning or
>> capabilities. A document describing the states and messages
>> allowed/denied & effects would be quite necessary.
> Stefan, is there any documentation besides the source?

No.

>
> Just asking, I don't think it is needed because...
>
>> Otoh, there doesn't seem to be other users of this protocol, or other
>> implementations. So it may make sense to make it qemu-specific, and
>> thus "private": the protocol and implementation can evolve without
>> risk to break other users. This gives us a lot more flexibility and
>> control, and doesn't have to be very strictly documented (although it
>> is still better to be strict, but requires more effort).
> ... I suspect it falls into this camp. I can't think of any users of th=
e
> protocol besides swtpm itself and now qemu. Stefan, is that correct?
>

Correct. Only swtpm client tools (swtpm_ioctl) and now your QEMU patches=20
are using the protocol.
