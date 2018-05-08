Received: from eggs.gnu.org ([2001:4830:134:3::10]:60694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fG4Nf-0000vS-7f
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1fG4Nb-00030s-V4
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:18:19 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1fG4Nb-0002uY-M9
	for qemu-devel@nongnu.org; Tue, 08 May 2018 11:18:15 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w48FBGVo053935
	for <qemu-devel@nongnu.org>; Tue, 8 May 2018 11:18:11 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hubhs1ee3-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 11:18:11 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 8 May 2018 09:18:10 -0600
References: <65983efd-e68f-76f5-bfb1-a8d14045df76@amsat.org>
	<20180508134831.GV5967@redhat.com>
	<CAFEAcA_L3fy+MFh72=zX3pHtXP634Uhu0+G=nz-fMWaGC8muNw@mail.gmail.com>
	<20180508140327.GY5967@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 8 May 2018 11:18:05 -0400
MIME-Version: 1.0
In-Reply-To: <20180508140327.GY5967@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <050255a7-5ebf-8e96-c0ef-169d56bcaf81@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] tpm_emu_test_wait_cond: code should not be reached
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On 05/08/2018 10:03 AM, Daniel P. Berrang=C3=A9 wrote:
> On Tue, May 08, 2018 at 02:54:39PM +0100, Peter Maydell wrote:
>> On 8 May 2018 at 14:48, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
>>> This test has a couple of threads running, and passes &error_abort to
>>> the qio_channel_socket_readv() function. So I expect that one thread
>>> is closing the socket connection, and the other thread has not yet
>>> shutdown cleanly, so tries to readv on a dead socket triggering the
>>> error_abort.  IOW,  qio_channel_socket_readv is likely just the sympt=
om
>>> of brokeness somewhere else in the test, not the cause.
>> That sounds familiar...didn't we have a thread about this a while back=
?
> Yeah, I don't recall if it was related to this particular test, or
> another similar situation in a different test.

My bad. I didn't upstream this one here:

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg04783.html

I'll send it to qemu-trivial, unless someone objects.

    Stefan

>
> Regards,
> Daniel
