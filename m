Received: from eggs.gnu.org ([2001:4830:134:3::10]:48171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eR1kc-0004LX-Km
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:11:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eR1kN-0000QZ-7Z
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:11:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:38396
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eR1kN-0000QG-2L
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 15:10:47 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBIK9avb033051
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 15:10:44 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2exkbf2qyk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 15:10:43 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Mon, 18 Dec 2017 15:10:43 -0500
References: <20171218183631.32357-1-cohuck@redhat.com>
	<c8748f83-b98e-6dd2-ddf5-6620f6b36f30@redhat.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Mon, 18 Dec 2017 15:10:38 -0500
MIME-Version: 1.0
In-Reply-To: <c8748f83-b98e-6dd2-ddf5-6620f6b36f30@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <1bb44350-bb7b-86a9-cc7c-8ddde2419629@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] tpm: move qdev_prop_tpm to hw/tpm/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Cornelia Huck <cohuck@redhat.com>, pbonzini@redhat.com
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org

On 12/18/2017 02:40 PM, Laurent Vivier wrote:
> On 18/12/2017 19:36, Cornelia Huck wrote:
>> Building with --disable-tpm yields
>>
>> ../hw/core/qdev-properties-system.o: In function `set_tpm':
>> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:274: undefined =
reference to `qemu_find_tpm_be'
>> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:278: undefined =
reference to `tpm_backend_init'
>> ../hw/core/qdev-properties-system.o: In function `release_tpm':
>> /home/cohuck/git/qemu/hw/core/qdev-properties-system.c:291: undefined =
reference to `tpm_backend_reset'
>>
>> Move the implementation of DEFINE_PROP_TPMBE to hw/tpm/ so that it is
>> only built when tpm is actually configured, and build tpm_util in ever=
y
>> case.
>>
>> Fixes: 493b78303532 ("qdev: add DEFINE_PROP_TPMBE")
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> ---
>> v1->v2: fix x86_64 build with mingw (always build tpm_util)
>> ---
>>   hw/core/qdev-properties-system.c | 64 ------------------------------=
--------
>>   hw/tpm/Makefile.objs             |  5 +--
>>   hw/tpm/tpm_util.c                | 67 ++++++++++++++++++++++++++++++=
++++++++++
>>   hw/tpm/tpm_util.h                |  3 ++
>>   include/hw/qdev-properties.h     |  2 --
>>   5 files changed, 73 insertions(+), 68 deletions(-)
>>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
>
>
>
Thanks. Preparing a pull request for tomorrow.

     Stefan
