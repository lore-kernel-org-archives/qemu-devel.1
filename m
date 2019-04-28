Received: from eggs.gnu.org ([209.51.188.92]:55084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1hKtJr-00047G-In
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 19:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.ibm.com>) id 1hKtJn-0002PS-OY
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 19:34:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49252)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.ibm.com>)
	id 1hKtJm-0002OG-54
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 19:34:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3SNYK8R048954
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 19:34:40 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s5efbvgvt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 28 Apr 2019 19:34:40 -0400
Received: from localhost
	by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.ibm.com>;
	Mon, 29 Apr 2019 00:34:40 +0100
References: <20190427131857.11600-1-philmd@redhat.com>
	<CAMxuvayZ-woUZPxnav8EXSVGGADxeJjhDs1bgzPAzNLMGFgTsA@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
Date: Sun, 28 Apr 2019 19:34:35 -0400
MIME-Version: 1.0
In-Reply-To: <CAMxuvayZ-woUZPxnav8EXSVGGADxeJjhDs1bgzPAzNLMGFgTsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Message-Id: <173af15e-881e-89a0-77c5-a937abc682cb@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/tpm: Only build tpm_ppi.o if any of
 TPM_TIS/TPM_CRB is built
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On 4/27/19 11:49 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>
> On Sat, Apr 27, 2019 at 3:19 PM Philippe Mathieu-Daud=C3=A9
> <philmd@redhat.com> wrote:
>> The TPM Physical Presence Interface routines are only used
>> by the CRB/TIS interfaces. Do not compile this file if any
>> of them is built.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>> ---
>> Marc-Andr=C3=A9:
>>    You might want to add yourself as reviewer/maintainer of TPM ;)
> yes, I suppose Stefan wouldn't mind having me as R: :)

I don't mind.
