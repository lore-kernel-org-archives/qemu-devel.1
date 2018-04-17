Received: from eggs.gnu.org ([2001:4830:134:3::10]:43637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1f8O3y-0002XZ-GG
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1f8O3u-0003x6-IA
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:42:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42552
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1f8O3u-0003rL-Be
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 06:42:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3HAfxNS053073
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 06:42:09 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hdekvabnf-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 06:42:05 -0400
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Tue, 17 Apr 2018 04:41:44 -0600
References: <1523900897-6630-1-git-send-email-stefanb@linux.vnet.ibm.com>
	<CAJ+F1CJ1NduViyjBw5LqwB4Sqm4TpYnXjNRyOgvPU=cjaLV05Q@mail.gmail.com>
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Tue, 17 Apr 2018 06:41:40 -0400
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJ1NduViyjBw5LqwB4Sqm4TpYnXjNRyOgvPU=cjaLV05Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <d5a1468b-1e62-e5ea-a2ee-5fe1d8b550a7@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: request access to locality 0 before
 sending command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU <qemu-devel@nongnu.org>

On 04/17/2018 05:08 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Mon, Apr 16, 2018 at 7:48 PM, Stefan Berger
> <stefanb@linux.vnet.ibm.com> wrote:
>> Recent changes to the CRB code now require that access to locality 0
>> be requested before the locality can be used for sending a command.
>> This patch adds the request to access the locality.
>>
>> Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
>> ---
>>   tests/tpm-util.c | 2 ++
> The patch fails to apply, tpm-util is added with your upcoming "tpm:
> Add test cases that use the external swtpm with CRB interface" patch,
> I guess it could be squashed there (I confirm it fixes the test)
>
>
> tpm-crb-test.c isn't affected, because you changed it in "tests: Tests
> more flags of the CRB interface" already

Right, wrong branch. Everything is good on 'git tip'.
